Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B31AAE2B
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980759; cv=pass; b=OGjl5wDaJ+1ucuNjC1JK1Sl3WHG1gawlI5UT+yOyfREdSD6LozcuNNoomFdpLZTzve1u04ImMEtQyLQa0e6RQ4AJIRau7Bf+N9IQ2w2rvDRNNFJO7NYXPFMTFaXTHQhIWfPYTbLeXkAA0rdbxIhUQF65i2POVztvFRox8eV/TUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980759; c=relaxed/simple;
	bh=jkUGFiyp0lT5+oeJhC4TL/a/N6HWGMi5QAq4LYnDLcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgQ7h5bG0PUoEg8J7fIlO1M8yL+6BNTN9E/nmMZ9B+f77pwszPiioRg/ZKvxYq9P1/zspBFt9ZWYjGUowg9D8rCTH+XTRfbNn3P0dMFRTTyCGC/hOD04ijHf8yrVsHPCpn99V1V4oFcEDZp8TuNqskQDSp5ARo7PjX23MfenBY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Otex/ao5; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=7wnKUb8U; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Otex/ao5";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="7wnKUb8U"
ARC-Seal: i=1; a=rsa-sha256; t=1727980742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oFrDoNg+GvzOx0/gbTKy0h64jN9p3+SdduY/RdH2Ud36PQoq2ZcGm3fgfenDfoBvTm
    reaFsgzuXhuIB+Pz6bmHj4/xHTU1Zp/5D4NKUGK4Y3vkoEhMUEPTbcHb0Xv4+231ENHY
    6x5C6eDJKG3wGsKCuYJ9FW+tIyGt178ugoQbXmwDMHfs5qu65+KQqZ9Lsglqrg6v3luC
    T5o892lJzoVTKm6X7QnqkYY0y8keLBSOHbNXSWOgH9m9F03C7So0qLmuiXF9TtMh9210
    N8Mgk6hRp9UY5ODOmjHcbaD6oQGx86Y1qOwVSAxFneAW3I34x9Nf6HjibsjUFIfbPICY
    KfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MkXoWQbAmwkIjmFoWl6Vgcn8P8Wm9hIrxAPyXeoXEgc=;
    b=nYK289YymuqQKDcR5hbU2JJ8ioofRupS5iPTHnUSm/oYlxd+D7o0NbChu5t0jxdOh6
    GczoeeWC4nrZpThq5Lp/uGTLTqxjg6syzM2aElgYJ3xyf4sBq7VG8HszVR8DpdS0ZJDW
    xohO9HXjiYITTkVYjqDoXvY6bSKt5y50mnrCZsyDW96avqytp1+naykMD2dQAxsEkHdU
    RUFFTNHp/u/0QVn0dMCpzTPukJJ+aJhVVAGifazUG98ZPnBj4wATGZoCfBYXISeNJAG0
    xRkr1lyiSpVdNzKrMJ9FSsd6a55rrx06e11ZbGw19154ySLNiWXELG6eaq875lR5qfRF
    6jlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MkXoWQbAmwkIjmFoWl6Vgcn8P8Wm9hIrxAPyXeoXEgc=;
    b=Otex/ao53Mj5IkKGfCwXtT4fIY0qFCdWFf3Rw1w8Hkj89xV/gFqAD57RnkKtSuqo9M
    wOGpSH4SfW4VvhKjbFozKcQi+vAcFqGk8e1G8agZMwGQNIxdzPvyT8VVa9ntfiA6Th9G
    oV/3QChLH8OCpVEUTXDwg93WqbKBH7/s66ita9ihmrTp/dTn1R+ciWOr4GBYundEdd7X
    HTrusR5pI+dmR1nmDQZcAggAkE839Tzi9nBKHfUJhgBbCb5unIpGx6c0UeN5gH/ctH6E
    o4Z79HH3tCtLPV5IXMd8KHcJ2ke32NN6Fn4913C3PAX8L4+Eez3sruPzhftwo7GY+6Du
    iX8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=MkXoWQbAmwkIjmFoWl6Vgcn8P8Wm9hIrxAPyXeoXEgc=;
    b=7wnKUb8Ujq9+iKb5OZoy4ZaZOBn4jpAuKIuTrycn9Ow8O/lqR6qpCwN4AyjGkj0qAx
    VG37kafezqM6BbsnF3CA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTu50pjmwgQ1wz9b7T+Mhx2Sk00RyG5Tc="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0093Id2iL9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 20:39:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 3/5] mmc-utils: Add new FFU mode using CMD25+CMD12 for Open-ended write download FW
Date: Thu,  3 Oct 2024 20:38:46 +0200
Message-Id: <20241003183848.58626-4-beanhuo@iokpp.de>
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

Introduced a new FFU mode leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c     | 3 ++-
 mmc.h     | 1 +
 mmc_ffu.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/mmc.c b/mmc.c
index 0a22f2e..73b694d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -234,7 +234,8 @@ static struct Command commands[] = {
 		"should be in decimal bytes and sector aligned.\n"
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
 		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
-		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
+		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
+		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc.h b/mmc.h
index 6f1bf3e..78cc140 100644
--- a/mmc.h
+++ b/mmc.h
@@ -27,6 +27,7 @@
 #define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
+#define MMC_STOP_TRANSMISSION	12	/* ac				R1b */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
diff --git a/mmc_ffu.c b/mmc_ffu.c
index 52889bd..7193a67 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -48,6 +48,13 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	} else if (ffu_mode == 3) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		multi_cmd->cmds[0].flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+
 	}
 }
 
@@ -233,7 +240,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 2) {
+			if (ffu_mode > 3) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
-- 
2.34.1

