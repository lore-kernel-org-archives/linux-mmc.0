Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB6149E13
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853117; cv=pass; b=Ll9mUfxCNHgUgfRM5tAYJrbJBPA7nivN0EKfH2twwCTr6WVqEqqJzVtRiHoYuL9b9ruRgf6QWre9P0sttBLYZOSlcTbgPB8kXuTrLqpFprpIaRH3npOp0azbiBqfwLbF9pLnUibBONU91Ll4JV5GyvHHtWy5kUr3X399PLMob5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853117; c=relaxed/simple;
	bh=TV2oBRczUy1L9A7Q8KwtDqssOcxI2uv50pFVfGCsUlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FecDC11L47F0CxD4dJULmQFsWXcZiacRzViW3pctlm5Drnv6UQ97YNO3vzTMJXIHsmNWhSpia+vP5Uefq6Yaa7hzDQ8UCoiZOGfe97CxIIyG9JN2iBZJAwXKSxnQqpb+HLNiakr7T1KQSeAsCbVJm3CkKJXGugxdYbj1W7snet8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=TJh1NHHt; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=xbNkubPP; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="TJh1NHHt";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="xbNkubPP"
ARC-Seal: i=1; a=rsa-sha256; t=1728853101; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W3Rg2CR6NMf5rSWGy2BsSb8IugpxFGBBhqn7NJeL7pcHbmE5fpFSZXVXAaeNe7t3iF
    Qn1sBDOxOmrl/ZadH684U1Wyq3c71ecOQ3aSsG69NhtH/nGI2KG1VPLR2l42z0IxytRH
    IJ8JTwhEUYRc7FNLJUn4zjF/ku7azjiwF8pcGXLSPcX9SsJF7pmmgnPLe1nwcVQxWNLU
    KCAP4rtpEs3lKkC4EG7EKVowgy2oc70qDyXHiMbajjGKV6Pqm1zZzSgTMtThYWbm8csE
    xhY9OVadkY2OKXsQABHfcX82CsIBLkZcKOhrXTMwMOMrg3bwOwwTaAp84pdaJT0fLAM3
    jVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H2dfH3vQI/TPQxxyBi1cnkemDN5jGXKmbTKOVRCQlzc=;
    b=ow3tNCSMVcUFJXV7sDJ3pJG9mJzlzSSoWRQn8+hkvqZ3vOr7WctAEOllpdZ5n6+h2z
    lEbeXEpAgRra+bmQTHuZBtL4lb3u1tWWQREfuDNjmW2+0b1nr11E8nYlcPTUT/jkaWbL
    CnbvqfBsgeKGEe67IjI/+9egh290Y/nn4+G7LP376kJBxpmH999nhNvcYZJ2XxbVZjgU
    P6A7EuP/T+qmwZVWYk+uLuDeoX/ZiNJExdII4X/gquJsetEKFpNiCj8i/hyP3Hht2FqD
    3+ui4tr17YbH8fWy8/TAjBUMuAcTa+ZMM/vL7iaCKaBuOOvByXKfjlJjlWxHqq217gVt
    j4uA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H2dfH3vQI/TPQxxyBi1cnkemDN5jGXKmbTKOVRCQlzc=;
    b=TJh1NHHtbjO81U8WSfDlzpRqh+/9Zx4Py9RB9P/A3pECvrB2uFO7AL2rcZSpvZmQ5n
    NIKjPSTtJiL3jT3FreuxUDBu502IPg4EQwlzIsQSqq4EbjQ5WxlNEIrX/PQ+zGPltbeT
    JV7eLBvb1OxvTbR8o346Tgp+OurlafpP39AVICkjNK34+0+lkwkyLA9frwTEcXbtjO0j
    s7xhT4cBIcD0DE2U1KiSrpAC+7KtM9Mnxyy+Qt2Ob43enuw4GcV+P4RdGpV/WRhBmKeM
    Dst+D2iWCHCFKtug0R0huMGEqKSzAQ852y4lSKDkOojKcAvC/4wkO8EQe2GIxd2L6J6H
    +Quw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853101;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=H2dfH3vQI/TPQxxyBi1cnkemDN5jGXKmbTKOVRCQlzc=;
    b=xbNkubPPK1vE66VruQc0LC7aKB8Oir9mzzcMCRup0u6Zhi3kIq54RAUbo6xEMDK+F4
    gNvvXWX/oIdXIylP0JCg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DKwLB76
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 22:58:21 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf,
	hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 1/5] mmc-utils: Refactor common FFU code into functions to support additional FFU modes
Date: Sun, 13 Oct 2024 22:58:03 +0200
Message-Id: <20241013205807.121932-2-beanhuo@iokpp.de>
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

Refactor common FFU code into functions to support additional FFU modes. Follow-up
patches will focus on implementing additional FFU modes and enhancements.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc_cmds.c | 287 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 171 insertions(+), 116 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3b1bcf4..72921a7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -29,6 +29,7 @@
 #include <stdint.h>
 #include <assert.h>
 #include <linux/fs.h> /* for BLKGETSIZE */
