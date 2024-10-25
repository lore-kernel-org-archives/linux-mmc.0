Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9569214415
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888697; cv=pass; b=UC7Vqo7K9FPnxyDvn7hejFxH+Bh81aVRnJnsH1ZfQ2Dpo35NwJ8Ry21oLPVTSd4ValHdGVu25qk3qhKHeHUtxHqzE5QLYccsGGyyqyegyCM4DD8ylkj8Bkl3f7CDQF+0soEmJZ0FJ6xPJ4mZgGsMko1ObCxhU82yQYMSe8X1vAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888697; c=relaxed/simple;
	bh=3BUn02X0fHs8bKvwX3NuCU9yIk3EnJF4E7rceUcVTcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gdh4E4TPONUKlT6jZLi32KrTgbjVPvrBr256RRiYjt6oCjVKXUFIpjXtkZN5eADDxZ67Wje2ntzHfVRo5HKkPanTMmeBZ7mWpPcjT1KLEuhTTtIX7tK5qnr9sIm1wkOczOKbhD8ItVMzfeo3uhYctilBlgqNoVd+Zy/MWodwIfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=J2EcnWOf; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=qdUqKD2m; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="J2EcnWOf";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="qdUqKD2m"
ARC-Seal: i=1; a=rsa-sha256; t=1729888503; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OX+89mLGdCpL/NILi8jz11qHmx/zaHAtiVZt7K8NC6vzZTHleW4vPa0evo90ZBQwnD
    x38zV/CZfeKRV9WB8I/xtwwEwdZAwmnB+1curwRz4M3y2UWNw3urSUh0F8ApaK8gVLmo
    4r2dH/k3hi+VG8iJ0SyvlUMXY7RFnFH8LwmAH0evrCFI5+km9lRFN/76MiveRms4hbgv
    hx8rcZhc6nSqYThwt4SRYeEnZys4csBUwzuHP9bw+QUwo4IEDHblBc4PMyTlZ6JnrvNJ
    fqek25ntKKHzRYOOn6nXAxBUeZgqSGDRmkWH0/ttKPzjDhUr3qPcDYgcquXjNnB0xb2w
    ZohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=Wl1i85JsySnqscMtKRPcZa2o5+DGITLKGqFaRCzmb3vJi6dF/N8MLD6dAfsqrg2kNO
    j3dHPXmKPjGeefq7qctiMRx+OzDf/k+Tgpqm2Y9URD8mLym1YKqYx7SagYY/eNPB+hy2
    Y7KPiGt6cELWXWMgquK4Cvm3hGq1Rjh1jrSCoSc6IZtt1gyUcW8DD5ge/e50C8p3AGXk
    558vSSSlP0fXqLT5oA12179aixG1RVBZ6R36jyD0P0Xf86ZqlhuPqeDqChM9NEshKjfA
    c33dzQdGxT+l5vQTd/7B6svoKya/cJnGw1QqsQhgiE/ALL5/P0tMjjPRwr6Uzf66eKZw
    YCZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=J2EcnWOfzm0agZ4of6xVDFYghVx6UMWEzjh7GdH3scv+YOkSGIkuJwuL6iONraGSfj
    djgDL/rASSDbrOf27HSfwa/D0eykyb3iELRd0qlpzgnOhx0ksu5QVRF8sb+q3or5IoZt
    oBcF20GxWcqQo6vF9kyP0uTGNtz95IUBEjFa9WBIpv6HRsCYfiuLk6QxqEhK83kXJ65/
    7Buik2H+OiOtzpM/tPsrynwZ9yGDPQZIXqM7Sjkm7hK8IRrfAfOOIG2ae5N/5uIOtfIJ
    7geuz6+c9nLJrzJ03DVVCBWUPPGORyc2v9fs/t1tmk0fDc1YfDgFGhplAiNrUlTCxRf7
    OhqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=qdUqKD2mZ2OzL+uLWn0gqwyOSmC4dxcmjSopmfoLQ5YxclWmvY9Ffa60NhFs2IRhoj
    NdJfmplvJxHziUFS5aBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKZ3bfg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:35:03 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 4/5] mmc-utils: Add FFU optional mode 3 that uses CMD6 and CMD24 single-block write to download firmware
Date: Fri, 25 Oct 2024 22:34:53 +0200
Message-Id: <20241025203454.162710-5-beanhuo@iokpp.de>
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

Add FFU optional mode 3, which initiates firmware download with CMD6 to enter FFU mode, followed
by CMD24 for single-block write, after each CMD24 single-block write, CMD6 is issued to exit FFU
mode. Which means in this mode, during FW downloading, the device will not remain FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 28 ++++++++++++++++++++++------
 mmc_cmds.h |  1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/mmc.1 b/mmc.1
index bc2f1b8..acb37c1 100644
--- a/mmc.1
+++ b/mmc.1
@@ -198,6 +198,9 @@ Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated d
 .BI opt_ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
+.BI opt_ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block is written.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 53a708b..d2a4d2a 100644
--- a/mmc.c
+++ b/mmc.c
@@ -244,6 +244,11 @@ static struct Command commands[] = {
 	 "Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
 	 NULL
 	},
+	{ do_opt_ffu3, -2,
+	"opt_ffu3", "<image name> <device> [chunk-bytes]\n"
+	"Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.\n",
+	NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb04821..2553de2 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -64,7 +64,8 @@
 enum ffu_download_mode {
 	FFU_DEFAULT_MODE, // Default mode: Uses CMD23+CMD25; exits FFU mode after each loop.
 	FFU_OPT_MODE1,	// Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
-	FFU_OPT_MODE2	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
+	FFU_OPT_MODE2,	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
+	FFU_OPT_MODE3	// Optional mode 3: Uses CMD24 Single-block write to download
 };
 
 static inline __u32 per_byte_htole32(__u8 *arr)
@@ -2860,6 +2861,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	} else if (ffu_mode == FFU_OPT_MODE3) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 
@@ -2961,8 +2967,13 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -EINVAL;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) /* in default mode, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
+		/* in FFU_OPT_MODE1 and FFU_OPT_MODE2, mmc_ioc_multi_cmd contains 2 commands */
 		num_of_cmds = 2;
+	} else if (ffu_mode == FFU_OPT_MODE3) {
+		num_of_cmds = 3; /* in FFU_OPT_MODE3, mmc_ioc_multi_cmd contains 3 commands */
+		chunk_size = 512; /* FFU_OPT_MODE3 uses CMD24 single-block write */
+	}
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
@@ -2972,9 +2983,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
 		/*
-		 * If the device is not in FFU mode 1, the command to enter FFU mode will be sent
+		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to enter FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = enter_ffu_mode(dev_fd);
@@ -3029,9 +3040,9 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
 		/*
-		 * If the device is not in FFU mode 1, the command to exit FFU mode will be sent
+		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to exit FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = exit_ffu_mode(dev_fd);
@@ -3217,6 +3228,11 @@ int do_opt_ffu2(int nargs, char **argv)
 	return __do_ffu(nargs, argv, FFU_OPT_MODE2);
 }
 
+int do_opt_ffu3(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_OPT_MODE3);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 4098931..0fbb2b5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -44,6 +44,7 @@ int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_opt_ffu1(int nargs, char **argv);
 int do_opt_ffu2(int nargs, char **argv);
+int do_opt_ffu3(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

