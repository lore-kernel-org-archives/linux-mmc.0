Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB33FCB2B
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469872; cv=none; b=H5wN/ws442lKHmpzh73DivbvtgzHobK/cmtAznE/B4v0+gj/dZU9Qnm8PlLEqAqdNHRURmLyNjkERUTYUwN1XOFR5xAQ3ujbJOFaChlVfqwFUdqxzpMNXsxTE/f5WGeP37yosl+vo7Xn/Y7dW728YJFAa5mMR+6sUGm4NkhSuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469872; c=relaxed/simple;
	bh=Oz5ufnT50otS5eVq3kMF329Gtgk2yxv8bNMFZvfcWTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6iKE39N2zK9cSH4RZYVN5jOOVPE66ubRHxvtNSftJCJGwW0LIXVLWVWbfB6FdLWQ5wbLgdk6fREIPC6msGvbuW83k3NkFy8Kn/Tp9jyJJNRirJXjazakc/OVub/Pt6KcAmB4IIttHj3ebvL0YEFq5DhqJHHjHNjH2XK4dK99ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ12e335; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ12e335"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so124052165e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469867; x=1781074667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC6f4Wxmf4007+Kz5r2DBYr80qLrwKMIhWhtoLp6w+U=;
        b=hJ12e335v8SAX2tutlG4KLiTtfBqTdgz0S7eTGnlx5bY3og3+wnU2RkojFL2VAoo7z
         yOPMOVQb0UTABePQDVJ+8Dk0YQ6oyaFpjI0P2GKhKtIJPZTsL6ZyFyYkPnbHtcyrzLK+
         GhpXSjfLjAbKQXxzpIq+wOpQv/Ex16liRNdVRXIcMlYMgICj6AP6GwrqpE4HlGqSpMDc
         ev/J+oPrfIoWeVqz5F+BxoCorC70+2r18BHcrGDyjGN65bshpzhuZV2D1r+OpGMgs9WP
         FeIVjQuXbQBLfDUX1oKSKjAoQ0KODCa+BlT0+j8YT/9imy0Cwu2ABq3wyXGMfz4UFcgi
         c59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469867; x=1781074667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KC6f4Wxmf4007+Kz5r2DBYr80qLrwKMIhWhtoLp6w+U=;
        b=aUohwp5a4RhjjgOhUYaZ16xGeRY1dEM7UiYlraETjGbX9Wb5hLCR2yj3Q/QwDeh8VG
         pxDEMQiE9GsWOyHoK1X1upltjX2zFTCDrnfkouTGIlKRYG18EMtzO6ANFjYvIIkGFU3w
         Az5N91lHJSu16KZmdpsGc3WSSQPJRnrzU0/Y4ZTYNyxPkA+FBq+dC71k0yGUgG9j2S4w
         AASQgy3nX9p7Yaxzu8WezXqaU/+QEXA8RZUDoB9pJ8ApZY8mOyi2FYNskNQPHOLRoKcd
         CArhgNjcLF2kvQW0LNQ4ErXE+UN+FsPs3fhv/64XsP9We8inPRtlKOewVTblUzA8Vgk+
         mNxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xGunQIbL4Ov7TVih1fHW7j0nvNlD7IqVXiECSNBFByCU7Fnjl4keBmG+fM5gRwEsBFRpQqgNY8VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcOxBzBO2BeNKq71WPu7nYueKYchtK9RVPD9JdRmSrN4289es
	MWBFkG4+SjscBwfMj3rWK5LQLLIcWrKK6S/EW2hsWFvF36wNV3FZ//Yu
X-Gm-Gg: Acq92OFXVQ+iyQlAitL26LfBjbDsUwhBBIsFYeGYwnBdTD98OsiobtxDUH0fnAd6Jyu
	vHSGziwDubnVcYEVifWfZHacD+JQvt1VbGkMAuRkFiFdg08WJSvn9pjpDe2pZAHiEnY1YHy/2k+
	4qNPuqdm5JDqmzJCRnbzDc5TtbJrs+q9fMZrVRKoVrTMFRG/Ehx/YdA8Qk07ATi8W4HEMM+uyrC
	Ep87fmfjSAJ43x51kMj95bz4lutrQnSehxgDR5vTOr0jZtRIba34pkO/Hbp5nxhjJg0QDwsBRDt
	9qcX6lFz61vGJXfZLJDIjPw+9SoJ4ogSgqFnoHqVdj7ABTMDGuGMnEF8xoodm5kI0YNtPhvZ7AB
	W5ffQWIwYnaZGtrfVHTpXacOjqsMPDFnP0QNU4k6LKmIZh5WtcsGlMGrDcD1EGH4qI90huLz2p0
	kF8pKr0dQnbXGH2zGR2GLn4RGR9OzKxI0j+D1uUz6TcrP9jFxIB+pfILw67Nc=
