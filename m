Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E924352030
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965135; cv=none; b=MSLUEcYaI0u2MEf9vCUtPXlEA22SMrnQr1V7xW599dgUb5QY2iN5bCEhxCcgxHTXJazzegrVrE10y02ZJR7mKDrJTBmVM3vdQOa/EhTz3m34j9YlTwPQhj5FsTsVwb2JvNXylpJwdNJvDOnx8XJt4uckC0rNR1EZ3F/edUooxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965135; c=relaxed/simple;
	bh=htdrSJftSkmMNibLYGV0Bicscode4YlmWbF5QiTo+ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsZVyFLn6GpT6H1F48pKXv0yctplMOAiCg0FfTNIuiEOj5/CY3ePlV2/vWfj9qfExE9fV4nRmzlSaxQfGLBlrlWMOvltMLLUcOZ9Mtnc/CRnSF113AfEmFzfEiOCHZAVbWOFtQFQkVWX0MkhSLnwdeiMdnnCijvOzEbK0ZE/5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDnScFO/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDnScFO/"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1937511f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965130; x=1784569930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVTWFeljHSjxUtnRnkZ30TyfY3T5+xBesFGu0z4Pd/k=;
        b=PDnScFO/fyAvyJP1TAbuJa+EnHbyOY36gpj4qIO2yzJirrRIt20/O22qaXzGw2wXCE
         Ib459hFke6vg861DzdLkd9n7HCs2Rtk457Wp3PE4XR7T2D14mQ1GyW7btVGBKsDpbnVk
         Xkly2WPgjfSkJc9X6JUkvf33AJ6sv1ppRfgfnBz0UCUmvcOAM3CUE/b1uTa2bTz3yvvy
         Q5RUxzfQsg5v89xKIuNZsZYZRZyZKsSajfZQ+ml7xHmZ3htOtWrCeRz3XDXFdtloY4pK
         URgfkQzz9u91efGHzO3CJVYu/2kdZjOSgzJxmhphD62WgCfS4qpU+GFqmkQs5oM7TPHn
         /dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965130; x=1784569930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVTWFeljHSjxUtnRnkZ30TyfY3T5+xBesFGu0z4Pd/k=;
        b=FxrwvJQy6r6WkUdnP4ndKF5QTwhTMSoCywLechINuD4tioR6VJoi+4aqfk39WAtew5
         K2LXDHd7NUEs28ninC5I9+mn4w2vgePOY4C1Bu1uLeLOcTJn3FOyWeiuum9QZoJ/yFgJ
         g5/doyMM8WMpFaAEScUxrhxSmPrxVm1JU1YUBPlyl41tFl3CPy+TBPC1Q1daQf5qaL2Y
         Aj/L1ze21Lyy8q3QrJ9dW2HCBJlQnyR0MIKyKkjjD6trWV8J/m6EPCk/NbnweYRZJRQa
         kW2rkYbKSwTK2NTrO3BYIxEdADCg3rHSMTKdMgB/Ca0g35WfrKKzBhXhKNb16GLHB8Yu
         s/qQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOM1qaB5Octv1WjpDkISDnDTI7oC97+AEMn5WuABvbSgvr82EDVscpxcXegRD+eRIU0xOEIYCZ0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwm7JzyNuDWo/In4maJ1Z5SwtsUB/c8A7vIdnWNbbl5z9S0uKB
	yKveGmcVjNgEhFvshNV59I2glmSViYX2VpwwHpka9wUrfDAZC66r+BOC
X-Gm-Gg: AfdE7cnqWTnRYV3dcIYzf1Sidr33PhgvtCyo2HPfnvk/B2PTu0FEqNUmweIgoJ9YBKL
	lJcWTgmEO8+BK123L4aTUh1gx7tTRx5ub03Z5O1OjMWt00qtw7ovd4itC9kVDJ5OkXcYqhybCVJ
	9evG4K8/v8exwbR8e+Xa2I9hTjPJ5SHo3O4NXdYoL/KU1Scsz2nzYmR5e7yNF2hVmnZaZN78pDh
	NYaKK0g5IP2pTkCxH2MQsgSJXKJb5orkPOKU14kG9pOhJTweToH6x/BPZy4vWqke4euzjth/RH+
	QH5mxNXLc2FmGAw8WRNmfoVDgCsR2HG0sBpwBZgPeW1MwojaRUvRCqTQB34sjAKjc/Tm01+j/BC
	lSub29VritXw8dWvGjnwjkPBHBLM6iFi1dKSwZrMQzxT4sSxcIWDJ261emKlA86liPLx/F++W4u
	2WITpFIevafamoKcXgqycso/+USEAznSaFun5MjQ==