+#include <stdbool.h>
 
 #include "mmc.h"
 #include "mmc_cmds.h"
@@ -2810,15 +2811,13 @@ out:
 	return ret;
 }
 
-static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
-			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
-			       off_t offset)
+static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_csd,
+				unsigned int bytes, __u8 *buf, off_t offset)
 {
 	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
 	/* send block count */
-	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
-		       bytes / 512);
+	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
 	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	/*
@@ -2826,23 +2825,141 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 	 * long as the product is fw_size, but some hosts don't handle larger
 	 * blksz well.
 	 */
-	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1,
-		       bytes / 512, arg);
+	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
 }
 
+static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
+{
+	int ret;
+
+	ret = read_extcsd(*dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD\n");
+		return ret;
+	}
+
+	ret = per_byte_htole32((__u8 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
+
+	return ret;
+}
+
+static bool ffu_is_supported(__u8 *ext_csd, char *device)
+{
+	if (ext_csd == NULL) {
+		fprintf(stderr, "ext_cst is NULL\n");
+		return false;
+	}
+
+	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
+		fprintf(stderr, "The FFU feature is only available on devices >= "
+			"MMC 5.0, not supported in %s\n", device);
+		return false;
+	}
+
+	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
+		fprintf(stderr, "FFU is not supported in %s\n", device);
+		return false;
+	}
+
+	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
+		fprintf(stderr, "Firmware update was disabled in %s\n", device);
+		return false;
+	}
+
+	return true;
+}
+
+static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
+							unsigned int chunk_size)
+{
+	int ret;
+	__u8 num_of_cmds = 4;
+	off_t bytes_left, off;
+	unsigned int bytes_per_loop, sect_done, retry = 3;
+	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
+
+	if (!dev_fd || !fw_buf || !ext_csd) {
+		fprintf(stderr, "unexpected NULL pointer\n");
+		return -EINVAL;
+	}
+	/* allocate maximum required */
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	/* prepare multi_cmd for FFU based on cmd to be used */
+	/* put device into ffu mode */
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+
+	/* return device into normal mode */
+	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+
+do_retry:
+	bytes_left = fw_size;
+	off = 0;
+	multi_cmd->num_of_cmds = num_of_cmds;
+
+	while (bytes_left) {
+		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
+
+		/* prepare multi_cmd for FFU based on cmd to be used */
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+
+		/* send ioctl with multi-cmd, download firmware bundle */
+		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+
+		if (ret) {
+			perror("Multi-cmd ioctl");
+			/*
+			 * In case multi-cmd ioctl failed before exiting from
+			 * ffu mode
+			 */
+			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			goto out;
+		}
+
+		sect_done = get_ffu_sectors_programmed(dev_fd, ext_csd);
+		if (sect_done <= 0) {
+			/* By spec, host should re-start download from the first sector if sect_done is 0 */
+			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			if (retry > 0) {
+				retry--;
+				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+				goto do_retry;
+			}
+			fprintf(stderr, "Programming failed! Aborting...\n");
+			ret = sect_done;
+			goto out;
+		} else {
+			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * 512, (intmax_t)fw_size);
+		}
+
+		bytes_left -= bytes_per_loop;
+		off += bytes_per_loop;
+	}
+
+	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
+out:
+	free(multi_cmd);
+	return ret;
+
+}
+
 int do_ffu(int nargs, char **argv)
 {
+	off_t fw_size;
+	char *device;
+	int sect_done = 0;
 	int dev_fd, img_fd;
-	int retry = 3, ret = -EINVAL;
+	int ret = -EINVAL;
 	unsigned int sect_size;
 	__u8 ext_csd[512];
-	__u8 *buf = NULL;
-	off_t fw_size, bytes_left, off;
-	char *device;
+	__u8 *fw_buf = NULL;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
 	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
-	__u32 sect_done = 0;
 
 	assert (nargs == 3 || nargs == 4);
 
@@ -2852,6 +2969,7 @@ int do_ffu(int nargs, char **argv)
 		perror("device open failed");
 		exit(1);
 	}
+
 	img_fd = open(argv[1], O_RDONLY);
 	if (img_fd < 0) {
 		perror("image open failed");
@@ -2859,28 +2977,22 @@ int do_ffu(int nargs, char **argv)
 		exit(1);
 	}
 
+	if (nargs == 4) {
+		default_chunk = strtol(argv[3], NULL, 10);
+		if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
+			fprintf(stderr, "Invalid chunk size");
+			goto out;
+		}
+	}
+
 	ret = read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
 		goto out;
 	}
 
-	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
-		fprintf(stderr,
-			"The FFU feature is only available on devices >= "
-			"MMC 5.0, not supported in %s\n", device);
-		goto out;
-	}
-
-	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
-		fprintf(stderr, "FFU is not supported in %s\n", device);
-		goto out;
-	}
-
-	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
-		fprintf(stderr, "Firmware update was disabled in %s\n", device);
+	if (ffu_is_supported(ext_csd, device) != true)
 		goto out;
