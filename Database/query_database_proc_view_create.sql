/************************************************************
 * Generated by SoftTree SQL Assistant � 7.5.502
 * Time:   21/12/2016 4:49:00 PM
 * Source: HOADON_XEM, HOADON_XEM_THEOMA, SP_DangNhap, SP_DangNhap_TaiKhoan, SP_DICHVU_KTTM, 
 *         SP_DichVu_MaDV_TDV, SP_DichVu_MaDV_TheoTDV, SP_DICHVU_SUA, SP_DICHVU_Them, 
 *         SP_DichVu_ThongTin, SP_DICHVU_XEM, SP_DICHVU_XOA, SP_HOADONDV_CNTT, SP_HOADONDV_Them, 
 *         SP_HOADONDV_XEM, SP_HOADONDV_XEM_CHUATT, SP_Khach_LayMaKhach, SP_KHACH_MAKHACH, 
 *         SP_KHACH_MA_PHONG, SP_KHACH_MA_PHONG_1, SP_KHACH_MA_TT, SP_KHACH_Sua, 
 *         SP_KHACH_TEN, SP_KHACH_Them, SP_KHACH_TTMAKHACH, SP_KHACH_Xem, SP_KHACH_Xoa, 
 *         SP_LOAIPHONG_KT, SP_LOAIPHONG_Sua, SP_LOAIPHONG_Them, SP_LOAIPHONG_Xem, 
 *         SP_LOAIPHONG_Xoa, SP_NhanVien_LayChuoiMNV, SP_NhanVien_LayMNV, SP_NhanVien_Sua, 
 *         SP_NhanVien_Them, SP_NhanVien_ThongTin, SP_NhanVien_ThongTin_ChucVu, SP_NhanVien_TimKiemMa, 
 *         SP_NhanVien_TimKiemMaTheoTen, SP_NhanVien_Xoa, SP_PHIEUDV_LOAIDV, SP_PHIEUDV_TheoPL, 
 *         SP_PHIEUTHUETRA_LayMa, SP_PHIEUTHUETRA_THEM, SP_PHIEUTHUETRA_Xem, SP_Phong_CapNhatTinhTrang, 
 *         SP_Phong_LayChuoiMaPhong, SP_PHONG_LOAIPHONG, SP_PHONG_MAPHONG, SP_PHONG_MAPHONG_TTLOAI, 
 *         SP_PHONG_MAPHONG_TTMA, SP_Phong_Sua, SP_Phong_Them, SP_Phong_ThongTin, 
 *         SP_Phong_ThongTin_MA_TEN, SP_Phong_TinhTrang, SP_Phong_Xoa, SP_TaiKhoan_DoiMK, 
 *         SP_TaiKhoan_MK, SP_TaiKhoan_Ten, VIEW_REPORT1, DANGNHAP, DICHVU, KHACH, 
 *         LOAIPHONG, NHANVIEN, PHIEUDICHVU, PHIEUTHUETRA, PHONG
 ************************************************************/

/* [QLKHACHSAN].[dbo].[HOADON_XEM] */

CREATE PROC HOADON_XEM
AS
BEGIN
   SELECT PHIEUTHUETRA.MAPHIEUTHUE,TENNV,PHONG.MAPHONG,PHIEUTHUETRA.NGAYTHUE,NGAYTRA,KHACH.MAKHACH,TENKHACH,CMND,datediff(day,PHIEUTHUETRA.NGAYTHUE,NGAYTRA)*SLNGUOI*LOAIPHONG.DONGIA AS 'TIEN PHONG',
   SLDV*DICHVU.DONGIA AS 'TIEN DICH VU',datediff(day,PHIEUTHUETRA.NGAYTHUE,NGAYTRA)*SLNGUOI*LOAIPHONG.DONGIA+SLDV*DICHVU.DONGIA AS 'TONG'
    FROM  PHIEUTHUETRA 
   INNER JOIN KHACH ON KHACH.MAKHACH = PHIEUTHUETRA.MAKHACH
   INNER JOIN PHONG ON PHONG.MAPHONG = PHIEUTHUETRA.MAPHONG
   INNER JOIN LOAIPHONG ON PHONG.MALOAIPHONG=LOAIPHONG.MALOAIPHONG
   INNER JOIN NHANVIEN ON NHANVIEN.MANV = PHIEUTHUETRA.MANV
   INNER JOIN PHIEUDICHVU ON PHIEUDICHVU.MAPHIEUTHUE =PHIEUTHUETRA.MAPHIEUTHUE
   INNER JOIN DICHVU ON DICHVU.MADV = PHIEUDICHVU.MADV
   END
