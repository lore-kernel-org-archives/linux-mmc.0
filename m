Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EF1925AB
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887907; cv=pass; b=on07ErUTqXL1C+GGiWwWDBmYg5peiffd0n4oZ7NfzqD4uPtyNMmxlaqkxEpQ2QJ/c2xRKuQn6e6+1SMXrCYynkW0+79xeBeIFkmrgCY4fmmzWbrucca9XRSAFG7qloG3lmVuor3iucS4NXiJuAAD6xCDgEQ/Sbi0++M//HZY+zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887907; c=relaxed/simple;
	bh=6PQ39GKuXfAUME8HbJ0aQj6mKhy6lHTPYVmXvkVFBfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtGYg9OR+fZ/YXXsEY4iIi1TQGHY8RjsOaUWtQFuI7wWp7+iN+fSm2M5JTmxCBu+tfZY4SNrO0gAAaah64EhmE2+Mue334yFYNZ0Ccs+MdrAdnxMSAOmFX32lhi0/b9GoAAaRcGbK3soDTRTwO1Aq65had28nEkreXnPeZ6AZvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=q1oKxday; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=UllaFivU; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="q1oKxday";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="UllaFivU"
ARC-Seal: i=1; a=rsa-sha256; t=1729887720; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hfW4u91qSvrtkEWFsVurZ9uTI9VS58zj72ldyBEcUxF8eqNflC3A6a36nP6SSFIN9s
    88upGkbOd3qbLSf08y/2EjLOMhSWInoQqi6/UZJJWmVEdTwlCZb5ljofmXqv+N7wvj98
    WD19IW3S4fYcwP9ZMavZ/otyzi46zqclLI376Q4/eOv8BPegjQkLQq26N+Jx1wmgisyI
    kng7okAmggfQM+JV0ak9Je2EfQmB7lXZnstggtxaPVh4jG/WBLqT9pJpBLMu4ahuU9eW
    /k16VsU13B+7HNrRvBxkKhBIJe+3ZgG1kSspuxBBJWIp0l5fcuc0BLDmHL8fz/DbjMAk
    JY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887720;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=jZWR3ev7KdsEwpq24w/hhzbRxNRO10y7xeM+6XaHt4Bl4bSmjuL18Sy9TaQQd4s+Ji
    cp954IXY0KX05AuQCWODxFLNrJUgjM4hm0g7A+fX8cizMrnXMnPZH6DqE2PA5RkkmNR4
    qpy7/8jOYj3CnsHDFMzz5eKfuykgp2G6Kq3mBa38xcZshta0c/h4JrbYKiV7IUTWwcZx
    AkS4zU1mMqky/f/TVOPnqszvVbP40bD2S/mg8yjm+F8dsMjbLcx0OV+2VpYES8MdyR34
    HFXghw186lJjJSRg8gdpyofvNuZ6cp3gh62eL7WNb55v++sKv+TrHUYVqRSdm/TY7URg
    Q1ow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887720;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=q1oKxday3aGHKzlgLH1c8GF7QPQ1ymwvfSTUuzRPgSL3Fb6QrmulCIlrst/3frWZ/F
    9qf85BRfemvqO7amaq5e5p7pp1WtR3eVUzSdz27iwC9dtZQLe1cxnUqPLA+yl13Xq60E
    mwRGoCoWIOskarbFDLQPze8aygenV8YCgwLrqOXHd6JbwFxG6NFfCBQeeuA9k+LqvInC
    BD93G+xuNXGdD6vq/g92SZcPYZR3Dn4fYzG2/uyXVyNzbvt+Gep8t9B6EUW0ACzLfyUC
    eh+Vvtcb4p6dfCc44PJDXzFJ5+HIuGHOknWLs0vhYgNGyLbESYK4fTTJyafHm497Ew5E
    RMxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887720;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=UllaFivU30elhsc3qyqqRP8eC8C8VgNaMt05reQ8aDEh0q0K4pHTuZTKZgqS/2rap3
    t/cUjUQ9Emc1+B6QmPBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKM0bf0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:22:00 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 5/5] mmc-utils: Add FFU optional mode 4 for firmware download using repeated CMD24 single-block write command
Date: Fri, 25 Oct 2024 22:21:48 +0200
Message-Id: <20241025202148.161586-6-beanhuo@iokpp.de>
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

