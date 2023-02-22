Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7F4C61DA4
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Feb 2023 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBVNeT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Feb 2023 08:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBVNeS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Feb 2023 08:34:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8C3B0D0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Feb 2023 05:33:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg37-20020a05600c3ca500b003e21e018039so7098843wmb.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Feb 2023 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjy7XTatXC+XxCQYn4bK+GvF+gmfm7vqZf4bRJfFvqE=;
        b=OQJNAKaUrLdK+1OAcKo/oLi8DsZZpVm2771Uds4bNBfGAsSmbqMZf94TmFIiV0IotM
         papClaC2/aZffHR+XqgoZo4j2MnFAdL4UGvNpneRD5je8lHmtjkqScC/L/zuGybHYPEX
         9XfE2eeSSr9yHD97xJvqsXzH9JakL+7B+x5gKH8ta7wc7QNGmfl9TBLu/WKOC/F07m1u
         rDWh6kt7eu+EL36hbq1rKk190PGiUVOBG/VqqP1funedAiXLumeEhOIEcGSsHShF28IS
         /eByRUHKu6GOOD/EgDlZXJk32vZsnCuBjMEg90hs2nvCAkDO99yKRgILBxXgRpec7DZg
         VmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjy7XTatXC+XxCQYn4bK+GvF+gmfm7vqZf4bRJfFvqE=;
        b=K/2fysEA/jHEYMoOqlyIDuPcXwM6P9UwFRaXVgJFex7XFiJsUUmH/wZ57KNFRw6mJD
         Mkk8OhxpjTX21UT58Iq4fW+RG/BocNzO9tD6zJ59106heXVVIjlfCwgTlkDue7qCn2mZ
         imlQlbGvwFu/bj8tskqljO29fU80h05N48jyp5b2JmfHFlSrh805x34V0foEaVY0fIVI
         f+1fuzL9VKU/PbvprshI9fYosQ/dX9izvfRToQw2445Kzf6cw6WG+ywDP+QMRN5/t976
         MXnsw0vw8WvA/fSN99KNpdoikwbI9GqQMDKhBGSZScS2oQkKNOF5IP3pMQXmT94s3uzI
         ditA==
X-Gm-Message-State: AO0yUKX355vkrA6bubLEv2/YNQl3zM1DrVG0ZwRLsF8IXeYJKHTqZ4zi
        HHp66UOajPsfeYQFBpurSmITTg==
X-Google-Smtp-Source: AK7set9D2pdjPY2VUsGWgakrRbvVWNA5mmQY2HD7k+FFoINpouHWlS9FQDY1Kw+RslKHuQgrQWkZqw==
X-Received: by 2002:a05:600c:328a:b0:3dc:50bc:da70 with SMTP id t10-20020a05600c328a00b003dc50bcda70mr5851830wmp.10.1677072832575;
        Wed, 22 Feb 2023 05:33:52 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d6351000000b002c70a68111asm1895156wrw.83.2023.02.22.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:33:52 -0800 (PST)
References: <0f78b654-86d9-3bbe-9fa5-003479b0cdbe@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH RFC] mmc: meson-gx: improve clock privisioning
Date:   Wed, 22 Feb 2023 12:15:08 +0100
In-reply-to: <0f78b654-86d9-3bbe-9fa5-003479b0cdbe@gmail.com>
Message-ID: <1j4jrdq0xt.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Sat 18 Feb 2023 at 21:07, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Motivation for dealing with this code is that the driver doesn't work
> on my SC2-based test system (HK1 RBOX X4S, based on ah212 board).
>
> The current code makes the assumption that clkin0 is set to XTAL rate
> (24MHz) or less, otherwise the initial frequency of 400kHz can't be set,
> considering that the maximum divider value is 63.
> Currently there's no code for changing the rate of clkin0.

Because it was expected the bootloader would leave clkin0 (the MMC clk)
on the XTAL. This has holded true on all the SoC so far. It is a fairly
weak and unsafe assumption for sure.