----
GO

/* [QLKHACHSAN].[dbo].[HOADON_XEM_THEOMA] */

CREATE PROC [dbo].[HOADON_XEM_THEOMA]
@MAPHIEUTHUE nvarchar(25)
AS
BEGIN
   SELECT PHIEUTHUETRA.MAPHIEUTHUE,TENNV,NGAYLAP,PHONG.MAPHONG,PHIEUTHUETRA.NGAYTHUE,NGAYTRA,KHACH.MAKHACH,TENKHACH,CMND,sum(datediff(day,PHIEUTHUETRA.NGAYTHUE,PHIEUTHUETRA.NGAYTRA)*SLNGUOI*LOAIPHONG.DONGIA) AS 'TIEN PHONG',
  SUM( SLDV*DICHVU.DONGIA )AS 'TIEN DICH VU',sum(datediff(day,PHIEUTHUETRA.NGAYTHUE,NGAYTRA)*SLNGUOI*LOAIPHONG.DONGIA+SLDV*DICHVU.DONGIA) AS 'TONG'
    FROM  PHIEUTHUETRA 
   inner  JOIN KHACH ON KHACH.MAKHACH = PHIEUTHUETRA.MAKHACH
   inner JOIN PHONG ON PHONG.MAPHONG = PHIEUTHUETRA.MAPHONG
    inner JOIN LOAIPHONG ON PHONG.MALOAIPHONG=LOAIPHONG.MALOAIPHONG
    inner JOIN NHANVIEN ON NHANVIEN.MANV = PHIEUTHUETRA.MANV
    left JOIN PHIEUDICHVU ON PHIEUDICHVU.MAPHIEUTHUE =PHIEUTHUETRA.MAPHIEUTHUE
   left JOIN DICHVU ON DICHVU.MADV = PHIEUDICHVU.MADV
   where PHIEUTHUETRA.MAPHIEUTHUE=@MAPHIEUTHUE
   GROUP BY PHIEUTHUETRA.MAPHIEUTHUE,TENNV,NGAYLAP,PHONG.MAPHONG,PHIEUTHUETRA.NGAYTHUE,NGAYTRA,KHACH.MAKHACH,TENKHACH,CMND
   
   END
GO

/* [QLKHACHSAN].[dbo].[SP_DangNhap] */

CREATE PROC SP_DangNhap 
@User nvarchar(25),@PassWord nvarchar(25)
AS
BEGIN
	SELECT [USER],PASSWORD,DANGNHAP.MANV
	FROM DANGNHAP INNER JOIN NHANVIEN ON NHANVIEN.MANV= DANGNHAP.MANV 
	WHERE [USER]= @User AND PASSWORD =@PassWord
END
GO

/* [QLKHACHSAN].[dbo].[SP_DangNhap_TaiKhoan] */

CREATE PROC SP_DangNhap_TaiKhoan
@USER NVARCHAR(25)
AS
BEGIN
    SELECT * FROM DANGNHAP 
    WHERE [USER] = @USER
END
GO

/* [QLKHACHSAN].[dbo].[SP_DICHVU_KTTM] */

CREATE PROC SP_DICHVU_KTTM @MADV nvarchar(25)
AS
BEGIN
	SELECT * FROM DICHVU where MADV =@MADV
END
GO

/* [QLKHACHSAN].[dbo].[SP_DichVu_MaDV_TDV] */

CREATE PROC SP_DichVu_MaDV_TDV
AS
BEGIN
     SELECT MADV,TENDV,DONGIA,DVT FROM DICHVU
END
GO

/* [QLKHACHSAN].[dbo].[SP_DichVu_MaDV_TheoTDV] */

CREATE PROC SP_DichVu_MaDV_TheoTDV
@TENDV NVARCHAR(25)
AS
BEGIN
     SELECT MADV FROM DICHVU WHERE TENDV=@TENDV
END
GO

/* [QLKHACHSAN].[dbo].[SP_DICHVU_SUA] */

CREATE PROC SP_DICHVU_SUA(@MADV NVARCHAR(25),@TENDV NVARCHAR(30),@DONGIA FLOAT)
AS
BEGIN
	UPDATE DICHVU SET TENDV=@TENDV,DONGIA=@DONGIA where MADV=@MADV
END
GO

