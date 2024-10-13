Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A51494A5
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853293; cv=pass; b=R5l3lMSmxEWYYLqZvsu6vW3ZA3zFZ0d5zO7ZaRC9dAl/9gKSwIGRJ39D5PEhpYn4c2VmG9wW4g0iV2cBdyP3kuRgocmsWLE/EF310VQ2BCXmsxCpPwwW948Si7kozj8E8iFaRsVP6CSuGERQQcRCZxIy0D4Y1L1fzzl9XhBTDpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853293; c=relaxed/simple;
	bh=78ehn2GW49afHlr67uwSENexqgP92ivsson6G2+a40A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3abq2+Q8ttOQS9y0Jfrj2QgzhCBuBNqmtnHAAHym5SKbd/01alwplnHMP/tqYAhSoJ4SCrNffGSzv4XCFyVtUzLghW31YjVRW4wwvg/v1zUl7ZwRYIlXxbHzzki+jtE8l28ETqFYxJu9a43UYV6U0uYE8qXjjie6etZdS8m+f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=LYuQNb/j; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=jJEypFWj; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="LYuQNb/j";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="jJEypFWj"
ARC-Seal: i=1; a=rsa-sha256; t=1728853102; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YZNPiXPUXf/Ax55lK9fwqZ5PJ2pGZBcGNCve9R9X26qv5NnDWWK0oIBE6bD988RTF6
    KKN6et3vBn2TUydbjKKWTYkV8WSbV1sXpGIGzwi8p1Sqti5O2skBqBmcgu7L9uPMN5qg
    7kYg5GdkQpVXYTLQm9kE2Da6G3ejz/xLYsEA3JeA4ofilY26a/yJHFOZ3z1HrlVjvNGW
    leQXdIR2qN3e9e9qr/J8aBuafpzd+F3Z/4upXvb8bJ3FcKviwstBFcd+bHZKGr5vl/VP
    iXRg9EAl6xGfBta551Dgn0WBiBlRz3ai2kr2a4zAW5me7Om7sh71+P9AcxITOq2CI8jB
    /aQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=UMoZ/U7ppKyeVbbVUxTojjvk70z42K/4Q9e2Mrz0x8cL9lyyl84s+NrBigQGGwbl1a
    w6VFHnxWfGoffXUHo/ya1vPCucoJsMo7XQNlvmbKyQ0n5q/Gv+CMDy1CERuIpT5jxKQh
    Tw32d9rduwc/2eMxuypkjFwC6mRhO3w/O67mG71jYlscPUAJ2yQAXpoplBlCHPJnOnm8
    qMjL1MJ/QZlEfr/kjQGcIBzNbjXJK+eFcCnuXtV41moMrmYWWZjzGgKxedhNx/XPcLoP
    EJbYi6sYWwa/l6LVVrIs1MY5BQuhiwue5EOq0q6w3z2Yl7xanfPjGEVy8bpr8qkFVZY/
    jqMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=LYuQNb/jILfZ1oA7BkiMPXGQKtmpNqtdAvY4Ez61IBpVxVWHRCskNWCbZ6iEaP6hhn
    tjHNwg1B98dHBXlGFgAFIKSkzWVawJAdj6MqRhZC0+ruToyLvTRniTx6K+Cma0XOly3r
    mSMKbEiKzTOeiDXXr+tZ0XkXMFNeecNpcQW6cEGUMeXfjpVu3iz7pBSdNlCxuEdFnyUD
    KcGns10Jwg97Mf1rJguQZGjuUxdfnm1cR0Tq5fqppXU47XLY/IKlvDYE7aZFIb9aScYn
    6OMSse03fkdazs9wS/csK31c/PbdrrZOcSEUdeap6lpLYRdGS4hWvmbDyGACit61DMON
    dgaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mtLlqwMfJdraYzKTVBUXLPJ+pM1xcACVTC/wkwYtcvE=;
    b=jJEypFWjpGd5jOf84Bdifch8DpLyGfLu3rX+fTBVwaj/XIb7NTMi8kn6JECXLi83gz
    0d3RTKm4bNgV/th1MgBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DKwMB7A
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 22:58:22 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf,
	hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 5/5] mmc-utils: add FFU mode 5 for firmware download using repeated CMD24 command to download FW bundle
Date: Sun, 13 Oct 2024 22:58:07 +0200
Message-Id: <20241013205807.121932-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013205807.121932-1-beanhuo@iokpp.de>
References: <20241013205807.121932-1-beanhuo@iokpp.de>
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

