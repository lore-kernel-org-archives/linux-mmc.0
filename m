Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC842C61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Feb 2023 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBRUHx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 18 Feb 2023 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRUHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2023 15:07:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF726AE
        for <linux-mmc@vger.kernel.org>; Sat, 18 Feb 2023 12:07:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d14so4893233eda.4
        for <linux-mmc@vger.kernel.org>; Sat, 18 Feb 2023 12:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBPNSm1EveWH4wATVmCWEtsUtsTncBvi5mrOEk7ttcw=;
        b=ewHqFqlLqRhXjwLOxILt9QdKlnFOxLGOJtbvfayQDlbSOcy2jwGU0fZ9czEhko3bOf
         XdBdNKC8hZrW9LWLh4CmCCglAwOUJSyAtf/Ecnzo22bmjGu14JQbidguFmGPWpTZcTNK
         4oZ3tsFdAjDPQ19yFORdS/eah7s8DQbo8DHVg14MUxLX8NjXwTni7Dy6Io/lV87F1/UJ
         jA8lrt15V3gBn/NmXHSHgSzZxurdbE/O+2k9G1Enc3q4SQlGXWEMs8WLTpWPtc6QLJc8
         wKaqi8+4xKr/d/O8AGmHWI2X1VjyKijnT7IA8+HZUkDS8xkbaGJc9cOyZ1eZrqTqQWCr
         PIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBPNSm1EveWH4wATVmCWEtsUtsTncBvi5mrOEk7ttcw=;
        b=Bmgi3PYf/mrfO6V1a2BdTilbfflW45j4ttt+9E2GdRY02UkYkmpcgW//MYjqA20bLg
         DuyrDxD6ZTdznwYmhWEB+mlFmF2oA2Vfyd7DZz5pUnLZlYclJsSeIvk0OIUgsezKnGt0
         53G1PYBG3uq9cTg4EAT4Nzy503vtTaX69cF+LPBCfYJKTuK0qRMGNpyBOICIfU3/03r8
         agCiDw9H2cM1YhdqG1QGN7373UTBblOnpG00OixuaPxkGPvGqYWzVmif3sueWAPVbIYK
         BuMG64I9P/n6tI67qHcm4R44W5+sfCMmiRe+YrCARTzvci+RdIHgjrfeWUSeXgGVrOCa
         Q/Wg==
X-Gm-Message-State: AO0yUKUKlz0qgUmUeiecHIqX0eM9kqBK0YXiOu1397HxY+8b1AutkjHX
        7UDssd5JQmDe/xD3w8nDxhI=
X-Google-Smtp-Source: AK7set9EaXl7rccSS26p8r9xH8yoSK5PbcKRpkioyAKwwOpfoJWI9OjOaGmAt3SrKjWR8RJ9yMvp+w==
X-Received: by 2002:a17:906:4f84:b0:882:e975:2fd5 with SMTP id o4-20020a1709064f8400b00882e9752fd5mr4898141eju.26.1676750868818;
        Sat, 18 Feb 2023 12:07:48 -0800 (PST)
Received: from ?IPV6:2a01:c22:7b82:af00:2955:cfd1:cf55:9ea? (dynamic-2a01-0c22-7b82-af00-2955-cfd1-cf55-09ea.c22.pool.telefonica.de. [2a01:c22:7b82:af00:2955:cfd1:cf55:9ea])
        by smtp.googlemail.com with ESMTPSA id f25-20020a170906561900b008b143c76ad7sm3694707ejq.211.2023.02.18.12.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 12:07:48 -0800 (PST)
Message-ID: <0f78b654-86d9-3bbe-9fa5-003479b0cdbe@gmail.com>
Date:   Sat, 18 Feb 2023 21:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC] mmc: meson-gx: improve clock privisioning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Motivation for dealing with this code is that the driver doesn't work
on my SC2-based test system (HK1 RBOX X4S, based on ah212 board).

The current code makes the assumption that clkin0 is set to XTAL rate
(24MHz) or less, otherwise the initial frequency of 400kHz can't be set,
considering that the maximum divider value is 63.
Currently there's no code for changing the rate of clkin0.

On my system clkin0 is set to 1Ghz (fclkdiv2) when meson-gx mmc driver
is loaded. Therefore the driver doesn't work for me as-is.

Further facts to consider:

The MMC block internal divider isn't strictly needed for clock generation
because the clkin0 hierarchy includes a better (wider) divider that
we could use. It's primary purpose is supporting resampling. The bigger
the divider value the more granularity we have for resampling.

clkin1 is fclkdiv2, and this clock is one parent of clkin0 anyway.
Therefore the MMC block internal mux isn't strictly needed.

What the proposed change does:
- Ignore the MMC block internal mux and use clkin0 only.
- Before setting rate of mmc_clk, set clkin0 to the rate closest to
  63 (max_div) * requested_rate. This allows for maximum divider value
  and therefore most granularity for resampling.

The changed driver works fine on my system.

I have limited insight in the other Amlogic families supported by this
driver. Therefore patch comes as RFC.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 77 +++++++++++++--------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2b963a81c..83d849db6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -32,6 +32,7 @@
 
 #define SD_EMMC_CLOCK 0x0
 #define   CLK_DIV_MASK GENMASK(5, 0)
