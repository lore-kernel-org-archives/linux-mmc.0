Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8213BCD23
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143784; cv=none; b=pFWKDNY0xmoAI8YuckrYHxqrfKIyVQ4vrxH2o1/yjcHXpuMhzK+9D27EQIcNqTq7vO+1md5tSV7uNzEkZyv6HFGKr3FKzX3MgkMBer9y27FVh+1C/vGk5NUKENdCGEFv2sNpClf1WGIl1KUlZkmTMWhDhvqnH0WlWBt89mzMOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143784; c=relaxed/simple;
	bh=rR0eO18H+UwpBEWOUhTvtMeIc6B2XzpNehOcxe6XyEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5JLdH4WfjFgnOdDsV6uhieVif6L3dRjDEUgE8+fWk2VCO8cQGP0ool5sOhUXUEgSCMq514u+sTFavspCL00IdsAS1qQpRD6rNro5/a3Ulm9cH31HZ/VOYCWiqyhjVzxGK1wjHvCO8O/d88OQBLerc+qOh1Pzue6bes8OF0n+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2P9cJrj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2P9cJrj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49222fb062bso48577865e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143780; x=1782748580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlxfqLn/UmsE4w5/VkqsShxX06pXIevDwx30SiuAtrg=;
        b=o2P9cJrj/4CcLQ8DUMnQFDkfaytgVr6YP7by/anaM9ijGTu3rysnGEkEtE6h5jWtDZ
         r/+B2U7jdWd7LE6V1R5ifrir9xJh7MJ7Kz7LJ6M+5pT9Py6AI0PehwShjcrI610FujaG
         C7AAgfYP6E/88ZSzlcAiKQyy80N4FkeLIbyXYnj3mFL7M3ypq94gbQdXj67DpTuPF8TP
         q7HoD+cqg6nt52AoINCJDc6nsFn2i0ce6iYWgyBUm5b//OZeYiLK3YHCWR/0Tt+zARHi
         2q4N5ga33pGvtJqpY4YQl+FMIiRhDbrpeolir8rq4sY7jmHDbJY3sNxqYgPXXWUrK0u0
         4+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143780; x=1782748580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlxfqLn/UmsE4w5/VkqsShxX06pXIevDwx30SiuAtrg=;
        b=gPNw03vlOiys1rCAGFkkxnMiyfdcxcjz56VxSX1St+Ghim0DcmpFsjb6p/Z7oWEBcV
         qxyMoe8XNm3Qit//SOJ0jzaKWGNi0SVcFOPl+9EuLNK+jzqyQuhGJc4CRKqL+D687pMg
         LVwomcXL/1TGR2B5g3aiVWlRtn3eGLDk+claqKUVtBlS7yowFE0jX0Bzb4w4GLwSgaa6
         dLrABqpG52dWIgzGPxhKTcJii/mJA0C57B0OfTcSw2ugz7mk2o8+vQvQxOqLPpwYYYnU
         JgxsauNseWnar85cOCdXWxC7aXUp2P65qgWLOrOUcnH5e+VUXOs7DrfjWrckujDWys+/
         5a9A==
X-Forwarded-Encrypted: i=1; AFNElJ80D4x5b0zQnIQZbKnUlHxUg00pfX/AmDpU1iol7ZrXInir5rEo5oT7w+88kajCfdUl3VB0BHuy4a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9/GDwoAH0+zYH+8WDNIQCtEb4QbJ4lKqcz7dLbDDF7iuimRO
	PbzbkY1Z+jxFuCI6ClqcVYPzm5DzMap94FNZ4jdTRmn1JFPr8BQ7LuT+
X-Gm-Gg: AfdE7cmDDlB4HuxPtzeY06bsBQp3yHOdX7c58uxJu5UTH8lXhRRIxBDIBhzIO555cXi
	I3/L4XTXobsT1OoSbFcsyHAhlmdMNeouV+or7OfWqNDfRABORHSzZx/DagQc4W0QAHE07LLS/pi
	I8Cm0RvZjsof1iC4HcgBINSnd8jYrEwHV8ZQpBPReI7bEfz1KV8lZiZxdhQ3PN29JGXQsHpc/L6
	AoLaoGZ8C/kbdamW3q/GbXY0r/sy7vFQyzkoxCojDrcdEOty8J/ibVOyfWb41dYoO0x90DOFrNG
	6362kjTu+h1U8DDZlqt1MalF35v/8pbc6wKs6fCge4sriUKOG13FQlhtFJ4iJByNuceNLkJ+HzI
	f4BS2U9QN5vBcwbEccA02JkAA53TIAaeb8uRq6M/JJSI/Qho2iEnFZfvDpLO9mhVkZ3RZLSbCST
	uCRNnbpokoKNqmlhV8R3mrEhpdofdCwoWhvA4lSQ==
X-Received: by 2002:a05:600d:4448:20b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-49240ea7f99mr205088725e9.31.1782143780200;
        Mon, 22 Jun 2026 08:56:20 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:19 -0700 (PDT)
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
Subject: [PATCH v18 05/12] mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
Date: Mon, 22 Jun 2026 16:55:56 +0100
Message-ID: <20260622155610.184271-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
References: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
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
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 86 +++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 21 ++++-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 75 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7e48e78cbfab..e9767aa83b00 100644
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
index c91b910488da..93219706a4d6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -143,6 +143,25 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
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
@@ -264,7 +283,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
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

