Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E034D90D
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965129; cv=none; b=UM70tedoSQbM8TzAXxxdEFXRUR5V4+iIZL5UIPJqOzFjZFF1Ds7SquhO4seWYSyFpeyHjMn59nVj2DI0BCktIWIzY55ZmeRExyEewuTur0Dkd3qjBEsFDYP1Q3PeG9EL0GUOpriaDb27tcKzNvqUMAn0b0UqQDucpr/9X+Q4sGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965129; c=relaxed/simple;
	bh=IgEed8k9ronp3Klw3j7YOg3QES44u75S/E47qAgzqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6DvzgosYx613VRMh4rTxbn1NsPROfg2TN3D96TKqDDY+mIajOq8gQSMvUJHSdN3WGnIVjcD1tS36TMdizX1IINJWlE069G5HgXp7j4/QksgoAIs82X2OA3EjGZ+LcU/CkBEeNrg8wUr7VBpytlor/QfB1fKaIa/ES58/q1c7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwx9Yltr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwx9Yltr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47db714766aso96837f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965125; x=1784569925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qY102a+IXjvnQY14+rM/cHb2EnSKmNDamCsdOqjRw5I=;
        b=Kwx9YltrHwTm1Q9F4IDzWTUXwztJepbMH9ICTSpEk0RD9j53IHB4lNJkCES+kwKre9
         Isc5z9/SrRDtXX7eLqzYT0B1b6nM/HFm9vrY/gowYpkglahbE+ORL+tspjZCiaXi8MUH
         7shul6PWDSZUvIzDeR8pfxflllY6bjxfdBtY8imRdmL6lidMh6bxumRdsmLe/QYK34kU
         XmXM1b5vtXwuT2BbBPmFesEdtyKssk9Kp14xJb8bk2SnYNbkhBLQ61fiPeYBHrnevU8l
         PD21BVtvxfBAOpZSjzPDq8JsBtAAd92HFEMh1W37n2EUKe3gWFmTgIiJDX+0aBYsWJbb
         U+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965125; x=1784569925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qY102a+IXjvnQY14+rM/cHb2EnSKmNDamCsdOqjRw5I=;
        b=MLirJUYF+RNATd7YLnyETLJGdY41YptoZBiia+uxrN1lJdNbnYwaSXu9JrAlocaLYm
         rzGVBmBCghHxoHpHdcqjebjXMhHjcF9434yV0OoyyQ301mvMDjf6zejEyEONvtDUgMgl
         7TPhzQVPNPxahBLnSirVYzn/ZgAQvz3PbVLAGNUIsexvgdBlbNC8RWYLSbIFwg3QARzx
         7sMyyvnMRH69xhUrrLff9VfU/sG/CdAznEEpBblkz+0lT/GPa1ga8izmhsnaCToMv8Dx
         5f03e6HoUoW1BTk6EYmSngRMq7Xz/qRktwa0tJ0T7XFjRyClpaq0BBtQ+w0naUR36E2j
         +Nkw==
X-Forwarded-Encrypted: i=1; AHgh+RrK3PSZmO5nlUT9a+Sn1pAcKHkg+eqZUaCSj9sT6yHdcyKm3RiIDCqXGnDnp7RLz9RGmb+qheMk3ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuxrgnklFpa2s+GAy24Y8ON9zoT7G4M4YW9p3CfxR2rGtiX9W
	QYIkk+S7EST5ORxns/rlg3mzheAZdfID5pEgWeCXxn9+kN5LXQ3JcqE4
X-Gm-Gg: AfdE7ckwuCnzmJQu37l89523DkReRaYvYmKRnwLZ/hfBT2ub5tzrQyfUQoIxgBcFHrn
	xTIvw255haGE6AeaBhkDrE20cC4mmGtC0C7vRdxECE+FI5OoHg0a90NuOqMYej4EjthkeiXIwKa
	s7fD+KzdmQhN7WYVatHYmpeGuQJqBC/qIKCg+JKaVb2G2NHCQiFr1YGrKsYmNESxRo+/1/+MKZr
	+b/ExZplVVq6abSE0WvuiVMQlOBf/muPHrkPNdPImvlX03Xh2GVZQ2hK1CN5Zum2axZG+EQzDp+
	r4CZl8XoMU6yGIFI6klH95OAGSCUhKO4fARPhfsGq2gn7pQidhSZOfUCP8PF96OsVKnPzVA6dsf
	oHokrDVK/wHbpwwA7g4NZleiD9hUL6jWFcFtsXUv3gfuGrzJ3awzTap7v9F4k4aILPqxnM1hij6
	D8Ed6WYFAWKWksgBkC8Bu3arZxHDdRNHDkfd6YvFDrcYxL8z51
