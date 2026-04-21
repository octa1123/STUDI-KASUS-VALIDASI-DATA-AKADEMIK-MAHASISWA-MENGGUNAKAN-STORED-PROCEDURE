DROP PROCEDURE IF EXISTS bagianA;
DELIMITER //

CREATE PROCEDURE bagianA()
BEGIN
    DECLARE nama VARCHAR(50) DEFAULT 'Nur Octavia';
    DECLARE nim VARCHAR(20) DEFAULT '2411038';
    DECLARE semester INT DEFAULT 4;
    DECLARE prodi VARCHAR(50) DEFAULT 'Informatika';
    DECLARE kampus VARCHAR(100) DEFAULT 'Universitas Mega Buana Palopo';

    SELECT CONCAT(
        'Mahasiswa ', nama, ' (', nim, ') dari Program Studi ',
        prodi, ' terdaftar di ', kampus,
        ' pada semester ', semester, '.'
    ) AS Output;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS bagianB;
DELIMITER //

CREATE PROCEDURE bagianB()
BEGIN
    DECLARE v_sks INT DEFAULT 15;
    DECLARE v_ipk DECIMAL(3,2) DEFAULT 3.20;
    DECLARE v_semester INT DEFAULT 4;
    DECLARE v_pembayaran VARCHAR(10) DEFAULT 'LUNAS';

    DECLARE v_status VARCHAR(20);
    DECLARE v_beban VARCHAR(20);
    DECLARE v_performa VARCHAR(30);

    IF v_pembayaran = 'LUNAS' AND v_sks > 0 AND v_semester > 0 THEN
        SET v_status = 'Valid';
    ELSE
        SET v_status = 'Tidak Valid';
    END IF;

    IF v_sks BETWEEN 1 AND 12 THEN
        SET v_beban = 'Ringan';
    ELSEIF v_sks BETWEEN 13 AND 18 THEN
        SET v_beban = 'Sedang';
    ELSE
        SET v_beban = 'Padat';
    END IF;

    IF v_ipk >= 3.50 THEN
        SET v_performa = 'Sangat Baik';
    ELSEIF v_ipk >= 3.00 THEN
        SET v_performa = 'Baik';
    ELSEIF v_ipk >= 2.50 THEN
        SET v_performa = 'Cukup';
    ELSE
        SET v_performa = 'Perlu Pembinaan';
    END IF;

    SELECT 
        v_status AS Status_Data,
        v_beban AS Beban_Studi,
        v_performa AS Performa_Akademik;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS bagianC;
DELIMITER $$

CREATE PROCEDURE bagianC(
    IN p_pembayaran VARCHAR(15),
    IN p_sks INT,
    IN p_semester INT
)
BEGIN
    DECLARE v_nama VARCHAR(50) DEFAULT 'Nur Octavia';
    DECLARE v_nim VARCHAR(20) DEFAULT '2411038';
    DECLARE v_ipk DECIMAL(3,2) DEFAULT 3.20;

    DECLARE v_status VARCHAR(20);
    DECLARE v_beban VARCHAR(20);
    DECLARE v_performa VARCHAR(30);
    DECLARE v_kelayakan VARCHAR(20);
    DECLARE v_alasan VARCHAR(100);

    IF p_pembayaran = 'LUNAS' AND p_sks > 0 AND p_semester > 0 THEN
        SET v_status = 'Valid';
        SET v_kelayakan = 'LAYAK';
        SET v_alasan = 'Semua syarat terpenuhi';
    ELSE
        SET v_status = 'Tidak Valid';
        SET v_kelayakan = 'TIDAK LAYAK';

        IF p_pembayaran <> 'LUNAS' THEN
            SET v_alasan = 'Pembayaran UKT belum lunas';
        ELSEIF p_sks <= 0 THEN
            SET v_alasan = 'Jumlah SKS tidak memenuhi syarat';
        ELSE
            SET v_alasan = 'Semester tidak valid';
        END IF;
    END IF;

    IF p_sks BETWEEN 1 AND 12 THEN
        SET v_beban = 'Ringan';
    ELSEIF p_sks BETWEEN 13 AND 18 THEN
        SET v_beban = 'Sedang';
    ELSE
        SET v_beban = 'Padat';
    END IF;

    IF v_ipk >= 3.50 THEN
        SET v_performa = 'Sangat Baik';
    ELSEIF v_ipk >= 3.00 THEN
        SET v_performa = 'Baik';
    ELSEIF v_ipk >= 2.50 THEN
        SET v_performa = 'Cukup';
    ELSE
        SET v_performa = 'Perlu Pembinaan';
    END IF;

    SELECT CONCAT(
        'Mahasiswa ', v_nama, ' (NIM ', v_nim, ') dinyatakan ',
        v_kelayakan, ' mengambil KRS. ',
        'Beban studi: ', v_beban, ', ',
        'Performa: ', v_performa, '. ',
        'Alasan: ', v_alasan, '.'
    ) AS Hasil;
