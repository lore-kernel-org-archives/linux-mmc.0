Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE63C37B4
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625370; cv=none; b=lEFaaU6i/Hgopti6pgKaptMccbwYP4S/B5LDu9FcojfRdboOzypWJxKjzoGKqF9YjoQm6AZ5STYV7R5iNSv2c1WI47nRH2EXVM5PyU0uD9j76CiH74NY4VAspXN1vgGSkwD45TjK++2NzuX7jLmejtdvzdPGYtNqQONjSfJPbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625370; c=relaxed/simple;
	bh=vzBQdJ1M1R/swWZ1bXg8311LOyCFVHJ7jmG6I8OJpQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdUNj63tMGn7izDT9V5pgAXfy629nwBEz/A7rO/C7G/4MSHjs1fC9FdWwLDxLXtJI/OYSfjKo9TqNTnctm7pFgU5YqOsNjz8d50CCBhgoFot4LbX+ShGhKsRTJ8VT1isp5ZfQvfUcH40D1W/BddCbfRO50hHxMi75xwfTRZaQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUgt4+Mj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUgt4+Mj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f2e39e81so145765e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625366; x=1784230166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axwrOiyWIwvhuEa/F51yTWG5g+FZ1REob5L9jKF4l+0=;
        b=mUgt4+MjSRwMaztBu+y3cVK+A7fj6fxpI8rWNHYK2uLxSvICWsE6/zrcBQt/t6wBwp
         kpjPmEZ2gTUc68Sq/YMqwwRxBQmDXcuxXiWkW3zRPfZMGTv/cXv1yB/EXE65smfIC1MW
         J7mJ84hBcTYu9ZghMb7he3P/hPmW/uN1+sgkUTAU4+5+HoSzg3kUuoQDco/RwfaBxomS
         /l3+1z+aRxGHYulgc9GQxnq1sRImll21gr+Z38lXxlT4a+WxMZbKENWjIkDSXFEQJTan
         9Z727EeDMVbkZxUb4qBIrLW4ZIQb/2tSAV2uu8bYaBrNJbnUgiO/OshLI0DFYLgv3d53
         4Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625366; x=1784230166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axwrOiyWIwvhuEa/F51yTWG5g+FZ1REob5L9jKF4l+0=;
        b=EfPAklaxVWAcU8S4NmIVhce1jjd+ICwEuUBq5/F2fbRldyjhQqmg8i3PU6QUvcV2Sd
         0eW2oMDlC+yWsFnvwtMdURa4+jLQI3eDsco0miE5X7FuqDk1TabxrGbv+0/WE5pjIuNr
         8NTS2+Ki7znketpetlVNMfgicffHslyJUDwAC0KiAGmlZ7L87VGMqqV5pMf3pTo8A5tM
         9uGW0Khu0xWOBFY2Ushm3Mxqxiy3l8PMciABXTWp4x8ZmlGm+tL77kc3m9wKnehUkIJq
         5ITQ71zbjrrjNm/POR6CQ2bNcp2Ebqye8/y5UvVJyVu/81dRvtdb6cnEFZLCMyjWVI5l
         a5OA==
X-Forwarded-Encrypted: i=1; AHgh+RomJP4sQlge5g1VCEWdKEJ6M3u2EjL3D3LLncnmRU0FJv0hKY57LcIVgjON+XCdbeFj8IazItYi02c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtpjG/NIw54qykeS7wjeEQPfwrNlJh46wpVR4khyw0nw4Sfvz
	02Plgd6KGvNL/V80BpQrZHh3U9Eo6Hq4hsS1ollYKHE9bALRyCoTR/xE
X-Gm-Gg: AfdE7cnuZZj69LBpWHkh4c6vtc8PINE3hrPhRW90R6y9/ekyq5EPYikWyerJ+OKQ6aJ
	rzuq5SoS2FPSagosVKx1sUSJ/pMdKw3l5McsBFG7dT2tZAlheHTvuOISaHt68gxFv5cPmyAPMmA
	/W6GtG57O1im795l39cSimUQbnhadESIW+Vu85YgGaCFJ2yNhBnMqYviUrx03P1FVmKtvjiApmE
	OhbCOxJ47cRP9ikJVXHDhT+FrAu8HmWnggkqufNt6usGvhdVDE7U27D74e0MhxYI2sRcbY01tAG
	h1Vu0juiWnhs07JTmq4Kp72XrL5gb+TSwEoMFyYmgcffBjWvYhfDKMXOmKyZ8ILxoOlkA8JY/ZA
	q4GuJzTI+Ghzj2zTMCIXvRCScS3l88fT5Ljs2XJPojV8vZYWvX5Mhw2gjIqRInaNibJVhyGH9i0
	1+IJerGtVA1M1irWorPtBO
X-Received: by 2002:a05:600c:c165:b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-493f2bfeecbmr3196745e9.11.1783625366373;
        Thu, 09 Jul 2026 12:29:26 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:26 -0700 (PDT)
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
Subject: [PATCH v19 10/12] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Thu,  9 Jul 2026 20:29:07 +0100
Message-ID: <20260709192916.630794-11-biju.das.jz@bp.renesas.com>
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

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Remove the hardcoded SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL constant
and replace it with a per-platform osel_tmpout field in both
renesas_sdhi_of_data and tmio_mmc_data. The field is propagated
during probe and consumed in renesas_sdhi_hs400_complete() and
renesas_sdhi_reset_hs400_mode() when setting or clearing the HS400EN
bit in TMPPORT2.

Set osel_tmpout = BIT(4) explicitly on of_data_rcar_gen3 and
of_data_rcar_gen3_no_sdh_fallback; platforms that omit it (such as
RZ/G2L and RZ/G3L) default to zero, leaving the OSEL bit untouched
during HS400 mode transitions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18->v19:
 * No change.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 include/linux/platform_data/tmio.h            | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 39d915da6f38..30eaa501664d 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u32 osel_tmpout;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index cec703122b22..caeabce7e192 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -307,7 +307,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -454,7 +453,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -595,7 +594,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1195,6 +1194,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
+		mmc_data->osel_tmpout = of_data->osel_tmpout;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index e78dbcb6c887..6a1b59d2e837 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -129,6 +129,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -147,6 +148,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rz_g2l = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index e6663cc736be..6443ba01c723 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -72,5 +72,6 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	unsigned int			max_divider;
+	u32				osel_tmpout;
 };
 #endif
-- 
2.43.0

