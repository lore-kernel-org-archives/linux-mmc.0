Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2402418A49
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411133; cv=none; b=HgBs8Tm7QfqOJXSQpkn0qZkUasxBdOGX7K4v0TngtAh6V8ZcwRN8inJMAzPEHhRHch1kalHTKDuuTyEx0q3UTn9+0E11vcC1jt6xMmE/xpm/Qia6nsF534tJXhW3jqcuqff9lAZGcpaLqfAxnBDFBdfHZCscmE0TwgCP7tKxVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411133; c=relaxed/simple;
	bh=CvqkqVrfhafwaLI5NKjGK9LYVqAiCvh3K9zZU+NFuAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzupVaUgNU534JPBmVd0FaSsR11YYdOQ7R4IEyVo/LleednmPuDxWAR3Tk8epnoK/F6UcJrkJvGBFVh5GzOO9SwRFVXOvN+8vw/HojEnr9ThuuMXrdOM6QvF+kVNctR3DzEw6vpiCBSA6aBmslvnl57/gB+eokOAcL3YbIAjmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzxvR0s+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzxvR0s+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so430485f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411129; x=1786015929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+58WfYPbQxT1mLdWtE/sQjuQHXF04uDkSKnTSkBPlyY=;
        b=hzxvR0s++ItkejIyJ8MkbbM5SV/VWzKMS7oK5i5ggI+f04DlJz2fBA3GRcwqv/GjHQ
         e9Zlq5VAe4l9iU1S7PlGA4EfQnTlmn+l5eX+mnBCZdkIgqzT51Zj9q7nWXf+SOfQfDPq
         3krUNS65raUJ5RfmXe5Gtg69wrgDbVB9texF6UlSKmPSxQHFU3LxcNPe7WhItuXZhMAf
         pO+MC3W1lw800DbNBsVWbPJwBfHW+Zj1Udj2FtOGVHTwAQKZEWPYyVzcomUr7cxqd4jA
         5S8I3PjQWjMKVX4dAi7OAY6hub+E3FqP4YJi1FL7Br9LI1ZpxzJlT6cmn8nwvowRW5rF
         c8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411129; x=1786015929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+58WfYPbQxT1mLdWtE/sQjuQHXF04uDkSKnTSkBPlyY=;
        b=LGYEXKfP9VNeJAcve7n0g4PtYvX2Yak0kSZmjBwNq/44di0Wg71hdl4vQ7mtpL3+gl
         B5/we/+4r2Bahtb4fKOVgm8OZqzilwb/43IgDCb70tusUg6pfN+DnffipnhHnhmeawl/
         Yifmpq+BvLvG9PM/EeCgzq4HOeiDyGs3vayqV8MaqE69XkZwZKTmr6DL2tMUJrGL2QkB
         k+ZdWqGhow2X8oQQn2rtF6/xK16dV3ADrYqS5FlSaiarjDdCILCZBeaYLkQ+N/easw3+
         AVqmxjtaCY/jOkhG4sLKGeifUMk6rZ9lvDMkYUb+p9vHDJAFD84cNoDF1RNJbssZn082
         zaug==
X-Forwarded-Encrypted: i=1; AHgh+RqpTlj7xSx4mjHyjnLMGHATyPx0XIcTYIp+ts1x8FXNVQCuW94qGzeXvwztyDuSAb7USXwsc4EysSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya69ioDsn7ieT3WvjMLu/tVvieiBkmmTjfxrgwCebE8LPC9Fa4
	yXpYjkvyXYXI/2B7mQL1h6P+3YN5uRF4446QeibRAZKVkFrFfpelL+yJ
X-Gm-Gg: AR+sD11xmSDhD8qqNinixRnHONlKia/8vr+Vo/7NkNn3RSV1OBlfBW9vjRNBswAKnIl
	yGUJQZuC5ReDOe0w20J9vy3qg88tfDL49OP8W8E50OcDT1gakeXpVKB1I+YHYZAx9zikgB6k/qs
	/toPBMdSxffLnPxrXx+AFEEV3J+OSpHwlqW9wtD7S75jQsqyA+lAYfGsHnHnj1UWrMHNkp12JCR
	InYCGLkf49nG4u7es81oucNTrsiMgEgaHIlt6tivnp2aCjEgCAxOdZqmMh5XQP/Dn71l3GNeYh5
	lU35TVFXPOcNmXlavJCpe4K8CGSbXObdZq2AAmFJMCk/VrJ6iLfIgYUKzazo8Bx9RNWa6S/KGGJ
	kpBJwuVsePIeT1KZkFgcF6fybHOKZsMPBSSIdv0PxkeVVS/TMK/fsko84uIQT+uoeYIrPyb/45C
	1Z4bxkq8gk/kndmUHM8JfPkNq3PL5Deqpj558Cz+w9Xs61yeJqIufL5QWbx6D/E0R0b03spWaob
	m2LtYF+eFnELA==
X-Received: by 2002:a05:6000:290e:b0:47f:8abb:1fd2 with SMTP id ffacd0b85a97d-47fc8bde0f9mr2793509f8f.3.1785411129154;
        Thu, 30 Jul 2026 04:32:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:07 -0700 (PDT)
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
Subject: [PATCH v23 05/14] mmc: renesas_sdhi: Make clock divider mask configurable
Date: Thu, 30 Jul 2026 12:31:43 +0100
Message-ID: <20260730113200.36456-6-biju.das.jz@bp.renesas.com>
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

Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
so each SoC can specify its own divider mask instead of the
hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().

Default to GENMASK(7, 0) at probe time when unset, and populate all
existing internal/sys DMAC of_data tables with this value to keep
current SoCs unaffected. This lets RZ/G3L, which has a wider
divider field, reuse the same clock-setting code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
index af56b4bfb1d4..9c72eb78e31e 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	int max_divider;
+	u16 clk_div_mask;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d893a263e770..5dcbb431e1e1 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -224,7 +224,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~0xff;
 	}
 
-	clock = clk & CLK_CTL_DIV_MASK;
+	clock = clk & host->pdata->clk_div_mask;
 	if (clock != CLK_CTL_DIV_MASK)
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