/* [QLKHACHSAN].[dbo].[SP_DICHVU_Them] */

CREATE PROC SP_DICHVU_Them(@MADV NVARCHAR(25),@TENDV NVARCHAR(30),@DONGIA FLOAT)
as
BEGIN
    INSERT INTO DICHVU (MADV,TENDV,DONGIA) VALUES(@MADV,@TENDV,@DONGIA)
END
GO

/* [QLKHACHSAN].[dbo].[SP_DichVu_ThongTin] */

CREATE PROC SP_DichVu_ThongTin
AS
BEGIN
     SELECT MADV,TENDV,DONGIA FROM DICHVU
END
GO

/* [QLKHACHSAN].[dbo].[SP_DICHVU_XEM] */

CREATE PROC SP_DICHVU_XEM
AS
BEGIN
	SELECT * FROM DICHVU
END
GO

/* [QLKHACHSAN].[dbo].[SP_DICHVU_XOA] */

CREATE PROC SP_DICHVU_XOA(@MADV NVARCHAR(25))
AS
BEGIN
	DELETE DICHVU WHERE MADV=@MADV
END
GO

/* [QLKHACHSAN].[dbo].[SP_HOADONDV_CNTT] */

CREATE PROC SP_HOADONDV_CNTT
@MAPHONG nvarchar(25),
@TRANGTHAI nvarchar(30)
as
   begin
   update PHIEUDICHVU set TRANGTHAI=@TRANGTHAI from PHIEUDICHVU inner join 
   PHIEUTHUETRA on PHIEUDICHVU.MAPHIEUTHUE=PHIEUTHUETRA.MAPHIEUTHUE
   WHERE PHIEUTHUETRA.MAPHONG=@MAPHONG
   end
GO

/* [QLKHACHSAN].[dbo].[SP_HOADONDV_Them] */

CREATE PROC SP_HOADONDV_Them
@MADV nvarchar(25),
@MAPHIEUTHUE nvarchar(25),
@SLDV int,
@NGAYTHUE datetime,
@TRANGTHAI nvarchar(30)
AS
BEGIN
	insert into PHIEUDICHVU values(@MADV,@MAPHIEUTHUE,@SLDV,@NGAYTHUE,@TRANGTHAI)
END
GO

/* [QLKHACHSAN].[dbo].[SP_HOADONDV_XEM] */

CREATE PROC SP_HOADONDV_XEM
@MAPHONG nvarchar(25)
AS
BEGIN
     DECLARE @MAKHACH nvarchar(25)
     SELECT @MAKHACH = MAKHACH from PHIEUTHUETRA WHERE MAPHONG=@MAPHONG
     SELECT TENDV,DONGIA,SLDV,PHIEUDICHVU.NGAYTHUE from PHIEUDICHVU inner join DICHVU 
     on DICHVU.MADV=PHIEUDICHVU.MADV
     inner join PHIEUTHUETRA on PHIEUDICHVU.MAPHIEUTHUE=PHIEUTHUETRA.MAPHIEUTHUE
     WHERE MAKHACH=@MAKHACH
END
GO

/* [QLKHACHSAN].[dbo].[SP_HOADONDV_XEM_CHUATT] */

create PROC [dbo].[SP_HOADONDV_XEM_CHUATT]
@MAPHONG nvarchar(25)
AS
BEGIN
     DECLARE @MAKHACH nvarchar(25)
     SELECT @MAKHACH = MAKHACH from PHIEUTHUETRA WHERE MAPHONG=@MAPHONG
     SELECT TENDV,DONGIA,SLDV,PHIEUDICHVU.NGAYTHUE from PHIEUDICHVU inner join DICHVU 
     on DICHVU.MADV=PHIEUDICHVU.MADV
     inner join PHIEUTHUETRA on PHIEUDICHVU.MAPHIEUTHUE=PHIEUTHUETRA.MAPHIEUTHUE
     WHERE MAKHACH=@MAKHACH AND PHIEUDICHVU.TRANGTHAI='1'
END
GO

/* [QLKHACHSAN].[dbo].[SP_Khach_LayMaKhach] */

CREATE PROC SP_Khach_LayMaKhach
AS
BEGIN
SELECT MAKHACH FROM KHACH ORDER BY MAKHACH DESC
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_MAKHACH] */

CREATE PROC SP_KHACH_MAKHACH
@MAKHACH NVARCHAR(25)
AS
BEGIN
	select * from KHACH where MAKHACH = @MAKHACH
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_MA_PHONG] */

