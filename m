Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFB471D0E
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819452; cv=none; b=GbYAe6RRfZZnhJaj8A3MkWT9ATK97TTwElR6uI420/BDMItjbKVf3qmwtrezj5k+bk2kA58yulDT3XUOcO9LCcc5M4BKij+V/NNEMZ8ePkM+hY7izNn8GwDIAaNn+QpZokJO0BgJSbK06ieyy1P/VXoThJGQ8pAlLEtaNO74QzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819452; c=relaxed/simple;
	bh=cK/G8S2azxBI4vAih/emWqAkXBCBhzTVKsGWfxd4pX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLEzX/CiesbO6nbV4/ngm7GhUf5YoD0ep2mlJAc4VKfs/AwdOhg4YwdQuWcEbI+9bIl4nhjiUpQEGuY0ywYSAhiEVeVvJcVyJ2hk6vYHBom2isBPNYelOtbUN2SSm2/PHN7qxPN2x3JCdEYX7EodmP3iJUe+vd6BzUpJLnZ3Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNVidpvK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNVidpvK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so5406775e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819433; x=1785424233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4P1ClV4sPills+Hp4c70chBzdHsizWxt+ax3LPmn9P8=;
        b=jNVidpvKBwdGRwC+GJn4XGNW9u4Gh/8m+2/B7EZ413oKn0RuCnENYVQHcULuFxUrS2
         +QaY+7sVPKA9dGJWREGbhAVC3aIaieSv5MJSGtS1qis0CNLj3m/03n2DANJj4wPuO9xN
         8URWehjMScrpoQGyC+I/rxO11Eztong9ZM5KLEBqG6jeVvw0iM95ZJ984vJbMeyEJ6ch
         f7bMQOZTS8GPT4eEsA+fyEn7fjKaY8HUxvYZEYscKdaaqAwSpbNMm2snPt8Pq1HBylmn
         ioLI3BOihweDmrEEm1txYPlvNoGwgctOcMvyn0UPck6SlMNh74zCqSEdfloHpq16j2eo
         zOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819433; x=1785424233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4P1ClV4sPills+Hp4c70chBzdHsizWxt+ax3LPmn9P8=;
        b=BbkU7fxa9y9tgfrtCZzgomWThL/eL2h485a3W0jah507swIaNj01PiDptA3PIMhKdd
         /we9dtgZdGkulDxMbNWE0zbLJmQAqDfHOw8GxWw8dcI1rTYIpS6mEMlvOCBA1qD/f+u7
         xZDc66WLodsfjEx29bU2A+vi7dWjn6uynWjWPn3qESepz6mhbb/F8aL4jodgzHSn9tIV
         FJ82V+quUSSPL99AiwLlalFCufH4IE+zbjjIRzU3ED79SPn7ghQiZklQ8dkOoqsoNUuZ
         4y6ZeHTnUZwbNUWO77h+luJTamZFQpk7K2MSosAH5ZrwtPPYgld5WRluAMcT194VBPH1
         xQkA==
X-Forwarded-Encrypted: i=1; AHgh+RoSGwqdesqcjL1/jj4JZEvWMZoUR/DRUYzkfnpPMH5dWnZtbTmro3aJKhVI/xQaMmFtD6LTZlMI8lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkekksMkSAgHvWD4TCXp8ZccB0lKSboaWjZVwnFdCGfzLCjU2
	+sWIVDXrtn14+egIrY5ioOd6uPts8yUbQFwC2TmrA7BTp8bOW7eM8b5r
X-Gm-Gg: AR+sD10Ph51n5GulrNezWvXM3R3igNUi1UKDW/eId25rKk67PttJC/S7tyiOMrtMxhx
	FHcGM6C8leRasYnPQ6i+gYxoOAZNRRY1VTzfC76X3cnWEVONsuGoybhI3VcuW5igHvEnNNbKJEP
	t6n3lRAmDaFtwDyyppdiHjjoXC5sfNfopHqjXmyAQKOosIz9btIhtMBAUahFoeJwUL6kNZRHCfZ
	MWSAytwbc36Y0A45CAa1AJy7DaE9j6CauVyAXkyiHytZD+4nFHnX1SmX+D0tCOadrOxCyaPbgb8
	qFoaxmW63H8KqkrE+K9mMP3Ubd4/KdJ93qNxm9bDvHRDu2GAwUZOV78bdwT5nu228kSbuOJq0cg
	VrIt1BJ2A71cWc60IvvM7nPPetb9vaEIQ4li3bfte9q0T3ByUG/7o/S0gw2wp/wEpoDXDY0fGRh
	SW3O6al0o+vzb7AZn9tXU4ROpsUvQ=
X-Received: by 2002:a05:600c:1d0d:b0:495:6b8a:5227 with SMTP id 5b1f17b1804b1-49573cfd6d1mr38925455e9.23.1784819432602;
        Thu, 23 Jul 2026 08:10:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:32 -0700 (PDT)
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
Subject: [PATCH v22 06/13] mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
Date: Thu, 23 Jul 2026 16:10:10 +0100
Message-ID: <20260723151024.318918-7-biju.das.jz@bp.renesas.com>
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

RZ/G2L and later SoCs need a hardware adjustment delay written to
SCC_TMPPORT2 on signal-voltage switch during tuning: 0x1 for 1.8V,
0x0 for 3.3V.

Add a TMIO_MMC_TUNING_DELAY flag and
renesas_sdhi_set_hw_adjustment_delay(), called from
renesas_sdhi_start_signal_voltage_switch() after the regulator is
set, and reset SCC_TMPPORT2 to 0 at the start of
renesas_sdhi_execute_tuning() when the flag is set and tap_num == 8.

Add a dedicated of_data_rz_g2l descriptor with this flag and switch
of_rzg2l_compatible to use it instead of the generic R-Car Gen3
descriptor.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description.
 * Added a renesas_sdhi_set_hw_adjustment_delay() call to
   renesas_sdhi_init_tuning().
v20->v21:
 * Added clk_div_mask to RZ/G2L of_data.
v19->v20:
 * No change.
v18->v19:
 * No change.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 88 ++++++++++++-------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 22 ++++-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 44d9f5da0b4b..9c6a3c5fbc8d 100644
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
@@ -377,6 +392,8 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	renesas_sdhi_set_hw_adjustment_delay(host);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -709,6 +726,9 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!priv->tap_num)
 		return 0; /* Tuning is not supported */
 
+	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
 			"Too many taps, please update 'taps' in tmio_mmc_host!\n");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9bf7aa9bd867..1799c6106102 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -145,6 +145,26 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.clk_div_mask	= GENMASK(7, 0),
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
+	.clk_div_mask	= GENMASK(7, 0),
+};
+
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
 	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
 	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
@@ -266,7 +286,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
-	.of_data = &of_data_rcar_gen3,
+	.of_data = &of_data_rz_g2l,
 	.quirks = &sdhi_quirks_rzg2l,
 };
 
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index f684f4087a8f..77d3dc91c828 100644
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