X-Received: by 2002:a05:600c:548d:b0:490:afc5:f94b with SMTP id 5b1f17b1804b1-490b5e8050dmr32650395e9.28.1780469866661;
        Tue, 02 Jun 2026 23:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:46 -0700 (PDT)
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
Subject: [PATCH v17 11/17] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Wed,  3 Jun 2026 07:57:11 +0100
Message-ID: <20260603065731.93243-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for the RZ/G3L (r9a08g046) SDHI controller, which has a
new hardware version register and also has different tuning registers,
internal clk divider, 11 bit divider, 3 resets and 5 clocks compared
to other SoCs. Similar to RZ/G2L SoCs it need tuning delay.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 23 +++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 42 +++++++++++++++++++
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 699872766f88..ee1b1f70c9e3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -59,6 +59,7 @@
 #define SDHI_VER_GEN2_SDR104	0xcb0d
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
+#define SDHI_VER_RZ_G3L_SDMMC	0xce10
 
 #define SDHI_GEN3_MMC0_ADDR	0xee140000
 
@@ -79,6 +80,7 @@ static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 		break;
 	case SDHI_VER_GEN3_SD:
 	case SDHI_VER_GEN3_SDMMC:
+	case SDHI_VER_RZ_G3L_SDMMC:
 		if (width == 64)
 			val = HOST_MODE_GEN3_64BIT;
 		else if (width == 32)
@@ -205,7 +207,8 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 		goto out;
 	}
 
-	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
+	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock) /
+		(priv->info->internal_divider ? 2 : 1);
 	clock = host->mmc->actual_clock / priv->info->max_divider;
 
 	/*
@@ -265,12 +268,14 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
-#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
+#define RZG3L_SDHI_SCC_HWADJ2		0x010
 #define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014
-#define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016
-#define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
-#define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
-#define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016 /* R-Car */
+#define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018 /* R-Car */
+#define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A /* R-Car */
+#define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C /* R-Car */
+#define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
@@ -393,6 +398,9 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	if (priv->info->internal_divider)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ4, 0x0);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -727,6 +735,9 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!priv->tap_num)
 		return 0; /* Tuning is not supported */
 
+	if (priv->info->tuning_delay && priv->tap_num == 8)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
 			"Too many taps, please update 'taps' in tmio_mmc_host!\n");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d056c3586e6f..fb8a70d28eed 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -89,6 +89,13 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 	},
 };
 
+static struct renesas_sdhi_scc rzg3l_scc_taps[] = {
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
 static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY,
@@ -104,6 +111,23 @@ static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.max_segs	= 1,
 };
 
+static const struct renesas_sdhi_of_data of_data_rzg3l = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rzg3l_scc_taps,
+	.taps_num	= ARRAY_SIZE(rzg3l_scc_taps),
+	/* DMAC can handle 32bit blk count but only 1 segment */
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
+	.max_segs	= 1,
+	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
+};
+
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
@@ -217,6 +241,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.hs400_disabled = true,
 };
 
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg3l = {
+	.fixed_addr_mode = true,
+};
+
 /*
  * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
  * So, we want to treat them equally and only have a match for ES1.2 to enforce
@@ -243,6 +271,13 @@ static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg2l = {
 	.tuning_delay = 1,
 };
 
+static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg3l = {
+	.clk_mask = 0x200000200,
+	.max_divider = 2048,
+	.tuning_delay = 1,
+	.internal_divider = 1,
+};
+
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_bad_taps2367,
@@ -296,6 +331,12 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 	.info = &sdhi_hw_info_generic,
 };
 
+static const struct renesas_sdhi_of_data_with_quirks of_rzg3l_compatible = {
+	.of_data = &of_data_rzg3l,
+	.quirks = &sdhi_quirks_rzg3l,
+	.info = &sdhi_hw_info_rzg3l,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
@@ -309,6 +350,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a08g046", .data = &of_rzg3l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
-- 
2.43.0