+#define     CLK_DIV_MASK_WIDTH __builtin_popcountl(CLK_DIV_MASK)
 #define   CLK_SRC_MASK GENMASK(7, 6)
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
@@ -131,8 +132,6 @@
 #define SD_EMMC_PRE_REQ_DONE BIT(0)
 #define SD_EMMC_DESC_CHAIN_MODE BIT(1)
 
-#define MUX_CLK_NUM_PARENTS 2
-
 struct meson_mmc_data {
 	unsigned int tx_delay_mask;
 	unsigned int rx_delay_mask;
@@ -155,7 +154,7 @@ struct meson_host {
 	struct	mmc_command	*cmd;
 
 	void __iomem *regs;
-	struct clk *mux_clk;
+	struct clk *clkin;
 	struct clk *mmc_clk;
 	unsigned long req_rate;
 	bool ddr;
@@ -203,6 +202,21 @@ struct meson_host {
 #define CMD_RESP_MASK GENMASK(31, 1)
 #define CMD_RESP_SRAM BIT(0)
 
+static int meson_mmc_clk_set_rate(struct meson_host *host, unsigned long rate)
+{
+	unsigned long max_div;
+	int ret;
+
+	/* maximize divider value, this improves resampling granularity */
+	max_div = min(ULONG_MAX / rate, (1UL << CLK_DIV_MASK_WIDTH) - 1);
+
+	ret = clk_set_rate(host->clkin, rate * max_div);
+	if (ret)
+		return ret;
+
+	return clk_set_rate(host->mmc_clk, rate);
+}
+
 static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
 {
 	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
@@ -386,7 +400,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
 	writel(cfg, host->regs + SD_EMMC_CFG);
 	host->ddr = ddr;
 
-	ret = clk_set_rate(host->mmc_clk, rate);
+	ret = meson_mmc_clk_set_rate(host, rate);
 	if (ret) {
 		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
 			rate, ret);
@@ -420,11 +434,9 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
 static int meson_mmc_clk_init(struct meson_host *host)
 {
 	struct clk_init_data init;
-	struct clk_mux *mux;
 	struct clk_divider *div;
 	char clk_name[32];
-	int i, ret = 0;
-	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
+	int ret = 0;
 	const char *clk_parent[1];
 	u32 clk_reg;
 
@@ -438,40 +450,10 @@ static int meson_mmc_clk_init(struct meson_host *host)
 		clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
-	/* get the mux parents */
-	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
-		struct clk *clk;
-		char name[16];
-
-		snprintf(name, sizeof(name), "clkin%d", i);
-		clk = devm_clk_get(host->dev, name);
-		if (IS_ERR(clk))
-			return dev_err_probe(host->dev, PTR_ERR(clk),
-					     "Missing clock %s\n", name);
-
-		mux_parent_names[i] = __clk_get_name(clk);
-	}
-
-	/* create the mux */
-	mux = devm_kzalloc(host->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux)
-		return -ENOMEM;
-
-	snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
-	init.name = clk_name;
-	init.ops = &clk_mux_ops;
-	init.flags = 0;
-	init.parent_names = mux_parent_names;
-	init.num_parents = MUX_CLK_NUM_PARENTS;
-
-	mux->reg = host->regs + SD_EMMC_CLOCK;
-	mux->shift = __ffs(CLK_SRC_MASK);
-	mux->mask = CLK_SRC_MASK >> mux->shift;
-	mux->hw.init = &init;
-
-	host->mux_clk = devm_clk_register(host->dev, &mux->hw);
-	if (WARN_ON(IS_ERR(host->mux_clk)))
-		return PTR_ERR(host->mux_clk);
+	host->clkin = devm_clk_get(host->dev, "clkin0");
+	if (IS_ERR(host->clkin))
+		return dev_err_probe(host->dev, PTR_ERR(host->clkin),
+				     "Missing clkin0\n");
 
 	/* create the divider */
 	div = devm_kzalloc(host->dev, sizeof(*div), GFP_KERNEL);
@@ -481,14 +463,14 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
 	init.name = clk_name;
 	init.ops = &clk_divider_ops;
-	init.flags = CLK_SET_RATE_PARENT;
-	clk_parent[0] = __clk_get_name(host->mux_clk);
+	init.flags = 0;
+	clk_parent[0] = __clk_get_name(host->clkin);
 	init.parent_names = clk_parent;
 	init.num_parents = 1;
 
 	div->reg = host->regs + SD_EMMC_CLOCK;
 	div->shift = __ffs(CLK_DIV_MASK);
-	div->width = __builtin_popcountl(CLK_DIV_MASK);
+	div->width = CLK_DIV_MASK_WIDTH;
 	div->hw.init = &init;
 	div->flags = CLK_DIVIDER_ONE_BASED;
 
@@ -497,11 +479,12 @@ static int meson_mmc_clk_init(struct meson_host *host)
 		return PTR_ERR(host->mmc_clk);
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
-	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
-	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
+	ret = meson_mmc_clk_set_rate(host, 400000);
 	if (ret)
 		return ret;
 
+	host->mmc->f_min = clk_get_rate(host->mmc_clk);
+
 	return clk_prepare_enable(host->mmc_clk);
 }
 
@@ -531,7 +514,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
 	int ret;
 
 	/* Resampling is done using the source clock */
-	max_dly = DIV_ROUND_UP(clk_get_rate(host->mux_clk),
+	max_dly = DIV_ROUND_UP(clk_get_rate(host->clkin),
 			       clk_get_rate(host->mmc_clk));
 
 	val = readl(host->regs + host->data->adjust);
-- 
2.39.2

