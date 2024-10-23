Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8F1FE100
	for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694698; cv=pass; b=ko7KzeIICjTt7g/1v3iNIvu2rrNzkiUqBGPK+bV3CaSPHOQ0f6ooo5kFtT9vt2VbQewvaXsZa5ENhynRYGGcZhkOXYORDhL0HEHEPG/O20HTNIfR4x5MHWCnFIesQ5p95QmY6FAnPzUhvrrbiWEdJTjUREnr1mil2XUv3ume0EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694698; c=relaxed/simple;
	bh=fVW7IZTwIyBE9MTvqTUTdHtyGoxR7vh3uxjDgnaUJqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myzmTUJSYo33zgQN+6jXzRDzqNa6rfoGvZqbHmTRlOaBSYGVHJDUSWT8jIlgdMt4eFj7qYnsOP4ibPPYQ4jNkTsp5CsIyAVu7r+dEt4kURKT05UaLd+dqhi2LPtV0f2QSSgiFVsYp65qFvWrZrwK23wQRfwB3K+YkbSTLXqoCIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=KUE1K3uQ; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Gu0kH7My; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="KUE1K3uQ";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Gu0kH7My"
ARC-Seal: i=1; a=rsa-sha256; t=1729694330; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rdWb8LsGN1YvyOrREwGuCRBatBIZiqMkvCqGQHvE+2fPuDkwu/ROfaOjwUGHDKdZ45
    7AGBNN0/Xfpjpg8k6IJnyeN0V8QpmKWy0sowr9YuToUolHPj/m+3z04Y+mYT/76mTyKd
    7i5KNMI5xc3UUs7Df00acCdlFQrar5piH7ZebQqVQrxMWQdWFnaPRfDfTll5DtPQUS4O
    X6m7PDjdSWq/1iKXC4ZA4+5Z4LD5Lsq45CvwrtRemuOlwTrTt3BLoGJBUl7MsIAgjkGA
    go0WnD9VgFfvG7gbcjHGTzgxEV9tTLXlGIa7URVyxYOsXHzynaatEMgvQC3xJMmOHC59
    +TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p5d81eT5j/qaZCSFlS0xBK0MfycK2mpIH8fZZtgB+hk=;
    b=rRuVWDEOw6hs4ZoaRIiBvzuJp2k5L4v2HtglEhCwY13ClIRE/49QG30ngGxjooJb7T
    Tqa++mwGsgSFeYJp2rXa+2k1DVWS6/6iP8M9BPFt5b1UAFzCRag9ejjmaTQ+DhRrfZui
    SfzHe7ZbXL3w3RGtHDk7+vKYYF8CKEBLP4fsbJXKnMxNu0c06PzTEGrGDMgpuVB+myf6
    SyLfVs7w98rlwCLYzOhFBBANMR39lR20LFb979RFW1Am32roFJM7Szvv44Li1WJ+CCRv
    cUG1o6srgk84MFa3tSTzwbj4ZFB/cRZbYKIdiouO22HN/nZrSFyXiOMFwr9E6LaOKsr1
    ojRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p5d81eT5j/qaZCSFlS0xBK0MfycK2mpIH8fZZtgB+hk=;
    b=KUE1K3uQV9M9H0SbUzQ7O6LXwlDDRiKjA7nYWJgJvpmAFggzaw/KWCfQA4vYyE2RYF
    08aFO73HgD5F8aqfvBSnSgWuARhAY8x6AVZ4JKGycDAROUo8nYw9NlQLA00229f1BrJt
    u82PJUgoagSvee22vwzCNH3t0md5e+QoGODDESKTKrqeVzn/j2dbeIWXQAcPEF49xjTe
    PfU58LZtrxXHa8aaCgczmEQW/fS3C44gIp3AnQRhxh0t5HlsOeiRl1B4nEI4y0OzZW06
    Hx2YriNrsDsBpOhJD6l1qqug6mtMWCH5ZCwp0iJAQs6aXi9/2iobMYNaPnpcfJv5xeJG
    mV2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=p5d81eT5j/qaZCSFlS0xBK0MfycK2mpIH8fZZtgB+hk=;
    b=Gu0kH7MySBxPx5NUxNlbNmIoB5JK+Ov7OMccgTeAKHdPPi/xj1or07VAeIlelLCxnO
    gNox9McREPMV2JGJcYDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209NEcoTmC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Oct 2024 16:38:50 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 5/5] mmc-utils: Add FFU mode 5 for firmware download using repeated CMD24 single-block write command
Date: Wed, 23 Oct 2024 16:38:39 +0200
Message-Id: <20241023143839.108572-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023143839.108572-1-beanhuo@iokpp.de>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
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
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  5 ++++-
 mmc.c      |  5 +++++
 mmc_cmds.c | 28 +++++++++++++++++++++-------
 mmc_cmds.h |  1 +
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/mmc.1 b/mmc.1
index 273bdcc..052d2d1 100644
--- a/mmc.1
+++ b/mmc.1
@@ -199,7 +199,10 @@ Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU m
 Same as 'ffu1', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
 .BI ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
-Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
+Same as 'ffu1', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
+.TP
+.BI ffu5 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu1', but uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.
 .TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
diff --git a/mmc.c b/mmc.c
index a6474db..928003e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -249,6 +249,11 @@ static struct Command commands[] = {
 	 "Same as 'ffu1', but uses CMD24 Single-block write to download, exiting FFU mode after each block written.\n",
 	 NULL
 	},
+	{ do_ffu5, -2,
+	 "ffu5", "<image name> <device> [chunk-bytes]\n"
+	 "Same as 'ffu1', but uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.\n",
+	 NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index c9db4b4..024f9d7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2857,6 +2857,9 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
 		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	} else if (ffu_mode == 5) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 	}
 }
 
@@ -2963,6 +2966,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 	} else if (ffu_mode == 4) {
 		num_of_cmds = 3; /* in FFU mode 4, mmc_ioc_multi_cmd contains 3 commands */
 		chunk_size = 512; /* FFU mode 4 uses CMD24 single-block write */
+	} else if (ffu_mode == 5) {
+		num_of_cmds = 1; /* FFU mode 5, it is single command mode  */
+		chunk_size = 512; /* FFU mode 5 uses CMD24 single-block write */
 	}
 
 	/* allocate maximum required */
@@ -2973,9 +2979,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	if (ffu_mode == 2 || ffu_mode == 3) {
+	if (ffu_mode == 2 || ffu_mode == 3 || ffu_mode == 5) {
 		/*
-		 * In FFU mode 2, mode 3, the command to enter FFU mode will be sent
+		 * In FFU mode 2, mode 3, mode 5, the command to enter FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = enter_ffu_mode(dev_fd);
@@ -2994,11 +3000,14 @@ do_retry:
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
@@ -3030,9 +3039,9 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
-	if (ffu_mode == 2 || ffu_mode == 3) {
+	if (ffu_mode == 2 || ffu_mode == 3 || ffu_mode == 5) {
 		/*
-		 * In FFU mode 2, FFU mode 3, the command to exit FFU mode will be sent
+		 * In FFU mode 2, FFU mode 3, FFU mode 5, the command to exit FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = exit_ffu_mode(dev_fd);
@@ -3223,6 +3232,11 @@ int do_ffu4(int nargs, char **argv)
 	return __do_ffu(nargs, argv, 4);
 }
 
+int do_ffu5(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, 5);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index a382349..3cb7480 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -45,6 +45,7 @@ int do_ffu1(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
 int do_ffu3(int nargs, char **argv);
 int do_ffu4(int nargs, char **argv);
+int do_ffu5(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