create proc SP_KHACH_MA_PHONG
@MAPHONG nvarchar(25)
as
   begin 
        select MAKHACH from PHIEUTHUETRA inner join PHIEUDICHVU on
        PHIEUDICHVU.MAPHIEUTHUE=PHIEUTHUETRA.MAPHIEUTHUE
         WHERE MAPHONG=@MAPHONG AND PHIEUDICHVU.TRANGTHAI='2'
   END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_MA_PHONG_1] */

create proc SP_KHACH_MA_PHONG_1
@MAPHONG nvarchar(25)
as
   begin 
        select MAKHACH from PHIEUTHUETRA 
         WHERE MAPHONG=@MAPHONG 
   END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_MA_TT] */

create proc SP_KHACH_MA_TT
@MAKHACH nvarchar(25)
as
   begin 
        select MAPHIEUTHUE from PHIEUTHUETRA 
         WHERE MAKHACH=@MAKHACH 
   END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_Sua] */

CREATE PROC SP_KHACH_Sua	
@MAKHACH NVARCHAR(25),
@TENKHACH NVARCHAR(60),
@NGAYSINH DATETIME,
@GIOITINH NVARCHAR(25),
@DIACHI NVARCHAR(60),
@CMND INT,
@QUOCTICH NVARCHAR(15)
AS
BEGIN
     UPDATE KHACH SET TENKHACH=@TENKHACH,NGAYSINH=@NGAYSINH,GIOITINH=@GIOITINH,DIACHI=@DIACHI,CMND=@CMND,QUOCTICH=@QUOCTICH
     WHERE MAKHACH=@MAKHACH
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_TEN] */

CREATE PROC SP_KHACH_TEN
@TENKHACH nvarchar(25)
AS
BEGIN
	select * from KHACH  where TENKHACH like @TENKHACH
	END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_Them] */

CREATE PROC SP_KHACH_Them
@MAKHACH NVARCHAR(25),
@TENKHACH NVARCHAR(60),
@NGAYSINH DATETIME,
@GIOITINH NVARCHAR(25),
@DIACHI NVARCHAR(60),
@CMND INT,
@QUOCTICH NVARCHAR(15)
AS
BEGIN
     INSERT INTO KHACH VALUES(@MAKHACH,@TENKHACH,@NGAYSINH,@GIOITINH,@DIACHI,@CMND,@QUOCTICH)
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_TTMAKHACH] */

CREATE PROC SP_KHACH_TTMAKHACH
AS
BEGIN
	select MAKHACH from KHACH 
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_Xem] */

CREATE PROC [dbo].[SP_KHACH_Xem]
AS
BEGIN
      SELECT * FROM dbo.KHACH
WHERE dbo.KHACH.MAKHACH Not In  (SELECT dbo.KHACH.MAKHACH
FROM  dbo.PHONG INNER JOIN
               dbo.PHIEUTHUETRA ON dbo.PHONG.MAPHONG = dbo.PHIEUTHUETRA.MAPHONG INNER JOIN
               dbo.KHACH ON dbo.PHIEUTHUETRA.MAKHACH = dbo.KHACH.MAKHACH
WHERE (dbo.PHONG.TINHTRANG <> N'TR?NG'))
END
GO

/* [QLKHACHSAN].[dbo].[SP_KHACH_Xoa] */

CREATE PROC SP_KHACH_Xoa
@MAKHACH NVARCHAR(25)
AS
BEGIN
     DELETE KHACH WHERE MAKHACH=@MAKHACH
END
GO

/* [QLKHACHSAN].[dbo].[SP_LOAIPHONG_KT] */

CREATE PROC SP_LOAIPHONG_KT @MALP nvarchar(25)
AS
BEGIN
     SELECT * FROM LOAIPHONG WHERE MALOAIPHONG=@MALP
END
GO

/* [QLKHACHSAN].[dbo].[SP_LOAIPHONG_Sua] */

CREATE PROC SP_LOAIPHONG_Sua
@MALOAIPHONG NVARCHAR(25),
@TENLOAIPHONG NVARCHAR(30),
@DONGIA FLOAT
AS
BEGIN
      UPDATE LOAIPHONG SET TENLOAIPHONG =@TENLOAIPHONG , DONGIA= @DONGIA
      WHERE MALOAIPHONG= @MALOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_LOAIPHONG_Them] */

