Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390424570DE
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819458; cv=none; b=Kcxb/ioh3BoqCtwcD1CbkK5yZHIqTj7V5YJGsh1T03vdim1kPgZ1h9hjIjWNGu1PhDdzphi2XHaflV++jcoBeqkEoM015LK0YsAVgjE+2ZDn0/kUi4VUnTj6yzSbZrXEnvKtCWYVxVICJ5j8jNMDcwYxwZXbduog+IxPc5XbW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819458; c=relaxed/simple;
	bh=WboOCyDCF7AbvxHTCR948lEfX3IziVYEAqZ+3x0HLQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXt/Az+rNTQC9YFcAiifKaIxcb31wFTsaBo5KpQiECW+QMGIOJlzdPf5/+pCQu8ozhiVL0LqYFCDarmyx0i5KRa/bmzv2MS19NWki/OGoQLmh46luDDhncuzI07uvyea/UE22KkM5zvEdl3ecJqzPg63s+OeB48xPlGyx0JbMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwnuPjRe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwnuPjRe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f365afc5aso490983f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819435; x=1785424235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gLTGrjF5l+5jbKrLDleaB4qZYjxxCzgzovbSkilTIE=;
        b=KwnuPjRe2IM9r9HgTLQbMIjlSC7BaI57dFUen7ksj8cumnIQMLac4Gr/VAB5nEYlun
         6fdL71AWsE2OE1bfIJv7qrOUerfhzVoQQ2SXEWHrdzIljwJ0KlVOBl2mVuqfb0IaUzkv
         Hm7Gncc60DbdTuJJvATzGvy7o90TUQHXR2lE4gNTr9erT3yFPvzQkRUozQ2kmJTeO1jm
         v55heOM6EpWk+JnTPOW0IEOK1RanqJjpdLT0cTJk7FJJtc/6nFuqTUrbQXX8ptPRsRlA
         f7q81cYkM5oINkImviQGH03hZ5AoI28+eXadgEmMmLzNvLiPekbGLI09PiR1+bKSXMoW
         GZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819435; x=1785424235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gLTGrjF5l+5jbKrLDleaB4qZYjxxCzgzovbSkilTIE=;
        b=iJglCRbBla4Uyhtg0Y4oRjIr+Re+C5VzWQL0qrqQ+JMefyG4ayBh7eAr61E80YjAF6
         T4hsQ5hk9G6F1b7nLsdZDRElUYqQW+6gbjtd/OBKb6lvFbZYVJLgC/8I0OpUzuoLBYBM
         U5K8Td9yOuVs17Z8wiqDJ3ZgFV7MpOhuzTmxyUrKW31uPrVHk6B1F1ltV5dQRQ/ou4RE
         ZWRZ201PHMpFeBjqsSm89xX1E7n0P85WCY+L1KkA+zpzSQJv74VDMnc4nK+e2XCqxTEl
         9mTqCMYKfQ9grSVNeU8V9HX3MjrMm2K4XYTpsKixaGHok8e+eZw9NOtMoFUzDiRnFurj
         7S1g==
X-Forwarded-Encrypted: i=1; AHgh+RrR3iiq/DKzzBQmkkNZiVjCK42Be7IgE/tTxQkYUqRF+plBATf+t0eMGWzJvdhAYwK2OF6Ltu7YORE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaHqfN2YfFcG27hdelKe1K5vO++XRk6LdhNNlhmzOQHVbk7aV
	mCkE6eb30PMBqGCFXQhBgO3YViaSOj1DcQqVS6di+GgeCWV9B09m1Idd
X-Gm-Gg: AR+sD11asPfnn24fXlwlbmb5QXxS+cwTpY3amN9iFdVdqytXM5aH2M+fmrykIfD0z8v
	b/yTx50O1dXybiYrwvFzm6aKTdZgeTuGix6qU4PVwHZvTt6L3p3xkUcgwgmYARkTe9Q0Ug91mdD
	c2Zs1UCMWmDknWkZb6EuXdpRbUowokuov8sADbzTM/r+Qjyp8qrzKLzukcc4efqSrCGYdCbOKCO
	8hbWwgqfCS5L5LwU/GsLRtDRfHF+B+mNXjKr2xqpnpEoWCOrn4tGOLiIbkYGkj9cTHOsmqCmH1R
	c9CxieWAhHDNtVFHNHxkMVveQKNXA2i9tvT1l6Qm4GME/578rBSnK6WFnsf5Och+1vuySdidxjD
	DKRgOol49ddrtCqCeu/BLTwrHqfgFJyVaGqQ6tMWfIxx54w0UR+mQQ21kqzC0bsbRvhQAVTdarU
	eAXsSJRcAoe0Ug6ncffcLL0xYEVgY2bV5+b0ifzA==
X-Received: by 2002:a05:6000:18a2:b0:475:f0c2:5afe with SMTP id ffacd0b85a97d-47f8dca4f76mr4335892f8f.52.1784819435021;
        Thu, 23 Jul 2026 08:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:34 -0700 (PDT)
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
Subject: [PATCH v22 09/13] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Thu, 23 Jul 2026 16:10:13 +0100
Message-ID: <20260723151024.318918-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L (r9a08g046) has an SDHI controller that differs from existing
platforms in clock divider width, a second HW adjustment register,
and an extra tuning register.