X-Received: by 2002:a05:6000:184d:b0:475:f100:3609 with SMTP id ffacd0b85a97d-47f2dd09355mr11469171f8f.56.1783965129499;
        Mon, 13 Jul 2026 10:52:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:09 -0700 (PDT)
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
Subject: [PATCH v20 08/12] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Mon, 13 Jul 2026 18:51:49 +0100
Message-ID: <20260713175159.138334-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC (r9a08g046) has an SDHI controller with several
differences from existing platforms, requiring dedicated handling.

Utilise the TMIO_MMC_HWADJ flag to identify controllers that carry
a second hardware adjustment register (SDm_SCC_HWADJ2 at offset 0x010).
When both TMIO_MMC_TUNING_DELAY and TMIO_MMC_HWADJ are set,
renesas_sdhi_set_hw_adjustment_delay() additionally programs HWADJ2
with 0x3FFF at 3.3 V and 0xFF at 1.8 V. A new RZG3L_SDHI_SCC_HWADJ4
register (offset 0x022) is also cleared at the start of tuning when
TMIO_MMC_INTERNAL_DIVIDER is set.

Add a new version constant SDHI_VER_RZ_G3L_SDMMC (0xce10) and extend
renesas_sdhi_sdbuf_width() to handle it alongside the existing Gen3
variants.

Introduce of_data_rzg3l with RZ/G3L-specific parameters: a wider
clk_mask of 0x200000200, a max_divider of 2048 (reflecting the 11-bit
divider), a dedicated rzg3l_scc_taps table, and all relevant tmio_flags,
including TMIO_MMC_INTERNAL_DIVIDER and TMIO_MMC_HWADJ. Wire it to a
new of_rzg3l_compatible entry using sdhi_quirks_rzg3l (which sets
fixed_addr_mode), and register the "renesas,sdhi-r9a08g046" compatible
string in the OF match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/mmc/host/renesas_sdhi_core.c          | 33 ++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 37 +++++++++++++++++++
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a4e822f141e8..42548f5fa2f4 100644
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
@@ -235,9 +238,18 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 
 	clock = clk & CLK_CTL_DIV_MASK;
 	if (clock != CLK_CTL_DIV_MASK)
-		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
+		host->mmc->actual_clock /= (1 << (ffs(clk) + 1));
+
+	if (host->pdata->max_divider != SDHI_MAX_DIVIDER_DEFAULT) {
+		u64 tmp;
+
+		tmp = FIELD_GET(GENMASK(9, 8), clk);
+		clock |= FIELD_PREP(GENMASK(17, 16), tmp);
+		sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clock);
+	} else {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
+	}
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		usleep_range(10000, 11000);
 
@@ -273,12 +285,14 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
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
@@ -328,14 +342,20 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
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
@@ -401,6 +421,9 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	if (host->pdata->flags & TMIO_MMC_HWADJ)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ4, 0x0);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 8476678d47a6..e78dbcb6c887 100644
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
@@ -161,6 +168,26 @@ static const struct renesas_sdhi_of_data of_data_rz_g2l = {
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
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
+};
+
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
 	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
 	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
@@ -241,6 +268,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.hs400_disabled = true,
 };
 
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg3l = {
+	.fixed_addr_mode = true,
+};
+
 /*
  * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
  * So, we want to treat them equally and only have a match for ES1.2 to enforce
@@ -300,6 +331,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
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
@@ -313,6 +349,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a08g046", .data = &of_rzg3l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 6c512e96e192..e6663cc736be 100644
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

