Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453471AAE31
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980761; cv=pass; b=GrmkFuvOqbI7bJuGbLQF7tCMUugdx3KB6vn30rPlf9kHqzj1lPDvmO8MLfBSMX4VURm+hkYKr6JI5ObAKjAg3hJ0SWi+xeZNEHX2L5612BZn9QAxeWMrmPDVrQpv5Ujuxv4RQZnv3Je87tuUI/IqcL9BmNmpg9qQxKiSJw93MQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980761; c=relaxed/simple;
	bh=Y/OdHo9Jxg4+XwsqZgXrMTkcc6N0goH4wzV3HWJNOHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQwGoVLbuItbfgaaQ1KsyC91fF7hU/7Exc947dP5mIpWU7924pnP8+9fMRJuV3AEjhqEtiYg81o0LjJ5XAUdKghYhkuy1opquLA5L3Ax3S/7A8dOsjbc25/EB7KWPdNZlmWl2lpaCU9Di36dJbr1Hb6c75kCd3nxpNOxbh0/ZVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=OnCRY4Df; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=b20z5aCC; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="OnCRY4Df";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="b20z5aCC"
ARC-Seal: i=1; a=rsa-sha256; t=1727980742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cYvIQoxqn2Me7ffq2AX5Z0mxDBSW+B23J+MtywhXYU/WULX/g7WC8fZCYxwGOckSjr
    h4C9BTyOD9Sb8fDAkpni7LB0OmVtKbbViac0nAGOS2pvpGAoTRAEDi8jZ+QZVswnsL9Q
    fL2eEvixfNNjAkUtBnurcpLn9qPfv4q87t60GcOlIHIg8FnAO7FHydEymdDU+oem+vil
    dZOd65xaaCxf6qgXDk7KRpaKR46gs13LlaK/YhFSJ7hZIiRrNlls7dztIhRC1fXG0EV4
    k09BseTscI5B3ZzvpA7nvdon9z+RJxS+OOVJse6dfd4kKVShdUjjKLZA/6QqlbVUdpEE
    JLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5ZM2Gmq8zvT1/ZvzuJODH1RqYsMulQJThH0EpUBZAWE=;
    b=F8T/qdCSKS3mj4Yn8F3sTXftimzQczJCiDL6qXcbZoQpmvWQO+vg6nsQiyt9pzXKMY
    TolpA9uCDMXiIPwPXMspuh0TsRtAcrnB1S2deG9zOFFtS3cVgGEn6wXYRGCvJzdLz2uV
    hg8wW1leLmkjisl0y3Fll+j88AMUNOeAzOSToZ5o+x5vGEjVpEAqm3azDnl0a72UcFV4
    Dncb5udB0muG9hoptMttSPjG3wYIMJf2hTnpGFztG+E+u+Nf1D0HRfML2KjLfLnUQPPG
    uYZIc8LcBMgrhsuAJJdYvbEAj560n+eCCTqLIQaMJZ7tW2a36/t+iYvtkwh22IC7t2bw
    DcFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5ZM2Gmq8zvT1/ZvzuJODH1RqYsMulQJThH0EpUBZAWE=;
    b=OnCRY4Df1bX0LewwyP+Bu1lO0xaXe35osj+jZwcz4re4vjOuqI3WAcrT4i/OtHasX4
    RzdJjyLMwH7geqd916TkG3JVCdt/XVqo18zGviIblTfLPBM0ZIUNhYfxlAcQhpZLMhtc
    HT2C+SLF0RT4D6PJu8bbOqquDh0lWACH3EaS2IDAIooFF3rQx5JO/HhQAY8A0YY6evKW
    3WOXgx0hPcTeEJiNChwjnukuSAVjWf1YqYLiUkA6fKVNCa7dzE9pshAw9TMCjbLGWhWo
    M5d6QhpLRZhexE7eFaHMECNH8ZI0rfp7hrebYOGjYhcfB0gTvqW153TOuQM0QNbskGM1
    N29Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5ZM2Gmq8zvT1/ZvzuJODH1RqYsMulQJThH0EpUBZAWE=;
    b=b20z5aCCOgUUNIRHamTu8aESnDqbLmrv7ZpBApmkwlvorVY0y0FzTV4NmKBIAUcCWu
    JliZ3AW1XFPuv28jk0DQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTu50pjmwgQ1wz9b7T+Mhx2Sk00RyG5Tc="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0093Id2iLA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 20:39:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 4/5] mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block firmware download
Date: Thu,  3 Oct 2024 20:38:47 +0200
Message-Id: <20241003183848.58626-5-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003183848.58626-1-beanhuo@iokpp.de>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
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
 mmc.c     |  3 ++-
 mmc_ffu.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/mmc.c b/mmc.c
index 73b694d..2fdfdce 100644
--- a/mmc.c
+++ b/mmc.c
@@ -235,7 +235,8 @@ static struct Command commands[] = {
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
 		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
 		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
-		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
+		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
+		" -m 4: FFU mode 4 (CMD6+CMD24+CMD6 repeated), exits FFU mode after each cycle.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_ffu.c b/mmc_ffu.c
index 7193a67..d342c7b 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -55,6 +55,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 
+	} else if (ffu_mode == 4) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 
@@ -141,8 +146,10 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		return -EINVAL;
 	}
 
-	if (ffu_mode != 1) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == 2 || ffu_mode == 3) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
 		num_of_cmds = 2;
+	else if (ffu_mode == 4)
+		num_of_cmds = 3;
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -240,7 +247,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 3) {
+			if (ffu_mode > 4) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
@@ -254,6 +261,11 @@ int do_ffu(int nargs, char **argv)
 			abort();
 		}
 	}
+
+	if (ffu_mode ==4)
+		/* FFU mode 4 uses CMD24, the write is limited to single-block operations*/
+		default_chunk = 512;
+
 	fprintf(stderr, "eMMC Devie: %s, fw %s, FFU mode %d, chunk size: %d\n",
 							device, fw_img, ffu_mode, default_chunk);
 	dev_fd = open(device, O_RDWR);
-- 
2.34.1

