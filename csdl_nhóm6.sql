﻿CREATE DATABASE THCSDL_NHOM6;
GO
USE THCSDL_NHOM6;

CREATE TABLE KHACHHANG (
    MAKHACHHANG CHAR(6) PRIMARY KEY,
    TENCONGTY NVARCHAR(30) NOT NULL,
    TENGIAODICH NVARCHAR(30) NOT NULL,
    DIACHI NVARCHAR(90) NOT NULL,
    EMAIL NVARCHAR(40) UNIQUE,
    DIENTHOAI CHAR(11) NOT NULL,
    FAX VARCHAR(15)
);

CREATE TABLE NHANVIEN (
    MANHANVIEN CHAR(6) PRIMARY KEY,
    HO NVARCHAR(10) NOT NULL,
    TEN NVARCHAR(10) NOT NULL,
    NGAYSINH DATE CHECK(NGAYSINH < GETDATE()),
    NGAYLAMVIEC DATE CHECK(NGAYLAMVIEC <= GETDATE()),
    DIACHI NVARCHAR(255) NOT NULL,
    DIENTHOAI CHAR(11) UNIQUE,
    LUONGCOBAN DECIMAL(10, 2) CHECK(LUONGCOBAN > 0),
    PHUCAP DECIMAL(10, 2) CHECK(PHUCAP >= 0),
    CONSTRAINT CHK_NHANVIEN_AGE CHECK (
        DATEDIFF(YEAR, NGAYSINH, GETDATE()) >= 18 AND
        DATEDIFF(YEAR, NGAYSINH, GETDATE()) <= 60
    )
);

CREATE TABLE NHACUNGCAP (
    MACONGTY CHAR(20) PRIMARY KEY NOT NULL,
    TENCONGTY VARCHAR(100) NOT NULL,
    TENGIAODICH VARCHAR(100) NOT NULL,
    DIACHI VARCHAR(255),
    DIEN_THOAI CHAR(11) UNIQUE,
    FAX CHAR(15) UNIQUE,
    EMAIL VARCHAR(100) UNIQUE
);

CREATE TABLE LOAIHANG (
    MALOAIHANG CHAR(6) PRIMARY KEY,
    TENLOAIHANG VARCHAR(50)
);

CREATE TABLE MATHANG (
    MAHANG CHAR(6) PRIMARY KEY,
    TENHANG VARCHAR(50),
    MACONGTY CHAR(20),
    MALOAIHANG CHAR(6),
    SOLUONG INT CHECK(SOLUONG >= 0),
    DONVITINH VARCHAR(50),
    GIAHANG DECIMAL(10, 2) CHECK(GIAHANG >= 0),
    FOREIGN KEY (MACONGTY) REFERENCES NHACUNGCAP(MACONGTY),
    FOREIGN KEY (MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG)
);

CREATE TABLE DONDATHANG (
    SOHOADON INT PRIMARY KEY,
    MAKHACHANG CHAR(6),
    MANHANVIEN CHAR(6),
    NGAYDATHANG DATETIME NOT NULL,
    NGAYGIAOHANG DATETIME,
    NGAYCHUYENHANG DATETIME,
    NOIGIAOHANG VARCHAR(30) NOT NULL,
    FOREIGN KEY (MAKHACHANG) REFERENCES KHACHHANG(MAKHACHHANG),
    FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN),
    CHECK (NGAYGIAOHANG >= NGAYDATHANG),
    CHECK (NGAYCHUYENHANG >= NGAYDATHANG)
);

CREATE TABLE CHITIETDATHANG (
    SOHOADON INT NOT NULL,
    MAHANG CHAR(6) NOT NULL,
    GIABAN DECIMAL(5,2) CHECK(GIABAN >= 0),
    SOLUONG INT DEFAULT 1 CHECK(SOLUONG >= 0),
    MUCGIAMGIA DECIMAL(5,2) DEFAULT 0 CHECK(MUCGIAMGIA >= 0),
    PRIMARY KEY (SOHOADON, MAHANG),
    FOREIGN KEY (SOHOADON) REFERENCES DONDATHANG(SOHOADON),
    FOREIGN KEY (MAHANG) REFERENCES MATHANG(MAHANG)
);