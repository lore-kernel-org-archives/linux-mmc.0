Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC82DC6FA8E
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Feb 2023 22:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBXWKm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBXWKl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2023 17:10:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20797662BF
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2023 14:10:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s26so2834399edw.11
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2023 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kye/t9BpGR7Zddn6GlLxGPICXa18i0Y3wLjrRuXRctM=;
        b=GzsbE3Q9ly/YBIxPyWh/5d4NwKqruu5TIhdgiSz9JOsVLfGI46+5tW7D3rSPf9GPcs
         aa8Z9V1i7t4W56xI3i+gT72n+cuOD/ljVyX4rBk792+Othv1IXyB12UpB3QoIYfM2Alg
         P9RwEzY0hG2vQhNB8XvDZ+kG8k54C+AGHJ8c2Ohbg9Akd+wqfVsQVQnmMUCSJ4DCBi6L
         /bhi/sM/ELZ29B9Qif2kZdKr2BZme8xtwcQ3c+Ihu/q1DvGKAAXxlhVqZnXxNLgJl+Aa
         YoH8r2lkX1WYSnZ74P/s3FlrZi420bYM9LoRlNBgJjzl0Jb+vHIilaTJkM5cUZP/fS0W
         i0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kye/t9BpGR7Zddn6GlLxGPICXa18i0Y3wLjrRuXRctM=;
        b=ZaKFMNLXeFvTAa13dzHlPHC8XmfmPg56lkfE7czgXRs12ZMk9T07fy+LcV9za4SHq6
         cP5cvpHAVYL1FZq5cBcfyaEpT7i1/T+e5ZD3XYviv0QWJAeFTzTSCxq7lnP666myRD5B
         /zGPy0yxezvruSzXJ0lHxXijn1An+8i4tuF4+gaDx3PZ+GAron8F0574SX7yT3nvXS9x
         RDm1m9KNxCV9YZMV2N4mhueKSOmly5lHb6iPplfrXATeoPcCh4pfvMvwZGv5LnqRynYi
         VFmBBK+TQ0eVs69NOpSv35xwGbuHorPHBMxgoh3I4zCdBxxMqvIxfuH6E9RXYNKfC7Wh
         D2NA==
X-Gm-Message-State: AO0yUKVRyBGXtYdkvaqhrsJ5665VPZeUZGZ2u4+PnbfFrJznnr0KTPGq
        GD8GzFkM48YNQXl4Bg6MjWY=
X-Google-Smtp-Source: AK7set/WJEmfr4bwzcdUMsDiGqQD9zWm9wT7CZx8+yey0Ma1Zzpl4b8q2uPeEEStvFzDJek+K/TpWQ==
X-Received: by 2002:a50:fb06:0:b0:4ac:be42:5c66 with SMTP id d6-20020a50fb06000000b004acbe425c66mr16768112edq.11.1677276635362;
        Fri, 24 Feb 2023 14:10:35 -0800 (PST)
Received: from ?IPV6:2a01:c23:b8b4:b000:4112:2010:ca46:c1a4? (dynamic-2a01-0c23-b8b4-b000-4112-2010-ca46-c1a4.c23.pool.telefonica.de. [2a01:c23:b8b4:b000:4112:2010:ca46:c1a4])
        by smtp.googlemail.com with ESMTPSA id z9-20020a50cd09000000b004ac54d4da22sm192716edi.71.2023.02.24.14.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:10:34 -0800 (PST)
Message-ID: <26b04db1-cc0b-8004-e90d-0cf9ed3090b3@gmail.com>
Date:   Fri, 24 Feb 2023 23:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <0f78b654-86d9-3bbe-9fa5-003479b0cdbe@gmail.com>
 <1j4jrdq0xt.fsf@starbuckisacylon.baylibre.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH RFC] mmc: meson-gx: improve clock privisioning
