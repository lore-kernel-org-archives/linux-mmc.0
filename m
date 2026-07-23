Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1190472F9A
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819453; cv=none; b=awOau1Sr+5Q2k9ZPMXh3UgFOc7eeTMRluvRLEPSsruM2HPSCpaskfG2Scxd8u7xKfthbEp9PhbQz5lEO8GcjzkW9qTilKfYwA5GYr7BRKopeZUxYieidV2Qyryo5OPXN0DwvEM0ivV/Z1LmREFomzvK9DMVPGZyGLGzgiZJXPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819453; c=relaxed/simple;
	bh=PCJOY+SrXQMG/DlW4LPSTdvinSiJxyrmJYBwZHWm3Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsDHh/Ep5PrGFNAkmdy40omkqvMtJEJEquJ0WmeFtGdQ6vfaJDqAzFPRtAe8YIJFCzkCm/Gtbw1UT1X9++0t3dPeeBLoQvdvrYD90HXfgrQJbcM6jHlXjAihM9k7ceNd/xplQvscyVYQhr24IXCAF4JbiFtUMYS+0TpawGDGHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKgc6WKJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKgc6WKJ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-471eeac43bfso754926f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819439; x=1785424239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEFS1IWqin3uCtw5zKzNrB2pYmBiypyJyd1pfqtBYUM=;
        b=oKgc6WKJ2j7r0C4SsgZ3UV0s0xWCVfdcemlNfPfIJOGbq7aQOgjcEuXa/mIpWkfqRV
         sCOEhwZHRCr5mBV/buGWI05z4VDejgBfx2iQJboZcVin/lOyHqS2JyfxPR5Ng3NKTeMZ
         048oHWECV2Xbj/odiILoFjQVrBmHkoMEZVeGhhLq+C/3j51Wpa6VB2Bx7E3wTIr5dAKb
         ROA57rh6jMPGghA0I2qwEzeY3QZMryRNlHgPhwzhuwgQfhySdjPi0HS/hJtHFdnloQQm
         0SWQWDQTiIJUW+HsRrktd+uW9Y4vopCmGCh4kH2tECENG4oHs2Wii6di4mt8LGBDAi5Q
         72Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819439; x=1785424239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEFS1IWqin3uCtw5zKzNrB2pYmBiypyJyd1pfqtBYUM=;
        b=kOATOeUaJblGsgsPSkBBhB7sD/VWB9M+0QXkcGQlhFOuB6TVpjmHzYelIj3jmmHhjJ
         hi3vy3pxXO3bQLzNQRn1LYRSvlQc9USW/AafMpSyjeenjkLwvYozSbmwvpZp3hYbwJfL
         Xr0wwVHS63olGteVhsMiM90t3FHEqFFdvdKWWlTGA5vtPNu6OVjgchEuliK3pPQNCpQu
         xdRVYec5HRKzRuLp0b3snADQhN+nXBkV3Sh62DLYnVJczuottU3NyasvnlpV7r3DfjRd
         5q8cUDKYzUVUe4dLldbMcJTfkOTY7nNFzPsOFHi41ydwyDxI3PQ0jtzU/T3mqT+/eVNq
         4gfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOiLPt4tued5bNpX2OnPW8r2ktA2q0DgADGch1JpproMhFf0Vm/hGFuNmgV/uXEtxD9TBWsMKc3dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l+QwnJlMrketQIKRhNgAw4ZYcEFvtbxeOlMQOWfvs/mNyHh9
	nmKI/0iYT0MhxpBqpardpWMRS2la68UJQQinxPWPiNPNTBC+r6ckTgbT
X-Gm-Gg: AR+sD12L8fpkcAPVDu7ca9IlQZVBpOjJYkhI7LJoWGKLQbBRCVXkYbBaLm72OzAjZgT
	4VAgEnTJXfOpI/xGLRa8aVj7zT9lWateHuG4MuUcObsSp/eYnDHWJpMJaUfs/RhWim9o3PFRUSU
	+US+H1JjlndKqa2Dp+z+gxurtUSKrLt2Qro9mnMP7xeibf4a8n0Qmhdhh//IZgc5r3+knEv/iZd
	UqoJC5WssxN6s27KYZT2cS1DPlI+ZgvKbpSM1ttCDgBaT0vg8jeeBZjV2pCrhAg73z2m2tX1ppY
	+z8bQHOgdzuldDXyZSc2JZ+JdbUYHhHk9qT6DFSwRyitPO+6gIJN55SAhkPSa3qXu/cXGFKSWMN
	y+BD0CaZ8tTjy03MHr2bqqEWmk27H27e+rwmBc5seNEfziI1opKwLEHx10Y6aJ6obpKX75x1wlh
	ISaoPyuXVykTFs8E4NFlWARlgb3nM=
