Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB18136345
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853782; cv=pass; b=ZcQ6vARMpRsRA6C1zCUfqaeRNTxbWMmTeCtMrl+cbAfIXFTCzz1LKuX8VDrv5LJgPVqgI/WVH1+bfgmAuYelTB53RhwlUFJPt7Oti9/hxu16r3UKx88e5Ah01PQhRetiD3FHzUCy02jyohPebiTTkj+A7sOPj6sItyWzjR2SR8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853782; c=relaxed/simple;
	bh=8oW5Dsyc/RpFudOVLoMeeD4uX9PAwHtRT1OyfCt0l5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIwmIpvFlDJJ328EBbhmQBAi8ebUTWGUNUoqrsetUnkjEKb9BaQ4pcEXg88zesMHwyVJcryLMUDDtg0BMqi2ZJwkd0IObyOxwcAg/B9b/p2hOVG/5qVfrorcoKZ+57+k8l0W3Zvena3jjssDNijWPha6yJ14rrR7gwBKmNIG444=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=NfjZ8Iu4; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=BO5wdJ2I; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="NfjZ8Iu4";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="BO5wdJ2I"
ARC-Seal: i=1; a=rsa-sha256; t=1728853775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CJ+I6lu+QFebemg/LAXJr8SZjdxQkYrbvpMV09RU6C/cLlN66X0TOXPa/YlA5bhcOC
    CVq+vLchvz4bmczXrYDQZA2842gPhUoRMGKQF5X5flo0X9gpllro8vaF2FimU+YbBIfj
    m8+l0NXao7y2sKwAS16eQq72aOSvi+bM3yk9G5O/bwAIZvnUhklRMghgL7GI0LfaNhyz
    WNuWSImpoP0zdqUYqGASgmLh4nLWMgb5SWytfD2GICeJD/525l44Rleril7qdpbixPwy
    /e3bOlEhKoJzhIESCys1/IJ7FxBukEU4F4g1K/qlminx1X2Jir5MIF2IVwrvyBxIYeTY
    YnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=gxJLIxFS1W9ksLiPHhjHCV3aa9vstIHRPdln5mjpvqXhNb4iJOe1ca+ENTC3y1HgiY
    R/wuNsiY/3P4PPozhqOMf01f5KlPqtiqFb+0TcoiCiiByVcX/pLmGFktNP+q9fW7QwY9
    osgodJL6udtAiU1792X52Zoa48ZknUndaigK7AkV+gCzxz0ID4Rm7zqJSUQTWbJlSEwV
    sCLSMp5+rgae98l4fGLFIYVSX7GjIwv/pvNxhxZxYkMF7/ZwxAmbESVRzqzzYvXlmyO3
    jbdCGJfEF7Ikvey3ECbjo8JUuyhIdhdqESE2sceYDz9jEPcY/6AbfdLpyt4iBetgQd/x
    rzYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=NfjZ8Iu4+EUmVlNESOye1QzF+4QscmghlbId9AiahG9CSIZPNo2gVw5+An7c1PmWWQ
    UeitlIB9cb6FQCDRw3HTCNk6bOUHmuQUz/gYD6o+RpJNwz8p24o2hSUP24Inj2aPCrgQ
    ferdAK8bu886poDy0xDmoXFuPEoKFcPcFQ0kobQ+U2WzTL2k/h3DbZY672EWVJBulyo9
    qwlKkWwCKfWxr+PnjtNW8mF+HSFQ+LR+NA5De+9sTFzeuPzQKVGDxinJICUXnhUts+3X
    QHMq/0HPTGNz+fbCo3eOa7O3yb0ycLs9pzD5tiqQKa6Lt8boY/6vJbKZ/I1bkrV/nIR6
    RN2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=BO5wdJ2I0WFparTn55BZugPe1Sru6bnvUfDTke8Idq71Y349QIbFle2oO2xYNKxnNf
    qM4tW6rK6tzqD2Klb9CQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DL9ZB83
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 23:09:35 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [RESENT PATCH v3 4/5] mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block firmware download
Date: Sun, 13 Oct 2024 23:09:24 +0200
Message-Id: <20241013210925.123632-5-beanhuo@iokpp.de>
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

FFU mode 4 initiates firmware download with CMD6 to enter FFU mode, followed by CMD24 for
single-block write. After each block is written, CMD6 is used to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 17 ++++++++++++++++-
 mmc_cmds.h |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/mmc.1 b/mmc.1
index d1598f7..5e147d7 100644
--- a/mmc.1
+++ b/mmc.1
@@ -198,6 +198,9 @@ Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mo
 .BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
+.BI ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index a0227ca..fd78f9b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -244,6 +244,11 @@ static struct Command commands[] = {
 		"Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
 	  NULL
 	},
+	{ do_ffu4, -2,
+	  "ffu4", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block written.\n",
+	  NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6c38387..6290440 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2839,6 +2839,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	} else if (ffu_mode == 4) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 static int enter_ffu_mode(int *dev_fd)
@@ -2924,8 +2929,10 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		return -EINVAL;
 	}
 
-	if (ffu_mode != 1) /* in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == 2 || ffu_mode == 3) /* in FFU mode 2, 3, mmc_ioc_multi_cmd contains 2 commands */
 		num_of_cmds = 2;
+	else if (ffu_mode == 4)
+		num_of_cmds = 3; /* in FFU mode 4, mmc_ioc_multi_cmd contains 3 commands */
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -3068,6 +3075,10 @@ static int __do_ffu(int nargs, char **argv, __u8 ffu_mode)
 		goto out;
 	}
 
+	if (ffu_mode ==4)
+		/* FFU mode 4 uses CMD24, the write is limited to single-block operations*/
+		default_chunk = 512;
+
 	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 
 	/* Check programmed sectors */
@@ -3150,6 +3161,10 @@ int do_ffu3(int nargs, char **argv) {
 	return __do_ffu(nargs, argv, 3);
 }
 
+int do_ffu4(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 4);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index e3e9192..27dc6c4 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -44,6 +44,7 @@ int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
 int do_ffu3(int nargs, char **argv);
+int do_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