>
> On my system clkin0 is set to 1Ghz (fclkdiv2) when meson-gx mmc driver
> is loaded. Therefore the driver doesn't work for me as-is.
>
> Further facts to consider:
>
> The MMC block internal divider isn't strictly needed for clock generation
> because the clkin0 hierarchy includes a better (wider) divider that
> we could use. It's primary purpose is supporting resampling. The bigger
> the divider value the more granularity we have for resampling.

I already tried to get rid of clkin1 in the past.
You may indeed get fdiv2 and other clocks through the mmc clock of the
main clock tree. However, getting fdiv2 (or another clock) through this
path caused problem under various conditions with high speed modes (such
as HS200 and SDR).

It should have been equivalent, but it was not. Revisiting this is a
good idea but it will require a *LOT* of tests on all the
supported HW.

>
> clkin1 is fclkdiv2, and this clock is one parent of clkin0 anyway.
> Therefore the MMC block internal mux isn't strictly needed.
>

In theory, it is not needed - In practice, it is needed.

> What the proposed change does:
> - Ignore the MMC block internal mux and use clkin0 only.
> - Before setting rate of mmc_clk, set clkin0 to the rate closest to
>   63 (max_div) * requested_rate. This allows for maximum divider value
>   and therefore most granularity for resampling.
>
> The changed driver works fine on my system.

Initializing clkin0 to force it back on XTAL after devm_clk_get() would
solve your problem too. It would be far simpler without any risk for the
other supported HW in the short term.

