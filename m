Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7D1E2604
	for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694518; cv=pass; b=EoxQmnxCC3WsY5siRu3ldq+AXQLWEzuANQGSIznJEDo1gRYjBopxRPxURs8ZHA5UTx5ATxDssYnFdU0V5gClD2sw0Lih8obxtHcfv8I+1Rm5F2RT9+cRkLxNGhws+Z0Uc6LAGmWIvGzP1wqI9HfA/rkmC9UUn/w38QgxiZi9HJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694518; c=relaxed/simple;
	bh=pOEkrvIZrlmY1ohTqJlokFeiG/QYgPns/4D/kUf+QLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/kbS5mFZoX5IXBKtXlUNud7wWhCBsQOMt5Q+d+lk+J6zXB6rppzyaNl2yS6weDDYYlI1AxSJzjrNiPpyb+6KFOUJOMYn3sL6QZs5MDZbOC3SbSNaMjNz0AQGJndAp20TFz/CongyHixBXS26lZkbrFSTnGsnbbHFsyEd/Qzi58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=kj+uu/rV; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Z5+zlVrS; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="kj+uu/rV";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Z5+zlVrS"
ARC-Seal: i=1; a=rsa-sha256; t=1729694329; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LCxn8BalzfGXVfWWLOjGEDPvIq+1s8SenSNXx8SCAmR1oL22igIFmZwsAfL/C4WXVC
    72knNw4tKNmyMMsabKpIeaftTr7z5IHsVyO7Gfb/Xo2eT01IFtMFNV2fGv10SNW3o2Jn
    mDXumds11Wwzl0FucVoNKlggTl1hhVeXOfKZBWJeh58ZvW6x1HciZ0pidTuQW44OJLUj
    RXDS/gHM20sfhTKFIg94DZj0/4q2JD7PM5xI4BAl4C7uXbcE19Ta487XFaKcq+oMn3Vi
    qnboGzRmICvGHSvP9xN1AaJit7RfDEXz3P72ceDI0lyS8wJD19rLtpkt1yjLA1a7YA4n
    px0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vzR3H7P+FOprNzNIrZ9JI6UECdvh7ijlmk5vCwjA5Zw=;
    b=XyR+l4omxEy6mkotdhhWP+dYr/Z1sGZUKLFht3+tk8yILLzzZndaA8QPb+irHXJZLZ
    IeVz++wCP16+yhp6MOVbEAhwFP+2LTBwBPPU4eQYFxM+wHL5jCW+ZAKfHGEJmITJGsp4
    i4fx7YiG/lLBYhqyWyRx79hMlDC1SjsZG/PCsuOroAp/LV9kNh1cNzsYLiypbA4nXILk
    vO2gbA6ltKdXovGx5jCQf/mfvhuSWbEGeVzLpCuOPoQIlHdZnXchZRxQ7qEwjqU77Xfv
    QyVykAb2aXTEW5qMGeQML3wc8eOCzmupJKOnXHYQTG3BdSoGz+3eLl7IrErT3rcGwzQD
    ZD2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vzR3H7P+FOprNzNIrZ9JI6UECdvh7ijlmk5vCwjA5Zw=;
    b=kj+uu/rV/c5dBe1KlVRE/ixLgc71sAOW/lIh+u5E22Pr4CONwgq1YGu0xdY8Hwpb2L
    BfOS2beDZFUeVTUhKH8yJ57HrQLNDnfriYcKCfDbcoL2pePPgIedgdrnl74c9kJdPoQu
    84Kv/WsTjOrVdiuUo+JDcqo0jIZWe492mATFr2ozR08Ap2gPMbXpdAI9cN6In0y/vxyI
    CUL02DdxXvtZxkSPT0wmjgyU4ifXdw0YCLuyKWI3pg4vFhUDPH7exqXXgMYxQtXd/nnz
    NCulxiVAc0qpBkiCVnNddEs6tsNTeJ6ugCYRlplKFzcsYsvTunzoZGgTZv42S00z9uPY
    1USQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729694329;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vzR3H7P+FOprNzNIrZ9JI6UECdvh7ijlmk5vCwjA5Zw=;
    b=Z5+zlVrS29eDgCfM4lO93wonW4ZUbg1GeiNYAep2H8Ls1fL4dUZhHA6E64QgIMsLlK
    GvBnnQd9uN2yuTm/BJAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209NEcnTm9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Oct 2024 16:38:49 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 2/5] mmc-utils: Add FFU mode 2
Date: Wed, 23 Oct 2024 16:38:36 +0200
Message-Id: <20241023143839.108572-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023143839.108572-1-beanhuo@iokpp.de>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Added a new FFU mode 2, in this mode, begins with CMD6, followed by repeated
CMD23+CMD25 for downloading the firmware bundle. Once the entire firmware image is downloaded,
the FFU mode is exited with CMD6, ensuring the download is treated as an atomic operation.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |   5 ++-
 mmc.c      |   9 +++-
 mmc_cmds.c | 126 +++++++++++++++++++++++++++++++++++++++++------------
 mmc_cmds.h |   3 +-
 4 files changed, 112 insertions(+), 31 deletions(-)

diff --git a/mmc.1 b/mmc.1
index e153557..256852b 100644
--- a/mmc.1
+++ b/mmc.1
@@ -185,13 +185,16 @@ The device path should specify the cid sysfs file directory.
 Print SCR data from \fIdevice\-path\fR.
 The device path should specify the scr sysfs file directory.
 .TP