END $$

DELIMITER ;
DROP PROCEDURE IF EXISTS bagianD;
DELIMITER //

CREATE PROCEDURE bagianD()
BEGIN
    DECLARE nama1 VARCHAR(50) DEFAULT 'Jeniati';
    DECLARE nim1 VARCHAR(20) DEFAULT '2411023';
    DECLARE ipk1 DECIMAL(3,2) DEFAULT 3.20;
    DECLARE sks1 INT DEFAULT 15;

    DECLARE nama2 VARCHAR(50) DEFAULT 'Mersi';
    DECLARE nim2 VARCHAR(20) DEFAULT '2411045';
    DECLARE ipk2 DECIMAL(3,2) DEFAULT 3.60;
    DECLARE sks2 INT DEFAULT 18;

    DECLARE hasil VARCHAR(255);

    IF ipk1 > ipk2 THEN
        SET hasil = CONCAT(
            'Mahasiswa ', nama1, ' lebih baik dari ', nama2,
            ' karena memiliki IPK lebih tinggi (', ipk1, ' > ', ipk2, '). ',
            'Berdasarkan aturan, IPK menjadi indikator utama dalam menentukan performa akademik mahasiswa.'
        );

    ELSEIF ipk2 > ipk1 THEN
        SET hasil = CONCAT(
            'Mahasiswa ', nama2, ' lebih baik dari ', nama1,
            ' karena memiliki IPK lebih tinggi (', ipk2, ' > ', ipk1, '). ',
            'Berdasarkan aturan, IPK menjadi indikator utama dalam menentukan performa akademik mahasiswa.'
        );

    ELSE
        IF sks1 > sks2 THEN
            SET hasil = CONCAT(
                'Mahasiswa ', nama1, ' lebih baik dari ', nama2,
                ' karena jumlah SKS lebih tinggi (', sks1, ' > ', sks2, ').'
            );
        ELSEIF sks2 > sks1 THEN
            SET hasil = CONCAT(
                'Mahasiswa ', nama2, ' lebih baik dari ', nama1,
                ' karena jumlah SKS lebih tinggi (', sks2, ' > ', sks1, ').'
            );
        ELSE
            SET hasil = 'Kedua mahasiswa memiliki performa akademik yang sama.';
        END IF;
    END IF;

    SELECT 
        CONCAT('Mahasiswa 1: ', nama1, ' (NIM ', nim1, ', IPK ', ipk1, ', SKS ', sks1, ')') AS Mhs1,
        CONCAT('Mahasiswa 2: ', nama2, ' (NIM ', nim2, ', IPK ', ipk2, ', SKS ', sks2, ')') AS Mhs2,
        hasil AS Kesimpulan;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS skenario_valid;
DELIMITER //
CREATE PROCEDURE skenario_valid()
BEGIN
    CALL bagianC('LUNAS', 15, 4);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS skenario_tidak_lunas;
DELIMITER //
CREATE PROCEDURE skenario_tidak_lunas()
BEGIN
    CALL bagianC('BELUM LUNAS', 15, 4);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS skenario_sks0;
DELIMITER //
CREATE PROCEDURE skenario_sks0()
BEGIN
    CALL bagianC('LUNAS', 0, 4);
END //
DELIMITER ;