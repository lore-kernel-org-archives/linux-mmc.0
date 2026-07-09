Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529F3C37A5
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625367; cv=none; b=cIXr3VhiWY2zC7xC0RWf8EsdhxMXT3injCoINrYyFJqe/4kH4Z/fRCG0G7ri2HDqThtcVYygi41muQRl85u7wvTK0QIZHhLlXgJ1NJIl8BulumdR1eN48nsrQUhMwG6TdU1nhRzxjNppr6IODiPxvqKUw904EW5V5HW7c2keUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625367; c=relaxed/simple;
	bh=Ihb5W19sun5uiPMAinUkhbjn3gtqVOtHoLhaoMkTz1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDa1POp28YZeHtZcxkMGPYYZ9QDRJWV7YQ8MgvU4itw4k9qnwGRItuKMpbn691uHDjwzTl0fhPw3evOt7JgAvq8vfMxyRlDZpY5KY87yRd3vk1kuD7/nz4UKxYGAFtfAZxNSlbNCyGyULk4YuUf3ine0RMgZfNtUmOTqi5xqO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwMB9yA8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwMB9yA8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c19bad03so1551755e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625363; x=1784230163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYMmBOr04je2K7SoxYSLr24DjFxtTeS8EmjTSbecB4Q=;
        b=BwMB9yA8oHW6nM85w9+XuYfOXQWxUtNB9e2AkYUayZW32zujgoihwQrdXDoQ+bSvsv
         NGdt9h58wUi/1WSY7+T4C63BZvnPb1phoAGsezZeofCpIe6SHRipXxGh4IAAILdE/iTK
         CnKCl36NyvpPsnJuHir7EvXSfnDEEnHO4glYl9MHi7mtm81SpCk5GtTK3qvynKEhoA3r
         9L5mK3Q8jhZbasF+mDKFkKlhQNxyySgnDnt+E6SohMNWRwtT2f3ZXMcwGrP/c0MIcj9W
         SkwPDhNuOGo/69EuyuSsHo6iS7jF9s0x5clprx0wKmPyr0UTeJBEJjRvJr7YswobcZOL
         IiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625363; x=1784230163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYMmBOr04je2K7SoxYSLr24DjFxtTeS8EmjTSbecB4Q=;
        b=WXVakftFujWNLwZFyCRtI82WtbTJoI0AfhkoTk95FWz6RpIVgK7aHdpPBMHqTecQTr
         YiYuqQkk33ASzV48QkyDt0Nc8e2BnqQapb6DJRZ8yNce3oMVBqP9+RsYlDNSgFApCEnb
         dSvuBAeuYvHT6T0UeiE9DbNtr7+fq8Pu/cmfQioeZzrB15PvbluFH7fDaTdrrmsZCXz2
         XQq+BP9LyXL4Pe6FqxQ+rAHnx8Gt/Ei0YxHb8hqI5Sv2mTwiLQp2658VgXAZD9yhiPnA
         7WjtRDPn/A+/hFmobUhArgtbgMH/g/p3MIU9cxXN3obVlWOCdNhVho+K3hrMkqGFO4MN
         E9IQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpp6sFPy/UqVInis59xI261og+Ehbor0aV/SMcQPJ+W7+nlVUGO2FvyksTbeRZOwMgOzADUNyGndXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqsbzJaQdeLR+7x3abTLj9YGhnGjjmctpNoscs7oS+fORqtar
	kNzR35zOS1HQPPVvPh9op4LVrb1y8SbPFMGRNrZ08PtPJrT1BiZ3NLoHg/tOdD9H
X-Gm-Gg: AfdE7clJQqnSmqXejtXzNHpZ960oyCjiHsIM9q6R4ijVq19qwsrnX7f6ctluobEPglS
	qJUHTQeQRsBKnI7Cm2TPqww5qnQ51eYjBZcs1ljCVEogstYJeonGsO6JXMdYwuMfK3yBCc7QQkQ
	A/71lVG9+HSfRdGFEgoLjprCEIUJOz5D9zN8NiifMLMn6l52M77WITE8z7eeWZCkx19dh+3b7bB
	VDhFxUDOfCA2zTh87Y5vUbcrffozhAEjPAu6ikWzn9o+0e7boMbz8B6BiVI6RH0/0JrFR972ols
	qUquyGRhW/ttqhWezvGMoimDhrc4spaIwZ7iWvri+M0t4hFCyuV6Y1q1IsV8drha3C3qp67Yb2A
	sCt3o/DcPyKwLE/vU9IW4TQPJAfMkKwHhg/OXvSg0IJthoO5wcpUBTp0ct1Yq5ZOGgTDTbX4G3n
	8IIdrdKXQK4SNLfu72dgT/
X-Received: by 2002:a05:600d:844e:10b0:492:5551:19c6 with SMTP id 5b1f17b1804b1-493f2b009b8mr3916505e9.7.1783625363016;
        Thu, 09 Jul 2026 12:29:23 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:21 -0700 (PDT)
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
Subject: [PATCH v19 05/12] mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
Date: Thu,  9 Jul 2026 20:29:02 +0100
Message-ID: <20260709192916.630794-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
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
index 5c478995d660..832a7a7be725 100644
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

