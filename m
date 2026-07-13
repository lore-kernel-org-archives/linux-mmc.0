Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83832350D7D
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965131; cv=none; b=o+kARniM/at1WadB+UOwUwTiHNzfNDmjpW9gcXCuxtiBK0oAUKz1w5Chxi1fAuVANSyhZCzXK70z2l1d+vZgXhvFigzaI5E+qQ0l74BB1ApaxATnBGgeBtw256ZxvH5xl6yNIKu7v89EQLUocOxCNN6/sKlsGuDXyH1DSkD5YZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965131; c=relaxed/simple;
	bh=f9e9HPrW7pHb6AYMxKN2MlBh66ucqSDBHuVtG7CpLsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drNv3NQXrDi1QFKDZdCvAd19jUnX3D4MJUKNY4IK0Cn45kU6RWHrXGzPoY+gvgnj6357zccdPMOo9OyNmLu0OEI1CcX7ngWjERc8G2KHZPr91e22FT1N1UVwxKG9FDJNGZvZQ1bC92NnREOO5NmTnZJ9fVQzPu3GdhoqpWXpLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8DeeU5O; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8DeeU5O"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475881b9a4bso89206f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965127; x=1784569927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+2CeqTBNfKqaWlWURz8uTEPGzp6HEOE0wrsSm7u0j0=;
        b=L8DeeU5Oal/JuaapMuKlMuDAejFKpCFARwDR+qPZPBXQlqpciPFyllTYQ1LrEag5kg
         x6MBTswn8iFXjylsnUiM/13IfzwCQ8LDxSoj2VdAL3HUxzlW5LQzkFI2NiVvx5EpOqOG
         vX5S+NifqY/OKTZA7Z3+TJkMdRD8Wey/ZHmJ7+hqLAx12IVtOuZuTLIn78bNPOqwIgnI
         UwpYDgd2BzbssxPURbGf7SoD5vk7KhUacR3If6j2b4xrZR76EkhKvkTpPkUMILc7uI2D
         lMnBZcUXQZlWgxAGv5J7E7JJ933SjULZ7F51FaagT0taQ8PtCcUf1W/NgBm2yOXFxN2a
         BYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965127; x=1784569927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+2CeqTBNfKqaWlWURz8uTEPGzp6HEOE0wrsSm7u0j0=;
        b=QVRwEpMNc+LPWA/GXeJzy4GHWnX3tVNEmDSTeCKfndAw24MK1xJX+PzWdoUo/9FC7S
         tEQYVZ679aMMF+vVg7iNDmv+x1QV5tZ/+1yajp4Z+GXxG+wlK+e53O2bA9xldcHHS9Td
         aySr/TW/S4tlqx1d64Nhv/UH+FijdQpUD2mBF6ZH21rjHhMieCu8/WgXmVTXh3GeAWoV
         IcpJwWnAYPwIruFVYdNvkki/0+wAZgyAuJfKwsb4ondB9SRcJ4wuaTQQaX/G3O4MkVF3
         DN2T5vesItC62WHdkiH8vU2KEaxy8AQIYk++RyirObJluE1Jab9LW9L6OCaCa+Qqd/cm
         p4tA==
X-Forwarded-Encrypted: i=1; AHgh+RoAIum1AQZJTBzp+qKHPNr/HGeMOKs4xRjkyLqznAqLhOMEz9Ys1gzLK9XRoKhzJolBops42SflG6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDn+b9lHAigYhFFujevk4gVnbP5C7QRrYwEC5Fkt1q01v5vhv0
	Ff8/kofTHmQpO1ah38xCC5ddmOa6/38ovK2GL+oandQ0UK5pJ2soFLV+qYlYMuzU
X-Gm-Gg: AfdE7cn9+4e9yJ8H3XDW4DaC6GDNpV3aI/DeqteV79Xgrmf88v5S+oWTbJbVBarbOXi
	iO12Q0PXlhOFwe+F9zEMQpsSB+/FOr+8DwIloDMZ8vgfB9Zbq39alAvtUG+FpU0SiJiZN8PS2bQ
	IDr2NafSIAaPROBk/J88916K/fnjwtc05ZIpOEEs5WXnaWbFM20zsEs78ikNLI2tKOITUP/z7O3
	mqS+66Ad4BYFBX9R7BKQs+/Kmpiq0LFE0lEQIIyPTjFtRTatWKjxOajHGZzqRdq8h3laGvoDf13
	HNVWcK86LcjbLvopPAsJzPlhRz4yd1ePT2jHKCcIswM3Jb8NT6GFZFjrZ7cINM63hUGHQVnzMeR
	V9n/mxMW7eyt6TDk8IQ5VGhfMxrtCwzBJ3gfMWih4jD3tN7j+cOyDNuNk1m2u32qCgR/RZoH6kA
	NxI0GESF6A3TvP1PuO2rf6ryO8TNi4UNmaaENgyw==
