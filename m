Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04806214409
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887736; cv=pass; b=SXD69hFT2fk8yc/uJce207rzo3Aq2MOoukthJ1EsMAPHXQrCrANA+a0Y5pg39uaUpq80cl2JGmFAFOjllhMTvhl4FmVVXCi7ytSEVsG+7BrtINSHRfk4Jg7BzLCX0HM7/s5xAT+7vlp9t7QRXiS/XsDAW8eaQHKv6oBpBQ1vGzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887736; c=relaxed/simple;
	bh=bFBF1fU/1hCUug9kd0yo6iuELjwChWvS4TF228+hrmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHIaryuqvPfIX/Lq53APubaWVazZsB1c4nk9r3WWP5iAw5x7gLU44Ephlt6t/Gzm53TwRofVjOgD/aNGWuX3QC+NOjysIDo8mqhvqgqm+c9viIp2Wyzkso9mLtNhE6SmqfOi7JXTx0EeKY3FpIUVBK7i/knrw/MzVxYVeUaGs20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=YOamJ3av; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Oy++wSu1; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="YOamJ3av";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Oy++wSu1"
ARC-Seal: i=1; a=rsa-sha256; t=1729887719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QtriEa8/k+Sa92y9R0ffn/tMYBnWaMGtEf5Kra8KLqsrGx/SG4/RPq/EJOUTviS61E
    ztc+P4GjPHHQ7cGM3zsokeuyVeRzkvsISDBVa4FznaEh+C1ghuvRTwtw2wQUBSlywugz
    miVI5YAwVf8CN7gTgxTKj6aGCYQzHLaKTY/vUnF6g/S4JRuIC+KzVy/FhUKQyisaBa9t
    6I1+BSSQtQUcZJCXZhgO42I0Fk7K1EKp1jYuQwL/rCb/qrrXeoTTTMbkrM4cn1EsUWxi
    10hqzgYj26Tl7A9GgEsuCjAJA+yXwvmiO1u23t5/urEdeslJpyzEWRGHw1wiuZUyFIR2
    Omtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=k3Sjiggo0lZRu9KiyTS7uTb1sqtbe6N9KUJ3E0dKihc=;
    b=sDq8zgX5VovgckXvuEWZL1Gv/B6XBLpPonSntgEL2KSdhoowQI3NaweiAg3ZvR2mpD
    BVz0XWs92Jxi3UkLnAG9MvHqrWCztNUbJ3iWkER/6MqfsIPVdp1/wPIY/sOFZVWwdgWd
    LzutmJDNctiUjWZcELPHvAuC3oe7nG4mVYjRJ1DJJVwW9664A/hngqU9KiBzsM+5I/m3
    7XGKm7Nt7yUGE8AvCoGEv0CW25fMAZO9GZBYz2GuPmgoYkLgOWZc9gT+ORRmpQqWa2do
    Dp/V/9C/CgPr3EusPphEuPqjKpcZkmsae22TBr6bCXCCa017//evJA53ZVgc3/Pz/RTx
    y6Nw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=k3Sjiggo0lZRu9KiyTS7uTb1sqtbe6N9KUJ3E0dKihc=;
    b=YOamJ3avEMMkoS2sztHio+4kr7LEnQ4jZaHROhErThfA97kvRze+CGHZHSPABwOENf
    pKhTP8e1n430mcCVvsN8AUYZs+u3C1cSuSEVGBGLJgELZKi/4WS4k/toKG97JGEAdNk1
    dW0JPMUoHdPoTu+BMZ90s8f7Hj/SAwkAbTeZsFWnbq3ExluMCXGaz3ch6d1gEf5oAoQr
    woJf+cmDzbUwH6KEn4qZMd/zIu9KoJ2ba07ok/3cuivDXkvkByHTac+6KZjraUUyO+Qm
    u5xQ5usFCKdVPPyTkUql7IeW0kBfDrnoKwZY4e5Ju/GhvNN+7hOuABUMv7xyCgrjCbBI
    AV/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=k3Sjiggo0lZRu9KiyTS7uTb1sqtbe6N9KUJ3E0dKihc=;
    b=Oy++wSu1wsbKGXJ1QOkS63cwc5e1tLoHOMvSG4wSFsU+IfhGrm3fGf7JS7Uzv5wyQw
    gkqaWTKzWhbeuSFbKsAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKLxbew
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:21:59 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 1/5] mmc-utils: Refactor common FFU code into functions to support additional FFU modes
Date: Fri, 25 Oct 2024 22:21:44 +0200
Message-Id: <20241025202148.161586-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025202148.161586-1-beanhuo@iokpp.de>
References: <20241025202148.161586-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Refactor common FFU code into functions to support additional FFU modes. Follow-up
patches will focus on implementing additional FFU modes and enhancements.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 326 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 207 insertions(+), 119 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3b1bcf4..1a35431 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -29,6 +29,7 @@
 #include <stdint.h>
 #include <assert.h>
 #include <linux/fs.h> /* for BLKGETSIZE */
