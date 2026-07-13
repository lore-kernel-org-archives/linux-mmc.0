Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E51353A6C
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965137; cv=none; b=m5gwylTvCAkMHQm/ZxZl4z8j64coxiU75G+kEGHgFkj3+bTvk586k2gEHBZQRa+cpK8JctL1zRZoE2fp/iV33gp8TCCwdfYSjrg0M9Qg3bD79RYEkOgvDtcj2SunMqODDqG+5oHeby2JE6ZR0IgiAZWfLKzO3/V8MoHDJKkMbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965137; c=relaxed/simple;
	bh=H0BB1+tLP5mVMxBZfWM1v8VRfW+JC6ZOjupeFTMVzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfZwBy3Abt73obuPaB3GLX8i0Gk3HImxq//v3n/3pIKzCfM1opBQBg1DJHzc3sLc/8ytik2hYadm+64LbJ8sJKEm581Nw/d7mNDGwyBdjPbyxa4J3pllU9qfJnnQqTJI8mf2330b+2WfISZ7CbfvXvDi0AnnuLdv2+vifPSl4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP3aiYPv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP3aiYPv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so2810281f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965131; x=1784569931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kVGQv1zLjxdqd3BJIRF46fls+zqS0NgMjE7tGJsJ9M=;
        b=CP3aiYPv5z+m+hSm41bM5C2jPWhgEjhVmAGtR0TFdIPG0ChQiiqA5kwCSIX2k9/Nut
         i8oufButodZtXI7gIhOSSKj2L+X7/WipGFXVyEeWOY4aT6nFJc76vk0ef/l49p1C0QWB
         yUo5hLa3QrIUP9OVBK+9CuLnZRNtiRhfBLBluytVRaBTnG8zy9wspQeu7qWNVdFeuDIm
         WLIiODkYqclSyoqtQusD65EUXs3hA4GBUIORmGHvabG+/qhgy2wyU1lPqCL7kHznvg1q
         Gm2mhgy6WhcqEid/gYN0Xt3MmDgdSQSie6lVTi0VpPRs8VaMVQIc4D9tYzSUdhD8Yybi
         cUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965131; x=1784569931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kVGQv1zLjxdqd3BJIRF46fls+zqS0NgMjE7tGJsJ9M=;
        b=OmMEe5wnvAizk2ZIOyPV4arwkM6IHc4KKur+Eg7ooQ4isogO1zo7FVwFlNFNA6wZLx
         C2gvPDkibOEqU9fbe6ALuNDoPAg7gdytQPThNisejRCPAtIi9MLQvWBYo021xFr1+Io8
         Iy7po+954M8RoHrXemODUpbLx+t5l4IuUJ/FYndJ+/UiYMwBxggcpcbA7whR6o8JAY2T
         O+QaeyDQoyob/iiwJSvilVT189Tqf/s9YolU3nZzL3cT5kbJ3XXfRX0rer2L7hWmto5n
         7b27DyR/JeIrpkjWlnsz4R0hFuoPJNYRdGo884m3r4YRT3winpkcuPkUTgj842Qb8oKE
         gZEg==
X-Forwarded-Encrypted: i=1; AHgh+RpdWQecbtJ/yJb1jGWSKQlZLfhdsBgQaX2YKbKKKoFusSCv7acGdDdQQaNheCVB03l2qQlKzTcWHrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyajMScSYRm0yi8FyOJVhHiKHHLXn5O0OxdW1w6MGRT/tfgKM
	1ACGGuRpi9r+5lrOfnK07HPqc+VZscAx40mcNVPFpaURuJ0Py8e0IClL
X-Gm-Gg: AfdE7cnbEw31fCZ4kjBl+Zf6IqzohI3MZC9jJyxlCW93zJ0+PvMES0bqidVgw7j1kFc
	WUNCt0XHd1rBkQ1V4VV8hPjxMu7Qdm24moACkXb6piXcAejkXy/Edv2e6nynkX69jInfEYOYVBO
	/jqzzw86WrIpUGOtwjUzNPX4VIrdEGdzYRseb1h7jaq0JSAVNTH+B36kP0jutEUvz+PvNSp8iho
	GvWiXXjr/sjy9L7Ji3Puz/Mn7YqDbQkODmUEXjRZWBcISUtF9ECFkvsG8Q0O9YR6wH1TrZQlWU4
	/9SwmB8EeRLZpAUuLwZTVyRaHDnBtlaGR2mZS5TKei0clR3G/WCjmubZrFQIzaOnuWnrE1p9uSA
	akT8vRzSUJ/vttt+8a3KpBtztFxSg6pC7CmELEBnW9nbgmNb0Uj3/781isugH2ftzCfIEfpjLBp
	DEfoohIIECvVYstGNexCZHma/WPihuY8AWgIWZnfdD0onWNL2U
X-Received: by 2002:a05:6000:120c:b0:478:2698:72f4 with SMTP id ffacd0b85a97d-47f46391de5mr606462f8f.45.1783965131085;
        Mon, 13 Jul 2026 10:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:10 -0700 (PDT)
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
Subject: [PATCH v20 10/12] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Mon, 13 Jul 2026 18:51:51 +0100
Message-ID: <20260713175159.138334-11-biju.das.jz@bp.renesas.com>
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
v19->v20:
 * No change.
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
index 861fa83b9980..57c7ec5424b5 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -310,7 +310,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -457,7 +456,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -598,7 +597,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1198,6 +1197,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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

