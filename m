Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924C1925B8
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815307; cv=pass; b=MLVvJhO6VosOPKtmguSBWerRHDnojiLCx7xGmiRoPQdR/82Xpr0vLJnYyKWeTSpk/jXx0XrXKY3pmoyCSQJ7j57Zt8SxeConCWTxwsF5CwjFEAPo1Q0PxcMpAKt2Hj4klQ1OvBcA18uAiwdIqk8X0Yob8z7JLdEmUQOnusg/LP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815307; c=relaxed/simple;
	bh=VwFqgswiA/G0KBdlrcOQ4cV5ZzlptNG38edXKtZMnas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/bHIEve+fQOjV7TwRRuyxZcohnHu5ySBEJMwO8h0b6+6Z/SnnqBqP8GzGoQitogUG97FSnlF5HPI9UXko4GfGwNzivhFldn0Nhw6p6cgRj8G15bQHuPqqSvw6WbHQK7cNgD1RQW42bQ/QtLbi1JS8+B/VA1AsFy9E5li0qkWMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=DyrsegBE; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=40Sk90hw; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="DyrsegBE";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="40Sk90hw"
ARC-Seal: i=1; a=rsa-sha256; t=1727815120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qq/kIL6o2/+1ydrGXYwLyIhRG2OjP+jEnm54kaEmDmxCGq53yZKbTzNt8YFGXN84Hs
    gVAEYDBCcbhIOIaqJ9h9ErFPUOMq/fY6/oBRdbFulB0J5A4ozIXVx4a/fn+p7ZVqYGpm
    3Qo7RQeX0JS+s0EBzr9KhuECX0w6IEcDvjPYZ2RevbWmhr9AISoAjRN0LNyMlVGMPsJA
    ULp9StUr5vmzOJIUS26wknyZEPDgAwSARDg8lN8nddw6DijKcD9RRxofm8eiQBTNecM1
    k2Dhlbag9mFBOXB2KzIsOcjT3TQBWwMHo5uQXO/GzUmXUY2N74G3IEdYSrmOWXLiwqWp
    R8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qofpX6R9XkkIFx8NFoA1GL1XUqXOxBJk0ms21KuXZbI=;
    b=iT/n1+EJBTI4uAvAoJV+CjnrvcaDCAF4rjkQ6HDQ19JtVZ7ni12TdD1UBKBFc0oWGt
    xeHz4rK9jyRBVLGsGdCOV0cXxjw6JUNdmLBMpCnMktR1dRETYURSFd/sRvMludTQTkkQ
    GcIbhrNevoIy2Ho0NAX7AQGIKqlI0zCbCPnReVzDC9Jy8KSiiy0Fddc6ijalPnZgRsVA
    LzekHm4Q5xObkuMQ1W8aVWli1ggPJanwqwIU4MJ1cj9QK7FTQpTjRpHH+jiswgltdHa6
    XwX7E38C0nGIV82W5oIucmONLqdSqfqbrotvUmG1tIFN8q3iniAbiztSW9bM0+3aoniL
    Q5uA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qofpX6R9XkkIFx8NFoA1GL1XUqXOxBJk0ms21KuXZbI=;
    b=DyrsegBEHtbqXurpELtqGDndGycRMUmdxqhpDpoQODESCnfHRtmyJQntJKMDjbVttl
    TFkfKzysNQayl243Syg02PWNphT45bZkREVkzd9F1Urn4tdzs7JT/queCdrKlAGrAgB2
    qqohnHn66FjtvF3jVJqU0nmu38tyl8dm/JURPZVsJG+4hs5pefAIH1VBeV4vxBjqGASY
    sXkP7TgIJvjTe3OOrbqHbgMIqHLuxMEG3uQvAVWsGNi/hR+wxMC+OL3ToZNFjbj69Dkm
    ETI/hM9oumrA6r2PA35sj5pp+gUdxwXVY14GAcptKGZy+j1OYf7HWp39q2xnCQ651lGe
    6T1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qofpX6R9XkkIFx8NFoA1GL1XUqXOxBJk0ms21KuXZbI=;
    b=40Sk90hwZH229MD+0KdWhZW7uHia0uZIVrUfOlx6pLmWM96YbxJsl4yScXK8VrsjRi
    Xi1HaXGtw2ZhMxHcgMDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcecdf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:40 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 1/5] mmc_utils: Extract FFU code to mmc_ffu.c for future FFU mode expansion
