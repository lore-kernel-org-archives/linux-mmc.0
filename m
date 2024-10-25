Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8175215C65
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888692; cv=pass; b=HNnE7zb7j2OUhU4G5GThgF6MvbMBfv8IP1TRGWVejQsK0iv7NEaw2C2sHrtcycZ5NlxF7vQtHGplzOQQwXqdeBpfn9ErKtbL4N7UqScdMxWngbgCEq0SIUz+4HDPFo2TCUuGQr4TvqG0XG4Tc9TwRz5++svxvKeqqPDpz4x2N2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888692; c=relaxed/simple;
	bh=MzQ2o0AyOM7uIUolx8vUHiqsKCHmSi3a5BdH2Meh/a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuLaZ/Hah3S++URTveCIBIYIZ3cM41qj+uQqT42k+A47SKdAqSHFJegwYXIzoprd0HQ8vIIFJwFobMzmC/IT+5Iim6wgMnhU2p8+0bqE+iLtc3zhOTUzgt5XUdUKl6mwgmB/XFqMsZbJuHFzmpIZ8fijVlo11mxA70snU6mxMds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=oJFSLXNC; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=mHDPgt63; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="oJFSLXNC";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="mHDPgt63"
ARC-Seal: i=1; a=rsa-sha256; t=1729888502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pupdJgMhFDHsYo4kEu/T/56UhEilrjjEu/4vg3rZDUyjFTS8EB4+JLWYCg8wWUsLTh
    lkLfRtvJZfk/gL98v4R22hGArvjfLCJMpf1wd4EtXSWJVhn6PSOVwl+4dqpq5GHeB0uy
    OQ65bGKKB5WG4S5UWL/zQDRhzQTywZx6cWp01fOiOK+IV1VZEKSb80iJ3omnqkhwJyY1
    q+Tsu9GsgfnVQNUJuul9Vi0CQl81aB/bxpnSUkIuySgGalgmBT38OfmxCXJDTNJYH0A8
    51ik/G3ybtjE5WR/gfDjETC2zcj9yfDN0QpDIUMmHPX59yykcAGB+tmlIwK0DEO5H4m0
    jiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=fPbXE4I3PgisgM4T0O2x03lkaLDQuqMr24eX4v749nlNwSzDW5ueIZ6Hhv1gfXG+Db
    ibfaedOKnflAjaHkBpxGDTdVoABUIi5Y9jC/kUrSz45OQG9t5dzRfjMXCFBMqk6VTKT5
    6DHecfFUsNMgg9WrS23l5CP+hNAqYkhWbCMya468naj4oAkKq+tWzrWQ8a15k7fqhfGO
    cFYmEKB+CtneVwqshYmJ2QMNtnZAGJvuT2Swzxs+XaiIWfdu/Ae+YeE1JFJ2tXab2Zfy
    sP4ikDm8IHiHWZmHAmtOzArVGZhszTPASdieiAw384jE2l/S0hrn2AjCRMdUVfTm5H9Y
    khOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=oJFSLXNCK5a5lcZImzec6u9FeGV1Ym6Qoz3Tc800mhnizg3KG/9yK4iyTj12G4MjH2
    fQpL+iiJ3TrmB7NA5IVfYYCAACWc1a3VXxYoxwp1Z8d9Qzky8gDH+peEK7E1T8Lgpf8Q
    0fo5u6w0VpwvbLs9tAYq7oNuCvUCVlVyKQyOmibFPAVzu8SdHcyw9pL9TAiWIrUqA32O
    2VF8kjG31F0DBWYmGrt+e6ALXFH5LNWGwIcvG9KLRUP0i16mhz4rYgQPmFzv7pRWO+uR
    pJJ14xCcJ5iFGVMkD8Bp/4tydMPtlsbJrxv1Vv9Uzpsf/43UnJNHXBEpo+F0428ilsOg
    69EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729888502;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=mHDPgt63gDcUQdcVgFpFoJWLJ0uio5eI8yzlvOtsb8VUJ0CCxxOaDMQKYuLGn37LbZ
    WzgY33+i/TFpiU0Oa/Aw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKZ2bfe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:35:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 2/5] mmc-utils: Add FFU optional mode 1
