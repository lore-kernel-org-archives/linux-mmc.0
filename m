Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2093423782
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411140; cv=none; b=e+YUWntAkyp3X/Q/hNmb9hORukYR6PRskkViwX9EHzMuxT3s7GvIkWroOA5Udtlxppdd48C/WHZirdMX9tQDFocFDSQRVWCpJaez0G9tWwkYZBGKt8zG7kWGOG1rvX4n1H782sqTk0f0hppvRpBGiRy00SBzI71rSExY2kuehWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411140; c=relaxed/simple;
	bh=OScNqowvS2jFMZAX2ikZFLFH2ow1EE3o8ThiagACZAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7BDotH4OLvq1QyqQ54LLCfWBMcgRVpZcSMuHbOm9cqx6TmqMxqumfchlraFSLs/K6VAFu69vOeA/jT0jBfMoN7ChsEhqjnoTlK/+tRdzBFfpe5yovI1LLgw5aI7qHtE1VsCNXotd03Ijt07DHspXs+l9K8NyTo1BVlaKBoy7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsAhwT7o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsAhwT7o"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so13451245e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411136; x=1786015936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iGZOgEO2OmhLDQdv7W8wXKVpEkuhyzZ9E6R14zN11zI=;
        b=WsAhwT7ogI4i0sd5vpIxYsDsZV3rENoPvB5ZJ3yRIlKyThTgbFP5Q4CRVZtquAQOOj
         06hTeWq8D5dfgynenbiTDDKF5L5VYOPOAwBwotBXcDjSNGAGItDHUwFwqZuOck0+7Ziw
         xFcz4v65jlCmRXULLk1YOLAzN8DOhQhwsQrfZxBKWctGCh1dzIuctrR/4UL2gvgLcMA/
         z++8IuDhE+OC3HLpFAL6vrsytpHVvGHMXxLN7JDVzikad27dXlkMxCkMCZ+LsNV4CT31
         2Vjjdakr43S6Odyn/+vjO0Z1ky6YuXeDeIPb/x3RKJ+gzoyEADOR1xYb1+swmcLmR08I
         B1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411136; x=1786015936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iGZOgEO2OmhLDQdv7W8wXKVpEkuhyzZ9E6R14zN11zI=;
        b=FQ8WbkBI98xTYG3ULBNCcQrM7i27BSdIzLrXe7P9WTp8ulO1VxyMYm+XxR1yCxV2xE
         XPL5DdfzajTmbPVXDh1UzFBh5XN0h/inHa294RMVXcpUpskOZnYig1p2OBgqQHvdE/ZT
         hdfz96Z9jP96sXk1rpov0MtPPtDTsip80wqqm8MZbs7JGEYLIVMQ2IpXownN49JnPyMJ
         dZHnKXd6ZeND6y13cBGavzp7TYlsfI49YExHbxW+o3+YSnPMlpgNJKQYLQNPzIT6lQob
         evvWW0xqNCZvWoYSfnw8486JooGHME5Z+nj6P4RdJmCJUm/gXG+1cZfeBIl6QK66ED/A
         GCqg==
X-Forwarded-Encrypted: i=1; AHgh+Rqgs6ubw9keJUw3veEjzVHM7mc0+woOMo4+mwuYGgbmPjVV7H5tM1mifws66n8VlDkui3WKI0O8fp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKg1FvP5Z+Z4eaCgfTlSzMon5lUiguqgapI57BUezYu3zdGlx
	Z7YzVk53hxYdpTlh2WCSOKmLudxjgMYun1gJTPw6OnXwR98AcHSxxLoP
X-Gm-Gg: AR+sD13lh9JXDepCPvqUQCkcWtU4vp9L+tr7fHaM0e3zxXeP4jfXFaLohDrPiEn2NE/
	YtnF78cmNZfuuFueKdw/ATcDYKuD6yn855xaDYQNG4pbkw3BlHspTdea1y1Er4GtvWw4rGyvtUt
	7Ebrwntu09NwiZ+hjc5wUmNXkTuGbNDJK6yplB2TWWKY9HY8XSKeOrVMsoNyjQEZzTiihhIMgUZ
	WEWYtmkVv1D+hT3+hFHkl93U89VSTKpyW5LeO0eiD+EfOaY0PzvrHrmycETljATOb2s+QPJmM8g
	EiULaJEPsIn++vSl6578o2CdXIIZTAaaflzjseS+yN7nGOPdGtpPaEIPlBllT8DUdsvkl2qNBPc
	Gsq7VVd3b8uZ7YprNsDR5AO2JqsboFXAJmXlLpA2KYZi/tdyPjVk2jcNfTbip0EkHc14ngHhhIQ
	1HgiEaT/rzAz6wPrFOlURB5XfmhMTfA4PDZ8gMwpIUhMmVJcMSHnT+adJz3USkdm90Ynkl32AMy
	DxB5ctTjt3qFZ6bDwTwpce+AA==
X-Received: by 2002:a05:600c:a44:b0:493:be13:98b with SMTP id 5b1f17b1804b1-49800ea0aaemr31038615e9.23.1785411135629;
        Thu, 30 Jul 2026 04:32:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:15 -0700 (PDT)
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
Subject: [PATCH v23 13/14] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Thu, 30 Jul 2026 12:31:51 +0100
Message-ID: <20260730113200.36456-14-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * No change.
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
index 58362c5ef793..b68567c93fef 100644
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
index fecc61e082de..88a3744f965a 100644
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