Add FFU mode 4 which enters FFU mode with CMD6, followed by repeated CMD24 commands to perform
single-block writes for the firmware download. After downloading all firmware data, CMD6 is issued
to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 36 ++++++++++++++++++++++++++----------
 mmc_cmds.h |  1 +
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/mmc.1 b/mmc.1
index acb37c1..543742c 100644
--- a/mmc.1
+++ b/mmc.1
@@ -201,6 +201,9 @@ Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to downloa
 .BI opt_ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block is written.
 .TP
+.BI opt_ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Optional FFU mode 4, uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index d2a4d2a..077e901 100644
--- a/mmc.c
+++ b/mmc.c
@@ -249,6 +249,11 @@ static struct Command commands[] = {
 	"Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.\n",
 	NULL
 	},
+	{ do_opt_ffu4, -2,
+	 "opt_ffu4", "<image name> <device> [chunk-bytes]\n"
+	 "Optional FFU mode 4, uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.\n",
+	 NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2553de2..dbe18ab 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -65,7 +65,8 @@ enum ffu_download_mode {
 	FFU_DEFAULT_MODE, // Default mode: Uses CMD23+CMD25; exits FFU mode after each loop.
 	FFU_OPT_MODE1,	// Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
 	FFU_OPT_MODE2,	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
-	FFU_OPT_MODE3	// Optional mode 3: Uses CMD24 Single-block write to download
+	FFU_OPT_MODE3,	// Optional mode 3: Uses CMD24 Single-block write to download
+	FFU_OPT_MODE4	// Optional mode 4: Uses CMD24 Single-block write to download, but stays in FFU mode during download.
 };
 
 static inline __u32 per_byte_htole32(__u8 *arr)
@@ -2866,6 +2867,9 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
 		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	} else if (ffu_mode == FFU_OPT_MODE4) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 	}
 }
 
@@ -2973,6 +2977,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 	} else if (ffu_mode == FFU_OPT_MODE3) {
 		num_of_cmds = 3; /* in FFU_OPT_MODE3, mmc_ioc_multi_cmd contains 3 commands */
 		chunk_size = 512; /* FFU_OPT_MODE3 uses CMD24 single-block write */
+	} else if (ffu_mode == FFU_OPT_MODE4) {
+		num_of_cmds = 1; /* in FFU_OPT_MODE4, it is single command mode  */
+		chunk_size = 512; /* FFU_OPT_MODE4 uses CMD24 single-block write */
 	}
 
 	/* allocate maximum required */
@@ -2983,10 +2990,11 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2 || ffu_mode == FFU_OPT_MODE4) {
 		/*
-		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to enter FFU mode will be sent
-		 * independently, separate from the firmware bundle download command.
+		 * In FFU_OPT_MODE1, FFU_OPT_MODE2 and FFU_OPT_MODE4, the command to enter FFU
+		 * mode will be sent independently, separate from the firmware bundle download
+		 * command.
 		 */
 		ret = enter_ffu_mode(dev_fd);
 		if (ret)
@@ -3004,11 +3012,14 @@ do_retry:
 		/* prepare multi_cmd for FFU based on cmd to be used */
 		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
-		/* send ioctl with multi-cmd, download firmware bundle */
-		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		if (num_of_cmds > 1)
+			/* send ioctl with multi-cmd, download firmware bundle */
+			ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		else
+			ret = ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[0]);
 
 		if (ret) {
-			perror("Multi-cmd ioctl");
+			perror("ioctl failed");
 			/*
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
@@ -3040,10 +3051,10 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
-	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2 || ffu_mode == FFU_OPT_MODE4) {
 		/*
-		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to exit FFU mode will be sent
-		 * independently, separate from the firmware bundle download command.
+		 * In FFU_OPT_MODE1, FFU_OPT_MODE2 and FFU_OPT_MODE4, the command to exit FFU mode
+		 * will be sent independently, separate from the firmware bundle download command.
 		 */
 		ret = exit_ffu_mode(dev_fd);
 		if (ret)
@@ -3233,6 +3244,11 @@ int do_opt_ffu3(int nargs, char **argv)
 	return __do_ffu(nargs, argv, FFU_OPT_MODE3);
 }
 
+int do_opt_ffu4(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_OPT_MODE4);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 0fbb2b5..407cbe6 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -45,6 +45,7 @@ int do_ffu(int nargs, char **argv);
 int do_opt_ffu1(int nargs, char **argv);
 int do_opt_ffu2(int nargs, char **argv);
 int do_opt_ffu3(int nargs, char **argv);
+int do_opt_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

