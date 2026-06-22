Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DD3CE4B2
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143787; cv=none; b=u7hZ2WAOuOXm4xMjdDJpgI7vI9V0W7ZQZ0CwCeJL7WIwGvN/59IJWL9eWBrHQ0GYJvXHqBoTMyj3X1eq6a9fv8FIV1UFD5MDPre5PeGjkQmETivYaeyuNCjBbXPxk17e0IJmBTVsvJ96Ih27ejr/pvgmPHg/S6Qwc4N0upekqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143787; c=relaxed/simple;
	bh=q79FjhgHQEDsmDffRlSw8MedN1Ja9HRPSaThIq8InOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng+DkuiDiMolt+eWq477/nIoAOj/76tFtXoWr8cPWus7FvWzeDgQLZhIIaNuLSGvKVLc7q5KxXWgBQaGPS7E7VCZrf9ywBMZsu8DWXzVB6wqjO9SPaTwSMO0N6bi8VxoS/P8Fk/b0sMDP59SyIBWqfAqvczPj+M9+MI/fwpLqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmfI3Ahh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmfI3Ahh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso295035e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143783; x=1782748583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26W5bm20xxXPvYh9zBnnA32+mtO9zhFS2iykiCYny4g=;
        b=rmfI3AhhfkhjZee3cJsoW1MvjlIYu7Nl6MCzpvE2kDXZBjqL9bNJ5Da1RXfY+OKCKF
         vuHbepHoVqLGuR2kU6ThZyZr5ox1x+lR30UdhZ3nHFifzXGG7Luw5z24doqWh3K4z6Le
         glYqAVYw1PAwgdTcqhI19a3xHGTq2pbmu8YwcPFuYxykVsI4AP+yadattDgs3vgTWWoB
         7lLW5HxYiGRoqGVURHBtlGg4Cce2uATKX6wF2ItqRogGJ+ZIwXa31Cj3lOSOoqBkcZ02
         tUVpDLMmKpf8ssysurezQhW5vefFmCM3IEzXQLZ86hktIm5pnkGZ/da6estsA3Pq1XsO
         N3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143783; x=1782748583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26W5bm20xxXPvYh9zBnnA32+mtO9zhFS2iykiCYny4g=;
        b=cP2VoDQoP11+TatVI8A6fIyX8757sM1YAWnokWVsKtXCz5iPRQNi7+8gLuFmUgPVpT
         xKri2Pm0UjwutHLzUI6mWOf+NRqDgu4tUbZW3TynLirSFp1/qirnGCgI7qJ2nGsjmQcK
         w9jefqHQ+wy2NG2613rc6xbExHmDC1plB6HF3zPSh1j9zY2JvOqiUOJhb5rj/GK6KOgj
         LYFkaI8ws20DyDUBovggzLwsUhzf9HA/DrRMPzFwnDJ1exhZjJUEpxxUpNlMLCFg8WiX
         N4XdDcxtjLhVdpJFVcbP7i9gHcy6kam3LAYw+2j7j87xU6wTrvojzK9mq2cTGx/62N9T
         cHsg==
X-Forwarded-Encrypted: i=1; AFNElJ/I0+Q1qvN5LNjzjDItJlZgwRtU3Hb/+fU1pEv+oxbDpWRhn3Pywh/gZ2nPBSumGRitu4NAfY99jHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsH9jEQxuEjaSw/UhwGRdA8sK37yzYTcjpx+Hc3Z1GpStnCcY
	bUatKuDP6uYYnj9tWsTGHm78dtyUgEdUA1L96Al5/sY4KULv4MaeMpe8
