Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCD3BF69A
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625364; cv=none; b=HSOnsXvtH0ZVZChTUbxPiF/GcMOP8T4krN/hcTo46BpCVW8un+t2tcLdT57+f32jzPbjLLItK+aB3b3A9Zkxm3XB5ak6D5vDhuObeYG8mZMgnVQ6Dt6c9ku1v07R40k+CYlXay2vXR65GfuQuwtC2vy4/B5OOlLg0b+xT+rqGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625364; c=relaxed/simple;
	bh=S3H6fUTHWhjvpC0BW7aevPN9NmKkov2sb+otOCrz6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzMX7UQDHpw7OAxf6AemaimXzSw2sj7QL/E5lA/aZbOe/as+J2DSAX7HH3yXd5I+MHjUEDeEtbCeHnL9jURMLknlRiyfBGi/P59un6exsRTd8VR0eP+gCqyVDWERvu4vlrqqbepBWfcyxyBVYtvSWpAFUglBOUA1tK9LRJZGjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go0i30A8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go0i30A8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so1061645e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625361; x=1784230161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vw7dlDRBzI9LIFK+Wpinj1k0I3j50RCuR7HKmuVgR7E=;
        b=Go0i30A8lzgDVaSEhhRlMLXcikoxEnwi1rR0YIFrxyFIF3MfFuw64sGzkBZntjFzpZ
         Kfc20+phNvUJuIgGotK+fCMdRruQYfp1d2ijflk5RKDMS+1Iq4vNlHgvYANj8Mo8RRCH
         OLsbSBLYaWPLxHBUN/SKU/C6WsiQ7WK7i/H/wOY1pq7SHRX14XBP8co1fu45POlCl9ym
         T/lUs9yYdMbIpReY1R3k4n/F3CJj8O34y/D8gtE+q7twXXsWQlVzTEzPmDNTAi8Z1/2s
         fY+ZNGPs6NDmM1hQBsnASz6CNeXS8AvIOGJL6SzOS0N/1ftkiQjOSnwOBKN4cXc6EIqR
         q/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625361; x=1784230161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vw7dlDRBzI9LIFK+Wpinj1k0I3j50RCuR7HKmuVgR7E=;
        b=dVXvkKzi2gGORAdJla9HqTZDIuy7Sym557gb4+luceaEPgcAtF70GH1cK4FTspeSk+
         AcnIv2vB+euP/2zgnTO6xb3NaNvVULp4HcCNTaLqHeVOzZkHYCNGDnmR0VZUl06pWbcI
         sibnFWTcUd3nRJho31XJtWGB/++xNF9boGNWUmySgTVnmaqB+aobX0olooqg87tKw+z5
         rYWD8FViUyRdPPol1y1k1dXnNPBh8B6z1jGDg2oDEhu9BRqw7azkcmpTwh3XTn3FDOij
         cdcqJ8mSHeF96RUk9/BxEt2XXJeRKzBkpWhGawuCkLlYBXJwyL0cIyo3acVHt0QWUB1O
         d3ig==
X-Forwarded-Encrypted: i=1; AHgh+Rqo7A6Y6hufYBAiRv7s7oCH8QS0ihms3uS3e7vl2bzX1+rxKSV61rfLZUNX+tBIF7RN+kuO3QJq6Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhCoJz2OeSNuhJ4BnGdUD7dDa60CiNzwn/ZU3gK5Hy+kLVIZ4
	ARO6ijBAvN4Ct3DHum6DtpTgAdEglLqSOAsd0arr0MvWHnV1coSja3eW
X-Gm-Gg: AfdE7ckCEWVZIknd25rUWQPsYYJ85z92z5ueR25xSF4ah6HBVURUT69gNtUMRxkC5G/
	0J1Y8eDW5E+BNT8hHZNZb+ODQbwL6/xbACsSPXSp8C2JYtZ1K/XTJoG4MDWT3LNkZi62tXn2vLj
	w76jZYfSd3UiR/tsXcIhLwt1v49fWkKgso8bk/MmAjY5UYINI23jJWQs8+zMiNLlI9SDPesIkHs
	FCVGh1EDZNipNX96FLprEYQMcNksFQM5yJS5pVSO0umFhhiytYzcjqOHZhGh8IY/2Yp+OATeg23
	2yzlNVinZaJj/ekyr+uEr8bqFbQ/zXAguht2f8gbh/m8G3TvIRbgehH1lh+Tz037faVo1ktH963
	ZX6NWWqehg8TZdaeryqQiCzCbanSi6vLLWWjKkFh3c/pezcpq7Dl/5dsWTBIW8VspiSpRK+hXyO
	ILo9LH4d0RTreLohA6Zdjq
X-Received: by 2002:a05:600c:8709:b0:492:454c:347c with SMTP id 5b1f17b1804b1-493ec569cfcmr44197915e9.7.1783625360995;
        Thu, 09 Jul 2026 12:29:20 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:20 -0700 (PDT)
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
Subject: [PATCH v19 04/12] mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock ranges
Date: Thu,  9 Jul 2026 20:29:01 +0100
Message-ID: <20260709192916.630794-5-biju.das.jz@bp.renesas.com>
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

