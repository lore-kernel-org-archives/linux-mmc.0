Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6984570F3
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819454; cv=none; b=WQGLkMTlISujruHTGMGvN/InM5+Z2rsuqIXSu1KmOi7mAgrMA+SU2OdabBwfRPwvj/M14xMqV+b5n6F3AgKQ+SJiFO0F0iPDpz/XhnTi3pWxs0el0PkzX9pNqKM46KTXL+Zc9Bhd+8f3roU4H/2/4w9n/misatBgKS/IHf6eb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819454; c=relaxed/simple;
	bh=JgtwgHsoPxaPZyUwybysqjgpmbaWm+LBt4Bgj7xGkHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+3McZtAS8CHcOQVqNPpt2c9ihSN55CLPyiG481aSv6bcIYQYzzFInPj1SpV1w9lwhuKgzyxbscQUO93i7wSFZ3XrbUF708Ocge28mlj4wsCebjdUnZkLfPAoESVIsdJOxipfa6umuyOwz2xxyhBbOJHvPRCTxshnmVy8VtjvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVuGZ32F; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVuGZ32F"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so702985f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819439; x=1785424239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyPjmnbe3atneEpHQ5RwJ2ZMp93lA/MEE/uir/p/tLk=;
        b=XVuGZ32FivvdYKf/zx+stihblficTOGBy4D2FDWgR2gQDy7RfRRwCGGReajMWiBRnx
         2Xm29AJsHa7z0iEjOInLit5GoXPR28Qm1aT3aC+tyNACgvQ0/rE3wWAlNamx8WCVvZs9
         R35hRog2Z8lcRS/c7QDt/SQGrtFO2s7kQZ488FwIRGF5mETcbpRig/WbZg58jxT7iuU7
         igglV/8lnz3O6zYe0LibBOay6ZVJiZ/8rHYMGJ6xtd3QEXh93SCEMTz4/w0cx/VWzIM5
         9SEyGHbYodl5eZEe26zrsVb+TMHJvU/Ax0g6HskLoyFQmaPj+XNt3JByHkupCESCPYU8
         zHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819439; x=1785424239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oyPjmnbe3atneEpHQ5RwJ2ZMp93lA/MEE/uir/p/tLk=;
        b=pzoe7O13L1ecobS8LJZ4yqXpe8rx8NlocZqtd2/BOFWIg3Xo3kIV4iEOk6Oj5yxBWA
         UrBuhfj0t0pVuiFjbBekdMKpAOWqdjqdLJ7q34O+9RP56WIwEhN3uxmGT6eY+YIn1Rdn
         1gBFuCkIhhqZj9ZHUsDYQiKmhhvH2mH7OthDhfL86nEVsH5vgTefBOtgbLzCfUd7TaW8
         8qOMe2cNsSVz5Njq8qLZLJRcqrvIB/ry2HqBNcRi5UB3+vqxxn6tQk9F08de75dxp25F
         VGjqEIk26lRDU5C28CGiBbOSq+n5H1591N2qos5jiUcVbj5ciWRZOQKB7O8FwgPiCim+
         wxIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHTNbvO3s6w2RoPN9DVNJE1epINZ8tO64QhKnj9gppm2kNqe2rmZLD1MqNIwrHv9mo6bbomsTejmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybddzufTbZ4v/e5MRpkC/lJKcW4UEcXkz3OdEJ9ZAibUEJkr8L
	OT1ej/LEoX1NDnWZu8WqzV+l5J/dKtfy7lIV3L1fIayk44GZGxjTXWwL
X-Gm-Gg: AR+sD112OC9hay/EuiGRhTAiV7VPP2S+HqS7GDpGpdxtlVzaBRMM1soH0T+AgWyHtZf
	WvluEaXyGZ1u+4gV+nsxXuRRu6tIUevMGQewCEn5t6m1ItpxfBEqyhWsFsLBpIJUDWPMBHUSaqz
	U20BrKl4bWkr5fxa/ufb28060NWil5XZv/oNZLkGZZ5GbPaDfOtE81hzcyxeuhd5LTgYerzVtjS
	TTh+Y+Xs4bswlnfKr+HVWJ96v/x863FzOadV2urVvy+zmHkKsmzYsbP3dQN75zsY/XetxkaD52u
	1kBSDvEuFNERKF3AzhQfw1YmwMnCOAMGiHNdV4IyMxKM0K7zVk0NUumfjThU650SUzVLCq84iu8
	LZs/WieGv1gF0t9dSEEOZ9gPc2AIJdwz6ynUqmixd2sosJzzQrCXfAZ11WyWXaN6KXavYeDDy2k
	oqjUxFePo5qODTsXCF5ADDFfQWfPY=