>
> I have limited insight in the other Amlogic families supported by this
> driver. Therefore patch comes as RFC.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 77 +++++++++++++--------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 2b963a81c..83d849db6 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -32,6 +32,7 @@
>  
>  #define SD_EMMC_CLOCK 0x0
>  #define   CLK_DIV_MASK GENMASK(5, 0)
> +#define     CLK_DIV_MASK_WIDTH __builtin_popcountl(CLK_DIV_MASK)
>  #define   CLK_SRC_MASK GENMASK(7, 6)
>  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
>  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
> @@ -131,8 +132,6 @@
>  #define SD_EMMC_PRE_REQ_DONE BIT(0)
>  #define SD_EMMC_DESC_CHAIN_MODE BIT(1)
>  
> -#define MUX_CLK_NUM_PARENTS 2
> -
>  struct meson_mmc_data {
>  	unsigned int tx_delay_mask;
>  	unsigned int rx_delay_mask;
> @@ -155,7 +154,7 @@ struct meson_host {
>  	struct	mmc_command	*cmd;
>  
>  	void __iomem *regs;
> -	struct clk *mux_clk;
> +	struct clk *clkin;
>  	struct clk *mmc_clk;
>  	unsigned long req_rate;
>  	bool ddr;
> @@ -203,6 +202,21 @@ struct meson_host {
>  #define CMD_RESP_MASK GENMASK(31, 1)
>  #define CMD_RESP_SRAM BIT(0)
>  
> +static int meson_mmc_clk_set_rate(struct meson_host *host, unsigned long rate)
> +{
> +	unsigned long max_div;
> +	int ret;
> +
> +	/* maximize divider value, this improves resampling granularity */
> +	max_div = min(ULONG_MAX / rate, (1UL << CLK_DIV_MASK_WIDTH) - 1);
> +
> +	ret = clk_set_rate(host->clkin, rate * max_div);
> +	if (ret)
> +		return ret;
> +
> +	return clk_set_rate(host->mmc_clk, rate);
> +}
> +
>  static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
>  {
>  	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
> @@ -386,7 +400,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
>  	writel(cfg, host->regs + SD_EMMC_CFG);
>  	host->ddr = ddr;
>  
> -	ret = clk_set_rate(host->mmc_clk, rate);
> +	ret = meson_mmc_clk_set_rate(host, rate);
>  	if (ret) {
>  		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
>  			rate, ret);
> @@ -420,11 +434,9 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
>  static int meson_mmc_clk_init(struct meson_host *host)
>  {
>  	struct clk_init_data init;
> -	struct clk_mux *mux;
>  	struct clk_divider *div;
>  	char clk_name[32];
> -	int i, ret = 0;
> -	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
> +	int ret = 0;
>  	const char *clk_parent[1];
>  	u32 clk_reg;
>  
> @@ -438,40 +450,10 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  		clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>  	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>  
> -	/* get the mux parents */
> -	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> -		struct clk *clk;
> -		char name[16];
> -
> -		snprintf(name, sizeof(name), "clkin%d", i);
> -		clk = devm_clk_get(host->dev, name);
> -		if (IS_ERR(clk))
> -			return dev_err_probe(host->dev, PTR_ERR(clk),
> -					     "Missing clock %s\n", name);
> -
> -		mux_parent_names[i] = __clk_get_name(clk);

=> Here you could init clkin0

Another solution is use 'assigned-rate' and 'assigned-parent' in DT
to properly set the MMC clock coming from the main clock tree. Maybe it
would be better.

> -	}
> -
> -	/* create the mux */
> -	mux = devm_kzalloc(host->dev, sizeof(*mux), GFP_KERNEL);
> -	if (!mux)
> -		return -ENOMEM;
> -
> -	snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
> -	init.name = clk_name;
> -	init.ops = &clk_mux_ops;
> -	init.flags = 0;
> -	init.parent_names = mux_parent_names;
> -	init.num_parents = MUX_CLK_NUM_PARENTS;
> -
> -	mux->reg = host->regs + SD_EMMC_CLOCK;
> -	mux->shift = __ffs(CLK_SRC_MASK);
> -	mux->mask = CLK_SRC_MASK >> mux->shift;
> -	mux->hw.init = &init;
> -
> -	host->mux_clk = devm_clk_register(host->dev, &mux->hw);
> -	if (WARN_ON(IS_ERR(host->mux_clk)))
> -		return PTR_ERR(host->mux_clk);
> +	host->clkin = devm_clk_get(host->dev, "clkin0");
> +	if (IS_ERR(host->clkin))
> +		return dev_err_probe(host->dev, PTR_ERR(host->clkin),
> +				     "Missing clkin0\n");
>  
>  	/* create the divider */
>  	div = devm_kzalloc(host->dev, sizeof(*div), GFP_KERNEL);
> @@ -481,14 +463,14 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
>  	init.name = clk_name;
>  	init.ops = &clk_divider_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> -	clk_parent[0] = __clk_get_name(host->mux_clk);
> +	init.flags = 0;
> +	clk_parent[0] = __clk_get_name(host->clkin);
>  	init.parent_names = clk_parent;
>  	init.num_parents = 1;
>  
>  	div->reg = host->regs + SD_EMMC_CLOCK;
>  	div->shift = __ffs(CLK_DIV_MASK);
> -	div->width = __builtin_popcountl(CLK_DIV_MASK);
> +	div->width = CLK_DIV_MASK_WIDTH;
>  	div->hw.init = &init;
>  	div->flags = CLK_DIVIDER_ONE_BASED;
>  
> @@ -497,11 +479,12 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  		return PTR_ERR(host->mmc_clk);
>  
>  	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> -	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
> -	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
> +	ret = meson_mmc_clk_set_rate(host, 400000);
>  	if (ret)
>  		return ret;
>  
> +	host->mmc->f_min = clk_get_rate(host->mmc_clk);
> +

This diff actually changes nothing

>  	return clk_prepare_enable(host->mmc_clk);
>  }
>  
> @@ -531,7 +514,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
>  	int ret;
>  
>  	/* Resampling is done using the source clock */
> -	max_dly = DIV_ROUND_UP(clk_get_rate(host->mux_clk),
> +	max_dly = DIV_ROUND_UP(clk_get_rate(host->clkin),
>  			       clk_get_rate(host->mmc_clk));
>  
>  	val = readl(host->regs + host->data->adjust);

