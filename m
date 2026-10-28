Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191887;
	b=rhRpW7s0vumE6LXtz5luK3QnUz+6GjJBHJcd/YLpJErnvB0vn+5vTgMHxKo5QzpWkcrp
	 Dmtjc86ffm6DtlmLXQje0zU2CEudENFUHT5rMqGa8XcJXSaDtgydiQoEzbYjPC25v5qnW
	 dBOtOqCoQb3OJmVXVu0XWbMb4w3z0CWQh3L3359PzZrU6okilwXclYrF3UQY4NS9C4Lt2
	 sjhYiSlua60A8FVl8bF050H4NStQhQsbm92C1/Yd4i40uISkihlX+bmVglxqfA2zPgqtt
	 H63vCXisLrAdBVwcRL8Xl5jGTow2K7b+KyHCo5MOsquZDuj6v8e8SRqUuMRhptQi8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=02HWLu9BwQh1aVmbqE9fm+dnQap3meHkncL6rIGE/1M=;
	b=3A6r/vpuRsZMpQM9NhSiREd+neqaz+RumKEXUA6gSv0RfBYd5NNsThFamQa+5vhxEIMC
	 4CDCzXbrvIGUAq3T5aKpPUZ6+GPglAUBF6Eg4yVUle8i7cJoOSjkux8w9vKhrfzZJTQtC
	 2nNqV9Z55ysFfXsRklQObdzT+v9/pc2OVWz94hE9QunsN7E6b2TpQYCJuLSxFkWVE+XKa
	 82Dh0C5PpnPAdO73FQfI22/lmoIfJPVPHUnnOszTrVm1sFi/aN/+jQzO/Loe8eL8w0QEo
	 /j5WMVeLi2GHVOgLbzMNjM3rLRoDveLSLjmv5rbFI9k7Ca6Axd5tXLPOqPI/AGQXAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pilXJiVG;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAA606A33C
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BAAA606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pilXJiVG
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e4831c028so777985f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191885; x=1793796685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=02HWLu9BwQh1aVmbqE9fm+dnQap3meHkncL6rIGE/1M=;
        b=pilXJiVGAvcTON2GvuIHpgT4FgF/+VTMYgxSpYWOhWr96t7WlLEPCWbH/VAydQhmPW
         YPdRZI08Ww1MZJGxlbPiBaBoTGGjlg0FkP6W4G/aoeTtBSx7Ziwr3iTKSEquOwcv9K1o
         zmGjhoaj6Yi2TolSRa7gMb+A+IsVx8ZLq+Sja9/xRZ3kaWapDywZevTvGcm4ElGF725M
         OLegDu/9GlzygA7ge0xb08T/9Gz+05J/0JJZEI1Z5r+fciDFJJAla1EU/5UVO8pH3UVh
         tN7sKGF2Njavo9uMFdGX7nazZ+dAf8CFfQ1g+F6eW51mTH20Akomi4fWr9BWthGz9Pnf
         8AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191885; x=1793796685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02HWLu9BwQh1aVmbqE9fm+dnQap3meHkncL6rIGE/1M=;
        b=klsBKLlYlCNV9SxnE+NREhwrRDji+kSCVDCVowKK7D2lfNzfasSEGzBSlYa3Fci3sZ
         2ucYDh208838eA4gk9qJ26koiSd6IYnGh2sZpla/JtEYrmSLnDvqHQUpTJ1Y/ZaYZc0F
         guhH0LKX1WcCjxmmaOa34kQlNToMxa3AS9kNKnAaumskO3O7kSAWZ2fk3c8zK/Dkj7D0
         2DRJNJNBJECcTPH1TFoSztWQRhWyC13dm7uc//uxqb24mQGu4aUyh46id2WE5RZLppt7
         Z3FS2vpxAi5LMWSGX5vo2wcOazbc6k8yTRTDQwSW1yWTryeJVrk32tGtGYBz7sDlrJEz
         hJfw==