+#include <stdbool.h>
 
 #include "mmc.h"
 #include "mmc_cmds.h"
@@ -2810,7 +2811,7 @@ out:
 	return ret;
 }
 
-static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
+static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
 			       off_t offset)
 {
@@ -2831,91 +2832,81 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
 }
 
-int do_ffu(int nargs, char **argv)
+/*
+ * Retrieves the number of sectors programmed during FFU download.
+ *
+ * @dev_fd:  File descriptor for the eMMC device.
+ * @ext_csd: Pointer to the buffer holding the Extended CSD register data of the eMMC device.
+ *
+ * Return: The number of sectors programmed, or -1 if reading the EXT_CSD fails.
+ */
+static int get_ffu_sectors_programmed(int dev_fd, __u8 *ext_csd)
 {
-	int dev_fd, img_fd;
-	int retry = 3, ret = -EINVAL;
-	unsigned int sect_size;
-	__u8 ext_csd[512];
-	__u8 *buf = NULL;
-	off_t fw_size, bytes_left, off;
-	char *device;
-	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
-	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
-	__u32 sect_done = 0;
-
-	assert (nargs == 3 || nargs == 4);
 
-	device = argv[2];
-	dev_fd = open(device, O_RDWR);
-	if (dev_fd < 0) {
-		perror("device open failed");
-		exit(1);
-	}
-	img_fd = open(argv[1], O_RDONLY);
-	if (img_fd < 0) {
-		perror("image open failed");
-		close(dev_fd);
-		exit(1);
+	if (read_extcsd(dev_fd, ext_csd)) {
+		fprintf(stderr, "Could not read EXT_CSD\n");
+		return -1;
 	}
 
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		goto out;
-	}
+	return per_byte_htole32((__u8 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
+}
+
+static bool ffu_is_supported(__u8 *ext_csd, char *device)
+{
 
 	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
-		fprintf(stderr,
-			"The FFU feature is only available on devices >= "
+		fprintf(stderr, "The FFU feature is only available on devices >= "
 			"MMC 5.0, not supported in %s\n", device);
-		goto out;
+		return false;
 	}
 
 	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
 		fprintf(stderr, "FFU is not supported in %s\n", device);
-		goto out;
+		return false;
 	}
 
 	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
 		fprintf(stderr, "Firmware update was disabled in %s\n", device);
-		goto out;
+		return false;
 	}
 
-	fw_size = lseek(img_fd, 0, SEEK_END);
-	if (fw_size == 0) {
-		fprintf(stderr, "Wrong firmware size");
-		goto out;
-	}
+	return true;
+}
 
