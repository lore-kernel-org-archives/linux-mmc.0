Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2541736B
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411131; cv=none; b=IxvmjVakH8ABOSO4xCfUUlK31RBICuElZB47ut6CkaDIVBf6Sz4CzcEu7VP14hYk1l3AXvv1XChg3idPgMzOiPVoQwVnYgvwfICIVvvD3F/HC6NHCW68wyK8dCRlHmtklPJPA+sbU9r7Jd9D2Tj/UE5HLjW8LBgJazPQsBabBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411131; c=relaxed/simple;
	bh=ftMIzazDxzBd2bcjOgm9s/jNP7dYQd2oDwN/uV24rsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYCpXDpD5ht1Nm4PJ/+1VOUbCvkk86SOqY8+D/CwBauY9unIc1LCJ6g+fH4zoSYdYLttsFq/8TUHqSSfYOQmKhdq4sdUYSSyiVz5eCYVncQo+ifgxQ4yWQdbYaVpqG0Tcj5uZLu66PuI1wiDtftKlYQ+1CRhOUXPnHDJUGOX39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KecAkVNg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KecAkVNg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1875757f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411127; x=1786015927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AgxBBbAjIBlFC8WCeeBHcpct58oN4t27VMGGa6/SRfk=;
        b=KecAkVNgTomFVklS+JkCMvDyvdTFKE+g9bZRrACGabDEtLUFsDGL6z4Jt3SVj6noF3
         HYSDNkrZBkR7iZT9Pf6AkVK4yCWzZLFf+GqtJUARq+eqp4z2nJG7UpRC+vUTQVKvnE51
         AVFiu6ELVQIzquLuhdNFYW54tvF9EDrAoykWr/WVvFnt6MqKpjuoYY8EfKmkSrqaU2Rb
         UGP4ogsKl/IGB6INGw7FFB1gYBmH5buWmjQ76WO9u1AI0tK7IjXzGvr9mO3rT4O/4GLb
         WRPnaHMyp/S54JFyloXInInUqCpu+VaLNnpJc1wvOK6X+qMj3EQSP3RcehbWbK4iChnG
         xvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411127; x=1786015927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AgxBBbAjIBlFC8WCeeBHcpct58oN4t27VMGGa6/SRfk=;
        b=aiiPvMTsrCK0/jxxbhFG/P3vrOOmqA+JIfAhI+ayBjubz47MM8a595XU1SLuTHhFGf
         NE/FnHzKXzOhOPqmGyzL3x+fDrGJJNjNMbGS4JyXqi+/IQ7ZmNXTasAKtoPAszQ/yk1x
         ZcwkHLilNbo4RCFUsHoHLgwOQQXKEy8TVsnjw5SL5/C/Hrvv6oCsSvCBDiWc4jrflc73
         MbUGt41iKXrhP26IQR2sKUkwCw0DwkUZwJeCQZmis/0fve4xQ3cD+EJXldcF325vd1fp
         OPi/OF0c7qwdXJTkmI/BzefahgZUWv2DOVONJajItT7tjUCD6MULOTj2fwMlBLBIHv0l
         ebpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr46NzkSAvW3/SKJCN6lbz/TRpmIhZwHGpH36/EEnAJwnM+cEUA4q5DRAF7XhsV37ZcroRDHKqHbeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVsS8B8R4vxyvPpoL5wCfGWGKkYIMTjZWCKe09HsIeSspRmL1
	nfcTpnbTaM7mgg8k71OMrc8mMtcQgzGIz4T1ceTlugiPeNWOnkrx5z8Z
X-Gm-Gg: AR+sD13B4n/d0qwJ28oI3OcBLKBbDMsqNNyP+uk4CqKNkSA45K6TKItEIJa3jJHBKmO
	9rHHHjGv+IzFImxxSoUQB94X5DJ6quq0PNP4H/oKXyZ5IGNaK5j05mM9Zr7Wuo5YTQm3IQFocrB
	3aDoes/EBid8D5fefTGzq7MMz2zmyCL3AuiPPSU0r2K6donBXa0V0oyst1e15YKfrA5dZGjzVcX
	9r3zN1Kg4BvkbsMdIpzyMgIn6++fsOzbmKSxgqTjjn+DmUfVKEZ/yQLTeUUXl2TVQqxxzGT1Ehl
	MOQYz7VRG+PN4civOZwLBMYF+mlO6otloYpQVVvztXN3VjoBe6Suq3iAGUNEECoYpnkfs4p0qXG
	IN+wAT8j1zohFSz8AptCsPseXB0yQAlhOXgCPArT+IgJZv3yIOPDybN2j/11aCAgp+4qgFMiPYv
	y1QSjbfdWHGMZbPRC8IRPm6GtQxjwK81prBR7o5Wk9qOQU0ngyB6mI3FL4n7/s0nfLfiIfY7gfK
	/9yb52kRM3CCg==
X-Received: by 2002:a05:6000:401e:b0:47f:45d2:8ac9 with SMTP id ffacd0b85a97d-47fcbb5d9ecmr164507f8f.48.1785411126577;
        Thu, 30 Jul 2026 04:32:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:06 -0700 (PDT)
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
Subject: [PATCH v23 03/14] mmc: renesas_sdhi: Add clk_mask field to support flexible clock divider widths
Date: Thu, 30 Jul 2026 12:31:41 +0100
Message-ID: <20260730113200.36456-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * No change.
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

