Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196B47F764
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246242; cv=none; b=QuC7mHzkBsG26Q98naVXfVVBLMN0fb689GzkKDYG+bU4Pedewj+LEo8DJpjiw4KmJjtz0P+gR9QS8U2mOuTUKk6dnPW4VdXEP8Js4vPVRIuBjgBNTIZAECjbt3fNLp2uCYkUQp40BGMcFz6Dfgms45MaVMXhfhinj/NnbUWqJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246242; c=relaxed/simple;
	bh=sYyllewJ3cgttHo6UftyUPHYObPBe0SizxN8dLtDyOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPH4MaretIPjym/pmCriwCfOGGZLm5za77XxHnuZ1MXQ2QvLWQgvlWRAj6qUy1+UK6l6Z/50FnZrKR0UBMUp3cKybt0UbWM20MXXDpX+17Kj8gaIAiip8whXx/cvUgyxx93/dB94TzdUrBzeiuH7W4OEIvJBUosk32fP3rM359w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohkiDP9Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohkiDP9Y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998e0916faso375995e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246234; x=1787851034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSHbTPTM8Mxt+MBjuk5J1lN1jUlzEGCaJlBkk8fdSrE=;
        b=ohkiDP9Y7rM2L0tHoEQKGnCTWFCNkxOnZYK45sjBHD86gDlyXCw2QFIn9OXhM+o1bE
         o5KQowDZo8pI155rMJ65yaxpeJLKcta7/SN5OFajt2MDBYZnsKd4QLvrOuni60LxU8ZT
         r278KrvxUrX379y4vdER0mCbAHMLJ27no4IF5AvzahZ2/JCUnOpTu9xSsQIZkClRSsMU
         UkLA7dDg1HnTrxW4ukR4FqueZJbmaL7m6+o/UyDO5sNC2GqL6TnCOe8YmJ0klOdfaJlR
         VTbREYIzSgkC/IGUrjA31Cv0wxDNfN129UUAXrdLH7rlTqXwwLnAIK+uL4bKyJBBQtX6
         IOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246234; x=1787851034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HSHbTPTM8Mxt+MBjuk5J1lN1jUlzEGCaJlBkk8fdSrE=;
        b=g8eOkwk5aa78jN+hYNVidCxm584zl8UzSc/LZAdcxczWouaCt7KNdO6zgtw38I4cir
         sDqcR6MOiIjCRk8chKXrmOLC/CuzMV5t62jSxIzbrvpeHHGGBHITXBoD9KxneNLAv3Xy
         LGZ0aKZbECUmva6rTYz1iAWA0ZpXnbyjilYkNK5OHypuKkTs5Zf0cFP+oak2fcqj0O4a
         FRcdNKwqreho7sfZwXW0RWkvG37uXGzDLJ/2lfl7Eps9TjwJyFtQ8nrova9Vq3h4Ge6W
         lRDux+8S3uNpbkf5rP3Rm8W+UC5TrKHzMJPbK7ry20erovut/pPd/w2RhISqJwX41/66
         W3cw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7Kyx6TSTrtiJawbdCBj2RZidVIB+9pwlDLJ9g903f+5rJAvFbbAgJXdQqJyf+pTfmEaK3V2xhlfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypU4ToD+hxJeiZcmOwwfSPgvfpjDHhrGQeZUgp1WmAVwJ8sQEc
	WdOTxXseSKROD58W72kCyZElPiKQ1DIud2QCD91F1CIHe2ucxL3HKIpT
X-Gm-Gg: AR+sD12A7Iiggwa02TJblES8SoZLxHREntCYs72fpNK42z7PfhmHTkyrS6KC9uWXDHs
	ZA9Dou+QWaadgWVv5keE/N2K7UWQ8rW9/0TLdpUm694Jl69InfCra6Kp1UDYx0qnPOA7jRR0oND
	9OCMvpIfx+uEdFQN7B41KKbWAW7crKpxP1gcIir7PY8NjufyTWzjPpqBgwUGzU/zP8K4FhYHxDn
	B/GOEX5BZQd5A/tCGZKFmUaqYEtO8/qeXE7RE1YM7qziNrolqUHvjupIQ2dg3FThrbycwtNpbM2
	av3IHu58moAt/mPdtDbrrrfWbIFXmmovejcIbqSfW9vywPUFLXpPKwJkQSR0CSugVQNWz7zGP4U
	r7JKIXTmDzcajULSsrMdVkC6HhGhW9u/nbYJUvlQrVMf2FEAXuocP9DMeMstiBtOFsOUz3tvOpP
	+WmGAvO6jyjw2iGv6KKmAhOWBOLRNUN5XFbCFSUsW1+pUCWU1NMtBvWl6en4jqXD54u6fO