X-Gm-Message-State: AFq9FYImL9waycKZ/wtCHsYOahdYxExzFROExL884/A/nxlrUdIijRGc
	GS9PYr6osN6ho1Vf6wURoAJxLrCSjGAz7Oe8qrazzXcwhD+HjY/imfv3T0PAMg==
X-Gm-Gg: AYBFou2mXegEa5z1fVv7hVMaM6rroONmrBTPQhWQF5QRQaoxClVznOfze7Z3h7Fnk67
	jc5XZLSIzVaFrZDeScjTpS/K2vWxb/fo/uFgucnoXQOc633JvskPt85/FRsTF5ajnUGd9V0fFec
	AZ09w5K2IIhOhXCDYhYg+KfD7ChuIe+3XOoMgPoftRrIz4KATtCg9k4lX55+xMVue140E19QARB
	VJS+bGUhs6JbUmeTs3TDGIxyf4CYMuUw0E8oN3hl9WAq8CvTTV5VNQBmZ0S6WOVtdML7N00fzI2
	t5ZvANesrhPr/m4kF/ol8dCGHxgNq7Pw2C39UWb6ihX4PfOPQCj+VQdWoCgkX5xdTQz2PyCKV/j
	QPKTxJYb3K0FB7L1UyrOItWRg3stPEzHkVrB7ymUWHinaItPlwxcnnyslVSTOk+2k/MNhiIR94d
	wDXGAEuqKx8MXFJ5w0Yo/bj5FrPSwBWZlOebjGtD4vmqvkjF4mMKBsfzM3FBK/Ut+o9w3MTk88t
	OcAOhV1ttuLXEkUR+QONIfPtM3eiKt03vkBCU3EeDGel5V312i4VE0lyr/s42OD1HXfANaaKwHM
	qz+OJOQ70H1iGK/9F+B02UCECMTFFUby1omgS2nRjDzPpfTTP7nywOJFwZytNzMlmqM=
X-Received: by 2002:adf:e009:0:20b0:48e:5550:c64c with SMTP id ffacd0b85a97d-48e5d44e556mr4221440f8f.14.1793191884666;
        Wed, 28 Oct 2026 05:51:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:24 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:21 +0000
Subject: [PATCH v25 04/11] mmc: renesas_sdhi: Add max_divider field to
 support SoC-specific clock ranges
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
Message-Id: <20261028-rzg3l_sdhi-v25-4-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=6384;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=o+05NCOAL+w+z1XuhSH+DV7neIMq7y0J3Zllh7EsFic=;
 b=YlOqgdE7HqYHRxFndsWjUxi7nqg0fNpdgsSNjf47M0C87XcQ7Rrm7mItP3CsTseHgNAFkT39q
 JgNeaP8yvYHC6b5JZEpTqRTD9aitbFNzS6Fa2IZBnFeRc0Vo9kjhEo8
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L supports a wider clock divider range than the hardcoded 512
used by existing SoCs. Add a max_divider field to
renesas_sdhi_of_data and tmio_mmc_data, and use it in
renesas_sdhi_clk_enable(), renesas_sdhi_clk_update(), and
renesas_sdhi_set_clock() instead of the fixed value.

While at it, check the return value of clk_round_rate() in
renesas_sdhi_clk_enable(). A negative error code was previously
divided and clamped into f_min; now the error is propagated and the
clk_cd clock is disabled again.

Default to SDHI_MAX_DIVIDER_DEFAULT (512) at probe time when
platform data doesn't set it. This paves the way for RZ/G3L's extended
divider support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Updated commit description.
 * Restored the data type of max_divider from signed int to unsigned int.
 * Dropped initializing max_divider as it use default value.
 * Updated mmc->f_min calculation with clk_round_rate().
 * Updated the comment using "ilog2(max_divider)" instead of "{9,11}".
v23->v24:
 * No change.
v22->v23:
 * Changed the data type of max_divider from unsigned int to signed int.
v21->v22:
 * Updated comit description.
v20->v21:
 * No change.
