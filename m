Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144143B3D2
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819446; cv=none; b=NegmRItw5GeSTm0/bJsWppJTPtoj0aRyWdSGDv1ZXcz6mzCQoZcySy3Se9Y4F0T+PRRUomYhjmAtsva1Eg8BTU3C0JlLBjTyQciuImZk0JKm1zMzCDzhASAwrjBlN7aLeEhT8S/Mz49jr53ccuMYqTK5q3K0FsVKtqBzW8qEAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819446; c=relaxed/simple;
	bh=uGfUbasJte88SKOBHsmKAFrdFbgwKTaL8EvAsqGzvq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9POWGxOyBaHy6cDSHDBZIgQMRiQj/6RbfaluhgucXUxxPXwIQMOUa0RKOGf/AxDLmc/J0ESEnnUNMzlRVCOEymYP+CovnX8vdDhS4Ft/etu9x6HSi0alEneDp7hJgWisIb5pOfdZgFenmgDdxB14eqHz+PBRte9BIP/LQCmZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKzwC4k+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKzwC4k+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955484387cso6250885e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819431; x=1785424231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6t3la3ocUwfaicbaizR3LtVSlDXzWQzWGmOIxs0p3z0=;
        b=UKzwC4k+amViERgo146Sh5r/aBUAhYnBR73eZtiqaqejPXnuFD/iH9SPs8/ZL/hSGc
         WnR78OFv6MlUwF568vsdAhPmuHJIF2MQ+cjBuKia70AT4nThctGRvVTfo+E2x8UOTnmq
         yiBXzbwotEmPTN4/LMyf43Gi242wiVyhSvRTnoh2BzBofYp+FbMbDehyMaqFv/XP14sA
         kTWHV2v29SapzYZXed5bf9bCgdUTzWRTCKvngs+P5UI3qZ/rptJBzVfu1joL9oNK6kvI
         keWsrkyIYMjoqS8nU+7FHyiEn8K2+qdN5k9ZJVT8/i8drNZpWlkee20cptlrBLfVHgd1
         sitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819431; x=1785424231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6t3la3ocUwfaicbaizR3LtVSlDXzWQzWGmOIxs0p3z0=;
        b=YJ7wGiiIpstVFEC0JN/qb0Vylc43nqYgvGdsJzNqRNUIEcqL7pg34I69yPxTswZpet
         T5Pkk+iUJB5Kq1XTYf1utOBsrmPtyCzoIBA1tEksYgm/Dz/8Jge7+O9V5QKNQUUegi7V
         CAGvdkj5evDbpVV0e/Np/YdhLQThvb7qqQm3yG8urgMf8Yn+H7VHD5aJPOfebnVGZr5J
         0I5szmFhMPTpLpz7eJHqEN9Td6mDpj5Z21As2IfDqeXFvx2W8+MauxhBeWf5QvmlltaC
         +4yGh2ya2P0F3EPOc5RKGGyYu6MOKqI2R/d6F3KH73ASbieTPLh+3tMC3WlgHVzIZZSi
         qndQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDnpVKC5WA+igGyJri236lF9eemzI3/DXeMoJ6qYwoZrFl7o1XX0pXrNeiqSb2XH7qjefC10ivnu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwNmW0Zrs1TQFyIGhy1ST6MdPNoKqmGBYtbjXA7U4Eu8im/Uh
	3gM0MvADCp+qBQu10gqOqbGQW7uFVbk89THibaDO/2h/B52nQWngUeT7
X-Gm-Gg: AR+sD10FTK5uSaDizkpSWeAi2vd3UxC3dVLPcQLbk3mYVCjQsvltfAZ6RiYsEOoPyMa
	Q8M37qb5rgsPU6zdD/Jd7bILj+RC3anHJ0reQmxAuJQq0s3Dru2yAsvF1Psk+vnsH8ZQOEo/ii+
	KWXgfQ/jphVh1R5jiGlYFeZjbikOdVxra9Xn17dk5LfnloRYvwrENX9dm1A4aYoqgEfbSxt2Ury
	1AGqVPMQCVTA0fTM7FeC0WsPT8uvnmDlwA1y1T0PXzh0gi4JxGHs+Fu/wsim9LrKe7M2PAj8UtS
	T27q4sZEBZVxkAGXCzD8EHvbGEkNAED0ei+uGywQsUQpFG10ojvbhRlH5twn4zZug18a9dOF6lM
	yQZ4Yj9h8HQSJacvUcsaWcKPeDtyk+RuwRn+7rtw/suJxTtOWBGuu4q7KETBdQ3Foa0AbtBAkIY
	PMuc0ShUctaVzq/kxxNVDdhV6S+Yg=
X-Received: by 2002:a05:6000:2993:20b0:47f:52e9:3716 with SMTP id ffacd0b85a97d-47f8dcae427mr3614005f8f.44.1784819430820;
        Thu, 23 Jul 2026 08:10:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:30 -0700 (PDT)
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
Subject: [PATCH v22 04/13] mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock ranges
Date: Thu, 23 Jul 2026 16:10:08 +0100
Message-ID: <20260723151024.318918-5-biju.das.jz@bp.renesas.com>
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

RZ/G3L supports a wider clock divider range than the hardcoded 512
used by existing SoCs. Add a max_divider field to
renesas_sdhi_of_data and tmio_mmc_data, and use it in
renesas_sdhi_clk_enable(), renesas_sdhi_clk_update(), and
renesas_sdhi_set_clock() instead of the fixed value.

Default to SDHI_MAX_DIVIDER_DEFAULT (512) at probe time when
platform data doesn't set it, and populate all existing internal/
sys DMAC of_data tables with this default to keep current SoCs
unaffected. This paves the way for RZ/G3L's extended divider
support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated comit description.
v20->v21:
 * No change.
v19->v20:
 * Replaced the check mmd->max_divider with mmc_data->max_divider and
   moved the code after assignment of variable mmd, this ensures
   assigning the default values for non-DT platforms and DT platforms with
   no device data.
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
index 604d886e483c..d893a263e770 100644
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
@@ -1182,6 +1183,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!mmc_data->clk_mask)
 		mmc_data->clk_mask = SDHI_CLK_MASK_DEFAULT;
 
+	if (!mmc_data->max_divider)
+		mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
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

