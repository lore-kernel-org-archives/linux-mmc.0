Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D357F48C
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853782; cv=pass; b=vGwQe/qtZpzs43qHYZUiHIRvbFBNyofJpWBX1tvnHDiRigAecLQaBFh3HsyuOqr6NG7Zp81WGRSq/jXY1eUe/ekn1UoTuuEDWNTAi0f/8rH3df8mNfLmiKQgEyc/KtO3FMtJTOAsOGMWW1tg6PUEDGMplFBbmN202uk5Y5d8gaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853782; c=relaxed/simple;
	bh=XmX4NgDoxP5XJO6ZVosSXsQk/U1Dd5vZuzI5M5/HHTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2F1h75KqnnjMVwWxkejIq0zxolCfuEr0am2d6jiZpH1qEN7Wq9HJesvccOsDJGhczXq3ciA2df7ofEQoOv4MYjYkoliIr5h1PyWaAJgqO1c+JjchTpPGZqK2NoUw3un3jt0OKBlfCOqlk5sglJiKCO5Q5NXUrhgweqD1zAVXpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=US6ljpT6; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=YreTz09X; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="US6ljpT6";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="YreTz09X"
ARC-Seal: i=1; a=rsa-sha256; t=1728853775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Axs3zSknRAR2Gh7pJT1PY8oQLlVhXW15dqelWvh3Z/VKPDMoSpI7kihI8aKnrREpxa
    bVXPE3K7vBjShhkgJMWmf4jfIo+l9DPqLBj2IcgirCm9opdx0tVHP2qvIdQEHRr97T73
    fMZYOq8Hxlx8s3TX47CjaEFh9vC3CK2vVYtnzvfRy7KVmFAokulKC5fpQNorS/+W6gZF
    ETl76noQAE56V1s6w7bzRoQjMDeghDmsmGRY4ONAiWY/c28HQQ4U0GQPbw1tQoOZUb2j
    TBl5Qq5dliXH1LOLr0BcFy3HyzWV1wdSccdBbLmxYwLNRjmrimsSvdUpa0txHubj0up0
    ig1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8FKF1EqrtyYkTljkfqgN6q4D1U/LdrhhotSGK4nGnvw=;
    b=bY2rdKGV4GWJWFSPGqDr0bwK2ARk5Yvr44GEMjCi0KBPXPmg/4vhq3OrsY7ub9oteN
    7d4UBoYltzAN6udYzMa6U4U6bPad98VZ+eLdCdpvSk8ogKrCeZDLs9TDdbr5/9DGNENt
    oW9cyPhecjyBP0SRTFfLXlkQ/pkw3gpMHd7ruaZlGRIfCAtkhFB+Ka4zMXHwFY0kHejf
    0C+dZKsdtAe8Hq7HjOL4b1PfQwifOEIvgkHY4o8KHRmDTMbV25Zk/BSm1iRZ1C2+oObL
    oBmKPVSArlKWx+NKA4+uMnk6u3JVzxccinwA76yAEk3/YFsP+HwL7oydJ1wGrMZ/UJ/e
    IKMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8FKF1EqrtyYkTljkfqgN6q4D1U/LdrhhotSGK4nGnvw=;
    b=US6ljpT638lokKItFhdolhtc7Qgr0qCcJsI1XzVFr5CaK0vbs9nCmrC93sS5Kr5Mft
    X7W2NZ9B4BBjvCeN3q2DijpibrE0S9VhzF21/sbZz7UVcNkFlttrLfgOGAqB4f3+OhQb
    qU2skpDi4e2VMwsXqpnH/nMuIDSdAy4w3bY6vMcLCPc6TtL/HBl2RolYOn4LXhFA7V9d
    BuDyGKxxaxvZWPwAh7g0WyhOypZqo03uI5jK71jQDK2NgBEQ5RT5OqO0YhBy35LdJnku
    r/wSGYg+V/QJEVQSHvuYieFeTgldW9sj2+u5N51sYECnddd1zhBV4ahfsDGCvl2T/uEM
    BKTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853775;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=8FKF1EqrtyYkTljkfqgN6q4D1U/LdrhhotSGK4nGnvw=;
    b=YreTz09XwceFWHMzlyRSesEh/5+lI9shVWn+vJrqZ9SNlhsS/g9naWEIgxy24jxKRV
    B+tjoGVpVyh3x0rPERDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DL9YB81
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 23:09:34 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [RESENT PATCH v3 2/5] mmc-utils: Add FFU mode 2
Date: Sun, 13 Oct 2024 23:09:22 +0200
Message-Id: <20241013210925.123632-3-beanhuo@iokpp.de>
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