Date: Fri, 25 Oct 2024 22:34:51 +0200
Message-Id: <20241025203454.162710-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025203454.162710-1-beanhuo@iokpp.de>
References: <20241025203454.162710-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Added optional FFU mode 1, in this mode, begins with CMD6, followed by repeated CMD23+CMD25
for downloading the firmware bundle. Once the entire firmware image is downloaded, the FFU
mode is exited with CMD6, ensuring the download is treated as an atomic operation.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |   3 ++
 mmc.c      |   5 ++
 mmc_cmds.c | 134 ++++++++++++++++++++++++++++++++++++++++++-----------
 mmc_cmds.h |   1 +
 4 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/mmc.1 b/mmc.1
index e153557..f69ab8f 100644
--- a/mmc.1
+++ b/mmc.1
@@ -192,6 +192,9 @@ Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
 .br
 if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
 .TP
+.BI opt_ffu1 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 2c5b9b5..67bd90b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -234,6 +234,11 @@ static struct Command commands[] = {
 		"should be in decimal bytes and sector aligned.\n",
 	  NULL
 	},
+	{ do_opt_ffu1, -2,
+	 "opt_ffu1", "<image name> <device> [chunk-bytes]\n"
+	 "Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
+	 NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 1a35431..53a1658 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -59,6 +59,13 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
+
+// Firmware Update (FFU) download modes
+enum ffu_download_mode {
+	FFU_DEFAULT_MODE, // Default mode: Uses CMD23+CMD25; exits FFU mode after each loop.
+	FFU_OPT_MODE1 // Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
+};
+
 static inline __u32 per_byte_htole32(__u8 *arr)
 {
 	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
@@ -2813,23 +2820,40 @@ out:
 
 static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
-			       off_t offset)
+			       off_t offset, enum ffu_download_mode ffu_mode)
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
+	if (ffu_mode == FFU_DEFAULT_MODE) {
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
+	} else if (ffu_mode == FFU_OPT_MODE1) {
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
@@ -2873,6 +2897,36 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
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
@@ -2881,12 +2935,13 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
  * @fw_buf:     Pointer to the firmware buffer containing the firmware data to be downloaded.
  * @fw_size:    Size of the firmware in bytes.
  * @chunk_size: Size of the chunks in which the firmware is sent to the device.
+ * @ffu_mode:	FFU mode for firmware download mode
  *
  * Return: If successful, returns the number of sectors programmed.
  *         On failure, returns a negative error number.
  */
 static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
-							unsigned int chunk_size)
+				unsigned int chunk_size, enum ffu_download_mode ffu_mode)
 {
 	int ret;
 	__u8 num_of_cmds = 4;
@@ -2898,6 +2953,10 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		fprintf(stderr, "unexpected NULL pointer\n");
 		return -EINVAL;
 	}
+
+	if (ffu_mode != FFU_DEFAULT_MODE) /* in default mode, mmc_ioc_multi_cmd contains 4 commands */
+		num_of_cmds = 2;
+
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
 				num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -2906,14 +2965,15 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
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
+	if (ffu_mode != FFU_DEFAULT_MODE) {
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
@@ -2924,7 +2984,7 @@ do_retry:
 		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
 		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
@@ -2935,7 +2995,7 @@ do_retry:
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
 			 */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			exit_ffu_mode(dev_fd);
 			goto out;
 		}
 
@@ -2962,6 +3022,16 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
+	if (ffu_mode != FFU_DEFAULT_MODE) {
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
@@ -3009,7 +3079,7 @@ out:
 	return ret;
 }
 
-int do_ffu(int nargs, char **argv)
+static int __do_ffu(int nargs, char **argv, enum ffu_download_mode ffu_mode)
 {
 	int dev_fd, img_fd;
 	int ret = -EINVAL;
@@ -3085,7 +3155,7 @@ int do_ffu(int nargs, char **argv)
 	}
 
 	/* Download firmware bundle */
-	ret = do_ffu_download(dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	ret = do_ffu_download(dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 	/* Check programmed sectors */
 	if (ret > 0 && (ret * 512) == fw_size) {
 		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
@@ -3125,6 +3195,16 @@ out:
 	return ret;
 }
 
+int do_ffu(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_DEFAULT_MODE);
+}
+
+int do_opt_ffu1(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_OPT_MODE1);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..351155b 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -42,6 +42,7 @@ int do_rpmb_write_block(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
+int do_opt_ffu1(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

