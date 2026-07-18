Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EF38AC80
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381930; cv=none; b=or7+R91hgpOFbESiEMHtHERkz68Za4E3gYPQ/9dyDiptPQJ2QOvZ7ZIxvjfdg+WG6n12fXl4enlG2Fqz/p/DlEUPKIG2djiaNXQ/Pp2DHrt3BKwXRhLbqmBlF+reF/AZn/1vyZzdyMq/vIBdNsbBK4aMjURa3vTqubafrqCBRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381930; c=relaxed/simple;
	bh=8xGHb0Ae9W5W3t5QiuHlPIojsE3cZMBpqwRnF4f+cQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+oVm2QVg/RZWaNhKuBaEZKcIOUSyoDDxPyUEzsLQCO2ZWQooouJCbksHbF2MotcEeKK+Vf5NBsyUB5OMMjiO2XqVd+4DB1dIUVcNoiKlqzwTVY+vuvkllSxnuXxpRN7vw0vQ/lGEV2Xx7wV+/yeal+9Rvx1BxnZLPUNkLjDdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIxkkh3F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIxkkh3F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953ddae026so26984695e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381927; x=1784986727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6un3uXbdKdPm708xmFzIZl4dMYgPdArKzNLAin2azs=;
        b=jIxkkh3FLNSjcwtnag1RPaau6H2cBvdJQK2C9B1F7N7+DhblNabmFpst8bEzmPLPou
         oW7SXBcUMjDUvGtv7KIWVvP81MdLDaU8YgbmBzQ6pYj6Hs/dG29BT4emvWeSWY2NpHKj
         XmGEKgTVAAYWmTNJf3P21qrah9MmFeVK/sCEtxj9vB759npMl5jhra8fsVSw+Hc5Tv4b
         sxjz9urtTBYJfxnEI0VPEPA0KqN8K1B0sMJ7TUgozrFvj36qvdhddtcdOx3VH0X8yyWX
         YTzzsTB3pWr0/vlGhnAgE/jeFoT62VM1gTrInTAC3M+u6tYNZI81V/8QQTh/4+APfOZz
         Upgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381927; x=1784986727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6un3uXbdKdPm708xmFzIZl4dMYgPdArKzNLAin2azs=;
        b=lZmjQiurspyCNCrGvn8vYa+k+G4czE/Vj1CeO5o/MqhylZgg50uImoT92knVanlm46
         CwxYMyuOhWfoLMl4tyfX8lPc7z0Jk5rjdDfO12zQgxZn71HKGROnIHzmpc8kS03Mt0UO
         qvzFwrfkEchWqozMZ88YqQf7YJAbGvkNec1m+x5ooHmBlj2ePDUz3LgMdwarnmXLtygb
         FaroRgfxhdlMkk66nUODpV4ZFwrkTa9lFPAX2yAdGEJfnDjkF9i2C8w3cRhzlatOBpTw
         8MGrBamWDnrOeIvDYpc+c34N7jkfC61IieRYM8jQE9n6ESjOjgVtSb28lfo+RWQdwH7W
         48qQ==
X-Forwarded-Encrypted: i=1; AHgh+Roo/5JPL6GPeeS9EbMEKNGFzxR2gdK5rfTZZtMQ4QVj7/Vdie09tCUsy7p53eBq+WUPPdK1uktMDvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3eLgyeJfb/j0s5KYSdNb4WBqfaQgv59DWCTZ4CbA4Q6ZXKfw
	LRp41XGUj60AsjcxQobw7s8FSkh42zYuilpRlSI5fFiAHqW901KDZQHP
X-Gm-Gg: AfdE7cmAmkAJSrwRl+ZZD1W2pvfMqIEHTPBZ96vdalVQV9hA1VEbEUe5FTNub1ND447
	Xqj7ZH3QFV+pMY57qOnQhzqHNBYTjxXtFfKnENY3FukVGOpX1jMjRYSkbCt8CrPbuLTVhVOPcr7
	IrZlkR4J2xTV1y3zPU6o3QLXb7txMpqiosEjhz+vMH/NspaIxG/USxeoQ+hK8osM9MzrWw1LsKe
	yHGo8ayEcTeNAownqQRNfQy7q5wNMT4JgsoZ5voV7wMqmT+nf4x+o0gelCh0RBM2irbbY/8Q97+
	69nHvAjccxaz9yY4gQaEFwF80VTwY2zzyr+r2yIBJd1qNrkCUln2E8BBw4B4zXs4CEBQWetFoS+
	ZQ+KHBgyH1Rf9v67w2rOIKJojIV1hMWG8p70M5IbMdCps9yAe8S5ssfdubHfwsoDklo2giSiuWw
	wLGOMyiDuG8Ud7c6zkntvjHkBdBUT3RkzBd6KUoQ==
X-Received: by 2002:a7b:c383:0:b0:495:48d7:7eaf with SMTP id 5b1f17b1804b1-4954a40bbd3mr46953545e9.28.1784381926721;
        Sat, 18 Jul 2026 06:38:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:46 -0700 (PDT)
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
Subject: [PATCH v21 06/12] mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
Date: Sat, 18 Jul 2026 14:38:26 +0100
Message-ID: <20260718133838.152905-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
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
v20->v21:
 * Added clk_div_mask to RZ/G2L of_data.
v19->v20:
 * No change.
v18->v19:
 * No change.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 86 +++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 22 ++++-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 44d9f5da0b4b..9c0062865866 100644
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