Date: Tue,  1 Oct 2024 22:38:07 +0200
Message-Id: <20241001203811.26279-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001203811.26279-1-beanhuo@iokpp.de>
References: <20241001203811.26279-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Refactor FFU functionality by extracting existing FFU code from `mmc_cmds.c` into a dedicated file,
`mmc_ffu.c`. Updated `do_ffu` in `mmc_utils` to reflect the new structure and interface. This
restructuring provides better code organization and a clearer separation of concerns, making it
easier to maintain and extend FFU functionality.

Follow-up patches will focus on implementing additional FFU modes and enhancements.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 Makefile   |   1 +
 mmc.c      |  11 +-
 mmc_cmds.c | 274 --------------------------------------------
 mmc_cmds.h |  52 +++++++++
 mmc_ffu.c  | 324 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 384 insertions(+), 278 deletions(-)
 create mode 100644 mmc_ffu.c

diff --git a/Makefile b/Makefile
index 06ae0f7..35aca6c 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,7 @@ objects = \
 	mmc.o \
 	mmc_cmds.o \
 	lsmmc.o \
+	mmc_ffu.o \
 	3rdparty/hmac_sha/hmac_sha2.o \
 	3rdparty/hmac_sha/sha2.o
 
diff --git a/mmc.c b/mmc.c
index 2c5b9b5..52c5a89 100644
--- a/mmc.c
+++ b/mmc.c
@@ -227,11 +227,14 @@ static struct Command commands[] = {
 		  "The device path should specify the scr file directory.",
 	  NULL
 	},