X-Received: by 2002:a05:6000:26c7:b0:47d:edc7:4c44 with SMTP id ffacd0b85a97d-47f2dcc2fdfmr10701682f8f.19.1783965125196;
        Mon, 13 Jul 2026 10:52:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:04 -0700 (PDT)
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
Subject: [PATCH v20 03/12] mmc: renesas_sdhi: Add clk_mask field to support flexible clock divider widths
Date: Mon, 13 Jul 2026 18:51:44 +0100
Message-ID: <20260713175159.138334-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The clock divider on the RZ/G3L SoC features an 11-bit width,
requiring a wider clock mask (0x200000200) in renesas_sdhi_set_clock()
than the historically hardcoded 32-bit value (0x80000080).

To accommodate SoC variants with wider clock divider masks, expand
the internal clock control variables (clk and clock) from u32 to
u64. Introduce a clk_mask field to both struct renesas_sdhi_of_data
and struct tmio_mmc_data to allow platform configuration data to
supply SoC-specific mask properties.

Update renesas_sdhi_set_clock() to read the dynamic mask from
platform data. During the probe phase, assign a default mask
fallback of SDHI_CLK_MASK_DEFAULT (0x80000080) if no specific mask
is specified, ensuring backward compatibility with existing
hardware variants.

Finally, explicitly populate clk_mask with the default value across
all current internal and system DMAC configuration profiles, in
preparation for the upcoming RZ/G3L clock customization.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v19->v20:
 * Replaced the check mmd->clk_mask with mmc_data->clk_mask and moved
   the code after assignment of variable mmd, this ensures assigning
   the default values for non-DT platforms and DT platforms with no
   device data.
v18->v19:
 * Fixed the clk_mask for non-DT platforms.
v18:
 * New patch dropping struct renesas_sdhi_hw_info instead using
   renesas_sdhi_of_data and tmio_mmc_data.
---
 drivers/mmc/host/renesas_sdhi.h               | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 8 ++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 4 ++++
 include/linux/platform_data/tmio.h            | 1 +
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 09bf9b24a8c3..f926a36f213c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -22,6 +22,7 @@ struct renesas_sdhi_scc {
 };
 
 #define SDHI_FLAG_NEED_CLKH_FALLBACK	BIT(0)
+#define SDHI_CLK_MASK_DEFAULT		0x80000080
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
@@ -37,6 +38,7 @@ struct renesas_sdhi_of_data {
 	unsigned int max_blk_count;
 	unsigned short max_segs;
 	unsigned long sdhi_flags;
+	u64 clk_mask;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f9ec78d699f4..604d886e483c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -194,7 +194,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
 	unsigned int clk_margin;
-	u32 clk = 0, clock;
+	u64 clk = 0, clock;
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -213,7 +213,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	 * provided for actual_clock in renesas_sdhi_clk_update().
 	 */
 	clk_margin = new_clock >> 10;
-	for (clk = 0x80000080; new_clock + clk_margin >= (clock << 1); clk >>= 1)
+	for (clk = host->pdata->clk_mask; new_clock + clk_margin >= (clock << 1); clk >>= 1)
 		clock <<= 1;
 
 	/* 1/1 clock is option */
@@ -1136,6 +1136,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
 		mmc_data->max_blk_count = of_data->max_blk_count;
 		mmc_data->max_segs = of_data->max_segs;
+		mmc_data->clk_mask = of_data->clk_mask;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
@@ -1178,6 +1179,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (mmd)
 		*mmc_data = *mmd;
 
+	if (!mmc_data->clk_mask)
+		mmc_data->clk_mask = SDHI_CLK_MASK_DEFAULT;
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b3f4a5f8dec0..c6db0418de15 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -101,6 +101,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 	/* DMAC can handle 32bit blk count but only 1 segment */
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
@@ -118,6 +119,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -134,6 +136,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	/* DMAC can handle 32bit blk count but only 1 segment */
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 7ae488e5c1e0..fcd2edfa69db 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -28,6 +28,7 @@
 
 static const struct renesas_sdhi_of_data of_default_cfg = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -36,6 +37,7 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 	.tmio_ocr_mask	= MMC_VDD_32_33,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_WAIT_WHILE_BUSY,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
@@ -43,6 +45,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 /* Definitions for sampling clocks */
@@ -70,6 +73,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.taps		= rcar_gen2_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 426291713b83..76056d49f5e0 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -61,5 +61,6 @@ struct tmio_mmc_data {
 	dma_addr_t			dma_rx_offset;
 	unsigned int			max_blk_count;
 	unsigned short			max_segs;
+	u64				clk_mask;
 };
 #endif
-- 
2.43.0