Added a new FFU mode 2 that ensures atomic firmware image download to improve reliability
and provide a smoother FFU process. In this mode, begins with CMD6, followed by repeated
CMD23+CMD25 for downloading the firmware image. Once the entire firmware image is downloaded,
the FFU mode is exited with CMD6, ensuring the download is treated as an atomic operation.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 ++
 mmc.c      |  5 +++
 mmc_cmds.c | 92 +++++++++++++++++++++++++++++++++++++++++-------------
 mmc_cmds.h |  1 +
 4 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/mmc.1 b/mmc.1
index e153557..b98b63f 100644
--- a/mmc.1
+++ b/mmc.1
@@ -192,6 +192,9 @@ Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
 .br
 if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
 .TP
+.BI ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 2c5b9b5..f1d98e6 100644
--- a/mmc.c
+++ b/mmc.c
@@ -234,6 +234,11 @@ static struct Command commands[] = {
 		"should be in decimal bytes and sector aligned.\n",
 	  NULL
 	},
+	{ do_ffu2, -2,
+	  "ffu2", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
+	  NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 72921a7..b507bff 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2812,21 +2812,55 @@ out:
 }
 
 static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_csd,
-				unsigned int bytes, __u8 *buf, off_t offset)
+				unsigned int bytes, __u8 *buf, off_t offset, __u8 ffu_mode)
 {
 	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
-	/* send block count */
-	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	if (ffu_mode == 1) {
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
+}
+static int enter_ffu_mode(int *dev_fd)
+{
+       int ret;
+       struct mmc_ioc_cmd cmd;
+       memset(&cmd, 0, sizeof(cmd));
 
-	/*
-	 * send image chunk: blksz and blocks essentially do not matter, as
-	 * long as the product is fw_size, but some hosts don't handle larger
-	 * blksz well.
-	 */
-	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+       fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+       ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+       if (ret)
+               perror("enter FFU mode faled\n");
+
+       return ret;
+}
+
+static int exit_ffu_mode(int *dev_fd)
+{
+       int ret;
+       struct mmc_ioc_cmd cmd;
+       memset(&cmd, 0, sizeof(cmd));
+
+       fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+       ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+       if (ret)
+               perror("exit FFU mode faled\n");
+
+       return ret;
 }
 
 static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
@@ -2871,7 +2905,7 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
 }
 
 static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
-							unsigned int chunk_size)
+							unsigned int chunk_size, __u8 ffu_mode)
 {
 	int ret;
 	__u8 num_of_cmds = 4;
@@ -2883,6 +2917,10 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		fprintf(stderr, "unexpected NULL pointer\n");
 		return -EINVAL;
 	}
+
+	if (ffu_mode != 1) /* in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+		num_of_cmds = 2;
+
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
 	if (!multi_cmd) {
@@ -2890,14 +2928,12 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		return -ENOMEM;
 	}
 
-	/* prepare multi_cmd for FFU based on cmd to be used */
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 
 do_retry:
+
+	if (num_of_cmds != 4 && enter_ffu_mode(dev_fd))
+		goto out;
+
 	bytes_left = fw_size;
 	off = 0;
 	multi_cmd->num_of_cmds = num_of_cmds;
@@ -2906,7 +2942,7 @@ do_retry:
 		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
 		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
@@ -2917,7 +2953,7 @@ do_retry:
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
 			 */
-			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			exit_ffu_mode(dev_fd);
 			goto out;
 		}
 
@@ -2941,6 +2977,9 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
+	if (num_of_cmds != 4 && exit_ffu_mode(dev_fd))
+		goto out;
+
 	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
 out:
 	free(multi_cmd);
@@ -2948,7 +2987,8 @@ out:
 
 }
 
-int do_ffu(int nargs, char **argv)
+
+static int __do_ffu(int nargs, char **argv, __u8 ffu_mode)
 {
 	off_t fw_size;
 	char *device;
@@ -3022,7 +3062,7 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 
 	/* Check programmed sectors */
 	if (sect_done > 0 && (sect_done * 512) == fw_size) {
@@ -3092,6 +3132,14 @@ out:
 	return ret;
 }
 
+int do_ffu(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 1);
+}
+
+int do_ffu2(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 2);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..81364f4 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -42,6 +42,7 @@ int do_rpmb_write_block(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
+int do_ffu2(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