X-Received: by 2002:a05:6000:25c2:b0:47f:93a1:116a with SMTP id ffacd0b85a97d-47f93a1159bmr1753077f8f.17.1784819439385;
        Thu, 23 Jul 2026 08:10:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v22 13/13] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Thu, 23 Jul 2026 16:10:17 +0100
Message-ID: <20260723151024.318918-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L's HS400 enhanced strobe mode needs extra SCC register
programming beyond the standard HS400 path. Add a TMIO_MMC_HS400ES
flag (bit 17) for controllers that support it.

Add renesas_sdhi_hs400_enhanced_strobe(), registered as
host->ops.hs400_enhanced_strobe when the flag is set. On enable, it
clears DTSEL and TAPEN, programs TMPPORT3 and HWADJ2, sets the HS400
interface bit in SDIF_MODE, sets HS400EN2 in HS400MODE2, and sets
HS400EN plus the new HS400MODE1_ENHANCED_STROBE bit in TMPPORT2. On
disable, only the enhanced-strobe-related bits are cleared.

Also mask off HS400MODE1_ENHANCED_STROBE in
renesas_sdhi_reset_hs400_mode() when TMIO_MMC_HS400ES is set, for a
clean reset on mode exit.

Since a controller reset clears these SCC registers,
renesas_sdhi_reset() now re-invokes
renesas_sdhi_hs400_enhanced_strobe() after reset whenever
TMIO_MMC_HS400ES is set and the controller is currently in HS400
with enhanced strobe active, restoring the enhanced-strobe state
instead of losing it across a reset.

Enable TMIO_MMC_HS400ES in of_data_rzg3l to finalize RZ/G3L HS400
support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description.
 * Restored the patch after fixing inode corruption.
 * renesas_sdhi_reset() now restores data strobe register values
   after reset.
v20->v21:
 * Dropped the patch due to inode corruption during boot.
v19->v20:
 * SD_CLK_CTRL clk enable turned off before updating SCC_CKSEL_DTSEL
   register.
v18->v19:
 * Updated commit description.
 * HS400ES support is enabled based on of_data.
 * Fixed the space in HS400ES comment block.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 68 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 541321e43a13..1db5b3339508 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -337,7 +337,8 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -635,6 +636,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	u32 val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | host->pdata->osel_tmpout);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -644,10 +647,11 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	if (host->pdata->flags & TMIO_MMC_HS400ES)
+		val &= ~SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
-		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 host->pdata->osel_tmpout) &
-			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+		       val & sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
 		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
@@ -678,6 +682,53 @@ static void renesas_sdhi_scc_reset(struct tmio_mmc_host *host, struct renesas_sd
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 }
 
+static void renesas_sdhi_hs400_enhanced_strobe(struct mmc_host *mmc,
+					       struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+
+	if (!(host->pdata->flags & TMIO_MMC_HS400ES))
+		return;
+
+	if (ios->enhanced_strobe) {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
+			       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+			       ~SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
+
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT3, BIT(8) | BIT(9));
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
+		sd_ctrl_write16(host, CTL_SDIF_MODE, SDIF_MODE_HS400 |
+				sd_ctrl_read16(host, CTL_SDIF_MODE));
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
+		val |= SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+		       SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+	} else {
+		val &= ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+			 SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE);
+
+		sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
+				sd_ctrl_read16(host, CTL_SDIF_MODE));
+
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0);
+	}
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 /* only populated for TMIO_MMC_MIN_RCAR2 */
 static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 {
@@ -702,6 +753,13 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
+
+			/* Restore data strobe registers */
+			if ((host->pdata->flags & TMIO_MMC_HS400ES) &&
+			    host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+			    host->mmc->ios.enhanced_strobe)
+				renesas_sdhi_hs400_enhanced_strobe(host->mmc, &host->mmc->ios);
+
 			/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			if (priv->rdev)
@@ -1399,6 +1457,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
 		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
+		if (host->pdata->flags & TMIO_MMC_HS400ES)
+			host->ops.hs400_enhanced_strobe = renesas_sdhi_hs400_enhanced_strobe;
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 8cd3ced88b81..a47f17e9bf81 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -179,7 +179,7 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
 			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
-			  TMIO_MMC_HS400MODE2,
+			  TMIO_MMC_HS400MODE2 | TMIO_MMC_HS400ES,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 81a37d6baefc..758b29308955 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -62,6 +62,9 @@
 /* Some controllers have HS400MODE2 */
 #define TMIO_MMC_HS400MODE2		BIT(16)
 
+/* Some controllers have HS400ES */
+#define TMIO_MMC_HS400ES		BIT(17)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