X-Received: by 2002:a05:6000:2302:b0:47d:ebab:7bb2 with SMTP id ffacd0b85a97d-47f8d75649bmr4254910f8f.31.1784819438435;
        Thu, 23 Jul 2026 08:10:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:38 -0700 (PDT)
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
Subject: [PATCH v22 12/13] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Thu, 23 Jul 2026 16:10:16 +0100
Message-ID: <20260723151024.318918-13-biju.das.jz@bp.renesas.com>
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

Add HS400 support for the RZ/G3L SoC.

RZ/G3L needs a second HS400 enable register, SDm_SCC_HS400MODE2
(offset 0x020), alongside the existing TMPPORT2 path. Add a
TMIO_MMC_HS400MODE2 flag (bit 16) for controllers that need it.

renesas_sdhi_hs400_complete() now also sets HS400EN2 in HS400MODE2
when the flag is set, and renesas_sdhi_reset_hs400_mode() clears it
on exit. Add renesas_sdhi_set_tmpport() to mask off only the lower
16 bits (TMPOUT) of TMPPORT2 when writing it, preserving the upper
bits on controllers with HS400MODE2, instead of the previous
unconditional zero write.

RZ/G3L HS400 supports only one divider value, so
renesas_sdhi_set_clock() now forces the clock value to 0 before
masking when HS400MODE2 is set and the internal divider isn't
currently enabled, rejecting any other divider. This also completes
renesas_sdhi_is_internal_divider_enabled() from earlier in the
series, which now additionally checks that the current timing mode
is not MMC_TIMING_MMC_HS400 before reporting the internal divider as
enabled.

Enable TMIO_MMC_HS400MODE2 in of_data_rzg3l to complete RZ/G3L HS400
support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * Updated commit description
 * Added a renesas_sdhi_set_tmpport() helper to set delay values.
 * Added a check in renesas_sdhi_is_internal_divider_enabled() to
   return disabled status when in HS400 mode.
v20->v21:
 * Updated renesas_sdhi_set_clock() for RZ/G3L HS400 clock handling as
   it supports only single clk divider value and other values are
   prohibited.
 * Updated commit description.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 42 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 0d38fbc53512..541321e43a13 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -132,7 +132,8 @@ static bool renesas_sdhi_is_internal_divider_enabled(struct tmio_mmc_host *host)
 {
 	bool enable = false;
 
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS400)
 		enable = true;
 
 	return enable;
@@ -252,6 +253,14 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~0xff;
 	}
 
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) &&
+	    !renesas_sdhi_is_internal_divider_enabled(host))
+		clk = 0;
+
 	clock = clk & host->pdata->clk_div_mask;
 	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
@@ -309,6 +318,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -341,6 +351,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -355,6 +366,22 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_tmpport(struct tmio_mmc_host *host, u32 tmpport)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val;
+
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
+		val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+		val &= ~GENMASK(15, 0); /* TMPOUT MASK */
+		val |= tmpport;
+	} else {
+		val = tmpport;
+	}
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -364,11 +391,11 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
 		return;
 
 	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+		renesas_sdhi_set_tmpport(host, 0x0);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0x3FFF);
 	} else {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		renesas_sdhi_set_tmpport(host, 0x1);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
 	}
@@ -477,6 +504,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -618,6 +649,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
@@ -776,7 +810,7 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return 0; /* Tuning is not supported */
 
 	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+		renesas_sdhi_set_tmpport(host, 0);
 
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b1146dca94ca..8cd3ced88b81 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -178,7 +178,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
-			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
+			  TMIO_MMC_HS400MODE2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 501ca4355c34..81a37d6baefc 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -59,6 +59,9 @@
 /* Some controllers have hw adjustment delay */
 #define TMIO_MMC_HWADJ			BIT(15)
 
+/* Some controllers have HS400MODE2 */
+#define TMIO_MMC_HS400MODE2		BIT(16)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

