SELECT B.POST_NO ,B.TITLE,M.NICKNAME,B.LIKE_COUNT,B.VIEW_COUNT,TO_CHAR(REGDATE, 'YYYY-MM-DD') AS AGEDATE
FROM BOARD B, MEMBER M
WHERE B.ID=M.ID ORDER BY POST_NO DESC

--post no 번호 짤리지 않게 하는 ..다시 rnum 부여하는것
SELECT  B.RNUM , B.TITLE,M.NICKNAME,B.LIKE_COUNT,B.VIEW_COUNT,AGEDATE
FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY POST_NO DESC) AS RNUM ,B.POST_NO,B.TITLE,M.NICKNAME,B.LIKE_COUNT,B.VIEW_COUNT,TO_CHAR(REGDATE, 'YYYY-MM-DD') AS AGEDATE
	FROM BOARD B, MEMBER M
	WHERE B.ID=M.ID AND M.AGENAME='조선시대'
) B , MEMBER M
WHERE B.NICKNAME=M.NICKNAME order by rnum desc;
