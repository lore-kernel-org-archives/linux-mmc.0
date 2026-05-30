Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C233F8C2
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157321; cv=none; b=XSvW9RMzO2EJlILKO7wK4A7X8veWsmQjHRK1vA/Ti3/Y3UgJeS+SdApOk9O3Zo+JHPY3M8262vOmTa1hhRSCrnkTiuS3ALk7Li37CV8IOUpZmpW7dhIz51q6Uq5hjOApzTvj8cI+b3bKiZYg+8QSGw9dchehIj3/ajKpSnVZyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157321; c=relaxed/simple;
	bh=7h8rrU9JQer3x8kcFtaVys+3g/HtLuERBfs5fKHvZn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG1xK400H3on05ljrdI45PhkOUxcSFEJWe2ZYDG/sQQUtmfTjFWLpSlFcaVR9+wolTzvgtemQwaJxaoPa+IPfAkQni44+rn5UqmXD84kY6v36wxYy2IkGC55+vzvDhj+iVuOV1uG1Ar0zJXxfx+zb1bIv8JXutUv49trnrUXok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4AXTKkM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4AXTKkM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef4223be7so888117f8f.2
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157316; x=1780762116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKSuDJR51XALEnHYzvRWkLQZfNsX2G6ozu9W/h5yoWE=;
        b=c4AXTKkMOv2q9LPnRaF0j7t9flQiPmYQE/hio0UpiYS930cggQcEbdYX7NE8YLKxNr
         cqBLU3kaWlLZZ/2NieYRTjPijuqXsnWwli2mxhptc+7zWRUwTkOSfkUovU675qUoA3fL
         BjsIhhboph9rnUptcSQkVh4PSuYtdaZ/4m3F0oBKFm/17k71LOmPK80MzCA6rwi59iJf
         FANNO4hC+KTKXTYHbF0sJgkCU7L4GaXtyPIS+c2DHBKZObgyKXM42iGQUar9cHqB+bnh
         IzMDYQ00o7yWabqJYHKotg+xu0qZmQidvON8O0sPDgMe8c/1uXWVNCnO46xBAA5CBIHC
         WNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157316; x=1780762116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKSuDJR51XALEnHYzvRWkLQZfNsX2G6ozu9W/h5yoWE=;
        b=NqxBzo6DHgGdUNdIzMvgIxqiw9cSTG72l51KZlqfihxOJhD5iNNqKU5xXSfGqEGhmQ
         IvWwzTB/imSDRR/j3i/rSxLTKcE+/jGgAqx55XOt6C8kGB1clmn+vAIVLu3tEnK0E4PR
         BpvjoZ25zxboeVuohtVTJE6m6PecooP40+8O5e+W6Al2VysGPrhggg/CXFHErK+67Yeu
         kqspKAPd+NM8EccRsjsuWCf9Tn9fAC+gAwivQvK4AzeO3RjWwkTuN7auA91XZy0VzgL0
         9uJVGt2eA3BfRdV66Ps+YPzi+9jXrngyoLoCRWN8hxbHyEm1rI7JRzr8Ir2x5E4WnFpb
         uZYA==
X-Forwarded-Encrypted: i=1; AFNElJ86ePQpI5DBqp+8D5/Dd8UDmI7zMzBip32J8j01yzAMQ/X62a3RqSwDWnwQnjWrA+jT9p0ytzB5Fbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5b4wy2xxBdVNWS0+EEKnjKPzPHdMCelePR5aot5RydcVn0i3
	68/ErUhDbaGDfpmiIoUE0+6HlmgG/rSDYy2qimNJ3mOEUElecEwhoLmD
X-Gm-Gg: Acq92OGwczSLOZ+qDdmGZSbXbQQGUBUy1fOYhdPSZaf2DH/2friWmAM8hJUj2arr0WV
	gCmBi7YT6mrb+AmN1F9do/aDy1N6LfiVV9HfIxHUZWmRTgc986Oprg54drZKAsuanw0+/55TAXO
	nWmv9ABhT01jK1APFxjkdUqkZ6H3pFRAo4Uj0KP5mdG6QlO2oGFzfyV0ZIcYIJa73isyilHBibz
	f17RvQ4lXTfCW4LD0xuVnGOhbVb7frJ7niTKq2nSPBsBSHcsl8k49N+gn9C6e6MzrL66vB25xsh
	tydtvx7VJNLyvmtCvdvy2Ap1dvOsxxfeGC2jij6GTBdsanW7EBm718fU67RIa4NjEKMeZVXHDAf
	vYcG4MDh41c0A6GSptROu5MBTX4/bPh7r0jPHJ6prKffw5ck++3bsBU7fwvTSWw0+f7v314mst/
	XUMix0iPhDfD6swZrkxZZFBhiH3kMZx4PtZDTj0ZTU+DcZv+vZRqA1ET3wbA8=
X-Received: by 2002:a05:6000:1a54:b0:454:a12c:6cdb with SMTP id ffacd0b85a97d-45ef6aea780mr6273419f8f.2.1780157316062;
        Sat, 30 May 2026 09:08:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:35 -0700 (PDT)
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
Subject: [PATCH 08/17] mmc: renesas_sdhi: Add tuning_delay hw_info flag
Date: Sat, 30 May 2026 17:08:02 +0100
Message-ID: <20260530160823.130907-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/G2L hardware manual, the TMPOUT bit field in the SCC_TMPPORT
register needs to be set to 0 when transferring at 3.3V, and to 1 when
transferring at 1.8V.

Add a tuning_delay bitfield to renesas_sdhi_hw_info to indicate hardware
that requires an adjustment when the signal voltage changes.

Add sdhi_hw_info_rzg2l with tuning_delay = 1 and assign it to
of_rzg2l_compatible, enabling the adjustment for RZ/G2L. All other
platforms retain sdhi_hw_info_generic with tuning_delay = 0 and
are unaffected.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 83 +++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 +-
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a42934e6d49d..a3c5fa368242 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -44,6 +44,8 @@ struct renesas_sdhi_of_data {
 struct renesas_sdhi_hw_info {
 	u64 clk_mask;
 	unsigned int max_divider;
+	/* hardware features */
+	unsigned tuning_delay:1;	/* Has tuning delay */
 };
 
 struct renesas_sdhi_of_data_with_info {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 16ed6fd8470d..868ba6a6919e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -257,40 +257,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
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
@@ -351,6 +317,55 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	if (!priv->info->tuning_delay)
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
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 84b1b38ca465..d056c3586e6f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -237,6 +237,12 @@ static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
 	.max_divider = 512,
 };
 
+static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg2l = {
+	.clk_mask = 0x80000080,
+	.max_divider = 512,
+	.tuning_delay = 1,
+};
+
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_bad_taps2367,
@@ -270,7 +276,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_rzg2l,
-	.info = &sdhi_hw_info_generic,
+	.info = &sdhi_hw_info_rzg2l,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
-- 
2.43.0

