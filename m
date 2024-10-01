Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09021CCEDA
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815844; cv=pass; b=CgixmFb6TGVoEkhPT4vOkqbP5rhdU4AleoZzBoQiphZ24MwDstawhw/Rojke8SSufYHiyuZfjCrOPyjo8PO5Gnwehek8q6a2i8FGQUeh/q0tAIrZOzyUh50Y6qiyE5N+jixWrYNDvQqXlTpvPkOUGQGMj3VftkdFzJBmWPtXKoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815844; c=relaxed/simple;
	bh=cNq00PhtdAW/w1eFeCEj03hARx7Oeywky+JlSt4bskg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqYqsV9kDpv4OgHxjlRtPmmy/i55jfEeB5Yton9rhmPv+X7/l4YTypNHPdOSRTbTpz6DgFO9LADpQPi1GhlVyMN/GxiMDX0Q5ZJh2eA23I3kSPGRShtnvEooWtO5a8gGzj9+qadfceVk47JGnj7qk4SuQmgjsHQ0mmu+FhA6qBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=VWpONjZX; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ZdwC1aoi; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="VWpONjZX";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ZdwC1aoi"
ARC-Seal: i=1; a=rsa-sha256; t=1727815120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cdiGcrRuKwALeh7WsGckQROmjCT8BN9WqwaJkO/VtZNKOCOdfPQJc5c/LyCOSGv++c
    JN87G9dcI5hsxaBzELXyfbsnIvXuS+YppaBZ7UFETRvpeSLEyuY4XdDJVvqW5+w0LaMP
    1HFSZ7o0wW16f8pUSJJqU5wxqvio87C+eiANBWbgW/Lg3Em8nxExthtus6jbyWuDZUnr
    6W+i3CdCHDqHzx4vHlxR9fv0UJa5hc45zQCuS4BXINiNq1NhTi8mlxoZ+DPQTmRIjZgp
    2OYbIgwDrnmOgcrEfPZ+RRVM36GywseU6y+Skd5lYs6CBCoqxE56VtqAhu5aYWmSnf6J
    ZZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adV/AlN66yoFTZFGicsknLNwIfKjXGozOqwCuqrqIVQ=;
    b=JZ7lpvhKS486sH9215rP+CwUGxFV/6uqC19go+JqkREIeQ49MOv1aG8EtyDNr75ixn
    8WhShp2K8HrbtFhjQiBsus9buTsqdeiOWmuAImY86P62a4/FZmC76iPeob9WXwxwJfyF
    8Xr9atlYl05jCBx8Fu4CofrSWlBdXU+JBZZWVYF3YQso+7cVYbyBk9mlb76/3/tgH9Bs
    O3xcjODFveoJWimyh34Qv/fGwoLJS2KAjTllsszhto3abInDX4gUMyXC32MV8GQhrz+R
    DbCSC5ewkx/mrQAyHP1/odl9quvqwxh2kKDP88TWQRAhfD063lh87SLNJ2h4pZtbzdUu
    L6HQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adV/AlN66yoFTZFGicsknLNwIfKjXGozOqwCuqrqIVQ=;
    b=VWpONjZXraFBEfyhEtqxOEoqZ4PvOq2egBPymDvccQnvsa3mtgI0c2taA+ix3yuM21
    JQStg6TStxJwSaUyh9qiLz0icUZTPABCI+/n7oXEAap+YsVwyiIsL2J9xUu6FAwkToN9
    x2oXnE6e4s1MazNDT2hneDQXe4N8e9rXTOPPSM5q01H08UQjvCbpdN0iE9A5TVSK7wLo
    w4k3eA145KvDbnnafgjCFwhdVrR+Tuj1mT64n1in36zvkP60hraPD6JXQ0+0L8nJh6U/
    zhdE/7bz8XuZFg9x9PVjFWpA3ia7os423fbdCHlfMc1zz/P10HhMm7XbXMdqEGv2n57S
    vAog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=adV/AlN66yoFTZFGicsknLNwIfKjXGozOqwCuqrqIVQ=;
    b=ZdwC1aoiA5Yc1lv6iGcXFzzaIn0a8irzqIwyuK9EU7Ba2OmnEwA7K/zk35nt+QrALJ
    wmCmxWL1Lsb1W4zDJuDQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcecdg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:40 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 2/5] mmc-utils: Add FFU mode 2
