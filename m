Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9F14AD2B
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853787; cv=pass; b=d6ZBHPTOu3J0oEl5kKy1iFIGpmtD3LOaXpbEdxHAWqvGa0i763bKQ6tCkZWfsmvh+xBxrVyxhNTjy7rSFfm+1gmecjIgzEXo3GONSxC81sb3PE/GCGC6f+5emX13FfGM3gsQsv5Tqlq+u3zdRhLPYGZjF5Q8TU2VU0YaR6H6E4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853787; c=relaxed/simple;
	bh=78ehn2GW49afHlr67uwSENexqgP92ivsson6G2+a40A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfMpAq6xWnKeNWJY5cCggNV9StmtmvMqzkxMWSLAqZ7QOKe8eVFeHUI/kYU38K/7VJORZjynHpLyZNgu103/R5Yj3cw6+NPHWo//4gw6B4LLbD6bQgFvRaGwxjp4lsFStiKCTfdv0gwveO1Cc/gESVZZWeScKMHQ5X3VIH5S3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Ep1SsPv/; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=XPqWJpAp; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Ep1SsPv/";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="XPqWJpAp"
ARC-Seal: i=1; a=rsa-sha256; t=1728853775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jKgpQD6/WvFFcvn+M03ClA3YRWotKEdkt1M9RmdPYztk6nWNRFANsMIsLzpSYVEfq9
    F/7EaMUUKuDlMNPelUYrxj06u12TE3Bx2L+KdhVfQCyPPmHO82/GUUhADcyViAfcNRrF
    UD5RRd8x0VLQxFbLITw/LOxmLxQN+q0f7WHJAJZw2QG3+8eSZlJJuQSpmIXK5GcG5CGO
    elvU+vFz5WY2S6NL+h0DA82cDjks2cKMTC/6WmP15oF0s7ijS4v/Bic5X8ljEs0cweP2
    opySODv4mG1sm9VVyJm5D6CGJPm6G0MYiK8yCzio/FbKBn046zGJ0ArIpyjjbphLEJzf
    eBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=oW2JFtrZ16gdzGp0iYkYFlLxLOv+a8t5V4YXiQc1PL5pz8rirbYl5L37mT4Cyky2mK
    L0Lf+txgbVEJ4WmfbeIEVge7efLC3V8m0O0Xjq9xNn+yDXQtkoYAGF8gQ7Q0EhZdIeH0
    PNd+dhKvbMmJSgcMNP7/5hG2YPdpyE1tgPHCFV+b+NgKhTKhqIWNvQSjr3i6qyg2juE2
    jpipLpeff9xeVOuxavNVumg5E68mK8L5eSm3a6plQJlm9gvnYP4EsVN5Ln39jWAgb3UU
    uJePUY727N5ldhZSy6eIMZAebcX17L7t35GxjCYhqP6+cGJOVAzWOn7W6QbCAMxnhH8L
    QFWA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=Ep1SsPv/uMzSzPr+JFe/jRGd0Ygple7LO9kq/d7VnRN6XlBJsCMWaDLtS8k5bTIN+A
    KJPewEw1T4MSViIo5XSsTLjYcXTgdVuxhiCxp2dSHo15dLY7oiEvhK81CIhlZUd00+PE
    mGdZrCqWbl735HSTiCvIc0fCZK+C3J4gcFoLjHCRLvR7Z6Kfu/NWMeOsizmFYdUlzATW
    kglJjzvXrhiom4LG/gwszB142AOUGyXL+oYFoaJOtFzPaoBLyBUuSybG7dJ3nTqf91W3
    hTn83joB0LjUbHAbvCg39tbvmNYhebAzXrFlgEuej/GSD2LpxV4FnObBdK0YiK20XByU
    RxHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=XPqWJpAph4yUprnX46SivinNgFbGA8afCxhaSw9dWT7zzA10auVdnIrbN69DrXzRRd
    WdN2tDqYo9v+dRsYLrBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DL9ZB84
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 23:09:35 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [RESENT PATCH v3 5/5] mmc-utils: add FFU mode 5 for firmware download using repeated CMD24 command to download FW bundle
Date: Sun, 13 Oct 2024 23:09:25 +0200
Message-Id: <20241013210925.123632-6-beanhuo@iokpp.de>
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

Add FFU mode 5 which enters FFU mode with CMD6, followed by repeated CMD24 commands to perform
single-block writes for the firmware download. After downloading all firmware data, CMD6 is issued
to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 23 ++++++++++++++++++-----
 mmc_cmds.h |  1 +
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/mmc.1 b/mmc.1
index 5e147d7..d478992 100644
--- a/mmc.1
+++ b/mmc.1
@@ -201,6 +201,9 @@ Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download
 .BI ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
 .TP
+.BI ffu5 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index fd78f9b..3c74549 100644
--- a/mmc.c
+++ b/mmc.c
@@ -249,6 +249,11 @@ static struct Command commands[] = {
 		"Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block written.\n",
 	  NULL
 	},
+	{ do_ffu5, -2,
+	  "ffu5", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.\n",
+	  NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6290440..bdfaea7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2844,8 +2844,12 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
 		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	} else if (ffu_mode == 5) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 	}
 }
+
 static int enter_ffu_mode(int *dev_fd)
 {
        int ret;
@@ -2933,6 +2937,8 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		num_of_cmds = 2;
 	else if (ffu_mode == 4)
 		num_of_cmds = 3; /* in FFU mode 4, mmc_ioc_multi_cmd contains 3 commands */
+	else if (ffu_mode == 5)
+		num_of_cmds = 1; /* in FFU mode 5, it is  single command mode  */
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -2957,11 +2963,14 @@ do_retry:
 		/* prepare multi_cmd for FFU based on cmd to be used */
 		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
-		/* send ioctl with multi-cmd, download firmware bundle */
-		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		if (num_of_cmds > 1)
+			/* send ioctl with multi-cmd, download firmware bundle */
+			ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		else
+			ret = ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[0]);
 
 		if (ret) {
-			perror("Multi-cmd ioctl");
+			perror("ioctl failed");
 			/*
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
@@ -3075,8 +3084,8 @@ static int __do_ffu(int nargs, char **argv, __u8 ffu_mode)
 		goto out;
 	}
 
-	if (ffu_mode ==4)
-		/* FFU mode 4 uses CMD24, the write is limited to single-block operations*/
+	if (ffu_mode ==4 || ffu_mode == 5)
+		/* FFU mode 4/5 uses CMD24, the write is limited to single-block operations*/
 		default_chunk = 512;
 
 	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
@@ -3165,6 +3174,10 @@ int do_ffu4(int nargs, char **argv) {
 	return __do_ffu(nargs, argv, 4);
 }
 
+int do_ffu5(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 5);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 27dc6c4..d198de8 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -45,6 +45,7 @@ int do_ffu(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
 int do_ffu3(int nargs, char **argv);
 int do_ffu4(int nargs, char **argv);
+int do_ffu5(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