v19->v20:
 * Replaced the check mmd->max_divider with mmc_data->max_divider and
   moved the code after assignment of variable mmd, this ensures
   assigning the default values for non-DT platforms and DT platforms with
   no device data.
v18->v19:
 * Fixed max-divider setting for non-DT platforms.
 * Replaced the magic number '9' with ilog2 function in
   renesas_sdhi_clk_enable().
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 22 +++++++++++++++++-----
 include/linux/platform_data/tmio.h   |  1 +
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index bfa626ea6bee..b54802c0807c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -23,6 +23,7 @@ struct renesas_sdhi_scc {
 
 #define SDHI_FLAG_NEED_CLKH_FALLBACK	BIT(0)
 #define SDHI_CLK_MASK_DEFAULT		0x80000080ULL
+#define SDHI_MAX_DIVIDER_DEFAULT	512
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
@@ -39,6 +40,7 @@ struct renesas_sdhi_of_data {
 	unsigned short max_segs;
 	unsigned long sdhi_flags;
 	u64 clk_mask;
+	unsigned int max_divider;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 495e58fa7728..74834e72f038 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
@@ -98,6 +99,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct renesas_sdhi *priv = host_to_priv(host);
+	long rate;
 	int ret;
 
 	ret = clk_prepare_enable(priv->clk_cd);
@@ -117,7 +119,13 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	 * Minimum frequency is the minimum input clock frequency
 	 * divided by our maximum divider.
 	 */
-	mmc->f_min = max(clk_round_rate(priv->clk, 1) / 512, 1L);
+	rate = clk_round_rate(priv->clk, 1);
+	if (rate < 0) {
+		clk_disable_unprepare(priv->clk_cd);
+		return rate;
+	}
+
+	mmc->f_min = max_t(long, rate / host->pdata->max_divider, 1);
 
 	/* enable 16bit data access on SDBUF as default */
 	renesas_sdhi_sdbuf_width(host, 16);
@@ -156,8 +164,8 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	/*
 	 * We want the bus clock to be as close as possible to, but no
 	 * greater than, new_clock.  As we can divide by 1 << i for
-	 * any i in [0, 9] we want the input clock to be as close as
-	 * possible, but no greater than, new_clock << i.
+	 * any i in [0, ilog2(max_divider)] we want the input clock to be as
+	 * close as possible, but no greater than, new_clock << i.
 	 *
 	 * Add an upper limit of 1/1024 rate higher to the clock rate to fix
 	 * clk rate jumping to lower rate due to rounding error (eg: RZ/G2L has
@@ -165,7 +173,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	 * for 533.333333 MHz will selects a slower 400 MHz due to rounding
 	 * error (533333333 Hz / 4 * 4 = 533333332 Hz < 533333333 Hz)).
 	 */
-	for (i = min(9, ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
+	for (i = min(ilog2(host->pdata->max_divider), ilog2(UINT_MAX / new_clock)); i >= 0; i--) {
 		freq = clk_round_rate(ref_clk, new_clock << i);
 		new_upper_limit = (new_clock << i) + ((new_clock << i) >> 10);
 		if (freq > new_upper_limit) {
@@ -205,7 +213,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
-	clock = max(host->mmc->actual_clock / 512, 1);
+	clock = max(host->mmc->actual_clock / host->pdata->max_divider, 1);
 
 	/*
 	 * Add a margin of 1/1024 rate higher to the clock rate in order
@@ -1137,6 +1145,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_blk_count = of_data->max_blk_count;
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
+		mmc_data->max_divider = of_data->max_divider;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
@@ -1182,6 +1191,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!mmc_data->clk_mask)
 		mmc_data->clk_mask = SDHI_CLK_MASK_DEFAULT;
 
+	if (!mmc_data->max_divider)
+		mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 76056d49f5e0..27ea21c00419 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -62,5 +62,6 @@ struct tmio_mmc_data {
 	unsigned int			max_blk_count;
 	unsigned short			max_segs;
 	u64				clk_mask;
+	unsigned int			max_divider;
 };
 #endif

-- 
2.43.0