CREATE PROC SP_LOAIPHONG_Them
@MALOAIPHONG NVARCHAR(25),
@TENLOAIPHONG NVARCHAR(30),
@DONGIA FLOAT
AS
BEGIN
      INSERT INTO LOAIPHONG VALUES(@MALOAIPHONG,@TENLOAIPHONG,@DONGIA)
END
GO

/* [QLKHACHSAN].[dbo].[SP_LOAIPHONG_Xem] */

CREATE PROC SP_LOAIPHONG_Xem
AS
BEGIN
     SELECT * FROM LOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_LOAIPHONG_Xoa] */

CREATE PROC SP_LOAIPHONG_Xoa
 @MALOAIPHONG NVARCHAR(25)
AS
BEGIN
     DELETE LOAIPHONG WHERE MALOAIPHONG= @MALOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_LayChuoiMNV] */

CREATE PROC SP_NhanVien_LayChuoiMNV
AS
BEGIN
SELECT TOP 1 MANV FROM NHANVIEN ORDER BY MANV DESC
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_LayMNV] */

CREATE PROC SP_NhanVien_LayMNV
AS
BEGIN
SELECT MANV FROM NHANVIEN ORDER BY MANV DESC
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_Sua] */

CREATE PROC SP_NhanVien_Sua
@MANV nvarchar(25),
@TENNV nvarchar(60),@NGAYSINH datetime,@GIOITINH nvarchar(25),
@DIACHI nvarchar(60),@SDT nvarchar(25),
@CHUCVU nvarchar(25) 
AS
BEGIN
	UPDATE NHANVIEN SET TENNV=@TENNV,NGAYSINH=@NGAYSINH,GIOITINH=@GIOITINH,
	DIACHI=@DIACHI,SDT=@SDT,CHUCVU=@CHUCVU WHERE MANV=@MANV
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_Them] */

CREATE PROC SP_NhanVien_Them @MANV nvarchar(25),
@TENNV nvarchar(60),@NGAYSINH datetime,@GIOITINH nvarchar(25),
@DIACHI nvarchar(60),@SDT nvarchar(25),
@CHUCVU nvarchar(25),@USER nvarchar(25),@PASSWORD nvarchar(25) 
AS
BEGIN
	INSERT INTO  NHANVIEN VALUES(@MANV,@TENNV,@NGAYSINH,@GIOITINH,@DIACHI,@SDT,@CHUCVU)
	IF EXISTS(SELECT * FROM NHANVIEN WHERE MANV=@MANV)
	BEGIN
	INSERT INTO  DANGNHAP VALUES(@USER,@PASSWORD,@MANV)
	END
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_ThongTin] */

CREATE PROC SP_NhanVien_ThongTin
AS
BEGIN
	SELECT NHANVIEN.MANV,TENNV,NGAYSINH,GIOITINH,DIACHI,SDT,CHUCVU,[USER],PASSWORD
	FROM NHANVIEN INNER JOIN DANGNHAP ON NHANVIEN.MANV= DANGNHAP.MANV 
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_ThongTin_ChucVu] */

CREATE PROC SP_NhanVien_ThongTin_ChucVu @USER nvarchar(25)
AS
BEGIN
	SELECT CHUCVU
	FROM NHANVIEN INNER JOIN DANGNHAP ON NHANVIEN.MANV= DANGNHAP.MANV
	WHERE [USER] = @USER
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_TimKiemMa] */

CREATE PROC SP_NhanVien_TimKiemMa 
@MANV nvarchar(25)
AS
BEGIN
	SELECT * from NHANVIEN
	WHERE MANV=@MANV
	 
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_TimKiemMaTheoTen] */

CREATE PROC SP_NhanVien_TimKiemMaTheoTen
@TENNV nvarchar(25)
AS
BEGIN
	SELECT MANV from NHANVIEN
	WHERE TENNV =@TENNV 
	 
END
GO

/* [QLKHACHSAN].[dbo].[SP_NhanVien_Xoa] */

CREATE PROC SP_NhanVien_Xoa
@MANV nvarchar(25) 
AS
BEGIN
	DELETE NHANVIEN WHERE MANV=@MANV
	DELETE DANGNHAP WHERE MANV=@MANV
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHIEUDV_LOAIDV] */

CREATE PROC SP_PHIEUDV_LOAIDV
AS
BEGIN
	select MADV,TENDV from DICHVU
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHIEUDV_TheoPL] */

