Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AD1B21B1
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888691; cv=pass; b=dJa+c8/cdFPxPLKLD1C3s+rGbRVUHaR3QrHO1pSCKT5INhX5k+3h99Ughoo7s525DJ7Jc6+arnqAEPbFN8OnHhCYoxVH1WsS3AHMw1Z1KTxtXA9Ulkf9LhhRNyRBjiz9p0sKwFnyWwg3/rXRz5EpYKYhKtf8jWvRtg12x7p+PZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888691; c=relaxed/simple;
	bh=6PQ39GKuXfAUME8HbJ0aQj6mKhy6lHTPYVmXvkVFBfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNwVk86TUAd5JNWin17XfqzQ1t1fTVEmdaEOXZYnNp+PxNKi2LlzsnJXPZNoMIKlrntu3+aJkswNscdJWR2c7udW7uOj+v9+d0Revj/SkTMo1PTtcg0zD2pcXz20cMx8WNKRkUgsDeu9mxAwTEui8CgdiAgHPr4FTU9qwectMoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=pcpwkxvu; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=/XtWl6rX; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="pcpwkxvu";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="/XtWl6rX"
ARC-Seal: i=1; a=rsa-sha256; t=1729888503; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SwHZNPRKLyKRcm85eTK/csiU5SNscSgB56ZQ2PohtOcCgbXqQOf3JzQ+EtL5gi4lEG
    WavU2JJhVVGf1Ua6i4mPOm68OuiX5i/JUy3CtbHTf1G6R1FjSaboorNlTV2YogkeTIqA
    ThaESYuUR2hRmN+qU7nuGtBwuOP0pO+/CvnDL0YirZIVxqqZNDoKnLjxm5rgHXFT0itR
    6MsfvpR6OHYFhBTM/QeHut5iMa6rT9bSvqqKE8ZQXE2hGtqbzXPoErEP/fkLOvdq8+Ml
    dj0I+L8YEtLSJ2ogHxwrjtHWH3Swjax7ArgR3rDOOGW6OX2yZ+RXHIC7ctol3wOp1dJm
    SXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=Lm//5i9pfC2a56NAyKHUqgquSDXu8m3QnC7JDMtTWp7G0YciVfHfGu1br+hR1aKbLh
    LR+3YW85ZJWFF/DBDcjCSE6Q/vx0SDxQVGoe9YU1FdH60B7QLoV2rc+piwk1iQyEyrx9
    gA0ik+jrg5mu++PqMRRVd/YnPsRPsyz/QtU3Kb7x8IzGXYMvZemyMDFslyneJvsLi+x4
    o07Yu+pDsEP5aew8kAMdRORHM8qET1qI9L5u6pGOulCkH/5OIdKs48M6L6kUwYKuTlTp
    nbnjdZe3pxx3hyXwKddp1SklRNHaOfCr9/NlIl0JfArOrDwAbODSlZrf8G8d376zoTVn
    Qm3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=pcpwkxvu+Sv60zQTwKIkOaO16K1cZBIxccMOhx7NllsXfuCtZzICVE4HRiw3+xKaS8
    1lGDileTKoWGJzdzvi5VyRsex511sjL5bvCaZA49iMg6Jd1AaE3JMX9jNQDljp/nyT1t
    bNE6FUkEdKdjr156xKAT5jQJr6LY079QHI8pI/xloWGsRzldP32TDuyUt4yr23NrX96C
    e1axbquIV14xb0ksMJMOJcDDl52pFk3I/k4angoU6vCqh9zu26ETJpRdhNXYaDz8rgmm
    WD12yq3glNXVG3Hps1atr7oD1gc3hij1VLBx61w7zQ3icSXCerMBkAuvf1pdctX/OGAJ
    Um9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729888503;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Bjr2GODXtzmbEbFbBTd5R0ilCQZ78NJ3oqWW3iNC0a4=;
    b=/XtWl6rX42zYSEVo7LLXU8uigM9If0/E1mh0q9ev+lsnGqzkBwBq8wqX4wqVu0Woeo
    wFvf6uMIRGCwhqCWObBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKZ3bfh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:35:03 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 5/5] mmc-utils: Add FFU optional mode 4 for firmware download using repeated CMD24 single-block write command
Date: Fri, 25 Oct 2024 22:34:54 +0200
Message-Id: <20241025203454.162710-6-beanhuo@iokpp.de>
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