The clock hardware on the RZ/G3L SoC supports a broader clock
divider range extending beyond the historically hardcoded value of 512.
This requires a flexible mechanism to pass SoC-specific divider
boundaries down to the core clock management logic.

Introduce a max_divider field to both struct renesas_sdhi_of_data
and struct tmio_mmc_data. Replace the static 512 constants inside
the core functions renesas_sdhi_clk_enable(), renesas_sdhi_clk_update(),
and renesas_sdhi_set_clock() with the dynamically supplied field.

To preserve backward compatibility with existing hardware variants,
implement a probe-time fallback mechanism that defaults to
SDHI_MAX_DIVIDER_DEFAULT (512) if no explicit constraint value is
assigned by platform data.

Finally, explicitly populate max_divider with the legacy default
across all current internal and system DMAC configuration profiles,
in preparation for the upcoming RZ/G3L extended divider support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18->v19:
 * Fixed max-divider setting for non-DT platforms.
 * Replaced the magic number '9' with ilog2 function in
   renesas_sdhi_clk_enable().
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 12 ++++++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  4 ++++
 include/linux/platform_data/tmio.h            |  1 +
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index f926a36f213c..438b2a7afe76 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -23,6 +23,7 @@ struct renesas_sdhi_scc {
 
 #define SDHI_FLAG_NEED_CLKH_FALLBACK	BIT(0)
 #define SDHI_CLK_MASK_DEFAULT		0x80000080
+#define SDHI_MAX_DIVIDER_DEFAULT	512
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
@@ -39,6 +40,7 @@ struct renesas_sdhi_of_data {
 	unsigned short max_segs;
 	unsigned long sdhi_flags;
 	u64 clk_mask;
+	unsigned int max_divider;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 1787f91d1ff2..5c478995d660 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -117,7 +117,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	 * Minimum frequency is the minimum input clock frequency
 	 * divided by our maximum divider.
 	 */
-	mmc->f_min = max(clk_round_rate(priv->clk, 1) / 512, 1L);
+	mmc->f_min = max(clk_round_rate(priv->clk, 1) / host->pdata->max_divider, 1L);
 
 	/* enable 16bit data access on SDBUF as default */
 	renesas_sdhi_sdbuf_width(host, 16);
@@ -156,7 +156,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	/*
 	 * We want the bus clock to be as close as possible to, but no
 	 * greater than, new_clock.  As we can divide by 1 << i for
-	 * any i in [0, 9] we want the input clock to be as close as
+	 * any i in [0, {9,11}] we want the input clock to be as close as
 	 * possible, but no greater than, new_clock << i.
 	 *
 	 * Add an upper limit of 1/1024 rate higher to the clock rate to fix
@@ -165,7 +165,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	 * for 533.333333 MHz will selects a slower 400 MHz due to rounding
 	 * error (533333333 Hz / 4 * 4 = 533333332 Hz < 533333333 Hz)).
 	 */
-	for (i = min(9, ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
+	for (i = min(ilog2(host->pdata->max_divider), ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
 		freq = clk_round_rate(ref_clk, new_clock << i);
 		new_upper_limit = (new_clock << i) + ((new_clock << i) >> 10);
 		if (freq > new_upper_limit) {
@@ -205,7 +205,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
-	clock = host->mmc->actual_clock / 512;
+	clock = host->mmc->actual_clock / host->pdata->max_divider;
 
 	/*
 	 * Add a margin of 1/1024 rate higher to the clock rate in order
@@ -1137,6 +1137,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_blk_count = of_data->max_blk_count;
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
+		mmc_data->max_divider = of_data->max_divider;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
@@ -1148,6 +1149,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (mmd && !mmd->clk_mask)
 		mmd->clk_mask = SDHI_CLK_MASK_DEFAULT;
 
+	if (mmd && !mmd->max_divider)
+		mmd->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
+
 	host->write16_hook = renesas_sdhi_write16_hook;
 	host->clk_enable = renesas_sdhi_clk_enable;
 	host->clk_disable = renesas_sdhi_clk_disable;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index c6db0418de15..2bf354331b2d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -102,6 +102,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
@@ -120,6 +121,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.max_segs	= 1,
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -137,6 +139,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index fcd2edfa69db..bb66ff7de065 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -29,6 +29,7 @@
 static const struct renesas_sdhi_of_data of_default_cfg = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -38,6 +39,7 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_WAIT_WHILE_BUSY,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
@@ -46,6 +48,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 			  MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 /* Definitions for sampling clocks */
@@ -74,6 +77,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
+	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 76056d49f5e0..27ea21c00419 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -62,5 +62,6 @@ struct tmio_mmc_data {
 	unsigned int			max_blk_count;
 	unsigned short			max_segs;
 	u64				clk_mask;
+	unsigned int			max_divider;
 };
 #endif
-- 
2.43.0