CREATE PROC SP_PHIEUDV_TheoPL
 @MAPHONG nvarchar(25)
 as
    begin 
         select SLDV,TENDV,DONGIA,PHIEUDICHVU.NGAYTHUE from PHIEUDICHVU 
         inner join DICHVU on DICHVU.MADV = PHIEUDICHVU.MADV
         inner join PHIEUTHUETRA on PHIEUTHUETRA.MAPHIEUTHUE = PHIEUDICHVU.MAPHIEUTHUE
         WHERE    PHIEUTHUETRA.MAPHONG=@MAPHONG
    end
GO

/* [QLKHACHSAN].[dbo].[SP_PHIEUTHUETRA_LayMa] */

CREATE PROC SP_PHIEUTHUETRA_LayMa
AS
BEGIN
     SELECT MAPHIEUTHUE FROM PHIEUTHUETRA ORDER BY MAPHIEUTHUE DESC
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHIEUTHUETRA_THEM] */

CREATE PROC SP_PHIEUTHUETRA_THEM
@MAPHIEUTHUE NVARCHAR(25),
@MAPHONG NVARCHAR(25),
@MAKHACH NVARCHAR(25),
@NGAYTHUE DATETIME,
@NGAYTRA DATETIME,
@SLNGUOI INT,
@NGAYLAP DATETIME,
@MANV NVARCHAR(25)
AS
BEGIN
 INSERT INTO PHIEUTHUETRA VALUES(@MAPHIEUTHUE,@MAPHONG,@MAKHACH,@NGAYTHUE,@NGAYTRA ,@SLNGUOI,@NGAYLAP,@MANV)    
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHIEUTHUETRA_Xem] */

CREATE PROC SP_PHIEUTHUETRA_Xem
AS
BEGIN
     SELECT * FROM PHIEUTHUETRA
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_CapNhatTinhTrang] */

CREATE PROC SP_Phong_CapNhatTinhTrang
@MAPHONG NVARCHAR(25),
@TINHTRANG NVARCHAR(25)
AS
BEGIN 
   update PHONG set TINHTRANG=@TINHTRANG WHERE MAPHONG=@MAPHONG
    
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_LayChuoiMaPhong] */

CREATE PROC SP_Phong_LayChuoiMaPhong
AS
BEGIN
SELECT TOP 1 MAPHONG FROM PHONG ORDER BY MAPHONG DESC
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHONG_LOAIPHONG] */

CREATE PROC SP_PHONG_LOAIPHONG
AS
BEGIN
	select TENLOAIPHONG from LOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHONG_MAPHONG] */

CREATE PROC SP_PHONG_MAPHONG
AS
BEGIN
	select MAPHONG from PHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHONG_MAPHONG_TTLOAI] */

CREATE PROC SP_PHONG_MAPHONG_TTLOAI
@LOAIPHONG nvarchar(25)
AS
BEGIN
	select MAPHONG,TENLOAIPHONG,DONGIA  from PHONG inner join LOAIPHONG on LOAIPHONG.MALOAIPHONG = PHONG.MALOAIPHONG
	 WHERE LOAIPHONG.TENLOAIPHONG=@LOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_PHONG_MAPHONG_TTMA] */

CREATE PROC SP_PHONG_MAPHONG_TTMA
@MAPHONG nvarchar(25)
AS
BEGIN
	select MAPHONG,TENLOAIPHONG,DONGIA   from PHONG inner join LOAIPHONG on LOAIPHONG.MALOAIPHONG = PHONG.MALOAIPHONG
	 where MAPHONG=@MAPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_Sua] */

CREATE PROC SP_Phong_Sua
@MAPHONG NVARCHAR(25),@MALOAIPHONG NVARCHAR(25),
@TINHTRANG NVARCHAR(25),@SDT  NVARCHAR(25)
AS
BEGIN
         UPDATE PHONG SET MALOAIPHONG=@MALOAIPHONG,TINHTRANG=@TINHTRANG,SDT=@SDT
         WHERE MAPHONG = @MAPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_Them] */

CREATE PROC SP_Phong_Them
@MAPHONG NVARCHAR(25),@MALOAIPHONG NVARCHAR(25),
@TINHTRANG NVARCHAR(25),@SDT  NVARCHAR(25)
AS
BEGIN
         INSERT INTO PHONG VALUES(@MAPHONG,@MALOAIPHONG,@TINHTRANG,@SDT)
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_ThongTin] */

