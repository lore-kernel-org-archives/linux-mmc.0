Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933292;
	b=T6kq2pa41ySpsEC1Edtcm6+wziWKlbZOfk59cjNaHNsEtUOSTvt2U7/qjGLrXNBfivpS
	 pxdHZy1g+SgFR97YkrGeGq2aXWRe+vUsA0t2xWhUMgJd8O0IkOgUAHqBbMpYQYdU6UfC8
	 7vx/9YeU3RMRlxXZMZt9qUDcTp+h/yyqO2P6sxLWNPlCDOOBfQhHi4ZxiGpbrl/zKaHNB
	 Jkm7GTvxHNOL6l2N6AH8i5qj9Ybeqcp2OPf7DTwnpxl0Tx3vMDoiXqC/wtOxRfQP9JGVe
	 i8EGkXavMI+THb+WOUJoxwc9XpVG3K9v+b9kVDuZGWBfLDIyNkGrZ3Rb78Y6VbVQCoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eLlVDnZH+MZxPpX0IQdtxg+/0rKConPaWJSzdjopMGs=;
	b=cv5k0xab6Ns8vF1evPBnZOwG0mHdQuspw7NqIVLHOSe1mWLwR7aH+ZDXAF5+Qxgwtja9
	 YvgvropTRqtVJUUlFmpJUTTSTVIfF/cx3Ck1qB1jLMYFNuijdAN4Sds6bElxrXuA6he+N
	 Eu/WiFZi2QBYMl4osPLC20vwdIOAm5JN1nOXqfWm6Rz3YSZow5L4R1ZRWBiLAoTI1cKQq
	 PH5zn4rf8wqBQgNu88NE20JjPyaDqJsSbVYhFXc2uAT9Q7ADFg0BXG4eixslWmWGQZHR8
	 9wA3kDTMaaL75EGdgQ3ILt/v7YMKJFvwStMLxfi5RFZkZvjYu/uY46A9/N1he5QH3aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LrQHqXXQ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF2606A338
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 16:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61BF2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LrQHqXXQ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490f38e9688so965446f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 08:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933291; x=1795538091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLlVDnZH+MZxPpX0IQdtxg+/0rKConPaWJSzdjopMGs=;
        b=LrQHqXXQvkJTHN3N3CK+2U/NdL+LZVL7ZW7ZSKTKwSa5XIOhQVQXymVXL7q2Tl6eXD
         +E2oSakLXWf8MRouXJFHiua9c9xVtI1UXssvhy5bvNCHDTLCBzN4qYcYvlihly+ajM66
         FHFQODXhjYMzKU8nL6Uf3h+OVOmRSsCJoq4Moo4q8HzS5aDiIWrUYIXW2OMd2BVRjrxG
         elSGVKqd2Wy/KszuU1LVxLvpvzW+mFHJM0dpKSPu7Kz8uUpfBQKNrOazQykusnpDGCpi
         mhovwiTpr8IVpVc6GfexRpVXCL3ksfho0VtNB62YIZ05IFwLpNQK2/eSRG+SegHTSrIs
         4G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933291; x=1795538091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLlVDnZH+MZxPpX0IQdtxg+/0rKConPaWJSzdjopMGs=;
        b=XOUfNljydNENcKmUEpY1Xm5vVHM3C/cCq32UamNhWYwcJMo94gNM2i4++qXWh8yfMj
         MWjykORxe890AuUgivvNKGir85amNjaYjfBOtpxWfsppUMDctO8QzmeNzCYyYn/V0zIS
         OObjExt3/ead9pJXIWfyJByKnmUFIXSxgUjM0JiJaMpsKXTg2H/xi0ycoxA3+q1rl678
         5L9hrANTUPf8YKu0Ulktf10b0mhneytmETI5cZJ7vgoKV0gCmX5fXd+YqkTIAHH/p6P8
         QfsN3ETaRV4EutnJcE9dklLxwa9H1zyvJd+qUqCTaEvJut0zvzYLAwG3Ob3njt3qctry
         vDug==
X-Gm-Message-State: APuU4Z8IeG5lwPNqRawro3Gm9l3wm/e6grvG6u1Y/z+2wFvwGDi3Wzul
	ysrrU6ZRCsZENmEhv+dUddzLh+LOEhvJkthJEgzMhmyGec7KHVgwf60t
