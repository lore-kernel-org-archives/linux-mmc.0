Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE741DEDA
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411138; cv=none; b=OGDh7cxZHsOgX/TFMBLDodRdVczev6h4+iOCOLKFuO+SVR/SlhIPeF3wz5l6BtH+y6qsqV0H1b6DO4CZxBjR3ujKs10fKhtME8ALxKpHQSKZARDIaUVeeamCpcZzo8fhq09U5qveImpAm9g4hv7PMdf/iZRgFWYT5WFopCReA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411138; c=relaxed/simple;
	bh=e0N3gDQ4ZGbZi24fypV8QksC1p8Br0h+H2qfCWMXIVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkSlo2eRKdscUM+eXRd/9EVLXZPV72QItZAID77hJGkRZbhsF40M1ld9+i91qnWEfQbumvq5kR4pukSSsKRv9W20feGQPS+3PVJ4lPylvkrYV9YIDN5v3JJrkeWvlbNUSdcX4oR2o3W0Yi3edP7yHmpBai/33epnrf6o8KvSOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwSz9naP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwSz9naP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so5493505e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411133; x=1786015933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S0H4W3moUOHeq9l9TrPV44kL3gzANH3gjaZQO6MNZQI=;
        b=nwSz9naPGY34RYcwdoSWdrWHMrpy1sJrKuftsbUwaf7VgimHrXyBl2a7iWi6Zq/boE
         KMamajm9qGOQgEUlpYoQXEbRC9iQrLPihca5uRZb7TJMTHFvc092SaMmNyeaJA9ptufL
         LAsvX+nn5fWe3aTPI1tGiDbhbGO4EoL4Q3fCSrHtQEUJuEYzHPY+DLyy0G8w2WeCVOTP
         ZZyE4jwcadjDDODKSNVrtpsR1L6q05UEXkr7YHhorLTRVXAelUDDPG0VedZwHS5bkL7c
         kWmz5FVvanSX2BWGPxK2zhYc/uIadxmh2SkY9QgGbi7hLYivv8f+9aaXXmA10eIk0QOJ
         r8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411133; x=1786015933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0H4W3moUOHeq9l9TrPV44kL3gzANH3gjaZQO6MNZQI=;
        b=fnxB71+VGEzPyY2tuitItTxhgTnsxtry4hXQzO1GsshGCNfYwZhCM4Mo0aWtTyO6Va
         nTIkjuFN3fmuT1qAEAz8UU1YjY7T3Y2PGFfxmHQvHXls1ApoPfUW82Z1rhq4uJlZP7R4
         QlsjvXOWxrcNRfohFgT09dsuTxeT3mlJarWL+zcIFIknKYfEA5PkCV3X3jGTE3M2FLIQ
         8u+wjiv8F503PvyE5gZ4ZSnJgvwRf+n6AWSdYA2jqVMnba8tgkr66wlbYOWTrkvj7tP7
         NMo9v2IDiaXgyngDQryyg5G6PB/SIW5MAILGHRcJRzR5e05wILXaM/u9C851UyKkCluD
         mVqw==
X-Forwarded-Encrypted: i=1; AHgh+Rrcg7hCipkAXelsUClM6p0QM+/InfnenBqtvEwgKyAgOWIYir2ze6nkCw4UgOvdgfo8rXxjJ6J9hgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXl3kbuOfFmKeijt58+RMJWm0JPEVM7rUtyNpQedGuPhU+MtOz
	DwEz9p12kZKe/zN5t65ZtIfCJUk+E+8cnvLint/C9KdROhobGSNg4c/A
X-Gm-Gg: AR+sD13SfpfJQhUPqRB+A8bDvTB9HiKvZ7LAvMwtj/2gI9ewXGv2irvGi8HxxlD4pJD
	pmAeUhIwr4VIQ0pwAdyS/AQVe7DiCsIrwoJKMO0ZHOFBvfSRzSt0G1XTlTWLqxU9OVqcLffSx6T
	s3u7ik88iuAzZreRp8d6DX8DNZLcxBqO2Aq+j1G6G+Tup2Vc4QkF6JQFm6TESI0Nb3iHSYqmhuo
	UUVMc/sOWMF9H2j6YhdTafog20H8atU//+By7R1hJe9/akr9ZDQcKtvs34Ksm02BcadNkueoF1R
	KFkwVFhBHxC/HrZx8JNY1kcNizitOKzEmdACOFUx2t0ij/1/G0cSd29RWikrDCNqrK5z+9EVL61
	WopBSdwdi12NTPyQRGCS2H8XsuznkZC2hG25bm1nDjru5Bc8N94UaMWEJkQOYIsybXIQ2ZrAuOd
	Qdn6WJk3xDgTtRY6Fhen/WRLZVgxHkbSLdHCTdKfZt2mBlLBx509OmCO8J8lc/bJJ86GzYasz+1
	r5iWacGcEmx0g==
X-Received: by 2002:a05:600c:a206:b0:495:7a0b:3b18 with SMTP id 5b1f17b1804b1-49801ed8860mr17664515e9.4.1785411133272;
        Thu, 30 Jul 2026 04:32:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:13 -0700 (PDT)
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
Subject: [PATCH v23 10/14] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Thu, 30 Jul 2026 12:31:48 +0100
Message-ID: <20260730113200.36456-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * Updated tmio_mmc_reset() to handle 32 bit divider register in RZ/G3L.
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
 drivers/mmc/host/tmio_mmc_core.c              | 13 ++++++-
 include/linux/platform_data/tmio.h            |  3 ++
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ba109a15b47b..65002e6ebf9b 100644
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
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 775e0d9353d5..8a34f7d29396 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -182,10 +182,15 @@ static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 {
 	u16 card_opt, clk_ctrl, sdif_mode;
+	u32 clk_ctrl_32;
 
 	if (preserve) {
 		card_opt = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
-		clk_ctrl = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+			clk_ctrl_32 = sd_ctrl_read32(host, CTL_SD_CARD_CLK_CTL);
+		else
+			clk_ctrl = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+
 		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 			sdif_mode = sd_ctrl_read16(host, CTL_SDIF_MODE);
 	}
@@ -217,7 +222,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 
 	if (preserve) {
 		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, card_opt);
-		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+			sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clk_ctrl_32);
+		else
+			sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+
 		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 			sd_ctrl_write16(host, CTL_SDIF_MODE, sdif_mode);
 	}
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 8d435f7690a5..e2273a262a23 100644
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