CREATE PROC SP_Phong_ThongTin
AS
BEGIN 
    SELECT DISTINCT MAPHONG,TENLOAIPHONG,TINHTRANG,SDT FROM PHONG
    INNER JOIN LOAIPHONG ON PHONG.MALOAIPHONG = LOAIPHONG.MALOAIPHONG
    
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_ThongTin_MA_TEN] */

CREATE PROC [dbo].[SP_Phong_ThongTin_MA_TEN]
AS
BEGIN 
    SELECT DISTINCT MALOAIPHONG,TENLOAIPHONG FROM  LOAIPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_TinhTrang] */

CREATE PROC SP_Phong_TinhTrang
@MAPHONG NVARCHAR(25)
AS
BEGIN
     SELECT TINHTRANG FROM PHONG WHERE MAPHONG=@MAPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_Phong_Xoa] */

CREATE PROC SP_Phong_Xoa
@MAPHONG NVARCHAR(25)
AS
BEGIN
     DELETE PHONG WHERE MAPHONG=@MAPHONG
END
GO

/* [QLKHACHSAN].[dbo].[SP_TaiKhoan_DoiMK] */

CREATE PROC SP_TaiKhoan_DoiMK
@USER NVARCHAR(25) ,@PASSWORD NVARCHAR(25)
AS
BEGIN
     UPDATE DANGNHAP SET PASSWORD=@PASSWORD  WHERE
     [USER]=@USER
END
GO

/* [QLKHACHSAN].[dbo].[SP_TaiKhoan_MK] */

CREATE PROC SP_TaiKhoan_MK
@USER NVARCHAR(25)
AS
BEGIN
     SELECT PASSWORD FROM DANGNHAP WHERE
     [USER]=@USER
END
GO

/* [QLKHACHSAN].[dbo].[SP_TaiKhoan_Ten] */

CREATE PROC SP_TaiKhoan_Ten
@USER NVARCHAR(25)
AS
BEGIN
     SELECT TENNV FROM DANGNHAP
     inner join NHANVIEN on DANGNHAP.MANV=NHANVIEN.MANV
      WHERE
     [USER]=@USER
END
GO

/* [QLKHACHSAN].[dbo].[VIEW_REPORT1] */

CREATE VIEW VIEW_REPORT1
AS
 
SELECT PHIEUTHUETRA.MAPHIEUTHUE,
       TENNV,
       PHONG.MAPHONG,
       PHIEUTHUETRA.NGAYTHUE,
       NGAYTRA,
       KHACH.MAKHACH,
       TENKHACH,
       CMND,
       DATEDIFF(DAY, PHIEUTHUETRA.NGAYTHUE, NGAYTRA) * SLNGUOI * LOAIPHONG.DONGIA AS 'TIENPHONG',
       SLDV * DICHVU.DONGIA AS 'TIENDICHVU',
       DATEDIFF(DAY, PHIEUTHUETRA.NGAYTHUE, NGAYTRA) * SLNGUOI * LOAIPHONG.DONGIA + SLDV * DICHVU.DONGIA AS 'TONG'
FROM   PHIEUTHUETRA
       LEFT JOIN KHACH
            ON  KHACH.MAKHACH = PHIEUTHUETRA.MAKHACH
       LEFT JOIN PHONG
            ON  PHONG.MAPHONG = PHIEUTHUETRA.MAPHONG
       LEFT JOIN LOAIPHONG
            ON  PHONG.MALOAIPHONG = LOAIPHONG.MALOAIPHONG
       LEFT JOIN NHANVIEN
            ON  NHANVIEN.MANV = PHIEUTHUETRA.MANV
       LEFT JOIN PHIEUDICHVU
            ON  PHIEUDICHVU.MAPHIEUTHUE = PHIEUTHUETRA.MAPHIEUTHUE
       LEFT JOIN DICHVU
            ON  DICHVU.MADV = PHIEUDICHVU.MADV
GO