X-Gm-Gg: AZFdTZfzJuUp+rYB4gfaKP29rs6F5VY/YCS9XYol6adiuyyD2HThtcBzB6J3cfQ0gbl
	rJzUQaIu/ZVSpSs+Jir3TISmZ0RTVVHsFJifT8n5Kmmh0cDNcqCFyzjw+EhcS+HWj9RDgWwyy8c
	yK7fEhtqlUtpBJMDgLcbYxnoVBiVtKPwX+VKgMGx7qmvLu1DEIzR91nEZDOaj1bueeH8AQpMU+V
	wgCReB31m1uxYJWt3QynvI13owo8U4e+rgh5KypCQuygeU2G5gfUeJqmKsIy+k1b4WbYOS5DNfn
	d/kBqY5lgYggWrHtgoD4KGfODjGBcFW8jj/yNYuwa+PxOJ3ttPohWR02ALn84HyHcUdh8di2VqK
	0EA+Ke2rK4g29RY5s2SUQFQFF+Cnc5nEHZiCLxpuoaLNrtXtyQNWtFPZqENF8c8kI0rt7V/koTe
	4dgRTpNTKUydtPmcYdSCo2qgYBz9mprkCwnsKJJaMTrdnICcJTJtybVMPoo0Zd0BS1MmK0ogN0U
	e7JP94iaFZG2k2BnjsPD1nn2b8AeLm7f01orBrL+Y+c4OXW6ugULtUcrNtrtt9TfBY2RC5j8WZ5
	5eAqKpO4Mfj3eiGCaYiODvRR/WdrbbHskCwwR7twfdyd8lCqsEntlNzm9FGAU7zJSi+vxDJuN/e
	Mu76fPANf16Y=
X-Received: by 2002:a5d:6f17:0:b0:4a3:c963:c1c3 with SMTP id ffacd0b85a97d-4a3c963c1f3mr5812653f8f.15.1794933290685;
        Tue, 17 Nov 2026 08:34:50 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:9260:9c28:f0f5:e091])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6d079a2asm26672248f8f.16.2026.11.17.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:34:50 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 17 Nov 2026 16:34:48 +0000
Subject: [PATCH v3 3/3] mmc: renesas_sdhi: Add RZ/G3L HS400 support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-sdhi_hs400-v3-3-b4659189db69@bp.renesas.com>
References: <20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com>
In-Reply-To: <20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933288; l=10431;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=lc2Wyr3UNmntywnmSTgfuVajjcPVDlJulK6otSVC7X4=;
 b=g6vpne12h4JqvrvfBlqI6iieQh4EzsbmcMtfRk6Ais/f5z5R6LZSmP+QLz6GkkyT8m7dNn6Ra
 cgg6P445VVQA7Tn6sHkW4jund16Ba1QdYlrvXb2YrNV1YWOaVncquFS
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Add HS400 support for the RZ/G3L SoC.

RZ/G3L needs a second HS400 enable register, SDm_SCC_HS400MODE2
(offset 0x020), alongside the existing TMPPORT2 path. Add a
TMIO_MMC_HS400MODE2 flag (bit 16) for controllers that need it.

RZ/G3L HS400 mode does not use internal divider and supports
only one divider value "0" in the SD_CLK_CTRL register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
- Clear hs400_active/hs400_clk in renesas_sdhi_reset() after a HW reset.
- Disable SCLKEN before leaving HS400 in renesas_sdhi_set_clock() to
  avoid transiently enabling the clock with stale divider settings.
- Drop the ios.timing check, which bypassed the divider before HS400
  was enabled in hardware and halved the clock; hs400_clk now follows
  hs400_active and the clock is reprogrammed in hs400_complete().
v1->v2:
- Using ios.timing to decide whether the HS400 divider restriction applies
  is wrong: mmc_hs400_to_hs200() lowers the clock while ios.timing is still
  HS400 and then walks through DDR52/HS/HS200 before prepare_hs400_tuning()
  clears the HS400 bits, so the divider could stay at 200 MHz or prohibited
  non-zero dividers could be programmed while HS400 is still enabled. So
  tracking HS400 hardware state for RZ/G3L clock programming using 2
  variables hs400_active and hs400_clk in struct renesas_sdhi.
