Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F033BC68A
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819449; cv=none; b=fiZGgQRbSOR+bFZpM/pYhHUY8p6/xjC5qE81i4d7D9MiMG7V2Ih4n0YVDFFu7/v92RQvL/+b4UTs7ix1WMiPvHqH/ZnbWsR+sDJHrAenkz6y2mGqaqEWLb2kf6tQwWC8pEQsSGSFu95158gBq2QmDsSGOXA5SqFzh+Ohjej5sqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819449; c=relaxed/simple;
	bh=/drmPq2OtGuJ63hWkuzu7zOYwDMeaWuBEN8oOYDUFSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUA/cH/bCaNZYiMxs0euX9Wzf6UksPkcPEDOAk7trAsF72NVk7UWcshB6n7ePlobzNFuZD5GWpldG4rB/3gfnuRkQsyp6NHeMyAqtgQURtxHqILCsGy/HBNAQ52uaWJExWP93Xjv74CT0RRe2mOBfePLLBYoMCrJJI4L05VSN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwura6UT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwura6UT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso4408845e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819432; x=1785424232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9VKapQXfx3nIS2LE46Zr0giHXXbo6NVsI+nJ0uBG1w=;
        b=Xwura6UTTJXhG1TnpaChBBkUu/UHHoBtu+JDBs8CtRRx3dzCRIb0GhvxGPLv7VmY2z
         IQ1/qVJ14OlYxCBKKIWXFStLIyqQxBT/VAApiyASxThwZUh66SyGvBFQp7Ehc2yRg7gn
         O4wYsin2GLrpxRPnm42XB1pPQjDToQBVmalbnI9oVyMN6LvIpzvXs73dVwOvRpAqgMvm
         VAEbfg+d3UYa5X5kZG8WvaEsIwkCwic3HrJeH8Ds4P+BfmN6reqb4Dfkmq+B1GFlktax
         vEOGKXhgt+qVqw8pQyWHR4ISb1J+8/RDT2BES1FngyzSTUIPvF1fLdehw34cKAKOxG83
         M1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819432; x=1785424232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9VKapQXfx3nIS2LE46Zr0giHXXbo6NVsI+nJ0uBG1w=;
        b=C+bBkV0jC5TPtcnwaQop2FROph4PIFRZWlmcrTtuOXkUq1b7Rj8fBQQ1GLoKjgJ6k0
         bPxkzJgA/oilHe1zXgOOs5NFVsYHLY2rg8lLBypzl1foF7M/rwob6byzSJQPiT6TbKTb
         Rr7IIMKgCwPbh1/6vRmjjxsPoDNQlYf9gtQKIV1iSymDjmT4EZwCviRFMft/1+E3k7M+
         /4Br00OiFbIrvn05fQUlCmg/XkPcie9lq6nGOb9OHVLZxncflitHhqn10q7vkyblWrQL
         Tof4Iueos/XFFiG+2JdFCjjb6eNdWP4GMvj/ktCh0ei9EP+OdlAXIRkJoWkfyDA11fkC
         b7UA==
X-Forwarded-Encrypted: i=1; AHgh+RrVZ3yXqW+42wxOfRh7p8CnvVTup595S1nIVz/Xhg9Ltym7aMFtkvnxK38JwxQj+W6QM7S5GkyqN9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnidGxLDM0D7k7pFDlw5pOv9aPXx+iYf8vV0gwQDCyxDMaTbAK
	6ktLH1Lg65McH7ckV2ZCae0DB0dcefh/oeSBayiLGDLYsm5LvAGsXVk1
X-Gm-Gg: AR+sD115FGDkDdaqgiNh1igqP2eIdbxz1yW8FVpRX5iyPyLPhQz2P8PVBl7sM1W1WcG
	eSInC+aiv/fBsUKaNSV9U3o4BJccUSM4UFWYrB3F98TrLVfwTlcn030x/lRfOPsnqHTZC1QxFgI
	mPo5QwoZ8GNakQPAfsd2Ae3cNxpSq2yG/q6PFj8uQzm74/89CkdFruU5gBMalksxTint/66B4wK
	E0BzxI7GspCs9tCMwnduGCoHqgf0XmSH8tL+AArd/62auUBGCznUF3Wr65DdESIE/5+j7P/obpv
	RyYVh4ntzCiOyKcfxDvmLWCOZgEf7YvQjlalZ4AHoGaU2J0tUG/IYuMgX7JEN359xIekfNHOjo9
	FOIGPgQ1ltgrlAGFyD5/NpYOh9ejxvxFzOyalBcO2/XWr98PU8PU54y+M6BGRrbSihmts7Rm3/N
	RG379q6w+kAkT7lBZ1I5/s8lrmau0=
X-Received: by 2002:a05:600c:4f84:b0:495:78ea:2687 with SMTP id 5b1f17b1804b1-49578ea26a9mr10387665e9.29.1784819431761;
        Thu, 23 Jul 2026 08:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:31 -0700 (PDT)
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
Subject: [PATCH v22 05/13] mmc: renesas_sdhi: Make clock divider mask configurable
Date: Thu, 23 Jul 2026 16:10:09 +0100
Message-ID: <20260723151024.318918-6-biju.das.jz@bp.renesas.com>
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

Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
so each SoC can specify its own divider mask instead of the
hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().

Default to GENMASK(7, 0) at probe time when unset, and populate all
existing internal/sys DMAC of_data tables with this value to keep
current SoCs unaffected. This lets RZ/G3L, which has a wider
divider field, reuse the same clock-setting code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description.
 * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.
v21:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 5 ++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 4 ++++
 include/linux/platform_data/tmio.h            | 1 +
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 438b2a7afe76..db147af9068c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u16 clk_div_mask;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d893a263e770..44d9f5da0b4b 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -224,7 +224,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~0xff;
 	}
 
-	clock = clk & CLK_CTL_DIV_MASK;
+	clock = clk & host->pdata->clk_div_mask;
 	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
@@ -1186,6 +1186,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!mmc_data->max_divider)
 		mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
 
+	if (!mmc_data->clk_div_mask)
+		mmc_data->clk_div_mask = GENMASK(7, 0);
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 2bf354331b2d..9bf7aa9bd867 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -103,6 +103,7 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
@@ -122,6 +123,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -140,6 +142,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index bb66ff7de065..90e3bc6b954f 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -30,6 +30,7 @@ static const struct renesas_sdhi_of_data of_default_cfg = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -40,6 +41,7 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
 			  MMC_CAP_WAIT_WHILE_BUSY,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
@@ -49,6 +51,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 /* Definitions for sampling clocks */
@@ -78,6 +81,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.clk_div_mask	= GENMASK(7, 0),
 };
 
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 27ea21c00419..f684f4087a8f 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -63,5 +63,6 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	unsigned int			max_divider;
+	u16				clk_div_mask;
 };
 #endif
-- 
2.43.0