-	{ do_ffu, -2,
-	  "ffu", "<image name> <device> [chunk-bytes]\n"
+	{ do_ffu, -4,
+	  "ffu", "-i <image name> -p <device> [ -c <chunk-bytes>] [-m <ffu_mode>]\n"
 		"Run Field Firmware Update with <image name> on <device>.\n"
-		"[chunk-bytes] is optional and defaults to its max - 512k. "
-		"should be in decimal bytes and sector aligned.\n",
+		"[-c <chunk-bytes>] is optional and defaults to its max - 512k. "
+		"should be in decimal bytes and sector aligned.\n"
+		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
+		" -m 1: Default mode, utilizing the CMD6+CMD23+CMD25+CMD6 command sequence. This \n"
+		" may exit FFU mode during firmware bundle downloading if FW size exceeds the chunk size. \n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3b1bcf4..22ab7d9 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -58,41 +58,6 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
-static inline __u32 per_byte_htole32(__u8 *arr)
-{
-	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
-}
-
-static int read_extcsd(int fd, __u8 *ext_csd)
-{
-	int ret = 0;
-	struct mmc_ioc_cmd idata;
-	memset(&idata, 0, sizeof(idata));
-	memset(ext_csd, 0, sizeof(__u8) * 512);
-	idata.write_flag = 0;
-	idata.opcode = MMC_SEND_EXT_CSD;
-	idata.arg = 0;
-	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	idata.blksz = 512;
-	idata.blocks = 1;
-	mmc_ioc_cmd_set_data(idata, ext_csd);
-
-	ret = ioctl(fd, MMC_IOC_CMD, &idata);
-	if (ret)
-		perror("ioctl");
-
-	return ret;
-}
-
-static void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8 value)
-{
-	cmd->opcode = MMC_SWITCH;
-	cmd->write_flag = 1;
-	cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) | (index << 16) |
-		   (value << 8) | EXT_CSD_CMD_SET_NORMAL;
-	cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-}
-
 static int
 write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 {
@@ -2101,18 +2066,6 @@ struct rpmb_frame {
 	u_int16_t req_resp;
 };
 
-static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
-				  int write_flag, unsigned int blocks,
-				  __u32 arg)
-{
-	ioc->opcode = opcode;
-	ioc->write_flag = write_flag;
-	ioc->arg = arg;
-	ioc->blksz = 512;
-	ioc->blocks = blocks;
-	ioc->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-}
-
 /* Performs RPMB operation.
  *
  * @fd: RPMB device on which we should perform ioctl command
@@ -2810,233 +2763,6 @@ out:
 	return ret;
 }
 
-static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
-			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
-			       off_t offset)
-{
-	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
-
-	/* send block count */
-	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
-		       bytes / 512);
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	/*
-	 * send image chunk: blksz and blocks essentially do not matter, as
-	 * long as the product is fw_size, but some hosts don't handle larger
-	 * blksz well.
-	 */
-	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1,
-		       bytes / 512, arg);
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
-}
-
-int do_ffu(int nargs, char **argv)
-{
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
-
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
-	}
-
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		goto out;
-	}
-
-	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
-		fprintf(stderr,
-			"The FFU feature is only available on devices >= "
-			"MMC 5.0, not supported in %s\n", device);
-		goto out;
-	}
-
-	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
-		fprintf(stderr, "FFU is not supported in %s\n", device);
-		goto out;
-	}
-
-	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
-		fprintf(stderr, "Firmware update was disabled in %s\n", device);
-		goto out;
-	}
-
-	fw_size = lseek(img_fd, 0, SEEK_END);
-	if (fw_size == 0) {
-		fprintf(stderr, "Wrong firmware size");
-		goto out;
-	}
-
-	/* allocate maximum required */
-	buf = malloc(fw_size);
-	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
-				4 * sizeof(struct mmc_ioc_cmd));
-	if (!buf || !multi_cmd) {
-		perror("failed to allocate memory");
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
-	}
-
-	/* prepare multi_cmd for FFU based on cmd to be used */
-
-	multi_cmd->num_of_cmds = 4;
-
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_NORMAL_MODE);
-
-	/* read firmware */
-	lseek(img_fd, 0, SEEK_SET);
-	if (read(img_fd, buf, fw_size) != fw_size) {
-		perror("Could not read the firmware file: ");
-		ret = -ENOSPC;
-		goto out;
-	}
-
-do_retry:
-	bytes_left = fw_size;
-	off = 0;
-	while (bytes_left) {
-		unsigned int chunk_size = bytes_left < default_chunk ?
-					  bytes_left : default_chunk;
-
-		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, off);
-
-		/* send ioctl with multi-cmd */
-		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
-
-		if (ret) {
-			perror("Multi-cmd ioctl");
-			/*
-			 * In case multi-cmd ioctl failed before exiting from
-			 * ffu mode
-			 */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
-
-		bytes_left -= chunk_size;
-		off += chunk_size;
-	}
-
-	/*
-	 * By spec - check if mode operation codes are supported in ffu features,
-	 * if not then skip checking number of sectors programmed after install
-	 */
-	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
-		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
-		ret = 0;
-		goto out;
-	}
-
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		goto out;
-	}
-
-	/* Test if we need to restart the download */
-	sect_done = per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
-	/* By spec, host should re-start download from the first sector if sect_done is 0 */
-	if (sect_done == 0) {
-		if (retry--) {
-			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
-			goto do_retry;
-		}
-		fprintf(stderr, "Programming failed! Aborting...\n");
-		goto out;
-	}
-
-	if ((sect_done * sect_size) == fw_size) {
-		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
-		fprintf(stderr, "Programming finished with status %d \n", ret);
-	}
-	else {
-		fprintf(stderr, "FW size and number of sectors written mismatch. Status return %d\n", ret);
-		goto out;
-	}
-
-	fprintf(stderr, "Installing firmware on %s...\n", device);
-	/* Re-enter ffu mode and install the firmware */
-	multi_cmd->num_of_cmds = 2;
-
-	/* set ext_csd to install mode */
-	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES,
-			EXT_CSD_FFU_INSTALL);
-
-	/* send ioctl with multi-cmd */
-	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
-
-	if (ret) {
-		perror("Multi-cmd ioctl failed setting install mode");
-		/* In case multi-cmd ioctl failed before exiting from ffu mode */
-		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-		goto out;
-	}
-
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		goto out;
-	}
-
-	/* return status */
-	ret = ext_csd[EXT_CSD_FFU_STATUS];
-	if (ret) {
-		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
-		goto out;
-	} else {
-		fprintf(stderr, "FFU finished successfully\n");
-	}
-
-out:
-	free(buf);
-	free(multi_cmd);
-	close(img_fd);
-	close(dev_fd);
-	return ret;
-}
-
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..40a137d 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -16,6 +16,57 @@
  * Modified to add field firmware update support,
  * those modifications are Copyright (c) 2016 SanDisk Corp.
  */
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <string.h>
+#include "mmc.h"
+
+static inline __u32 per_byte_htole32(__u8 *arr)
+{
+	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
+}
+
+
+static inline int read_extcsd(int fd, __u8 *ext_csd)
+{
+	int ret = 0;
+	struct mmc_ioc_cmd idata;
+	memset(&idata, 0, sizeof(idata));
+	memset(ext_csd, 0, sizeof(__u8) * 512);
+	idata.write_flag = 0;
+	idata.opcode = MMC_SEND_EXT_CSD;
+	idata.arg = 0;
+	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata.blksz = 512;
+	idata.blocks = 1;
+	mmc_ioc_cmd_set_data(idata, ext_csd);
+
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret)
+		perror("ioctl");
+
+	return ret;
+}
+
+static inline void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8 value)
+{
+	cmd->opcode = MMC_SWITCH;
+	cmd->write_flag = 1;
+	cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) | (index << 16) |
+		   (value << 8) | EXT_CSD_CMD_SET_NORMAL;
+	cmd->flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+}
+
+static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode, int write_flag,
+						unsigned int blocks, __u32 arg)
+{
+	ioc->opcode = opcode;
+	ioc->write_flag = write_flag;
+	ioc->arg = arg;
+	ioc->blksz = 512;
+	ioc->blocks = blocks;
+	ioc->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+}
 
 /* mmc_cmds.c */
 int do_read_extcsd(int nargs, char **argv);