X-Gm-Gg: AfdE7clkuHgvxc9Z1UokTiJU+YrqHZe10soDLjNVvGJBPWYEuaqkaBK9I/P5iHiTS+X
	fChMELvsqLoxhkEAn1WEGGy7HFBQE9GfmSo1Jlwa90anMYjtZx71aKhGFbRsUhZZfUnmCdGJIlQ
	6KEOPvXtyo1fQ610hTNSb70z7S9qGTrx/BBQuHilCXJ8IHfPh2eLEmh4DW/iTshMlJCMJIeAzPC
	ahlvrBohhyz/LeVoBP8h5B6gHNthKcnMYmP472yM867QCobLP13KWhJFxh5bo9/+jNcs48Aor6L
	6HowKF6UYm3n22CK7KBiUURIV/j0D/YkuG+eL2ox9R5r5yl6v83hFl9VC02ebOaoQRVTft6tGtJ
	CQa4+EZc6/RDz+FDGAEjUG9OtbMzunVTkU21Bw06X/carYrcn9GFbZUZdXF3XaIQE4AtiNMjxPY
	HXUQ9OoLgQH7tXJJ0zDFyOm4/2ykxv8nHYx85tSg==
X-Received: by 2002:a05:600c:480f:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-4925a0c4f1cmr780625e9.13.1782143783001;
        Mon, 22 Jun 2026 08:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:22 -0700 (PDT)
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
Subject: [PATCH v18 08/12] mmc: renesas_sdhi: Add RZ/G3L SDHI support
Date: Mon, 22 Jun 2026 16:55:59 +0100
Message-ID: <20260622155610.184271-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
References: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC (r9a08g046) has an SDHI controller with several
differences from existing platforms that require dedicated handling.

Introduce a TMIO_MMC_HWADJ2 flag (bit 15) to identify controllers
that carry a second hardware adjustment register (SDm_SCC_HWADJ2 at
offset 0x010). When both TMIO_MMC_TUNING_DELAY and TMIO_MMC_HWADJ2
are set, renesas_sdhi_set_hw_adjustment_delay() additionally programs
HWADJ2 with 0x3FFF at 3.3 V and 0xFF at 1.8 V. A new
RZG3L_SDHI_SCC_HWADJ4 register (offset 0x022) is also cleared at the
start of tuning when TMIO_MMC_INTERNAL_DIVIDER is set.

Add a new version constant SDHI_VER_RZ_G3L_SDMMC (0xce10) and
extend renesas_sdhi_sdbuf_width() to handle it alongside the existing
Gen3 variants.

Introduce of_data_rzg3l with RZ/G3L-specific parameters: a wider
clk_mask of 0x200000200, max_divider of 2048 (reflecting the
11-bit divider), a dedicated rzg3l_scc_taps table, and all relevant
tmio_flags including TMIO_MMC_INTERNAL_DIVIDER and
TMIO_MMC_HWADJ2. Wire it to a new of_rzg3l_compatible entry using
sdhi_quirks_rzg3l (which sets fixed_addr_mode) and register the
renesas,sdhi-r9a08g046 compatible string in the OF match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 20 ++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 37 +++++++++++++++++++
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f3ce29cb3053..8e14ce3ca7ba 100644
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
@@ -264,12 +266,15 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
-#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
+#define RZG3L_SDHI_SCC_HWADJ2		0x010
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E  /* G3L: SDm_SCC_HWADJ3 */
 #define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014
 #define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
@@ -319,14 +324,20 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
+	bool hwadj2 = host->pdata->flags & TMIO_MMC_HWADJ2;
 
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
@@ -392,6 +403,9 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ4, 0x0);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 93219706a4d6..9cb69003ac96 100644
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
@@ -162,6 +169,26 @@ static const struct renesas_sdhi_of_data of_data_rz_g2l = {
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
 };
 
+static const struct renesas_sdhi_of_data of_data_rzg3l = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ2,
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
@@ -242,6 +269,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.hs400_disabled = true,
 };
 
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg3l = {
+	.fixed_addr_mode = true,
+};
+
 /*
  * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
  * So, we want to treat them equally and only have a match for ES1.2 to enforce
@@ -301,6 +332,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
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
@@ -314,6 +350,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a08g046", .data = &of_rzg3l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 6c512e96e192..96eff17179cc 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -56,6 +56,9 @@
 /* Some controllers have internal divider */
 #define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
 
+/* Some controllers have hw adjustment delay */
+#define TMIO_MMC_HWADJ2			BIT(15)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

