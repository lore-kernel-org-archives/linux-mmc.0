Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743121440C
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887736; cv=pass; b=dCNLU9WR4Q9AlVlKJTWtkRiHR6owtbvBgWPO3UJdtysjU6lWn+nO40dFQG+UAgEXPZgdsY8BBSMs5VgN4yUaSlZSdxWx+1NFPzzzafJSOWlJCUkD9HMhxXLBXx1dDf4jAgtxvLRqvOgXN8N+ZopXmXoyGfqb+1iw4A4jkhs+fCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887736; c=relaxed/simple;
	bh=MzQ2o0AyOM7uIUolx8vUHiqsKCHmSi3a5BdH2Meh/a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6T08DXNteK8Qw0su8QcKn2djiwnFRvoYDJICeg2v7HalOEcvf73EzndvaQu3RTzq4GOAzFfvCAp/6dWz275So+czCYdpEEq402mVQIsjhO3rpqhehiReX7sTXmluRR5Z56j3qoupreVAJx9M1Q7egHB5QPGuhEfHs2MxacqZnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ZUr4slxK; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=NkzEZPfw; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ZUr4slxK";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="NkzEZPfw"
ARC-Seal: i=1; a=rsa-sha256; t=1729887719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pcd90q5oXxxUEj2WlHtGeApX3Z1HOzJUvSwQiIWPEDQLYvlJMAbFGJ9MuPF4O07Kz+
    h6aTRFoDUAErrCYmjcdvBi5E36Ss0KkqnJyb3q4NnB8RgFJS4PPFUTULD8L6Ew2F7cwX
    mPynN1No/KDTKmCK6oBrYf0gimlyM7HulMDQRje/tLRMB4Eu5awDojI+kN0dA+mz1+5b
    yVUMOEbvoedF7iUef5EJT0Ju+f+NhJlDOpg+Wl4ztJxtc8Jvm25gMVDfjVVXYjuVj4x2
    7BxQGk9zUY3aO5RkE1tnMMS1VmrZWLFsCKLMlrsfU7UrZrshj/FwKepR4jVbp9j1UiZj
    uUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=Dh0y4U0+1DmDUM7YAeS8DDj3vCp/OEbJUULBGnMKRPVZ5PiA3GeRHScSojtgQVI/2f
    UEcHSs0+h+v236mFQp88+GRT7+HP82UsNSsWw6YZns8frTublljRYMtvE4KWHEZbGV9i
    xqZ+M+7155Qz6QbuccdeOwV/ceUxX7OWt4FL7En7MIR4LNcWGzvpyZHhNJwII4sbTAtV
    syJ3niirz2rQ8dgcqNtxrhc6kXwpyLxI+8zo1KQSEVBVx2h5xw0FP7J1rt8z/09f9D1K
    Emf9G3CWDcmhPxNJoT/Bs7J9eCfuCZvndFsiC/3ak3uBKGbEx/8kE7D2sRcJl7vo/917
    NJ3A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=ZUr4slxKv+z8ffIEMMDjuspvcqgDfjH4Yt1nt/7/VHJMxb0lt368H8du0IuZfH3sgR
    HXjAkTa3Pw53WcRUq6Q9gXyMrt9607izS31c1sqhGrRdjneromda/NO7NytUrbil9mgJ
    QL7mFUBZNGFC0jF43Sm04hliNzlHTaonWyyjVDAQrBmY6biHOaEWLAkMx0Z7JqYKv1xN
    HyYFgSQGzZVEVRvUFVQt2I3O6LvybGrKgFT7Rx60cY6t7HGUwmauEMDxBgVC4Eb3qPXC
    +a/Axnwq6QnbRTR4sB1FfDsLU00g0kmv3Ai1B7QXa7RFmfoLL+TcgaM7Z/cP6iu/6aGz
    whXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KyF9xri1DVk974O0eO8n43yCGmKk6r9EdSlmmqdziI4=;
    b=NkzEZPfw7LQHv/Z7JyLFWE1T++7URca/7vFO/RGag5coPYw04J7Pl/W/O4mA7VpHJQ
    dDoyx5ksB73D1CFTBUDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKLxbex
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:21:59 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 2/5] mmc-utils: Add FFU optional mode 1
Date: Fri, 25 Oct 2024 22:21:45 +0200
Message-Id: <20241025202148.161586-3-beanhuo@iokpp.de>
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

