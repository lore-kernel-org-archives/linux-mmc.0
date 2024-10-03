Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45A1A705E
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980760; cv=pass; b=YR2NCYa4oo7Tv7qTzJIp2+F96PNLbcVUqjTiK7kSRPON7R8tmNLP4nfNdTp1i8PgBjC3Rw9g89/LFV9EG//Kg5IwgtdGRvE9rcw3ubhFoCmRMEV4pZ2LUN/jUEMyaq6PFnkr5v0bdtCxilFfzkhy0eieA9gvoQ9xOUlgbA7l2hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980760; c=relaxed/simple;
	bh=bhBhXsOg6DjAGu3LgRvweFiDwbDuIOLnqj4gwtNYpgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDQ4jZyWqo7vuc9j0vHto57p+jadHlnRNpZftPO4wFG+SjNHZcWMIEUzZy0Lvxpk0Z4XjoBeQfDREycMMYoauEeu18BQQurEwL2PPw/zUbNnyUxXCeWgBquGEJqACcVxOvNNxacsCXJt53CSBAGDC+NUh0vcNlw1BmYGsYUlVyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=QFyVnGev; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=azTMpIf3; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="QFyVnGev";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="azTMpIf3"
ARC-Seal: i=1; a=rsa-sha256; t=1727980742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o/zIGinKLKqJhQZ4JP/OiMhFtuKV6yAtzJDv0qUAyVhqswq8qfH6wqA2rvfajBD3Uj
    olIxm9YS36QZyKbubkHKEXBW5yGcdQA+g23MXiRH6iEHg+Z4I0gzqhxLf58avFKJ6DU+
    t/J4/7zsaz1LYznb5NjIhGOyG0BY+LFbQjDaR2adNyhGMFVJWCTR3uW8UZdsmZR2KZ87
    qh/E34g/OfyaOxBup2Qe8XbuewrJDQtkzKavVk1tMmYUNlEdydatxJsS5iuFmHdmCnjD
    x/6XrdqjylkmRE6YNL2E3QHYDRomQRAZdsWDRrhLfBT7hUX1dbVYlpWhN2t6OrMe5kCy
    Y+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3LhQd2NzaIpZNPv7D6Tw0ngd1hVwt3JFs3SH+5goykg=;
    b=gONW5onDQSaXMr23Clm7z9PGzw06CS7voog15EbIpcAwe9QUSn3gTQClwAYoSHSWb7
    FTPPsAN1MUgfAHWa5ae5RkD3qjUVDoX8Hhv6cVpGc9Mwpa2LUZCqtArtmmVRZCuTw7Xw
    5pD4+BznjFjUYtqMGZK4mbl2TTeaXkuhlqP0GLpNofgN1fRIifll3G++GeBZYeFbo3o1
    Br5/9c3Cs/ESBR4wgJqOQOUK+3GKHkdSlkRYE/cnTXIOu/9NzbHncCiPXZAN9rkahSSr
    Iv9nETNJaesGq0P/UOsNXne4ikmTCDghUP3LTTKCB/WGRWpKCnwYC4ED7gMNfKofshtH
    DFtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3LhQd2NzaIpZNPv7D6Tw0ngd1hVwt3JFs3SH+5goykg=;
    b=QFyVnGevX/+lkoL8CTpERS02pUmQ1bilEQNykHqkheaQkd8Q23smFLTxVt5BGnvcPL
    UHXQQ/6NondxI2JBlnCI6cLzPKXID5itKRAXOeReRe3etLoofKv3FsdcYi75YAMuTaCy
    9mSDlxPWH3krbfkPIauWI20Rj58N8hXsZMJPW7ZQTwHRP3YD+NgS3qyWl7dpkfjHj+om
    QCwwJb30NiZaLt0/dSv8p5VROLZnXZeAo9qxaIsiEMS/29af+Kr8eXf5UiIeKz+ba/W2
    5MO0fUsiwMRF1Lua3sLXGkkFhKg+0MTXXyQ5/Z2APc3GGM863KGjgG6k5haJOLpR5nE0
    dLww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=3LhQd2NzaIpZNPv7D6Tw0ngd1hVwt3JFs3SH+5goykg=;
    b=azTMpIf3QG0iFL914ScHjFMBa4Z/Gu9JgRCdB0OEEWxT1Ti7Yj5C1yoVNMo+Rj7Y/G
    wSybLZiNR62UlO9R3nCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTu50pjmwgQ1wz9b7T+Mhx2Sk00RyG5Tc="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0093Id1iL8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 20:39:01 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 2/5] mmc-utils: Add FFU mode 2
