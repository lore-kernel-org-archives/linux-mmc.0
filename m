Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537886;
	b=KKBv9CfCzDeWgkAKbnVzp7wZv+caVI5ZgazVFMxhdxkjFF4tvfY967Q+Q1l7l9JimB3r
	 sJ73trobzhFXis0/OavL8uw8CEEZ7KIhFmg/P3s8/SqTEpX9nAzUbkCMZXv6T97/QL2t8
	 hzFKGITZk0hCXCfz+NBY9V/kUOPhJoJCH+UZ+RTU9jQxk0c0beZavv/Qv3eA8aGoFlxfJ
	 GJy//EpRkbQw5wAG9TXAxtsF8n8ZFaH6RZvrNiI3oEWv4T7pLDdwQTS8qbr3r3dV4nvo7
	 hNwg/O6W8l68mvGnYZ0WpFH19i+68Bab5avChDkeYbYLqh9J61WK7VjXKCz5l08qyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HEVRHs43jVpRuHUy3gqjkopl9JNDsrgIgAxV2wMUWVs=;
	b=i5OdtbAtiizMG4Ap2Btd2tQlA7dyrQab69r8Cfl3rZDXugNmAL41GULjwo/Z80M+Y1+W
	 4r8wzWuD4NrMSm8TBcJt3nt5TAi1Q7eqjtSDxso61wQMl2PBuNgd251a4Rq0uKGmyKJ0W
	 jbJSCatxCY4I3DaLRipOFEBjtx0w2sNhPu76u7aEUfTK35vzv+x8Yjlc6/7qlQptDYv3k
	 SPH3lwkoRsIdFb3er58vmJUJCupFnof/6yRJn+nHTcYfmq+/8/2Qr2HDCJIqs83fPjZjV
	 kGRjFwCFwBP1oFY+yVg4wEqhryrjX127CX636JoaBO+777TT+wvDYwj4zbDd8kSbNnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oxa7q55V;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C6606A334
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 16:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 656C6606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oxa7q55V
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so4094186f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537884; x=1796142684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEVRHs43jVpRuHUy3gqjkopl9JNDsrgIgAxV2wMUWVs=;
        b=Oxa7q55V0D5KMLRL8zJzLh37ixSxHvNLpZ0oVz57Pp/itMVheDvukyLk7vBKwTN6tG
         EnYs0Zs5IXOPQWcfBuBtH0gu8Dd+pRoAmL+MmrJ0hX3Y2ndWKG1xsPOqQmd77FGGjZX7
         J3yG4aOpBtFUX7mcDfSzsy0EYV/uZWD8plpNVBWjtaH3e0dDvLMKXrPL2D2IEGbSrsok
         w8VbKHfFqLRxCwQjgol1UT7QhmFfZWqugFi4J/bJw3LxHN43yIvkEoyyHgZymnQ6w2CI
         OLttycEHENZ7OOpA+wgc+hHgPXbMEiw/P66t/ngnWwsEcO3xehSy/2+cX+UcbqmKF2ti
         bBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537884; x=1796142684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEVRHs43jVpRuHUy3gqjkopl9JNDsrgIgAxV2wMUWVs=;
        b=pqGVqy4tfgUCbHfyMnKR4qXuhERVsgJdONlhzS8IjxDJcDYz3qTnr2UX4Ncj98uIEU
         Os+UR7Q02a9ciVaiU2Ku+RbrMbRXudsG5vkA0/NV2qtmR1J284kI3okma0eNfZJYZyFv
         DxDlAYuzC00HdpwV35wwD1Gg3tmZ8ou/mcU2D4EcyCN94A+gPg5N6XrLci9hZSymtZa5
         kgSeJ4Wv5tMJELI90qQqbgyzov9+FkUoVoH5ghmalgO+Gu+B8CcyFIt7JJuuGPCvPxqd
         pxtya8xmTMx7nBJgYYjaAeOngr3cXl/oP6VXUqjN9y+M5T9xy50o4MbtBnUWwMXq/+l8
         PugQ==
X-Gm-Message-State: APuU4Z9k6ifSCX1bRQLbHp994lwWYaUqprK8go/R86dDIqqEfrk+N7LZ
	a03oMzb3o3orQ66i65MqDmWyMigAN2Vm0liePfPTzEn5KQQTKJN/nbzB
