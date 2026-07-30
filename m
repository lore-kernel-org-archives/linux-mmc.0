Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC5424656
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411141; cv=none; b=ecOoN1ORO7A/KoHq9ELkX0AKzqF+o6w2P03n7C+NWFkvR7h/ZNwB2hqSfjlLxUnJiYw15GrS4KDJh87gPvNp+mtI4Ahr6qJ3W6oosJrF0i7rULX1wY/DXZuPL3BUatJ+vbBQW0u1gyCk3awRntj4nKEFRoo8T7lTmoP01bXep8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411141; c=relaxed/simple;
	bh=54AeD9UVboIFR9RAvPnTQZgsWVXH9dvBpU6e2OuqAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq43ZENfp46Hame/4Lllm3ESw38VoiYGPpYFNlf34vQePhuXiwxbb62aN9N9ySfmw8v0R2XLMOt6cCRtNyymOTbUtFPUf0Y3WRerRZXZWPM6nZcQ8Wk0nGMtn7mPvRKJrB/XB1FdltOub8U5uuo7NvQPY7+gGcXIJc49/LILkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnOA5RSo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnOA5RSo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de008b020so430562f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411137; x=1786015937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdhL68ME/QxWT+L220rx1ETDJ/c+scGCOnZ8aJiBNBA=;
        b=lnOA5RSo04eCgADlk/6cMXMoGw7rTgLmU127gWdR3VwHVNazjWRm7kLUVfLZwucbNv
         RpJRQ0pmLm35lZanfuNOk1JU2EpkZY7ApRwcoJIFZXQ6djQNmcNGrnNWJ7R1Ae0ficeX
         kzizO0FziS6e79bJ813ckjuMVpMKw8szygiarSPJ8BQ92xzELg28X10JmawtjTOCws0H
         GPEzNSMe5JXiFovjhhZ2PbKLr85bUjuPjCchLKB1PddrB9QHToPfKJbAtqvvXc4lu7td
         OBy5d3vz387I0Hfu5EzcHIJyfxzqKDOXDS8XgV5ByFf64q2Oixro+DftM7J4pda9VQwR
         ygeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411137; x=1786015937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdhL68ME/QxWT+L220rx1ETDJ/c+scGCOnZ8aJiBNBA=;
        b=gMo1fLFxOIsnV7LU2NP6H7FvlWdR68WACcsiSZMEPi8R7DKmJAANfPlJOfOUqiaubz
         c90ERJ712Wsx4fJbIn4XYNM8iFGIM31E3Kv5YUQFRhJ3a9OGsUDz+B1dF6WKCMiTwI9X
         jvKcmOCcc2jNL+L77Yfl5m8dni+3OtPCTgv1yZyHoR/LToaNujvK18Km3IEqNJ59TVoJ
         kAgOiPgWMwwUHVQXvRdn16Dk5hIY/XQMG38uwHfyN7j0Tp5sFXKwKuVEtkaZNptQwS0/
         y+K8HlPr7oerXRo+i7CqJyrfmEKwRCw63of0N24rHt9aEE9Mtjer/LYlrPQqciN4y3Yk
         H7EA==
X-Forwarded-Encrypted: i=1; AHgh+RqWfdcNgHCy0FOnCn1RvRqQHnm18dTVtKQk7KWYZhM7aczgiH3vAoG7Gv4aqMaBWQJ5/XdIDK0H9xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRsHtU9olWbbc/BbWmBWhCGwwAtZR8YyJbPGA+pvV12/85unv
	SIjRlq8luzpsnRaleXUj9gSycqaB+U5iqogfKs+6rPNGSVeOQ7NXBQMQ
X-Gm-Gg: AR+sD13m6Ed3MAp4+rC8JAN/XIeyuBM5y0xcaE2ukBzJn3RdE9fIVXYqGJI9fSXDKPW
	tHdZ+gvRvoC7LdRvknwFcYgbmjmK56PtvZhg+T6q+60rmG04KnKR7a5u1cbqSTPUVapx6RiI4Bv
	6TNADZpW5EqPPlZOCn1h+/z3ANlU2qt/4/Le6b9n0vwbj05VFbwlf0BYzuuP2IJ8w73NhmlxAxV
	Thds1F1deYWAap4iY/zEb36z2WvhRFJVLj0lNUhp/Uq+FW5tiD6jUGa83tH8xmwN7tZJ6DXUkl/
	N8gMkYYacGTQBqKyHjKyy/CKFQTGBGZovWZDYPmwUFDGe6N4yR5JuORlbeaNS1aBJPBEG5pVL3/
	bxbnwxD9UWWeghisQO4TTBAEkbTV/JCrDqChU/ZVXRWddRW+u45hq/KNiE9liRlwbogWYG9A4tT
	kEjQPFTl2kZOuhAZLe1Qj6OXXZ19zNyv/S2QbGKJ5yo5P91op6quzEHei+U+IwR8e4BxapE/U1s
	pcsjMhS7pmonw==
X-Received: by 2002:a05:6000:250a:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-47fcbc24929mr40120f8f.0.1785411136461;
        Thu, 30 Jul 2026 04:32:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:16 -0700 (PDT)
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
Subject: [PATCH v23 14/14] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Thu, 30 Jul 2026 12:31:52 +0100
Message-ID: <20260730113200.36456-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * No change.
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
index b68567c93fef..13c24c42f0ec 100644
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
@@ -1409,6 +1467,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
index 88a3744f965a..ca1435441628 100644
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

