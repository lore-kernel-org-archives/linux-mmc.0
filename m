Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473221441D
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888699; cv=pass; b=EstDB14jDMrQuRsLChCd0PxBOIeURmNDDrTdhnEZy37lZyJ5nenNWzRj6brXzMR0XB6qGIaiwh3WpCliUiYQ2hPStHgNGAQU0B+rB0cdP9bNbEiTeoD+jpn+lUHdt1KF5NbYllvamjG+qwzbqA/lgWGMIhjI8Penpm0nBirqOpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888699; c=relaxed/simple;
	bh=fp1k/NkCPxwbukQcVqaIbDB9uCBxUDYLknbXvycq82g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYaOHUukg6xmihjzzaFQKhgvw//pPcAGrymzMvTIhkCi1RdRsWH4MIJOERLHuv2QSxksGxdOBI/e9w40sW8pzkRUI4u5/rK2Ivgs45DtdGAMhjtEjH/aClXdAiCZZdgVKv9xO1gzITbXNgJItDzgBGCai9XYDkWuQUZlUEVd+gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=g98my2sU; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=fAzrewtH; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="g98my2sU";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="fAzrewtH"
ARC-Seal: i=1; a=rsa-sha256; t=1729888503; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qkTZviqallvraxytc1HSvDEGka3oKTuSifa287b0fXs4+TZl3zrlX6jkYxRtoeoUlP
    kKOY+9ff7oNJvHHoNc+YsFPj4b/f2qd1szOpjN4yQy5RkUMrAuOXptQlonhcrZLTV+hF
    FIRs59yUoExttreDXt1D0+BEA2RcSCgmqWBo2i6oDfIYFmeA4v0bu65K/6bWzn9wo8P3
    8cRYibPe9Ph75TulX4jFENJgACq2lHR/TxyaNtNzyzHwMQotUlmlBtVD2DLdIgkXepgv
    2f9W/8n+zx2HJ/eQobzOk/qb9Z6MKyrFQmldbEQ1r8IE3Ovj5pPMg4eaFa9tzv1TU8yX
    v1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=auFcfPxumQ/FRGuc14sorlkI5qxgrkOsbmMqLLt+BK9tmbWGv2M4LnBU1LY1fDMMCJ
    Q/Y+zSNT3OMGTSapfwtNVyxRX/4GZESgcn0uiUkRv5TYsL3OdQtgNuClfvzj0oM00bai
    qo2UeyXb+Cbpnz2zJKbKxzYe32x6iAf41U8L5nCGeD8iDmzjq7jJokFRcfzSUaQ8YqyJ
    8ihNKPW8ikJCwR/iE1F/vJ0EdMml89HkKKdaoyGubey+bGVKYKZNfNNUKhcjZ1j5JJdQ
    v8iH6rRfD3OWbwjlPQyXv2kGvfXBchOz1ZW1umzqkY3uX/TGElET2lP2a6gk00x8MlKe
    +csA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=g98my2sUNzfNawrJ/yhmnXSqQAknvCVgp2wVGZSTgHG3HD/CTPSpP/ubhaDmIdSmjP
    wTkQWdMzcAiF5+dL5ry4Hr2Shgz5/ZB8cj4WJYcg/KLkJzBWqxIItDn91R7lpDN4B005
    13S6ewZex92Nlb9JbNrPaKM5sB7eb0oOM6HtlYABrlUjiztYcQS77ZoZd1iNC0D5aep9
    aS3fNktko1GO9XTM/ETW5rEje2PlfGT29aHZaJIJ0RAD0Hh/fGU3nVpin9b471m7mVkB
    069CdKBjjqsOmABCFFzOXAb+fCgNrx7zyKZaO7lxnCxr+3s4FqSAfqPCXBW3/MZ+6XXj
    KQgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=fAzrewtHQjieT4px/yOscpsllrsZYS5H/4az8A+P/BZ7UG/0elqhoGFWjXapjooelY
    3vAbgoAwPMKNHxDEhsCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKZ2bff
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:35:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 3/5] mmc-utils: Add FFU optional mode 2 using CMD25+CMD12 for Open-ended write download FW
Date: Fri, 25 Oct 2024 22:34:52 +0200
Message-Id: <20241025203454.162710-4-beanhuo@iokpp.de>
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

Introduced a new FFU mode 2 of leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle. In this mmode, the device remains in FFU mode during firmware
download until the downloading is completed.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 14 +++++++++++++-
 mmc_cmds.h |  1 +
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/mmc.1 b/mmc.1
index f69ab8f..bc2f1b8 100644
--- a/mmc.1
+++ b/mmc.1
@@ -195,6 +195,9 @@ if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the larg
 .BI opt_ffu1 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
 .TP
+.BI opt_ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 67bd90b..53a708b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -239,6 +239,11 @@ static struct Command commands[] = {
 	 "Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
 	 NULL
 	},
+	{ do_opt_ffu2, -2,
+	 "opt_ffu2", "<image name> <device> [chunk-bytes]\n"
+	 "Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	 NULL
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
index 53a1658..fb04821 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -63,7 +63,8 @@
 // Firmware Update (FFU) download modes
 enum ffu_download_mode {
 	FFU_DEFAULT_MODE, // Default mode: Uses CMD23+CMD25; exits FFU mode after each loop.
-	FFU_OPT_MODE1 // Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
+	FFU_OPT_MODE1,	// Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
+	FFU_OPT_MODE2	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
 };
 
 static inline __u32 per_byte_htole32(__u8 *arr)
@@ -2853,6 +2854,12 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	} else if (ffu_mode == FFU_OPT_MODE2) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		multi_cmd->cmds[0].flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	}
 }
 
@@ -3205,6 +3212,11 @@ int do_opt_ffu1(int nargs, char **argv)
 	return __do_ffu(nargs, argv, FFU_OPT_MODE1);
 }
 
+int do_opt_ffu2(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_OPT_MODE2);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 351155b..4098931 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -43,6 +43,7 @@ int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_opt_ffu1(int nargs, char **argv);
+int do_opt_ffu2(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

