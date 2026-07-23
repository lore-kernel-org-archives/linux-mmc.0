Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD729992A
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819447; cv=none; b=PZ0Ky9Q6b629+TIIVqDbUqODUrSPUhUJjrHQGn/s0pt9VWWGs+ZJbnFnDBcxWsLmI+luHxdhbjKKlSEX+le9e0+Lm8NqjppfeChwaEOT+xwAsmpQCJ6qj426y9DuV2fqlb798gXT0CYiDSggkMZ0bOIFwN1mqfIRd9epwpBzp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819447; c=relaxed/simple;
	bh=gCLmpPjyQxDvAqOddjjCDGlY7eKVOVjUHsO52YGmmRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUsFaLHYkNLAq3alxBWPJ2o1rPRDm5G6hG+/zcodpyLhmqluQdJIPHc2mS32m0+SOz8CmfGxoPUE4t4umO8WFtw/Gsa5LA95NJ5lshlR5CSFlFQBR8DBcJ+RyjZnXRl3oMmlvpvCZL+qJsX6MsAmKH10RSMXb825aVdny8TTMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXbA6Lo9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXbA6Lo9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so6267035e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819430; x=1785424230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCddQzmghaE15HZkMbuyaacL5FIxyVYwt3e+Aex3zBY=;
        b=VXbA6Lo9HwoSJL2JC15ASwhMEK59n5FN4OJx53sgoGvV1ViuAgShAgWlkRqw3iiWcY
         DEobOO3HMJ8OdwIo3l7IDcVYOBsWRE/QtxA5nmEsGo7cyI5Nrcm89pvMsElY5Iowd3hF
         ++YI5Zz2gx1esriHcpZIsACeo4Z5hh8mq4xbYkf3/Pmlp+ixZpV/VO1iSwVVkLYIM+Jj
         HvBIxE7T7Fs0IwWuJzFw3MreVEiQCbvB+LIRLSXN8hCR1/CksVNUReTYygjtkOxcwRqi
         pl5S85M86OSUgpqX1WdyEf6gNgrQ8s94R97zONl7qn0+gFexT+ndolCSJi3xbx8mc9w5
         GzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819430; x=1785424230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCddQzmghaE15HZkMbuyaacL5FIxyVYwt3e+Aex3zBY=;
        b=SRKRQXt3zVvvo+KiIiXREh+9KC8JfpCAnXuYRxhAS6gp0DOSySCUc0dB7YuqjkPODp
         hpWZVqnXgsZBj9Ruhd54suw8fw0ZjoDWFhdfA8Lq+LKnDsMgVHU5kenYD5oNYu0g23fN
         +p2qlZVg7NG3nLTLPOZS12NfqjlcaOkfUbJhoTVGu0WFRfUHI+OtAHVM3/8rj9L18F/c
         3jT9149WKRb+JEO0wBGzYpxhaY6EuQT6kbwyktoyT0exS4yc6zZUS3R5X5yNa61uc3gr
         irOapuwhhvN0wTr/Ik0JNcf8IJTROXhRceEyLRDfz9DXkAhHp3BilWzYqP0Jfvn5ks54
         SUVg==
X-Forwarded-Encrypted: i=1; AHgh+RpJBf8MeKprQ7HPO77/r5hXcBfdGnrbbgBzsxCaLqatxAmqaeKfUXg5QQPdWnhtPcgvPw8uP63wYtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24+egCspfQ9SwwNfY1HRA6krZPrqPQ7hDyvDXfgd8i4TUZFEq
	jAKAEahapsYVW3SYHJyQ0DOpJVL2NgiwzdnEFkl8xpN9xfUDgyd3UGwq
X-Gm-Gg: AR+sD10VJAGCOD0yu8sW1uJIMCM2jESZRTBlV44KlGoHdnVUQfL60+/N42/5uMGIUvU
	HwefeZyMmpMxp2l/1d+Nq5iUmE7E8r8ACNDd2KhyaoaPNlBom/XV6SzssZl3vuufm8LaafYrGQb
	b8EZL+NIx9Xn/Qvpklz4P2NCClT9s3o+jxSYc2gaEiWx+0iNNAXfmSsSbv5oU8X2PtO/KL0xBXJ
	FbtnzYal86yMKD7oExBERps97oq/Gox/SL9iHTpYOWerOskOh+2KuQFKnvcGd+eA3m6GV9Jlm8s
	q/dGoBXoatQwIcn4IEimJU74FyVjITRCa1jE9s4U9aZ50+YpBx5AY87hl5A89ArFyoyFM0zYgpV
	F7MIKVnA5P6Q8ngazuUiofdSRHhqePiG8Le3Wk+UlV9nBAI+wQ3bwbkr0HYO2Oc4WtP3JMUPr1Y
	IAbYUnMDftwahq5uHPl+O8G61e5IXxkRyyF9bhsQ==
X-Received: by 2002:a05:600c:c172:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-49574581089mr34138615e9.2.1784819430075;
        Thu, 23 Jul 2026 08:10:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:29 -0700 (PDT)
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
Subject: [PATCH v22 03/13] mmc: renesas_sdhi: Add clk_mask field to support flexible clock divider widths
Date: Thu, 23 Jul 2026 16:10:07 +0100
Message-ID: <20260723151024.318918-4-biju.das.jz@bp.renesas.com>
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
v21->v22:
 * No change.
v20->v21:
 * No change.
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