X-Received: by 2002:a05:600c:4fc5:b0:499:b000:b828 with SMTP id 5b1f17b1804b1-499b830db9fmr7670915e9.4.1787246234380;
        Thu, 20 Aug 2026 10:17:14 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:14 -0700 (PDT)
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
Subject: [PATCH v24 14/15] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Thu, 20 Aug 2026 18:16:44 +0100
Message-ID: <20260820171657.62815-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add HS400 support for the RZ/G3L SoC.

RZ/G3L needs a second HS400 enable register, SDm_SCC_HS400MODE2
(offset 0x020), alongside the existing TMPPORT2 path. Add a
TMIO_MMC_HS400MODE2 flag (bit 16) for controllers that need it.

renesas_sdhi_hs400_complete() now also sets HS400EN2 in HS400MODE2
when the flag is set, and renesas_sdhi_reset_hs400_mode() clears it
on exit. Add renesas_sdhi_set_tmpport() to mask off only the lower
16 bits (TMPOUT) of TMPPORT2 when writing it, preserving the upper
bits on controllers with HS400MODE2, instead of the previous
unconditional zero write.

RZ/G3L HS400 supports only one divider value, so
renesas_sdhi_set_clock() now forces the clock value to 0 before
masking when HS400MODE2 is set and the internal divider isn't
currently enabled, rejecting any other divider. This also completes
renesas_sdhi_is_internal_divider_enabled() from earlier in the
series, which now additionally checks that the current timing mode
is not MMC_TIMING_MMC_HS400 before reporting the internal divider as
enabled.

Enable TMIO_MMC_HS400MODE2 in of_data_rzg3l to complete RZ/G3L HS400
support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * Simplified renesas_sdhi_set_tmpport().
 * Replaced GENMASK(15, 0) with RZG3L_SDHI_SCC_HS400MODE1_TMPOUT.
v22->v23:
 * No change.
v21->v22:
 * Updated commit description
 * Added a renesas_sdhi_set_tmpport() helper to set delay values.
 * Added a check in renesas_sdhi_is_internal_divider_enabled() to
   return disabled status when in HS400 mode.
v20->v21:
 * Updated renesas_sdhi_set_clock() for RZ/G3L HS400 clock handling as
   it supports only single clk divider value and other values are
   prohibited.
 * Updated commit description.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 40 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 23332539ac65..5d9d3c7dedf9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -135,7 +135,8 @@ static bool renesas_sdhi_is_internal_divider_enabled(struct tmio_mmc_host *host)
 {
 	bool enable = false;
 
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS400)
 		enable = true;
 
 	return enable;
@@ -255,6 +256,14 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) &&
+	    !renesas_sdhi_is_internal_divider_enabled(host))
+		clk = 0;
+
 	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
@@ -312,6 +321,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -344,6 +354,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
+
+#define RZG3L_SDHI_SCC_HS400MODE1_TMPOUT		GENMASK(15, 0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -358,6 +371,18 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_tmpport(struct tmio_mmc_host *host, u32 tmpport)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = tmpport;
+
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		val |= sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2) &
+		       ~RZG3L_SDHI_SCC_HS400MODE1_TMPOUT;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -367,11 +392,11 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 		return;
 
 	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+		renesas_sdhi_set_tmpport(host, 0x0);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
 	} else {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		renesas_sdhi_set_tmpport(host, 0x1);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
 	}
@@ -480,6 +505,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -621,6 +650,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
@@ -779,7 +811,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return 0; /* Tuning is not supported */
 
 	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+		renesas_sdhi_set_tmpport(host, 0);
 
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index de570f7fc9c4..afe259c1566d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -178,7 +178,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
-			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
+			  TMIO_MMC_HS400MODE2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index fecc61e082de..88a3744f965a 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -59,6 +59,9 @@
 /* Some controllers have hw adjustment delay */
 #define TMIO_MMC_HWADJ			BIT(15)
 
+/* Some controllers have HS400MODE2 */
+#define TMIO_MMC_HS400MODE2		BIT(16)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