Date: Thu,  3 Oct 2024 20:38:45 +0200
Message-Id: <20241003183848.58626-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003183848.58626-1-beanhuo@iokpp.de>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Added a new FFU mode 2 that ensures atomic firmware image download to improve reliability
and provide a smoother FFU process. In this mode, begins with CMD6, followed by repeated
CMD23+CMD25 for downloading the firmware image. Once the entire firmware image is downloaded,
the FFU mode is exited with CMD6, ensuring the download is treated as an atomic operation.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c     |  4 +--
 mmc_ffu.c | 95 +++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/mmc.c b/mmc.c
index 52c5a89..0a22f2e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -233,8 +233,8 @@ static struct Command commands[] = {
 		"[-c <chunk-bytes>] is optional and defaults to its max - 512k. "
 		"should be in decimal bytes and sector aligned.\n"
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
-		" -m 1: Default mode, utilizing the CMD6+CMD23+CMD25+CMD6 command sequence. This \n"
-		" may exit FFU mode during firmware bundle downloading if FW size exceeds the chunk size. \n",
+		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
+		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_ffu.c b/mmc_ffu.c
index 5f7cb00..52889bd 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -19,24 +19,36 @@
 #include "mmc.h"
 #include "mmc_cmds.h"
 
-static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size, unsigned int chunk_size);
+static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size, unsigned int chunk_size, __u8 ffu_mode);
 
 static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_csd,
-				unsigned int bytes, __u8 *buf, off_t offset)
+				unsigned int bytes, __u8 *buf, off_t offset, __u8 ffu_mode)
 {
 	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
-	/* send block count */
-	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	/*
-	 * send image chunk: blksz and blocks essentially do not matter, as
-	 * long as the product is fw_size, but some hosts don't handle larger
-	 * blksz well.
-	 */
-	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+	/* prepare multi_cmd for FFU based on cmd to be used */
+	if (ffu_mode == 1) {
+		/* put device into ffu mode */
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		/* return device into normal mode */
+		fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+		/* send block count */
+		set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+
+		/*
+		 * send image chunk: blksz and blocks essentially do not matter, as
+		 * long as the product is fw_size, but some hosts don't handle larger
+		 * blksz well.
+		 */
+		set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+	} else if (ffu_mode == 2) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
+		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	}
 }
 
 static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
@@ -80,8 +92,36 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
 	return true;
 }
 
+static int enter_ffu_mode(int *dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+	memset(&cmd, 0, sizeof(cmd));
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("enter FFU mode faled\n");
+
+	return ret;
+}
+
+static int exit_ffu_mode(int *dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+	memset(&cmd, 0, sizeof(cmd));
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("exit FFU mode faled\n");
+
+	return ret;
+}
+
 static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
-							unsigned int chunk_size)
+							unsigned int chunk_size, __u8 ffu_mode)
 {
 	int ret;
 	__u8 num_of_cmds = 4;
@@ -93,21 +133,20 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		fprintf(stderr, "unexpected NULL pointer\n");
 		return -EINVAL;
 	}
+
+	if (ffu_mode != 1) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+		num_of_cmds = 2;
+
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
 	if (!multi_cmd) {
 		perror("failed to allocate memory");
 		return -ENOMEM;
 	}
-
-	/* prepare multi_cmd for FFU based on cmd to be used */
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
-
 do_retry:
+	if (num_of_cmds != 4 && enter_ffu_mode(dev_fd))
+		goto out;
+
 	bytes_left = fw_size;
 	off = 0;
 	multi_cmd->num_of_cmds = num_of_cmds;
@@ -116,7 +155,7 @@ do_retry:
 		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
 		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
@@ -127,7 +166,7 @@ do_retry:
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
 			 */
-			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			exit_ffu_mode(dev_fd);
 			goto out;
 		}
 
@@ -151,11 +190,13 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
+	if (num_of_cmds != 4 && exit_ffu_mode(dev_fd))
+		goto out;
+
 	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
 out:
 	free(multi_cmd);
 	return ret;
-
 }
 
 int do_ffu(int nargs, char **argv)
@@ -192,7 +233,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 1) {
+			if (ffu_mode > 2) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
@@ -253,7 +294,7 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 
 	/* Check programmed sectors */
 	if (sect_done > 0 && (sect_done * 512) == fw_size) {
-- 
2.34.1