Date: Tue,  1 Oct 2024 22:38:08 +0200
Message-Id: <20241001203811.26279-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001203811.26279-1-beanhuo@iokpp.de>
References: <20241001203811.26279-1-beanhuo@iokpp.de>
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
 mmc.c     |  4 +--
 mmc_ffu.c | 93 +++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/mmc.c b/mmc.c
index 52c5a89..0a22f2e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -233,8 +233,8 @@ static struct Command commands[] = {
 		"[-c <chunk-bytes>] is optional and defaults to its max - 512k. "
 		"should be in decimal bytes and sector aligned.\n"
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
-		" -m 1: Default mode, utilizing the CMD6+CMD23+CMD25+CMD6 command sequence. This \n"
-		" may exit FFU mode during firmware bundle downloading if FW size exceeds the chunk size. \n",
+		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
+		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_ffu.c b/mmc_ffu.c
index 5f7cb00..ac65130 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -19,24 +19,36 @@
 #include "mmc.h"
 #include "mmc_cmds.h"
 
-static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size, unsigned int chunk_size);
+static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size, unsigned int chunk_size, __u8 ffu_mode);
 
 static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_csd,
-				unsigned int bytes, __u8 *buf, off_t offset)
+				unsigned int bytes, __u8 *buf, off_t offset, __u8 ffu_mode)
 {
 	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
-	/* send block count */
-	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0, bytes / 512);
-	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	/*
-	 * send image chunk: blksz and blocks essentially do not matter, as
-	 * long as the product is fw_size, but some hosts don't handle larger
-	 * blksz well.
-	 */
-	set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
+	/* prepare multi_cmd for FFU based on cmd to be used */
+	if (ffu_mode == 1) {
+		/* put device into ffu mode */
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		/* return device into normal mode */
+		fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
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
 }
 
 static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
@@ -80,8 +92,34 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
 	return true;
 }
 
+static int enter_ffu_mode(int *dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+	ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("enter FFU mode faled\n");
+
+	return ret;
+}
+
+static int exit_ffu_mode(int *dev_fd)
+{
+	int ret;
+	struct mmc_ioc_cmd cmd;
+
+	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	ret = ioctl(*dev_fd, MMC_IOC_CMD, &cmd);
+	if (ret)
+		perror("exit FFU mode faled\n");
+
+	return ret;
+}
+
 static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_size,
-							unsigned int chunk_size)
+							unsigned int chunk_size, __u8 ffu_mode)
 {
 	int ret;
 	__u8 num_of_cmds = 4;
@@ -93,21 +131,20 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		fprintf(stderr, "unexpected NULL pointer\n");
 		return -EINVAL;
 	}
+
+	if (ffu_mode != 1) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+		num_of_cmds = 2;
+
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
 	if (!multi_cmd) {
 		perror("failed to allocate memory");
 		return -ENOMEM;
 	}
-
-	/* prepare multi_cmd for FFU based on cmd to be used */
-	/* put device into ffu mode */
-	fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
-
-	/* return device into normal mode */
-	fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
-
 do_retry:
+	if (num_of_cmds != 4 && enter_ffu_mode(dev_fd))
+		goto out;
+
 	bytes_left = fw_size;
 	off = 0;
 	multi_cmd->num_of_cmds = num_of_cmds;
@@ -116,7 +153,7 @@ do_retry:
 		bytes_per_loop = bytes_left < chunk_size ? bytes_left : chunk_size;
 
 		/* prepare multi_cmd for FFU based on cmd to be used */
-		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off);
+		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
 		/* send ioctl with multi-cmd, download firmware bundle */
 		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
@@ -127,7 +164,7 @@ do_retry:
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
 			 */
-			ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+			exit_ffu_mode(dev_fd);
 			goto out;
 		}
 
@@ -151,11 +188,13 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
+	if (num_of_cmds != 4 && exit_ffu_mode(dev_fd))
+		goto out;
+
 	ret = get_ffu_sectors_programmed(dev_fd, ext_csd);
 out:
 	free(multi_cmd);
 	return ret;
-
 }
 
 int do_ffu(int nargs, char **argv)
@@ -192,7 +231,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 1) {
+			if (ffu_mode > 2) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
@@ -253,7 +292,7 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
 
-	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk);
+	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 
 	/* Check programmed sectors */
 	if (sect_done > 0 && (sect_done * 512) == fw_size) {
-- 
2.34.1