In-Reply-To: <1j4jrdq0xt.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22.02.2023 12:15, Jerome Brunet wrote:
> 
> On Sat 18 Feb 2023 at 21:07, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> Motivation for dealing with this code is that the driver doesn't work
>> on my SC2-based test system (HK1 RBOX X4S, based on ah212 board).
>>
>> The current code makes the assumption that clkin0 is set to XTAL rate
>> (24MHz) or less, otherwise the initial frequency of 400kHz can't be set,
>> considering that the maximum divider value is 63.
>> Currently there's no code for changing the rate of clkin0.
> 
> Because it was expected the bootloader would leave clkin0 (the MMC clk)
> on the XTAL. This has holded true on all the SoC so far. It is a fairly
> weak and unsafe assumption for sure.
> 
>>
>> On my system clkin0 is set to 1Ghz (fclkdiv2) when meson-gx mmc driver
>> is loaded. Therefore the driver doesn't work for me as-is.
>>
>> Further facts to consider:
>>
>> The MMC block internal divider isn't strictly needed for clock generation
>> because the clkin0 hierarchy includes a better (wider) divider that
>> we could use. It's primary purpose is supporting resampling. The bigger
>> the divider value the more granularity we have for resampling.
> 
> I already tried to get rid of clkin1 in the past.
> You may indeed get fdiv2 and other clocks through the mmc clock of the
> main clock tree. However, getting fdiv2 (or another clock) through this
> path caused problem under various conditions with high speed modes (such
> as HS200 and SDR).
> 
> It should have been equivalent, but it was not. Revisiting this is a
> good idea but it will require a *LOT* of tests on all the
> supported HW.
> 
That's the type of feedback I was hoping for when sending the patch as RFC.
Thanks. I didn't notice any problems with HS200 and the patch on my system.

>>
>> clkin1 is fclkdiv2, and this clock is one parent of clkin0 anyway.
>> Therefore the MMC block internal mux isn't strictly needed.
>>
> 
> In theory, it is not needed - In practice, it is needed.
> 
>> What the proposed change does:
>> - Ignore the MMC block internal mux and use clkin0 only.
>> - Before setting rate of mmc_clk, set clkin0 to the rate closest to
>>   63 (max_div) * requested_rate. This allows for maximum divider value
>>   and therefore most granularity for resampling.
>>
>> The changed driver works fine on my system.
> 
> Initializing clkin0 to force it back on XTAL after devm_clk_get() would
> solve your problem too. It would be far simpler without any risk for the
> other supported HW in the short term.
> 
That's what I did in the first place to make it work on my system.