-.BI ffu " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+.BI ffu1 " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
 .br
 [\fIchunk\-bytes\fR] is optional and defaults to its max - 512k. should be in decimal bytes and sector aligned.
 .br
 if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
 .TP
+.BI ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 2c5b9b5..ffc98dc 100644
--- a/mmc.c
+++ b/mmc.c
@@ -227,13 +227,18 @@ static struct Command commands[] = {
 		  "The device path should specify the scr file directory.",
 	  NULL
 	},
-	{ do_ffu, -2,
-	  "ffu", "<image name> <device> [chunk-bytes]\n"
+	{ do_ffu1, -2,
+	  "ffu1", "<image name> <device> [chunk-bytes]\n"
 		"Run Field Firmware Update with <image name> on <device>.\n"
 		"[chunk-bytes] is optional and defaults to its max - 512k. "
 		"should be in decimal bytes and sector aligned.\n",
 	  NULL
 	},
+	{ do_ffu2, -2,
+	 "ffu2", "<image name> <device> [chunk-bytes]\n"
+	 "Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
+	 NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 1a35431..c183a2d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2813,23 +2813,40 @@ out:
 
 static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
-			       off_t offset)
+			       off_t offset, __u8 ffu_mode)
 {
 	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
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
+	/* prepare multi_cmd for FFU based on cmd to be used */
+	if (ffu_mode == 1) {
+		/* put device into ffu mode */
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		/* send block count */
+		set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
+			       bytes / 512);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+		/*
+		 * send image chunk: blksz and blocks essentially do not matter, as
+		 * long as the product is fw_size, but some hosts don't handle larger
+		 * blksz well.
+		 */
+		set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1,
+			       bytes / 512, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+		/* return device into normal mode */
+		fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	} else if (ffu_mode == 2) {
+		/*
+		 * FFU mode 2 uses CMD23+CMD25 for repeated downloads and remains in FFU mode
+		 * during FW bundle downloading until completion. In this mode, multi_cmd only
+		 * has 2 sub-commands.
+		 */
+		set_single_cmd(&multi_cmd->cmds[0], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
+		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	}
 }
 
 /*
@@ -2873,6 +2890,36 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
 	return true;
 }
 
+static int enter_ffu_mode(int dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("enter FFU mode failed!");
+
+	return ret;
+}
+
+static int exit_ffu_mode(int dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("exit FFU mode failed!");
+
+	return ret;
+}
+
 /*
  * Performs FFU download of the firmware bundle.
  *
@@ -2886,7 +2933,7 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
  *         On failure, returns a negative error number.
  */
 static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
-							unsigned int chunk_size)
+							unsigned int chunk_size, __u8 ffu_mode)
 {
 	int ret;
 	__u8 num_of_cmds = 4;
@@ -2898,6 +2945,10 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		fprintf(stderr, "unexpected NULL pointer\n");
 		return -EINVAL;
 	}
+
+	if (ffu_mode != 1) /* in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+		num_of_cmds = 2;
+
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
 				num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -2906,14 +2957,15 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	/* prepare multi_cmd for FFU based on cmd to be used */
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_NORMAL_MODE);
+	if (ffu_mode != 1) {
+		/*
+		 * If the device is not in FFU mode 1, the command to enter FFU mode will be sent
+		 * independently, separate from the firmware bundle download command.
+		 */
+		ret = enter_ffu_mode(dev_fd);
+		if (ret)
+			goto out;
+	}
 
 do_retry:
 	bytes_left = fw_size;
@@ -2924,7 +2976,7 @@ do_retry:
 		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
 		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
@@ -2935,7 +2987,7 @@ do_retry:
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
 			 */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			exit_ffu_mode(dev_fd);
 			goto out;
 		}
 
@@ -2962,6 +3014,16 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
+	if (ffu_mode != 1) {
+		/*
+		 * If the device is not in FFU mode 1, the command to exit FFU mode will be sent
+		 * independently, separate from the firmware bundle download command.
+		 */
+		ret = exit_ffu_mode(dev_fd);
+		if (ret)
+			goto out;
+	}
+
 	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
 out:
 	free(multi_cmd);
@@ -3009,7 +3071,7 @@ out:
 	return ret;
 }
 
-int do_ffu(int nargs, char **argv)
+static int __do_ffu(int nargs, char **argv, __u8 ffu_mode)
 {
 	int dev_fd, img_fd;
 	int ret = -EINVAL;
@@ -3085,7 +3147,7 @@ int do_ffu(int nargs, char **argv)
 	}
 
 	/* Download firmware bundle */
-	ret = do_ffu_download(dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	ret = do_ffu_download(dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 	/* Check programmed sectors */
 	if (ret > 0 && (ret * 512) == fw_size) {
 		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
@@ -3125,6 +3187,16 @@ out:
 	return ret;
 }
 
+int do_ffu1(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, 1);
+}
+
+int do_ffu2(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, 2);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..e2eba91 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -41,7 +41,8 @@ int do_rpmb_read_block(int nargs, char **argv);
 int do_rpmb_write_block(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
-int do_ffu(int nargs, char **argv);
+int do_ffu1(int nargs, char **argv);
+int do_ffu2(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

