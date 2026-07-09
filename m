Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672D3BBA0A
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625363; cv=none; b=dzQNfjx5jew0HrJziczaYzvkO8kMT/74pOs6YgfxAox4sr93ugsifZZlRR/OMa45rg87k6hQCk/BovOqiCe5P6CSjIFnHlneXKqNH+MiGu3+20N3oRXXHgYIRrlqFnL3+ZXMUss2Fs9K3K5pPwcikpdaeQrUNozm9bR75viOSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625363; c=relaxed/simple;
	bh=j0oYPaRLBENumjsSxqippfUYPYG4pT4znONq+zjuhWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfW2Ih02gbE8yF7D0VZuRrikqIhXkQxE/gf0FKGbnXLCHsQiXzZBCz0VDfTT9WDPd8nvseMm563N/Z433gwtvjNy631yRpCZZoQ+Wj8HM+tN01mtjyGPQjRFal7DY1764GoQdsvdq5i34oc8oew28bibMl8uu6g2gumWFuCCGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgqyVwlI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgqyVwlI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso1597605e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625360; x=1784230160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcfkR7nyscsSkQjMYX2e8moPxu+3WX14zYtHKAtB5H0=;
        b=bgqyVwlIK6TkChJIl7MuYHGreT5+JIvBREeykgiRhj3sTgVAo6tE2nzSJp9EbGehjv
         ojp5KSKkQF2w9ffFjrAQ80EbFAZAtT9rkR2IPl4Os7z02ozpBs3RidWfEeoRmMgLpQiU
         40BrJ+JscffBNrThRK0Jry+m20U6do+zF7QNBnQJ8iT0u/ZrayfDzcA3Ppus4ZENMb2j
         RsMS3qrdfV4UwwvoHxV9DcILlRsUbIbLF5LBcBnh/DZ7VeHHhFBHXr2yYWRQRvjIDTHS
         0+rHCo4Uo77W6Hot0E7f+Y8el1wwjk9WCACWNoGm5fbBhSmndFT5CHXaUV4iXeTNym2G
         n9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625360; x=1784230160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lcfkR7nyscsSkQjMYX2e8moPxu+3WX14zYtHKAtB5H0=;
        b=s/qCXj/CUxuJ020sqhjjtyb8K0u/SP7J4qP1DrkFM6YkkpaeqJrNZfqaN01SGyF3hb
         l+nAque2DwoVO0pGf+VZvTApICV8JvC58LJRy7aeugIKAE26J2DKpq/RvVqnCVp6omd7
         SKPiqjFaeliHpbMIKi63HX0LCqYRRA16WQtcgj45AyRvN1VQe02Qf44AQfsmDx9Zez77
         y8LVvxv2LPrSBw3vowuZSwRVC4seXpVCC4DYYXcYfdnmAcxCdnJhBvwdbwjsfsCQyc3f
         fwqzOoBkLxULhCv5tw+PCy4I5Y/Qgmj491N/vviRuyuHvUOVvo2TYAxvX32j10zYIp1i
         jpTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkqDnU4Mt6PTPvWRmpCap7X6SP1dr4WoloW1JQGL9oK3Fm6CbhyFIjV9vEPdfH7W8nI7W9rj4BRqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfsXIManv5oKDu4Runm7Y5aqqRSrWXwDgsWCDD+GHgEhhghKn
	Wc4pZoYp9URO3cy//K61bwJ5Bf6xIufxaWGghk09NkfaBGpO1jSe0zpE
X-Gm-Gg: AfdE7cn97uUX5PMhG1BC8wzL7wHi5j7sq/wdEiH23MVa2HhFmGvfQBuSX5a3M13C0T1
	zTY4tWBJ4CgdphQ4qbA1MIDA2zYV3GJSnKMMr/muOCRr8X2VLZ4FhrfBZcO6QsLv/uE6LheNv33
	z0QVjULk9C72XP0R16KgAlq5jYenkBQcE9XyOLGgYOsrHZ8NASkZ98XaDLKQdW8qJ7qvFAOLKPN
	Hz0yl++WSaJVg1Rafp411iqnGkCf7J9KRKzMhwmS/7xUedAKhVJNidsbBCYX9up7sVR55VKJhPj
	nCmhfBtilCyfjdmXfjPhuHJs+QGdN+tiJcft+4+RL11SaNGLNeHAUkXByYNlyAaZuC6pPixrup+
	mVPkqID6yoGaTrHiZL8yoyAoIXP1dvKl/XWBjTlM7JwA+Btw/T52CQdIMeW7NnQrST60jibHKj6
	t3Xui+5VKIlOXxIex78LjV
X-Received: by 2002:a05:600c:6289:b0:493:b647:1acd with SMTP id 5b1f17b1804b1-493e68dbd98mr83005195e9.36.1783625360258;
        Thu, 09 Jul 2026 12:29:20 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.19
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
Subject: [PATCH v19 03/12] mmc: renesas_sdhi: Add clk_mask field to support flexible clock divider widths
Date: Thu,  9 Jul 2026 20:29:00 +0100
Message-ID: <20260709192916.630794-4-biju.das.jz@bp.renesas.com>
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
index f9ec78d699f4..1787f91d1ff2 100644
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
@@ -1144,6 +1145,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	}
 
+	if (mmd && !mmd->clk_mask)
+		mmd->clk_mask = SDHI_CLK_MASK_DEFAULT;
+
 	host->write16_hook = renesas_sdhi_write16_hook;
 	host->clk_enable = renesas_sdhi_clk_enable;
 	host->clk_disable = renesas_sdhi_clk_disable;
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