/* [QLKHACHSAN].[dbo].[DANGNHAP] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DANGNHAP](
	[USER] [nvarchar](25) NOT NULL,
	[PASSWORD] [nvarchar](25) NOT NULL,
	[MANV] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[USER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DANGNHAP]  WITH CHECK ADD  CONSTRAINT [FK10] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DANGNHAP] CHECK CONSTRAINT [FK10]
GO

GO

/* [QLKHACHSAN].[dbo].[DICHVU] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DICHVU](
	[MADV] [nvarchar](25) NOT NULL,
	[TENDV] [nvarchar](30) NULL,
	[DONGIA] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MADV] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

GO

/* [QLKHACHSAN].[dbo].[KHACH] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[KHACH](
	[MAKHACH] [nvarchar](25) NOT NULL,
	[TENKHACH] [nvarchar](60) NULL,
	[NGAYSINH] [datetime] NULL,
	[GIOITINH] [nvarchar](25) NULL,
	[DIACHI] [nvarchar](60) NULL,
	[CMND] [int] NULL,
	[QUOCTICH] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAKHACH] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

GO

/* [QLKHACHSAN].[dbo].[LOAIPHONG] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LOAIPHONG](
	[MALOAIPHONG] [nvarchar](25) NOT NULL,
	[TENLOAIPHONG] [nvarchar](30) NULL,
	[DONGIA] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MALOAIPHONG] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

GO

/* [QLKHACHSAN].[dbo].[NHANVIEN] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NHANVIEN](
	[MANV] [nvarchar](25) NOT NULL,
	[TENNV] [nvarchar](60) NULL,
	[NGAYSINH] [datetime] NULL,
	[GIOITINH] [nvarchar](25) NULL,
	[DIACHI] [nvarchar](60) NULL,
	[SDT] [nvarchar](25) NULL,
	[CHUCVU] [nvarchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[MANV] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

GO

/* [QLKHACHSAN].[dbo].[PHIEUDICHVU] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PHIEUDICHVU](
	[MADV] [nvarchar](25) NULL,
	[MAPHIEUTHUE] [nvarchar](25) NULL,
	[SLDV] [int] NULL,
	[NGAYTHUE] [datetime] NULL,
	[TRANGTHAI] [nvarchar](30) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PHIEUDICHVU]  WITH CHECK ADD  CONSTRAINT [FK2] FOREIGN KEY([MADV])
REFERENCES [dbo].[DICHVU] ([MADV])
GO

ALTER TABLE [dbo].[PHIEUDICHVU] CHECK CONSTRAINT [FK2]
GO

ALTER TABLE [dbo].[PHIEUDICHVU]  WITH CHECK ADD  CONSTRAINT [FK3] FOREIGN KEY([MAPHIEUTHUE])
REFERENCES [dbo].[PHIEUTHUETRA] ([MAPHIEUTHUE])
GO

ALTER TABLE [dbo].[PHIEUDICHVU] CHECK CONSTRAINT [FK3]
GO

GO

/* [QLKHACHSAN].[dbo].[PHIEUTHUETRA] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PHIEUTHUETRA](
	[MAPHIEUTHUE] [nvarchar](25) NOT NULL,
	[MAPHONG] [nvarchar](25) NULL,
	[MAKHACH] [nvarchar](25) NULL,
	[NGAYTHUE] [datetime] NULL,
	[NGAYTRA] [datetime] NULL,
	[SLNGUOI] [int] NULL,
	[NGAYLAP] [datetime] NULL,
	[MANV] [nvarchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAPHIEUTHUE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PHIEUTHUETRA]  WITH CHECK ADD  CONSTRAINT [FK4] FOREIGN KEY([MAPHONG])
REFERENCES [dbo].[PHONG] ([MAPHONG])
GO

ALTER TABLE [dbo].[PHIEUTHUETRA] CHECK CONSTRAINT [FK4]
GO

ALTER TABLE [dbo].[PHIEUTHUETRA]  WITH CHECK ADD  CONSTRAINT [FK5] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO

ALTER TABLE [dbo].[PHIEUTHUETRA] CHECK CONSTRAINT [FK5]
GO

ALTER TABLE [dbo].[PHIEUTHUETRA]  WITH CHECK ADD  CONSTRAINT [FK6] FOREIGN KEY([MAKHACH])
REFERENCES [dbo].[KHACH] ([MAKHACH])
GO

ALTER TABLE [dbo].[PHIEUTHUETRA] CHECK CONSTRAINT [FK6]
GO

GO

/* [QLKHACHSAN].[dbo].[PHONG] */

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PHONG](
	[MAPHONG] [nvarchar](25) NOT NULL,
	[MALOAIPHONG] [nvarchar](25) NULL,
	[TINHTRANG] [nvarchar](25) NULL,
	[SDT] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MAPHONG] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PHONG]  WITH CHECK ADD  CONSTRAINT [FK1] FOREIGN KEY([MALOAIPHONG])
REFERENCES [dbo].[LOAIPHONG] ([MALOAIPHONG])
GO

ALTER TABLE [dbo].[PHONG] CHECK CONSTRAINT [FK1]
GO

GO
