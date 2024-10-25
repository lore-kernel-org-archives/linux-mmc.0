Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BD1925AB
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887913; cv=pass; b=h5vf5amEoL3gPx7Ks8/FwnLQsPvS97OXkt4pCMF61E64B10Vo1v+2Wb35VKMH0lF8LZcitTCmn25eoY15gtFvAi/OQsZj81NYnWtl4WYtpi+Na3fT5poaHNyt8EhZ/h8FTiCsAN0aTmatoQxzEbzzCD/xtPTlIJoUzARMATO7/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887913; c=relaxed/simple;
	bh=fp1k/NkCPxwbukQcVqaIbDB9uCBxUDYLknbXvycq82g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcJClXt++fuGIYq/5igmgVrkuvUZeK5OGt9yzxdnQgzZekivzxYU6L3BuXr5ILiE+YAMHjuMhBuIC35hDNeyeNP/EfmXC5CIJlNmTVbzB1Oz9ii/oVZOULmSpJr00ZcGcb+n1Pniu8kHgO6tNGQ3GP7DG6GNnzzRsrx5so2B9hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ZYh5mvfu; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=KpQTTXbp; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ZYh5mvfu";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="KpQTTXbp"
ARC-Seal: i=1; a=rsa-sha256; t=1729887719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UJUjPmEEuxuD1Nyx+Qcqr+1aIIFou6t6z9sdqqqw4jrqotJ4Qned0tFYTcRahceuay
    il1SuEkHvitYpltOw+Qt8spOj9Pdg91IzgOUpjsBrFEpN//jMWQfDWC+scOf5qVNZqeT
    0DKgKCKSjEiNzKL47vPh3gYKCBt0qY6GwN6+QJAU0Kv8KfBuVnR814qdAOFGWzVzZAc0
    UL+eDkPSYwp1CNLmrhk1nbA/qPJcMMjg3xxiiIjr58mTXZunA6HyiBe7zLAwkqNclybc
    cOLjEs7X5biNaNUMdQKp65iXnZb5HToUmF89Scf8sYewLovz+NupDDz1TU5yluDkzmCO
    aQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=e8H2RMetVEB3T3mjr9g/c1Rq+MRLEYox8Y9J0qHfcnR5WwRZ+RxQElzecm28c90Z3M
    BQZ+vXm9sGsPjf8NOheo+FJilUvqPS/km99HAZvBiD4nfY00MYWnNcUIzN3QhYeQWDAn
    DmEJMl3r6nmyBzspv/L36ynaRuPBI+N9x1f5C+yV7Y/ONaPkETaIQnFlLQIImKtLFjkb
    JlqiivJuVOVC0OMBiiQI3AC9hpovZK6e0IUA3WpjY2knhi+3XQ4IiIkVi/eVYdla7xAN
    zceojgQdqxUlXQIvWrzVa9v864sABQD7bVaMcjcnSKawWmQxVYQ7PAtFLaVQgrvIlr97
    wawA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=ZYh5mvfuK0SCEOH2nFlj7EHwiHPVrb8eOgHU16xC8Vevga8HNHqDBsRQ3+GHfTxNDE
    N/N5CJ/KAnPahdKMFbOjYU7X5EGKVVnVW/F7DaZttLJJZ9oGwvSoUDhxxmyNg0uiRo5j
    zmTMwPG/i2MvGCgekd+ClP2HBOhQ8msLG9SAUigo271U0f7mIqQML+RiiUfIdysVfShj
    NpQafyeBnhzVVoFR70aKu5vwf5RVEnWqeh0/XMAA4Y3XPMIYLEauUItSIOnIoq4I3ip4
    nPSuH9KofAZuh6ECScbsB3scELiiy2Wj0j1bVRZugHWFbzwzdHdHOfDVofjHyhaOQrcv
    Vybg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UH0q/lXb3bzTen8WCFIlB7A3eJqaXnA2J1FmsRftutM=;
    b=KpQTTXbptb4O+L8TpopIoy0GjuV9iBLxZo8gPSndqbqLlBLG3h99P14+J8UFpOG/lu
    HeSn++NFejDs/Q8u2ZBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKLxbey
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:21:59 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 3/5] mmc-utils: Add FFU optional mode 2 using CMD25+CMD12 for Open-ended write download FW
Date: Fri, 25 Oct 2024 22:21:46 +0200
Message-Id: <20241025202148.161586-4-beanhuo@iokpp.de>
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