Add TMIO_MMC_HWADJ to mark controllers with a second HWADJ2 register
(offset 0x010), programmed by renesas_sdhi_set_hw_adjustment_delay()
alongside TMPPORT2 (0x3FFF at 3.3V, 0xFF at 1.8V). Clear the new
HWADJ4 register (0x022) at tuning start when TMIO_MMC_INTERNAL_DIVIDER
is set.

Update renesas_sdhi_set_clock() to write the clock control register
with a 32-bit access when max_divider isn't the default, moving bits
[9:8] of the clock value into bits [17:16] of the register — needed
to drive RZ/G3L's wider 11-bit divider field via the max_divider/
clk_div_mask support added earlier in this series.

Add SDHI_VER_RZ_G3L_SDMMC (0xce10) and handle it in
renesas_sdhi_sdbuf_width(). Add of_data_rzg3l with RZ/G3L's wider
clk_mask, an 11-bit max_divider of 2048, a dedicated tap table, and
the relevant flags including TMIO_MMC_INTERNAL_DIVIDER and
TMIO_MMC_HWADJ. Wire it up via of_rzg3l_compatible (fixed_addr_mode
quirk) and register the "renesas,sdhi-r9a08g046" compatible string.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description.
 * Added `clock &= ~GENMASK(9, 8)` to clear the divider mask bits in
   the register value.
v20->v21:
 * Added clk_div_mask to RZ/G3L of_data.
 * Restored actual_clk calculation in renesas_sdhi_set_clock().
v19->v20:
 * Added bitfield.h header file.
 * Reworked on renesas_sdhi_set_clock() to handle the 11-bit divider
   case and the 32-bit register write.
v18->v19:
 * Update commit description.
 * Updated handling for clk divider.
 * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
   hardware tuning delays
 * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 31 +++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 38 +++++++++++++++++++
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 6d8f32e2fc38..be7720305d32 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -59,6 +60,7 @@
 #define SDHI_VER_GEN2_SDR104	0xcb0d
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
+#define SDHI_VER_RZ_G3L_SDMMC	0xce10
 
 #define SDHI_GEN3_MMC0_ADDR	0xee140000
 
@@ -79,6 +81,7 @@ static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 		break;
 	case SDHI_VER_GEN3_SD:
 	case SDHI_VER_GEN3_SDMMC:
+	case SDHI_VER_RZ_G3L_SDMMC:
 		if (width == 64)
 			val = HOST_MODE_GEN3_64BIT;
 		else if (width == 32)
@@ -253,7 +256,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
+	if (host->pdata->max_divider != SDHI_MAX_DIVIDER_DEFAULT) {
+		u64 tmp;
+
+		tmp = FIELD_GET(GENMASK(9, 8), clk);
+		clock |= FIELD_PREP(GENMASK(17, 16), tmp);
+		clock &= ~GENMASK(9, 8);
+		sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clock);
+	} else {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
+	}
+
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		usleep_range(10000, 11000);
 
@@ -289,12 +302,14 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
-#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
+#define RZG3L_SDHI_SCC_HWADJ2		0x010
 #define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014
 #define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
@@ -344,14 +359,20 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
+	bool hwadj2 = host->pdata->flags & TMIO_MMC_HWADJ;
 
 	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
 		return;
 
-	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
-	else
+		if (hwadj2)
+			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
+	} else {
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		if (hwadj2)
+			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
+	}
 }
 
 static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
@@ -418,6 +439,8 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
 	renesas_sdhi_set_hw_adjustment_delay(host);
+	if (host->pdata->flags & TMIO_MMC_HWADJ)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ4, 0x0);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1799c6106102..893d9395e9d6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -88,6 +88,13 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
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
@@ -165,6 +172,27 @@ static const struct renesas_sdhi_of_data of_data_rz_g2l = {
 	.clk_div_mask	= GENMASK(7, 0),
 };
 
+static const struct renesas_sdhi_of_data of_data_rzg3l = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
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
+	.clk_mask	= 0x200000200,
+	.max_divider	= 2048,
+	.clk_div_mask	= GENMASK(9, 0),
+};
+
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
 	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
 	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
@@ -245,6 +273,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.hs400_disabled = true,
 };
 
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg3l = {
+	.fixed_addr_mode = true,
+};
+
 /*
  * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
  * So, we want to treat them equally and only have a match for ES1.2 to enforce
@@ -304,6 +336,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 	.quirks = &sdhi_quirks_fixed_addr,
 };
 
+static const struct renesas_sdhi_of_data_with_quirks of_rzg3l_compatible = {
+	.of_data = &of_data_rzg3l,
+	.quirks = &sdhi_quirks_rzg3l,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
@@ -317,6 +354,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a08g046", .data = &of_rzg3l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 09b3411a59c9..99b05c8c840a 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -56,6 +56,9 @@
 /* Some controllers have internal divider */
 #define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
 
+/* Some controllers have hw adjustment delay */
+#define TMIO_MMC_HWADJ			BIT(15)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