-	}
 
 	fw_size = lseek(img_fd, 0, SEEK_END);
 	if (fw_size == 0) {
@@ -2888,15 +3000,6 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	/* allocate maximum required */
-	buf = malloc(fw_size);
-	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
-				4 * sizeof(struct mmc_ioc_cmd));
-	if (!buf || !multi_cmd) {
-		perror("failed to allocate memory");
-		goto out;
-	}
-
 	/* ensure fw is multiple of native sector size */
 	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
 	if (fw_size % sect_size) {
@@ -2904,61 +3007,32 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	if (nargs == 4) {
-		default_chunk = strtol(argv[3], NULL, 10);
-		if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % 512) {
-			fprintf(stderr, "Invalid chunk size");
-			goto out;
-		}
+	/* allocate maximum required */
+	fw_buf = malloc(fw_size);
+	if (!fw_buf) {
+		perror("failed to allocate memory");
+		goto out;
 	}
 
-	/* prepare multi_cmd for FFU based on cmd to be used */
-
-	multi_cmd->num_of_cmds = 4;
-
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
-			EXT_CSD_NORMAL_MODE);
-
 	/* read firmware */
 	lseek(img_fd, 0, SEEK_SET);
-	if (read(img_fd, buf, fw_size) != fw_size) {
+	if (read(img_fd, fw_buf, fw_size) != fw_size) {
 		perror("Could not read the firmware file: ");
 		ret = -ENOSPC;
 		goto out;
 	}
 
-do_retry:
-	bytes_left = fw_size;
-	off = 0;
-	while (bytes_left) {
-		unsigned int chunk_size = bytes_left < default_chunk ?
-					  bytes_left : default_chunk;
-
-		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, off);
-
-		/* send ioctl with multi-cmd */
-		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
 
-		if (ret) {
-			perror("Multi-cmd ioctl");
-			/*
-			 * In case multi-cmd ioctl failed before exiting from
-			 * ffu mode
-			 */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
-
-		bytes_left -= chunk_size;
-		off += chunk_size;
+	/* Check programmed sectors */
+	if (sect_done > 0 && (sect_done * 512) == fw_size) {
+		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
+		fprintf(stderr, "Programming finished with status %d \n", ret);
+	} else {
+		fprintf(stderr, "Firmware bundle download failed. Operation status %d\n", sect_done);
+		ret = -EIO;
+		goto out;
 	}
-
 	/*
 	 * By spec - check if mode operation codes are supported in ffu features,
 	 * if not then skip checking number of sectors programmed after install
@@ -2969,48 +3043,29 @@ do_retry:
 		goto out;
 	}
 
-	ret = read_extcsd(dev_fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		goto out;
-	}
-
-	/* Test if we need to restart the download */
-	sect_done = per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
-	/* By spec, host should re-start download from the first sector if sect_done is 0 */
-	if (sect_done == 0) {
-		if (retry--) {
-			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
-			goto do_retry;
-		}
-		fprintf(stderr, "Programming failed! Aborting...\n");
-		goto out;
-	}
-
-	if ((sect_done * sect_size) == fw_size) {
-		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax_t)fw_size);
-		fprintf(stderr, "Programming finished with status %d \n", ret);
-	}
-	else {
-		fprintf(stderr, "FW size and number of sectors written mismatch. Status return %d\n", ret);
+	fprintf(stderr, "Installing firmware on %s...\n", device);
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + 2 * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("failed to allocate memory");
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	fprintf(stderr, "Installing firmware on %s...\n", device);
 	/* Re-enter ffu mode and install the firmware */
 	multi_cmd->num_of_cmds = 2;
-
-	/* set ext_csd to install mode */
-	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES,
-			EXT_CSD_FFU_INSTALL);
+	/* put device into ffu mode */
+	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	/* Re-enter ffu mode and set ext_csd to install mode */
+	fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_OPERATION_CODES, EXT_CSD_FFU_INSTALL);
 
 	/* send ioctl with multi-cmd */
 	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
 
 	if (ret) {
 		perror("Multi-cmd ioctl failed setting install mode");
+		fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 		/* In case multi-cmd ioctl failed before exiting from ffu mode */
-		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[1]);
 		goto out;
 	}
 
@@ -3022,16 +3077,16 @@ do_retry:
 
 	/* return status */
 	ret = ext_csd[EXT_CSD_FFU_STATUS];
-	if (ret) {
+	if (ret)
 		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
-		goto out;
-	} else {
+	else
 		fprintf(stderr, "FFU finished successfully\n");
-	}
 
 out:
-	free(buf);
-	free(multi_cmd);
+	if (fw_buf)
+		free(fw_buf);
+	if (multi_cmd)
+		free(multi_cmd);
 	close(img_fd);
 	close(dev_fd);
 	return ret;
-- 
2.34.1

