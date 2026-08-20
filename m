Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63D47F791
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246230; cv=none; b=AQqiMJmdwW7ZZ6VigNshw+mrsHj2XTCXDu/fNKXd4BK/eJfs4wKjcNdjU1L7Da3Hc+wubVKp8FvKMuHFTe8d5Ua7PEhl26XlpXu/AJve5XmuY+49XsPdwi0EJ1wlcwa239YUa7c3S98A+rA7jG84SodkKV3Hnokxg03Y4mm9g3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246230; c=relaxed/simple;
	bh=ELy1SYX43E2A5YfHEENcygQp07Ma+0lnFG47zqjAuUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUU5A0ydXMp0COQWaNlKjdhLvkGJUchx+Uao3WU04/ih5a6XbgMXECzmmCCHpxUGnsbTdNTs+e/VJS/yjJ/KgtIkedQDO1BBKjjHJywnP0gDoyx9mtqu2ChrpjXcmE+ABDbFFEyVVHa6+LsWKRB3TH62qyJri20Cq8sTDn/49TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDd8iOQU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDd8iOQU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4957eefd361so522545e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246225; x=1787851025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zjAEfquqUIqfee4UdVSzVIYDAGu85RBGZc/axrKJpc=;
        b=pDd8iOQUfJ7SsdY807lCQvF0Djh5+1UsqZGa3CmOz3WBRsXP3qpzm8Lluk8pSWCL8o
         CHrMdE8DxTqV5o2uesw4G3KLzhvv+5gqK6WvYhuWdmEytXRv+IBHbsy78O6oVA7rVkfY
         4Q355gJzsT7GL8gqqONJT6APYfs3UR2CRmCRUIBSp8276OKxICDyIUoFUSVk9lV/U/b4
         RB8M9bvleOcAiS8D2Td0eJR7h0YvGBN+0ncPwQVqDY7Ym5isGKy+540B3iuKmLVJx7E2
         E9AV66iztqhVZHXsTVuxQNrWMb7Z0xUr66Lh/zKxBnrBGB5i4v1yn6zqrZyVhVPbT7ci
         o/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246225; x=1787851025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zjAEfquqUIqfee4UdVSzVIYDAGu85RBGZc/axrKJpc=;
        b=mK2iWpaJZ3bgai+GMHOWeWaUWn8aZMPkNQ8iWeLjxXPPeRHFO963Z+m7h3XICX/taJ
         4zOJLgfQtDzXPXQ4ox4GRCTTC7geTqa+LsZl4N4pZ+LcKP6XbyMnC6OOJCAVo9RE9wto
         4HAXrhP53HwYct8n58SOvvCM+zLLoRwYk4VYVxDBjS5o1ljSmAtVVsRFiEWtvpNhRdND
         1yAAHt42jGFxjFJAoVGymc1JzRLWQ1eZDf/QEgqdXPvsnBbQ3eW0L1c2ByCieTHxMpwJ
         hR370KUCdSndmTuvRBeFr4kZmqoQGHHdLHs4a6FLkRHA9k3/ZTcKQYXrAk9VEA+Ijexp
         XcjA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5I90xAjZ2ftnEtF9Ks9JBtl8slSYO64MvEse0ykFCWt3hkdg434LD7I9qwFbEuRT8SITQremyY3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2LJUiNSmj5gCuFOdmM69iePQQOj1upei64DypsKetO8gHo9M
	wfR1r8jHV1B9McQ3boysAMr5Sg19AmHsvMA0URDKL7k3Iv9Frgj59XAR
X-Gm-Gg: AR+sD11jIom+MY+PYYfsP5FLlT3P0J5cEHShnghsrk+i+t+9FEFR2OP/8riZjJ6Fe9p
	/i9NPmukieiFlcdWzkKks+oZERmWLCijdzArtrPdnqP15gbivkJp+fQKbZ58ePAzdmbi4tyFg4E
	/3ZycTTF6SAdLsz9IWZ6+dg+l1C40IB7SDVGjIn6wHv8GAajhEou4ixn84DFibpVi20xodiaR27
	hHCGJzODB+e0mYC9Y4UQWSe+4aEkZVJaCi4dMKDGgtmEAwmYN08aSkFL+qtyWaXVQLSXcb1WH3O
	mrY+S0dgP7xLKz7x6makl42SqKfSGlfmxa2ZfaNVAV8ELT/GzVjcfprHnF33eYXqvi2fDcblDYK
	Dp4MmmABXIaVFkk5v3fqbsqMDH3fFa7zSPjfmWZFYkl6oZPKgT29U5OT1R/TbrG4fgK6nj2/EpD
	IBFp0ov1vYc5MN9h/HsXtGWF7SlLYIF06CpZmYtKCvJhjCq4hov8MT1SxuYjQtu7oGbEOK
X-Received: by 2002:a05:600c:1548:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-499b8277214mr10768745e9.0.1787246225271;
        Thu, 20 Aug 2026 10:17:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:03 -0700 (PDT)
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
Subject: [PATCH v24 06/15] mmc: renesas_sdhi: Make clock divider mask configurable
Date: Thu, 20 Aug 2026 18:16:36 +0100
Message-ID: <20260820171657.62815-7-biju.das.jz@bp.renesas.com>
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

Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
so each SoC can specify its own divider mask instead of the
hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().

Default to CLK_CTL_DIV_MASK at probe time when unset, and populate all
existing internal/sys DMAC of_data tables with this value to keep
current SoCs unaffected. This lets RZ/G3L, which has a wider
divider field, reuse the same clock-setting code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * Updated commit description.
 * Replaced  GENMASK(7, 0) with CLK_CTL_DIV_MASK.
v22->v23:
 * Assigned of_data->clk_div_mask in renesas_sdhi_probe().
v21->v22:
 * Updated commit description.
 * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.
v21:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 4 ++++
 include/linux/platform_data/tmio.h            | 1 +
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a1b2761ceccc..cef043d22dba 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -42,6 +42,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	int max_divider;
+	u16 clk_div_mask;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fbc0a8317b30..e11d357225a1 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -224,7 +224,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
-	clock = clk & CLK_CTL_DIV_MASK;
+	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
@@ -1138,6 +1138,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
+		mmc_data->clk_div_mask = of_data->clk_div_mask;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
@@ -1186,6 +1187,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!mmc_data->max_divider)
 		mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
 
+	if (!mmc_data->clk_div_mask)
+		mmc_data->clk_div_mask = CLK_CTL_DIV_MASK;
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 2bf354331b2d..b2622ea9ce20 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -103,6 +103,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
@@ -122,6 +123,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -140,6 +142,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index bb66ff7de065..7a7d254fbba4 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -30,6 +30,7 @@ static const struct renesas_sdhi_of_data of_default_cfg = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -40,6 +41,7 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 			  MMC_CAP_WAIT_WHILE_BUSY,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
@@ -49,6 +51,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 /* Definitions for sampling clocks */
@@ -78,6 +81,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index e104718cf21f..e4232934c7fe 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -63,5 +63,6 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	int				max_divider;
+	u16				clk_div_mask;
 };
 #endif
-- 
2.43.0

