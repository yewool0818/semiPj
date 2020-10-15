package HoH.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class BoardDAO {
	private static BoardDAO dao=new BoardDAO();	
	private DataSource dataSource;
	private BoardDAO(){
		dataSource=DataSourceManager.getInstance().getDataSource();
	}
	public static BoardDAO getInstance(){
		return dao;
	}
	public Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}
	public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException{
		closeAll(null,pstmt,con);
	}
	public void closeAll(ResultSet rs,PreparedStatement pstmt,Connection con) throws SQLException{
		if(rs!=null)
			rs.close();
		if(pstmt!=null)
			pstmt.close();
		if(con!=null)
			con.close();
	}
	
	//핳게시물 받아오기
	public ArrayList<PostVO> getListByLike() throws SQLException{
		ArrayList<PostVO> list=new ArrayList<PostVO>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="SELECT b.title, m.nickName, m.ageName FROM board b, member m WHERE b.id=m.id ORDER BY like_count, view_count DESC";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PostVO pvo=new PostVO();
				MemberVO mvo=new MemberVO();
				pvo.setTitle(rs.getString(1));
				mvo.setNickName(rs.getString(2));
				pvo.setMemberVO(mvo);
				list.add(pvo);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list; 
	}
	
	//시대별글 리스트불러오기
	public ArrayList<PostVO> getListByAge(String ageName) throws SQLException {
		ArrayList<PostVO> list = new ArrayList<PostVO>();
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT  B.RNUM ,B.POST_NO, B.TITLE,M.NICKNAME,B.LIKE_COUNT,B.VIEW_COUNT,AGEDATE ");
			sql.append("FROM ( ");
			sql.append("SELECT ROW_NUMBER() OVER(ORDER BY POST_NO DESC) AS RNUM ,b.post_no,B.TITLE,M.NICKNAME,B.LIKE_COUNT,B.VIEW_COUNT,TO_CHAR(REGDATE, 'YYYY-MM-DD') AS AGEDATE ");
			sql.append("FROM BOARD B, MEMBER M ");
			sql.append("WHERE B.ID=M.ID AND M.AGENAME=? ");
			sql.append(") B , MEMBER M ");
			sql.append("WHERE B.NICKNAME=M.NICKNAME order by rnum  desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, ageName);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PostVO pvo=new PostVO();
				MemberVO mvo=new MemberVO();
				pvo.setRnum(rs.getString(1));
				pvo.setPostNo(rs.getString(2));
				pvo.setTitle(rs.getString(3));
				mvo.setNickName(rs.getString(4));
				pvo.setMemberVO(mvo);
				pvo.setLikeCount(rs.getInt(5));
				pvo.setViewCount(rs.getInt(6));
				pvo.setRegDate(rs.getString(7));
				list.add(pvo);
			}
			
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
}//class