+/*
+ * Performs FFU download of the firmware bundle.
+ *
+ * @dev_fd:     File descriptor for the eMMC device on which the ioctl command will be performed.
+ * @ext_csd:    Extended CSD register data of the eMMC device.
+ * @fw_buf:     Pointer to the firmware buffer containing the firmware data to be downloaded.
+ * @fw_size:    Size of the firmware in bytes.
+ * @chunk_size: Size of the chunks in which the firmware is sent to the device.
+ *
+ * Return: If successful, returns the number of sectors programmed.
+ *         On failure, returns a negative error number.
+ */
+static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
+							unsigned int chunk_size)
+{
+	int ret;
+	__u8 num_of_cmds = 4;
+	off_t bytes_left, off;
+	unsigned int bytes_per_loop, retry = 3;
+	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+
+	if (!fw_buf || !ext_csd) {
+		fprintf(stderr, "unexpected NULL pointer\n");
+		return -EINVAL;
+	}
 	/* allocate maximum required */
-	buf = malloc(fw_size);
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
-				4 * sizeof(struct mmc_ioc_cmd));
-	if (!buf || !multi_cmd) {
+				num_of_cmds * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
 		perror("failed to allocate memory");
-		goto out;
-	}
-
-	/* ensure fw is multiple of native sector size */
-	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
-	if (fw_size % sect_size) {
-		fprintf(stderr, "Firmware data size (%jd) is not aligned!\n", (intmax_t)fw_size);
-		goto out;
-	}
-
-	if (nargs == 4) {
-		default_chunk = strtol(argv[3], NULL, 10);
-		if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
-			fprintf(stderr, "Invalid chunk size");
-			goto out;
-		}
+		return -ENOMEM;
 	}
 
 	/* prepare multi_cmd for FFU based on cmd to be used */
-
-	multi_cmd->num_of_cmds = 4;
-
 	/* put device into ffu mode */
 	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
 			EXT_CSD_FFU_MODE);
@@ -2924,25 +2915,18 @@ int do_ffu(int nargs, char **argv)
 	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
 			EXT_CSD_NORMAL_MODE);
 
-	/* read firmware */
-	lseek(img_fd, 0, SEEK_SET);
-	if (read(img_fd, buf, fw_size) != fw_size) {
-		perror("Could not read the firmware file: ");
-		ret = -ENOSPC;
-		goto out;
-	}
-
 do_retry:
 	bytes_left = fw_size;
 	off = 0;
+	multi_cmd->num_of_cmds = num_of_cmds;
+
 	while (bytes_left) {
-		unsigned int chunk_size = bytes_left < default_chunk ?
-					  bytes_left : default_chunk;
+		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
 
-		/* send ioctl with multi-cmd */
+		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
 
 		if (ret) {
@@ -2955,83 +2939,187 @@ do_retry:
 			goto out;
 		}
 
-		bytes_left -= chunk_size;
-		off += chunk_size;
+		ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
+		if (ret <= 0) {
+			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			/*
+			 * By spec, host should re-start download from the first sector if
+			 * programmed count is 0
+			 */
+			if (ret == 0 && retry > 0) {
+				retry--;
+				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+				goto do_retry;
+			}
+			fprintf(stderr, "Programming failed! Aborting...\n");
+			goto out;
+		} else {
+			fprintf(stderr,
+				"Programmed %d/%jd bytes\r", ret * 512, (intmax_t)fw_size);
+		}
+
+		bytes_left -= bytes_per_loop;
+		off += bytes_per_loop;
 	}
 
-	/*
-	 * By spec - check if mode operation codes are supported in ffu features,
-	 * if not then skip checking number of sectors programmed after install
-	 */
-	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
-		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
-		ret = 0;
+	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
+out:
+	free(multi_cmd);
+	return ret;
+}
+
+static int do_ffu_install(int dev_fd, const char *device)
+{
+	int ret;
+	__u8 ext_csd[512];
+	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + 2 * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	/* Re-enter ffu mode and install the firmware */
+	multi_cmd->num_of_cmds = 2;
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES, EXT_CSD_FFU_INSTALL);
+
+	/* send ioctl with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	if (ret) {
+		perror("Multi-cmd ioctl failed setting install mode");
+		fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[1]);
 		goto out;
 	}
 
+	/* Check FFU install status */
 	ret = read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
 		goto out;
 	}
 