@@ -50,3 +101,4 @@ int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
 int do_preidle(int nargs, char **argv);
 int do_alt_boot_op(int nargs, char **argv);
+int do_ffu(int nargs, char **argv);
diff --git a/mmc_ffu.c b/mmc_ffu.c
new file mode 100644
index 0000000..5f7cb00
--- /dev/null
+++ b/mmc_ffu.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Modified and add more FFU modes.
+ * And changed and updated by: Bean Huo <beanhuo@micron.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <ctype.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <unistd.h>
+
+#include "mmc.h"
+#include "mmc_cmds.h"
+
+static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size, unsigned int chunk_size);
+
+static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_csd,
+				unsigned int bytes, __u8 *buf, off_t offset)
+{
+	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
+
+	/* send block count */
+	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
+	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+	/*
+	 * send image chunk: blksz and blocks essentially do not matter, as
+	 * long as the product is fw_size, but some hosts don't handle larger
+	 * blksz well.
+	 */
+	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+}
+
+static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
+{
+	int ret;
+
+	ret = read_extcsd(*dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD\n");
+		return ret;
+	}
+
+	ret = per_byte_htole32((__u8 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
+
+	return ret;
+}
+
+static bool ffu_is_supported(__u8 *ext_csd, char *device)
+{
+	if (ext_csd == NULL) {
+		fprintf(stderr, "ext_cst is NULL\n");
+		return false;
+	}
+
+	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
+		fprintf(stderr, "The FFU feature is only available on devices >= "
+			"MMC 5.0, not supported in %s\n", device);
+		return false;
+	}
+
+	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
+		fprintf(stderr, "FFU is not supported in %s\n", device);
+		return false;
+	}
+
+	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
+		fprintf(stderr, "Firmware update was disabled in %s\n", device);
+		return false;
+	}
+
+	return true;
+}
+
+static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
+							unsigned int chunk_size)
+{
+	int ret;
+	__u8 num_of_cmds = 4;
+	off_t bytes_left, off;
+	unsigned int bytes_per_loop, sect_done, retry = 3;
+	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+
+	if (!dev_fd || !fw_buf || !ext_csd) {
+		fprintf(stderr, "unexpected NULL pointer\n");
+		return -EINVAL;
+	}
+	/* allocate maximum required */
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	/* prepare multi_cmd for FFU based on cmd to be used */
+	/* put device into ffu mode */
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+
+	/* return device into normal mode */
+	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+
+do_retry:
+	bytes_left = fw_size;
+	off = 0;
+	multi_cmd->num_of_cmds = num_of_cmds;
+
+	while (bytes_left) {
+		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
+
+		/* prepare multi_cmd for FFU based on cmd to be used */
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+
+		/* send ioctl with multi-cmd, download firmware bundle */
+		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+
+		if (ret) {
+			perror("Multi-cmd ioctl");
+			/*
+			 * In case multi-cmd ioctl failed before exiting from
+			 * ffu mode
+			 */
+			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			goto out;
+		}
+
+		sect_done = get_ffu_sectors_programmed(dev_fd, ext_csd);
+		if (sect_done <= 0) {
+			/* By spec, host should re-start download from the first sector if sect_done is 0 */
+			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			if (retry > 0) {
+				retry--;
+				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+				goto do_retry;
+			}
+			fprintf(stderr, "Programming failed! Aborting...\n");
+			ret = sect_done;
+			goto out;
+		} else {
+			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * 512, (intmax_t)fw_size);
+		}
+
+		bytes_left -= bytes_per_loop;
+		off += bytes_per_loop;
+	}
+
+	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
+out:
+	free(multi_cmd);
+	return ret;
+
+}
+
+int do_ffu(int nargs, char **argv)
+{
+	int opt;
+	int dev_fd, img_fd;
+	int ret = -EINVAL;
+	unsigned int sect_size;
+	__u8 ext_csd[512];
+	__u8 *fw_buf = NULL;
+	off_t fw_size;
+	char *device, *fw_img;
+	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
+	int sect_done = 0;
+	__u8 ffu_mode = 1;
+
+	assert(nargs >= 4);
+
+	while ((opt = getopt(nargs, argv, "i:p:m:c:")) != -1) {
+		switch (opt) {
+		case 'i':
+			fw_img = optarg;
+			break;
+		case 'p':
+			device = optarg;
+			break;
+		case 'c':
+			default_chunk = atoi(optarg);
+			if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
+				fprintf(stderr, "Invalid chunk size");
+				exit(1);
+			}
+			break;
+		case 'm':
+			ffu_mode = atoi(optarg);
+			if (ffu_mode > 1) {
+				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
+				abort();
+			}
+			break;
+		default:
+			/* Unknown option or missing argument for options */
+			if (isprint(optopt))
+				fprintf(stderr, "Unknown option `-%c'.\n", optopt);
+			else
+				fprintf(stderr, "Unknown option character `\\x%x'.\n", optopt);
+			abort();
+		}
+	}
+	fprintf(stderr, "eMMC Devie: %s, fw %s, FFU mode %d, chunk size: %d\n",
+							device, fw_img, ffu_mode, default_chunk);
+	dev_fd = open(device, O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open failed");
+		exit(1);
+	}
+	img_fd = open(fw_img, O_RDONLY);
+	if (img_fd < 0) {
+		perror("image open failed");
+		close(dev_fd);
+		exit(1);
+	}
+
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
+	if (ffu_is_supported(ext_csd, device) <= 0)
+		goto out;
+
+	fw_size = lseek(img_fd, 0, SEEK_END);
+	if (fw_size == 0) {
+		fprintf(stderr, "Wrong firmware size");
+		goto out;
+	}
+	/* ensure fw is multiple of native sector size */
+	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
+	if (fw_size % sect_size) {
+		fprintf(stderr, "Firmware data size (%jd) is not aligned!\n", (intmax_t)fw_size);
+		goto out;
+	}
+	/* allocate maximum required */
+	fw_buf = malloc(fw_size);
+	if (!fw_buf) {
+		perror("failed to allocate memory");
+		goto out;
+	}
+	/* read firmware */
+	lseek(img_fd, 0, SEEK_SET);
+	if (read(img_fd, fw_buf, fw_size) != fw_size) {
+		perror("Could not read the firmware file: ");
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+
+	/* Check programmed sectors */
+	if (sect_done > 0 && (sect_done * 512) == fw_size) {
+		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
+		fprintf(stderr, "Programming finished with status %d \n", ret);
+	} else {
+		fprintf(stderr, "Firmware bundle download failed. Operation status %d\n", sect_done);
+		ret = -EIO;
+		goto out;
+	}
+	/*
+	 * By spec - check if mode operation codes are supported in ffu features,
+	 * if not then skip checking number of sectors programmed after install
+	 */
+	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
+		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
+		ret = 0;
+		goto out;
+	}
+
+	fprintf(stderr, "Installing firmware on %s...\n", device);
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + 2 * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("failed to allocate memory");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Re-enter ffu mode and install the firmware */
+	multi_cmd->num_of_cmds = 2;
+	/* put device into ffu mode */
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	/* Re-enter ffu mode and set ext_csd to install mode */
+	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES, EXT_CSD_FFU_INSTALL);
+
+	/* send ioctl with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+
+	if (ret) {
+		perror("Multi-cmd ioctl failed setting install mode");
+		fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[1]);
+		goto out;
+	}
+
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
+
+	/* return status */
+	ret = ext_csd[EXT_CSD_FFU_STATUS];
+	if (ret)
+		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
+	else
+		fprintf(stderr, "FFU finished successfully\n");
+
+out:
+	if (fw_buf)
+		free(fw_buf);
+	if (multi_cmd)
+		free(multi_cmd);
+	close(img_fd);
+	close(dev_fd);
+	return ret;
+}
-- 
2.34.1