X-Gm-Gg: AZFdTZcG2YAqd4iquBM1U1zREYSyBmL4uYeR2j+HV0YUrt55nuVAnJQ4o9d1kuC9eUJ
	wrxh3qgJzt6EpEMS6yfAhuUM715/sJnANbTGCmTKIPeJrRXlkckHgxA2ciBwUuWMumqNMt00Xll
	9qz1UNEyTvh0L18tENw0AhA1G/zise/oQbNLF7IueXjcS24Qo00lq7egsxhRFDJYR8+jWd2CPq+
	fuLbRAN/70dDFJqz4l0/1zXmzMfTJa/UudubJY6rbJF77ufQFrO4oMn51wcmEqpOWx4BGwqE3Xe
	XZwfkDOQhPc/k3pQ0r64oHf6LcsEfR8816ru1+FUr+k6d4yw3ATCsrYIWE7z70HjzWvkH4NIvSt
	YPCkcU3yAm1e1qX3KVUZs/T9/RCqDI0TusRzYHZ5xlNkNAcfhtngRMfENvLCx4mn0zUp36hk3ST
	LjiyJkeAVL3orJ+ADdRL4dJgVIWuarSz70i9XfHt0eawrAdKgz/aeFwcd28geIMOVJl+3gXqKk7
	8FiWWVhQmreV5yp54yeh6vDzjQlbLf420mr2pCZ/9ipA24+AFgYNNMZPCwGRwcDGHQRnc6aAvg+
	BEKjkNIjdYPKpDlen44BAXw6Sv8osTtHvmsj137MBpwJzjPWnvGyAUDbPa3LArPucOEwq8LhPy8
	IQFxt9Pr9BDA=
X-Received: by 2002:adf:e014:0:10b0:4a6:b87:d799 with SMTP id ffacd0b85a97d-4abb400bb42mr21867971f8f.17.1795537883616;
        Tue, 24 Nov 2026 08:31:23 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:d107:658c:9ded:696c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm33058741f8f.24.2026.11.24.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:31:23 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 24 Nov 2026 16:31:21 +0000
Subject: [PATCH v4 3/3] mmc: renesas_sdhi: Add RZ/G3L HS400 support
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
Message-Id: <20261124-sdhi_hs400-v4-3-df452ccd9bca@bp.renesas.com>
References: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
In-Reply-To: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537880; l=12284;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=9wMONUB0X/POs9e6kuYRcAUeqMQKKm1u1yOYugcj5Dw=;
 b=aznvK0I/uPQjNvE040rmOhHmpczi61aqtkFPeRmdg4ZJnshuguhBsKZsMp80mlxJBOm/jT61w
 6DPtmfbPyCOBQ2m+IlEE8omq4wcH76kASdKGJ7Bz8DMzl7Wxbgcx2nY
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
v3->v4:
- Fixed ios.timing check in renesas_sdhi_set_clock() halves clock
- Fixed premature SCLKEN enable in renesas_sdhi_hs400_complete()
- Fixed overclock in renesas_sdhi_clk_update() for HS400MODE2
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
 drivers/mmc/host/renesas_sdhi_core.c          | 97 ++++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 +
 4 files changed, 93 insertions(+), 12 deletions(-)

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
index 7dfcf7f970aa..57ff0b341b41 100644
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
@@ -149,7 +150,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	unsigned int new_clock, clkh_shift = 0;
 	unsigned int new_upper_limit;
-	int i;
+	int i, max_shift;
 
 	/*
 	 * We simply return the current rate if a) we are not on a R-Car Gen2+
@@ -181,7 +182,13 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	 * for 533.333333 MHz will selects a slower 400 MHz due to rounding
 	 * error (533333333 Hz / 4 * 4 = 533333332 Hz < 533333333 Hz)).
 	 */
-	for (i = min(ilog2(host->pdata->max_divider), ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
+	/* RZ/G3L HS400 bypasses the SD_CLK divider, so only shift 0 is valid */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) && priv->hs400_clk)
+		max_shift = 0;
+	else
+		max_shift = ilog2(host->pdata->max_divider);
+
+	for (i = min(max_shift, ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
 		freq = clk_round_rate(ref_clk, new_clock << i);
 		new_upper_limit = (new_clock << i) + ((new_clock << i) >> 10);
 		if (freq > new_upper_limit) {
@@ -226,14 +233,33 @@ static void renesas_sdhi_sclken(struct tmio_mmc_host *host, bool enable)
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
@@ -253,12 +279,23 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 
 	/* 1/1 clock is option */
 	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1)) {
-		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
+		bool hs400 = (host->pdata->flags & TMIO_MMC_HS400MODE2) ?
+			     priv->hs400_clk :
+			     host->mmc->ios.timing == MMC_TIMING_MMC_HS400;
+
+		if (!hs400)
 			clk |= SDHI_SD_CLK_CTL_DIV1;
 		else
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
@@ -315,6 +352,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -350,6 +388,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
+
+#define RZG2L_SDHI_SCC_TMPPORT2_TMPOUT		GENMASK(15, 0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -364,6 +405,18 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
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
@@ -374,12 +427,12 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
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
@@ -486,6 +539,12 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
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
@@ -513,7 +572,11 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 		       SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
 
-	renesas_sdhi_sclken(host, true);
+	/* Reprogram the clock now that the HS400 divider bypass is active */
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		renesas_sdhi_set_clock(host, host->mmc->ios.clock);
+	else
+		renesas_sdhi_sclken(host, true);
 
 	if (priv->adjust_hs400_calib_table)
 		priv->needs_adjust_hs400 = true;
@@ -607,11 +670,9 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
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
@@ -623,9 +684,21 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
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
 
@@ -678,6 +751,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
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