X-Received: by 2002:a05:6000:612:b0:47f:2c3a:83e2 with SMTP id ffacd0b85a97d-47f2dcd1a1amr10583994f8f.3.1783965126721;
        Mon, 13 Jul 2026 10:52:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:06 -0700 (PDT)
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
Subject: [PATCH v20 05/12] mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
Date: Mon, 13 Jul 2026 18:51:46 +0100
Message-ID: <20260713175159.138334-6-biju.das.jz@bp.renesas.com>
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

Some SoCs, starting with RZ/G2L, require a hardware adjustment delay to be
written to SCC_TMPPORT2 when switching signal voltage during tuning. The
register value differs by voltage: 0x1 for 1.8 V and 0x0 for 3.3 V.

Introduce TMIO_MMC_TUNING_DELAY flag (bit 13) in tmio.h to identify
controllers that need this behaviour. Add
renesas_sdhi_set_hw_adjustment_delay(), which writes the appropriate
value to SCC_TMPPORT2 when the flag is set, and call it from
renesas_sdhi_start_signal_voltage_switch() after the regulator is
configured. Additionally, reset SCC_TMPPORT2 to 0 at the start of
renesas_sdhi_execute_tuning() when the flag is set and tap_num is 8.

Introduce a dedicated of_data_rz_g2l descriptor carrying the new flag
alongside RZ/G2L-specific capabilities, and wire of_rzg2l_compatible
to it instead of the generic R-Car Gen3 descriptor.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v19->v20:
 * No change.
v18->v19:
 * No change.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 86 +++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 21 ++++-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 75 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d893a263e770..569009ff4c52 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -256,40 +256,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 		 TMIO_STAT_DAT0);
 }
 
-static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
-						    struct mmc_ios *ios)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct renesas_sdhi *priv = host_to_priv(host);
-	struct pinctrl_state *pin_state;
-	int ret;
-
-	switch (ios->signal_voltage) {
-	case MMC_SIGNAL_VOLTAGE_330:
-		pin_state = priv->pins_default;
-		break;
-	case MMC_SIGNAL_VOLTAGE_180:
-		pin_state = priv->pins_uhs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/*
-	 * If anything is missing, assume signal voltage is fixed at
-	 * 3.3V and succeed/fail accordingly.
-	 */
-	if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
-		return ios->signal_voltage ==
-			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
-
-	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
-	if (ret < 0)
-		return ret;
-
-	return pinctrl_select_state(priv->pinctrl, pin_state);
-}
-
 /* SCC registers */
 #define SH_MOBILE_SDHI_SCC_DTCNTL	0x000
 #define SH_MOBILE_SDHI_SCC_TAPSET	0x002
@@ -350,6 +316,55 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
+		return;
+
+	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+	else
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+}
+
+static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
+						    struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	struct pinctrl_state *pin_state;
+	int ret;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		pin_state = priv->pins_default;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		pin_state = priv->pins_uhs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * If anything is missing, assume signal voltage is fixed at
+	 * 3.3V and succeed/fail accordingly.
+	 */
+	if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
+		return ios->signal_voltage ==
+			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
+
+	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
+	if (ret < 0)
+		return ret;
+
+	renesas_sdhi_set_hw_adjustment_delay(host);
+
+	return pinctrl_select_state(priv->pinctrl, pin_state);
+}
+
 static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv;
@@ -709,6 +724,9 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!priv->tap_num)
 		return 0; /* Tuning is not supported */
 
+	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
 			"Too many taps, please update 'taps' in tmio_mmc_host!\n");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 2bf354331b2d..8476678d47a6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -142,6 +142,25 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
+static const struct renesas_sdhi_of_data of_data_rz_g2l = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rcar_gen3_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
+	/* DMAC can handle 32bit blk count but only 1 segment */
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
+	.max_segs	= 1,
+	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
+	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+};
+
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
 	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
 	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
@@ -263,7 +282,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
-	.of_data = &of_data_rcar_gen3,
+	.of_data = &of_data_rz_g2l,
 	.quirks = &sdhi_quirks_rzg2l,
 };
 
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 27ea21c00419..868a21842fa5 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -50,6 +50,9 @@
 /* Some controllers have a 64-bit wide data port register */
 #define TMIO_MMC_64BIT_DATA_PORT	BIT(12)
 
+/* Some controllers have tuning delay */
+#define TMIO_MMC_TUNING_DELAY		BIT(13)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