---
 drivers/mmc/host/renesas_sdhi.h               |  2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 79 ++++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 +
 4 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 8ae2ec04bd1f..d14cfd873bb9 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -94,6 +94,8 @@ struct renesas_sdhi {
 	const u8 *adjust_hs400_calib_table;
 	bool needs_adjust_hs400;
 	bool card_is_sdio;
+	bool hs400_active;	/* HS400 enabled in hardware */
+	bool hs400_clk;		/* divider bypassed for HS400 clock */
 
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_LONG);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7dfcf7f970aa..f7888c4b13ee 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -133,9 +133,10 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
 					      struct clk *clk)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq = clk_get_rate(clk);
 
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) && !priv->hs400_clk)
 		freq /= 2;
 
 	return freq;
@@ -226,14 +227,33 @@ static void renesas_sdhi_sclken(struct tmio_mmc_host *host, bool enable)
 	}
 }
 
+static void __renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
+					    struct renesas_sdhi *priv);
+
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int clk_margin;
 	u64 clk = 0, clock;
 
 	renesas_sdhi_sclken(host, false);
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
+		/*
+		 * While HS400 is enabled in hardware only divider 0 is allowed.
+		 * Leaving HS400 (e.g. mmc_hs400_to_hs200()) lowers the clock
+		 * before the core calls prepare_hs400_tuning(), so disable
+		 * HS400 here once a non-HS400 clock is requested.
+		 */
+		if (priv->hs400_active && new_clock &&
+		    new_clock <= MMC_HIGH_52_MAX_DTR)
+			__renesas_sdhi_reset_hs400_mode(host, priv);
+
+		if (new_clock)
+			priv->hs400_clk = priv->hs400_active;
+	}
+
 	if (new_clock == 0) {
 		host->mmc->actual_clock = 0;
 		goto out;
@@ -259,6 +279,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) && priv->hs400_clk)
+		clk = 0;
+
 	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
@@ -315,6 +342,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -350,6 +378,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
+
+#define RZG2L_SDHI_SCC_TMPPORT2_TMPOUT		GENMASK(15, 0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -364,6 +395,18 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_tmpport(struct tmio_mmc_host *host, u32 tmpport)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = tmpport;
+
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		val |= sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2) &
+		       ~RZG2L_SDHI_SCC_TMPPORT2_TMPOUT;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
 						 bool force_clear)
 {
@@ -374,12 +417,12 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
 		return;
 
 	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330 || force_clear) {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+		renesas_sdhi_set_tmpport(host, 0x0);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
 				       RZG3L_SDHI_SCC_HWADJ2_3_3V);
 	} else {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		renesas_sdhi_set_tmpport(host, 0x1);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
 				       RZG3L_SDHI_SCC_HWADJ2_1_8V);
@@ -486,6 +529,12 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
+	priv->hs400_active = true;
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -515,6 +564,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	renesas_sdhi_sclken(host, true);
 
+	/* Reprogram the clock now that the HS400 divider bypass is active */
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		renesas_sdhi_set_clock(host, host->mmc->ios.clock);
+
 	if (priv->adjust_hs400_calib_table)
 		priv->needs_adjust_hs400 = true;
 }
@@ -607,11 +660,9 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT3, 0);
 }
 
-static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
-					  struct renesas_sdhi *priv)
+static void __renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
+					    struct renesas_sdhi *priv)
 {
-	renesas_sdhi_sclken(host, false);
-
 	/* Reset HS400 mode */
 	sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
 			sd_ctrl_read16(host, CTL_SDIF_MODE));
@@ -623,9 +674,21 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
+	priv->hs400_active = false;
+	priv->hs400_clk = false;
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
+}
 
+static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
+					  struct renesas_sdhi *priv)
+{
+	renesas_sdhi_sclken(host, false);
+	__renesas_sdhi_reset_hs400_mode(host, priv);
 	renesas_sdhi_sclken(host, true);
 }
 
@@ -678,6 +741,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
 
 			priv->needs_adjust_hs400 = false;
+			priv->hs400_active = false;
+			priv->hs400_clk = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
 
 			/* Ensure default value for this driver. */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 37eeaa52f011..d9b9f9663386 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -165,7 +165,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
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

