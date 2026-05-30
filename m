Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB5342530
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157324; cv=none; b=PrIq8pnQUPNxcvfGA4YGQMWQu1BCsWMvhErjXGR1d7TQQ17CHNUCqXDBiWP3LoomDeABYmEReBCDijgIhAZMy7MBq5oViAvBbEHJT5xbDrbWJq2LdFxNSqiGcSDwrMidUjipMaSZCURva/LEo4YopxKj/u1/5yThVFUHsT28j+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157324; c=relaxed/simple;
	bh=MOeZzD89M01JUKdu/mbGWHPqElMHRlF13oq3pX+ClBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD6dzF3s5WlbP548E0ZLi9RLeZMelAHFctyiScSZX5m/Ty9299kAy5P+B0wJ0IeKe0nosX9epTMxhrt+omksbK4eFkRb01SRGSlbzLky/13oJkB13shQR1ApfxTLWggEMflR70WuzElUowBLGYrOe6BgdqEURxhQKN9mHLwFLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0G/1JK7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0G/1JK7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so156802245e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157319; x=1780762119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4aMOzmEL8d/PQOQgkUdqSkefep9L5LAnFLPYwMlDAk=;
        b=o0G/1JK7/7DU84SswHuhOqd2x8yTX72++aGcZbep0PLe7dYpPbGN8czfH4mn9be239
         0Eu5gM7rUaYbO9iTwYlz2O+WfNP1kGCM+rKEG7YhWZ/cEoy7HWhBz13ShPOPJ27thAim
         s5GBhGhbPDWkmSiaHAyV/DJm6iY6nkug+nljYo0Pn+fjq4kTgmo6ksh4OgTIKn/t7CE/
         opAFQJr8nIbNyLdqzyDGYE9l5FBzudLYSVRFPXVeYJRzKjrkHTRocMLeym8vkb9P6gKD
         wf8/dOzpkFaZgMmbzTOxjj2mltkNsBMsF12oFe+viNvBiBd6jg3wgBK3owfCBKInB2VX
         /Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157319; x=1780762119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4aMOzmEL8d/PQOQgkUdqSkefep9L5LAnFLPYwMlDAk=;
        b=Y2VCiYzI9kDKtkHTLYL/wc40zMUr2D3t1n7yB+3290Kox4rYw1DtJthyJDOkIMRj7F
         4nJ3HbikmePOnQHpLpsgj9H03I+MOx6/u1DccMsNlLbdsWMAIzgZfZREs59WdJtxFi//
         OvV0QbxbidctJxPex2NwlfHthu69W4MuLbSvAnZNfiIuhEczrpWQn90wFXLLoZhb1+DS
         7O18GGsLEMHI00Mub966GK4AqKTSr6H0uFtq+OA052VwFZIcT9CqUlPYur2Tvj0+7VlG
         UL0mu/3laHg2sLV2w9YwAIlhQ6xIS+uytIZepzbiefYldh8qYVm/BVn7R/UMqdDAmJCo
         cGZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Dd6lSApsLXQpF6GZdyNr8j7/RcZKsV26XAxuQo1rRxyCIeDLHIXrS3Urp1gdF7bxi7EI1FgkBYBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6s2RdEkLNtLNEySCF3BWw4KQVsYYbYvlWkM6+g9lGMP8uLrTQ
	f25p/uEf/PPaHx+xHX/toBP3yUPwFN1SzM07hIW3ZJ7iPGKNsUDBIFno
X-Gm-Gg: Acq92OHMSz1cyK3eQK/Ps51oO/ju12SvLKcNgXXv47R0Sl5+x76U20sY5JQJ3Un7umW
	vCExwWvV40ATLbTcpwnGCZe8rwxxjsVcxgjoXA1/hEwSb6VwsSQdE3jhKZKnublGp4qn39RaqNK
	TdGVFJ/uJSYdw5dkxHqnuVqwv+bOZxd/zwfrS4IhHgI9p6X7w7inwqsBm2W/hqnkjrH7fXLW/fS
	qNBorjWwEYgK/8Zv0MDgPfRtN4T175HmeZ/PpG6XnRXM1A7KdpjHhT11LAKyicqbwW4G5oS3SD1
	Dhkm8Ha9ouUYlaEn6TxZr4c1NoBkwH3XRXmZ1HebULbq4Uu9R3ESgU7BWkCxUq+3yfA+/vecg8V
	dD4l8pMMjJsGLVkPleyijxgVEVjNKoYaK4Z4oOMdSH4xN7HeKyBP/Smizq8TwcKQOjj+sVBkRnf
	GKfN926tdoxihiS107uy0iudNTEGlJYiDHUTlqP0OPZ5+wE4bdAwgKarQ8wFs=
X-Received: by 2002:a05:600c:4703:b0:48f:d1b8:9ab1 with SMTP id 5b1f17b1804b1-490a2915af8mr78625975e9.9.1780157318877;
        Sat, 30 May 2026 09:08:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:38 -0700 (PDT)
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
Subject: [PATCH 11/17] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Sat, 30 May 2026 17:08:05 +0100
Message-ID: <20260530160823.130907-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
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