>>
>> I have limited insight in the other Amlogic families supported by this
>> driver. Therefore patch comes as RFC.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 77 +++++++++++++--------------------
>>  1 file changed, 30 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 2b963a81c..83d849db6 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -32,6 +32,7 @@
>>  
>>  #define SD_EMMC_CLOCK 0x0
>>  #define   CLK_DIV_MASK GENMASK(5, 0)
>> +#define     CLK_DIV_MASK_WIDTH __builtin_popcountl(CLK_DIV_MASK)
>>  #define   CLK_SRC_MASK GENMASK(7, 6)
>>  #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
>>  #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
>> @@ -131,8 +132,6 @@
>>  #define SD_EMMC_PRE_REQ_DONE BIT(0)
>>  #define SD_EMMC_DESC_CHAIN_MODE BIT(1)
>>  
>> -#define MUX_CLK_NUM_PARENTS 2
>> -
>>  struct meson_mmc_data {
>>  	unsigned int tx_delay_mask;
>>  	unsigned int rx_delay_mask;
>> @@ -155,7 +154,7 @@ struct meson_host {
>>  	struct	mmc_command	*cmd;
>>  
>>  	void __iomem *regs;
>> -	struct clk *mux_clk;
>> +	struct clk *clkin;
>>  	struct clk *mmc_clk;
>>  	unsigned long req_rate;
>>  	bool ddr;
>> @@ -203,6 +202,21 @@ struct meson_host {
>>  #define CMD_RESP_MASK GENMASK(31, 1)
>>  #define CMD_RESP_SRAM BIT(0)
>>  
>> +static int meson_mmc_clk_set_rate(struct meson_host *host, unsigned long rate)
>> +{
>> +	unsigned long max_div;
>> +	int ret;
>> +
>> +	/* maximize divider value, this improves resampling granularity */
>> +	max_div = min(ULONG_MAX / rate, (1UL << CLK_DIV_MASK_WIDTH) - 1);
>> +
>> +	ret = clk_set_rate(host->clkin, rate * max_div);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return clk_set_rate(host->mmc_clk, rate);
>> +}
>> +
>>  static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
>>  {
>>  	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
>> @@ -386,7 +400,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
>>  	writel(cfg, host->regs + SD_EMMC_CFG);
>>  	host->ddr = ddr;
>>  
>> -	ret = clk_set_rate(host->mmc_clk, rate);
>> +	ret = meson_mmc_clk_set_rate(host, rate);
>>  	if (ret) {
>>  		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
>>  			rate, ret);
>> @@ -420,11 +434,9 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
>>  static int meson_mmc_clk_init(struct meson_host *host)
>>  {
>>  	struct clk_init_data init;
>> -	struct clk_mux *mux;
>>  	struct clk_divider *div;
>>  	char clk_name[32];
>> -	int i, ret = 0;
>> -	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
>> +	int ret = 0;
>>  	const char *clk_parent[1];
>>  	u32 clk_reg;
>>  
>> @@ -438,40 +450,10 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>  		clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>>  	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>>  
>> -	/* get the mux parents */
>> -	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>> -		struct clk *clk;
>> -		char name[16];
>> -
>> -		snprintf(name, sizeof(name), "clkin%d", i);
>> -		clk = devm_clk_get(host->dev, name);
>> -		if (IS_ERR(clk))
>> -			return dev_err_probe(host->dev, PTR_ERR(clk),
>> -					     "Missing clock %s\n", name);
>> -
>> -		mux_parent_names[i] = __clk_get_name(clk);
> 
> => Here you could init clkin0
> 
> Another solution is use 'assigned-rate' and 'assigned-parent' in DT
> to properly set the MMC clock coming from the main clock tree. Maybe it
> would be better.
> 

I think you mean assigned-clocks and assigned-clock-rates.
Yes, this would be another option. Thanks for the hint.

>> -	}
>> -
>> -	/* create the mux */
>> -	mux = devm_kzalloc(host->dev, sizeof(*mux), GFP_KERNEL);
>> -	if (!mux)
>> -		return -ENOMEM;
>> -
>> -	snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
>> -	init.name = clk_name;
>> -	init.ops = &clk_mux_ops;
>> -	init.flags = 0;
>> -	init.parent_names = mux_parent_names;
>> -	init.num_parents = MUX_CLK_NUM_PARENTS;
>> -
>> -	mux->reg = host->regs + SD_EMMC_CLOCK;
>> -	mux->shift = __ffs(CLK_SRC_MASK);
>> -	mux->mask = CLK_SRC_MASK >> mux->shift;
>> -	mux->hw.init = &init;
>> -
>> -	host->mux_clk = devm_clk_register(host->dev, &mux->hw);
>> -	if (WARN_ON(IS_ERR(host->mux_clk)))
>> -		return PTR_ERR(host->mux_clk);
>> +	host->clkin = devm_clk_get(host->dev, "clkin0");
>> +	if (IS_ERR(host->clkin))
>> +		return dev_err_probe(host->dev, PTR_ERR(host->clkin),
>> +				     "Missing clkin0\n");
>>  
>>  	/* create the divider */
>>  	div = devm_kzalloc(host->dev, sizeof(*div), GFP_KERNEL);
>> @@ -481,14 +463,14 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>  	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
>>  	init.name = clk_name;
>>  	init.ops = &clk_divider_ops;
>> -	init.flags = CLK_SET_RATE_PARENT;
>> -	clk_parent[0] = __clk_get_name(host->mux_clk);
>> +	init.flags = 0;
>> +	clk_parent[0] = __clk_get_name(host->clkin);
>>  	init.parent_names = clk_parent;
>>  	init.num_parents = 1;
>>  
>>  	div->reg = host->regs + SD_EMMC_CLOCK;
>>  	div->shift = __ffs(CLK_DIV_MASK);
>> -	div->width = __builtin_popcountl(CLK_DIV_MASK);
>> +	div->width = CLK_DIV_MASK_WIDTH;
>>  	div->hw.init = &init;
>>  	div->flags = CLK_DIVIDER_ONE_BASED;
>>  
>> @@ -497,11 +479,12 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>  		return PTR_ERR(host->mmc_clk);
>>  
>>  	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>> -	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
>> -	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
>> +	ret = meson_mmc_clk_set_rate(host, 400000);
>>  	if (ret)
>>  		return ret;
>>  
>> +	host->mmc->f_min = clk_get_rate(host->mmc_clk);
>> +
> 
> This diff actually changes nothing
> 
>>  	return clk_prepare_enable(host->mmc_clk);
>>  }
>>  
>> @@ -531,7 +514,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
>>  	int ret;
>>  
>>  	/* Resampling is done using the source clock */
>> -	max_dly = DIV_ROUND_UP(clk_get_rate(host->mux_clk),
>> +	max_dly = DIV_ROUND_UP(clk_get_rate(host->clkin),
>>  			       clk_get_rate(host->mmc_clk));
>>  
>>  	val = readl(host->regs + host->data->adjust);
> 

