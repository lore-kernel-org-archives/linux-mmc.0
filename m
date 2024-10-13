Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42914A4D1
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853782; cv=pass; b=SLUjpqCmjqyNPe0EIP9AqsY0XUcP8yved3W0e0eVTlUQvDA7TcoMbMpwvU5nSflkSowNLWu0ynalwuXJGOy9AjhccTK92szFBuOPCpNQof607vNkuCXrQWHX+LxhQ3e2AP464XPXH2AMaJ68PyEf+yyQwhKiCFDwtjTdDSjodNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853782; c=relaxed/simple;
	bh=WjLJiEacKb8JAvYDydKxrhgcovKSHovR0j+uJ01QUKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8pOuvV107SRZege8kFx5ft/j/KiCxZbYbqGH2a+2cAdMfM5afvzmfNt1twu0cfJ31cdXahdmYy1+4FdL7f8GNhJT5LSKyrI9th9XWJb1UdlqupCO+iE1TOZNV+gnolC2tHyg7KEZc/CPsLicWNcmTPCeS4kbnk+8xom4fwkQr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=NBsBvC2a; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=TIURjfRg; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="NBsBvC2a";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="TIURjfRg"
ARC-Seal: i=1; a=rsa-sha256; t=1728853775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U3r7Qp24KoNUaVwp8BvRBxJ0UXeDQd7Pp0i5zB/LRhnhQGEZmZBTXHFdHi0QiQSBQ6
    20onvCN50ZkZ5wypQZUt1nzxQ4ZgFPKQSbK01dwv8Ji2P/j6pIY3UtnUY6nskLWjVI7s
    WZ/FI6cooV9MpfoMTlzNDv+DJIdE8T6le2jlJMdlxOkH+6VTS/KaxkcOLpOOCy2iyY7z
    El9LFuNFnND60z8asuHtOkuZqR14ZVaBG9YWPbe7uSWtyjEP6WV8Xfvwojf8IhFt4CI7
    C3DPfCUwYA/00ACr+poy4HRieUan9daSu46cOLCfg/1cO9q1LI+AlcjcLRLkr3/DruqS
    n/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=TgRvGR+42hpEtwwqdzHoo0pJJV4CUYGlWNzZdtvap9keXIaP1Mah+y18ba9AKq1lRN
    cJkvPCR1MYS70UKHQxalZzjGxF2IsRRty8H1COSlY4tSoERnOWfXGtPUH7w/1a9L/tx+
    4EwYlO0SMi+SOXBYj0k+wyZ8fIUT0DHLtoUJYHNQp8k+iYI2zmU5AaZhky1XNXVA7fWQ
    HxJCTlBV9Q8Ni7jy666VArsS57OtCf5iD5UP0UEso01b6X5sQ427g+OWgcLgAXBxWGh2
    aGnmXconRIMujjygsvqC+QAbt+qtII2wjh2GjZqDc9BB74dOoOvTfA/T6DUlT483ZcVN
    Tq3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=NBsBvC2a86DhpIASYtpyIAQO9m6xhHeDtFHOfsc3WzO7yF1N6ajA2jzn6Zwd9COPBb
    5Cgo7W3uZ3dDu3O0zjP9UUEtHfgXOgKoQrkkEtHqPFGsOVDfNK+Tl0e9IdC9p7nj/oTY
    FFE03UDqN7rgJIgDILZxOvxIWc3aHvHoyN4qLFrhArzrkx8/T5n7QItCXm6QPfk2RT4V
    E1Gejr4aQ4isSqMcmclmcaBnbkdcUC7yLRAmYufVbOfs4pO0FDhXObGfOXpp53JaiKwr
    sY6XsCNulXFzHkYDJUyDfign4Q71K6pa4s5hzIrm49CvUxBAEeBSYpGcpz3Vj8jAvOTL
    VdLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=TIURjfRgO8Tla7K7dQ2R6vfd73O9hi+n7qCXpLvO5xXBL8L3QJ1OyCZKsPUEnH5vQC
    UYeza8muueD+KdCDiMCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DL9ZB82
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 23:09:35 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [RESENT PATCH v3 3/5] mmc-utils: Add new FFU mode using CMD25+CMD12 for  Open-ended write download FW
Date: Sun, 13 Oct 2024 23:09:23 +0200
Message-Id: <20241013210925.123632-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013210925.123632-1-beanhuo@iokpp.de>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Introduced a new FFU mode leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 10 ++++++++++
 mmc_cmds.h |  1 +
 5 files changed, 20 insertions(+)

diff --git a/mmc.1 b/mmc.1
index b98b63f..d1598f7 100644
--- a/mmc.1
+++ b/mmc.1
@@ -195,6 +195,9 @@ if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the larg
 .BI ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
 .TP
+.BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index f1d98e6..a0227ca 100644
--- a/mmc.c
+++ b/mmc.c
@@ -239,6 +239,11 @@ static struct Command commands[] = {
 		"Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
 	  NULL
 	},
+	{ do_ffu3, -2,
+	  "ffu3", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	  NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc.h b/mmc.h
index 6f1bf3e..14dac38 100644
--- a/mmc.h
+++ b/mmc.h
@@ -27,6 +27,7 @@
 #define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
+#define MMC_STOP_TRANSMISSION  12      /* ac                           R1b */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b507bff..6c38387 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2833,6 +2833,12 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	} else if (ffu_mode == 3) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		multi_cmd->cmds[0].flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	}
 }
 static int enter_ffu_mode(int *dev_fd)
@@ -3140,6 +3146,10 @@ int do_ffu2(int nargs, char **argv) {
 	return __do_ffu(nargs, argv, 2);
 }
 
+int do_ffu3(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 3);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 81364f4..e3e9192 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -43,6 +43,7 @@ int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
+int do_ffu3(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