-	/* Test if we need to restart the download */
-	sect_done = per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
-	/* By spec, host should re-start download from the first sector if sect_done is 0 */
-	if (sect_done == 0) {
-		if (retry--) {
-			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
-			goto do_retry;
+	/* Return status */
+	ret = ext_csd[EXT_CSD_FFU_STATUS];
+out:
+	free(multi_cmd);
+	return ret;
+}
+
+int do_ffu(int nargs, char **argv)
+{
+	int dev_fd, img_fd;
+	int ret = -EINVAL;
+	unsigned int sect_size;
+	__u8 ext_csd[512];
+	__u8 *fw_buf = NULL;
+	off_t fw_size;
+	char *device;
+	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
+
+	assert(nargs == 3 || nargs == 4);
+	if (nargs == 4) {
+		default_chunk = strtol(argv[3], NULL, 10);
+		if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
+			fprintf(stderr, "Invalid chunk size");
+			exit(1);
 		}
-		fprintf(stderr, "Programming failed! Aborting...\n");
+	}
+
+	device = argv[2];
+	dev_fd = open(device, O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open failed");
+		exit(1);
+	}
+	img_fd = open(argv[1], O_RDONLY);
+	if (img_fd < 0) {
+		perror("image open failed");
+		close(dev_fd);
+		exit(1);
+	}
+
+	fw_size = lseek(img_fd, 0, SEEK_END);
+	if (fw_size == 0) {
+		fprintf(stderr, "Wrong firmware size");
 		goto out;
 	}
 
-	if ((sect_done * sect_size) == fw_size) {
-		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
-		fprintf(stderr, "Programming finished with status %d \n", ret);
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
 	}
-	else {
-		fprintf(stderr, "FW size and number of sectors written mismatch. Status return %d\n", ret);
+
+	/* Check if FFU is supported by eMMC device */
+	if (!ffu_is_supported(ext_csd, device)) {
+		ret = -ENOTSUP;
 		goto out;
 	}
 
-	fprintf(stderr, "Installing firmware on %s...\n", device);
-	/* Re-enter ffu mode and install the firmware */
-	multi_cmd->num_of_cmds = 2;
+	/* Ensure FW is multiple of native sector size */
+	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
+	if (fw_size % sect_size) {
+		fprintf(stderr, "Firmware data size (%jd) is not aligned!\n", (intmax_t)fw_size);
+		ret = -EINVAL;
+		goto out;
+	}
 
-	/* set ext_csd to install mode */
-	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES,
-			EXT_CSD_FFU_INSTALL);
+	/* Allocate the firmware buffer with the maximum required size */
+	fw_buf = malloc(fw_size);
+	if (!fw_buf) {
+		perror("failed to allocate memory");
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	/* send ioctl with multi-cmd */
-	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	/* Read firmware */
+	lseek(img_fd, 0, SEEK_SET);
+	if (read(img_fd, fw_buf, fw_size) != fw_size) {
+		perror("Could not read the firmware file: ");
+		ret = -ENOSPC;
+		goto out;
+	}
 
-	if (ret) {
-		perror("Multi-cmd ioctl failed setting install mode");
-		/* In case multi-cmd ioctl failed before exiting from ffu mode */
-		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+	/* Download firmware bundle */
+	ret = do_ffu_download(dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	/* Check programmed sectors */
+	if (ret > 0 && (ret * 512) == fw_size) {
+		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
+	} else {
+		if (ret > 0 && (ret * 512) != fw_size)
+			fprintf(stderr, "FW size %jd and bytes %d programmed mismatch.\n",
+					(intmax_t)fw_size,  ret * 512);
+		else
+			fprintf(stderr, "Firmware bundle download failed with status %d\n", ret);
+
+		ret = -EIO;
 		goto out;
 	}
 
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+	/*
+	 * By spec - check if MODE_OPERATION_CODES is supported in FFU_FEATURES, if not, proceed
+	 * with CMD0/HW Reset/Power cycle to complete the installation
+	 */
+	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
+		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
+		ret = 0;
 		goto out;
 	}
 
-	/* return status */
-	ret = ext_csd[EXT_CSD_FFU_STATUS];
-	if (ret) {
+	fprintf(stderr, "Installing firmware on %s...\n", device);
+	ret = do_ffu_install(dev_fd, device);
+	if (ret)
 		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
-		goto out;
-	} else {
+	else
 		fprintf(stderr, "FFU finished successfully\n");
-	}
 
 out:
-	free(buf);
-	free(multi_cmd);
+	if (fw_buf)
+		free(fw_buf);
 	close(img_fd);
 	close(dev_fd);
 	return ret;
-- 
2.34.1

