Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A232C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 00:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE85761131
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 00:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhIWAEB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhIWAEB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 20:04:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28AC061574;
        Wed, 22 Sep 2021 17:02:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id gs10so3112674qvb.13;
        Wed, 22 Sep 2021 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6za8hvNiMknZJLAQShJVN9k8ISMwqJs16dYb7Dbhy5I=;
        b=axUK3TKinPUn6A14DlJ5l75sUiHUS4zA4aiWlQb2xZNI7d/ZObmdqIZAwSJF6Qcx3X
         Bxveue63eavt8VkKBEHVhr5BP/mpZ4LxgbBBPS+If5Unl9y8AL15Fby7WugMV7wAbGrh
         53pH+8O1hJDpwkBoww1i77rp+yHIn34Ss/oGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6za8hvNiMknZJLAQShJVN9k8ISMwqJs16dYb7Dbhy5I=;
        b=b8wGX0nxwfKkdKgGGNBjnlfHNCCurM5bB91wv8zWss1CjFD6QpxPc/2vwX7iSBM+bD
         4s8wSC/Lv3wjxygpF1bBwJ9XgMTJHq+DfX4GSQAEcY8PzC17NEIPsFkuOVv1tIyRVWcr
         xxeLZK/YCa8q1ZSL5BB4jIK95CQSc2ttnTSvirOpOxs+zhRDxVlenF6ybcMwmtzSufFj
         qn5Way7olLyUPy2FFia/+j8cQksIW7t5lkOUfLLjfYJPjvEDettFGu/R2HoBIVIfS2qU
         pCzsUiTjeCb7PqeTE2cHTT1/yOXICmlG7lp7RAMbtPiBCgqT7MWkfZjXaiPiMDd5rN7Y
         7P7Q==
X-Gm-Message-State: AOAM532U2LDwLKqpT3gFSgCTPe8JbT9T8SME2iqQGHpM0Max+PpA50kK
        xHkn2FbYuUDwGnOGgm8+p72j8V3t+bJ77XEG4/OOrTR37RMDfQ==
X-Google-Smtp-Source: ABdhPJwXwTQ1XjK5fncsWgEeP1jfN7ZYA6DFOZN7Q3GRnYZd8PBPLFUInicZnO0NAukPfyU/GXMHGGR33J3eFlRlg9s=
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr1959081qvx.17.1632355349480;
 Wed, 22 Sep 2021 17:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com> <20210922103116.30652-2-chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20210922103116.30652-2-chin-ting_kuo@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 23 Sep 2021 00:02:17 +0000
Message-ID: <CACPK8XeeEeQb52ZHYaN49r_Vso-xUHamDyrA+bFvP4_ESQs9dA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: aspeed: ast2600: Porting sdhci clock source
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Sept 2021 at 10:31, Chin-Ting Kuo
<chin-ting_kuo@aspeedtech.com> wrote:
>
> - There are two clock sources used to generate
>   SD/SDIO clock, APLL clock and HCLK (200MHz).
>   User can select which clock source should be used
>   by configuring SCU310[8].
> - The SD/SDIO clock divider selection table SCU310[30:28]
>   is different between AST2600-A1 and AST2600-A2/A3.
>   For AST2600-A1, 200MHz SD/SDIO clock cannot be
>   gotten by the dividers in SCU310[30:28] if APLL
>   is not the multiple of 200MHz and HCLK is 200MHz.
>   For AST2600-A2/A3, a new divider, "1", is added and
>   200MHz SD/SDIO clock can be obtained by adopting HCLK
>   as clock source and setting SCU310[30:28] to 3b'111.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 69 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bc3be5f3eae1..a6778c18274a 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -168,6 +168,30 @@ static const struct clk_div_table ast2600_div_table[] = {
>         { 0 }
>  };
>
> +static const struct clk_div_table ast2600_sd_div_a1_table[] = {

Let's put the revision next to the ast2600 like the other tables:

ast2600_a1_sd_div_table

> +       { 0x0, 2 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 16 },
> +       { 0 }
> +};
> +
> +static const struct clk_div_table ast2600_sd_div_a2_table[] = {

For naming; can I propose we omit the revision for the A2/A3+ case? So
this one would be called:

ast2600_sd_div_table

> +       { 0x0, 2 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 1 },
> +       { 0 }
> +};
> +
>  /* For hpll/dpll/epll/mpll */
>  static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
>  {
> @@ -424,6 +448,11 @@ static const char *const emmc_extclk_parent_names[] = {
>         "mpll",
>  };
>
> +static const char *const sd_extclk_parent_names[] = {
> +       "hclk",
> +       "apll",
> +};
> +
>  static const char * const vclk_parent_names[] = {
>         "dpll",
>         "d1pll",
> @@ -523,18 +552,42 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
>
> -       /* SD/SDIO clock divider and gate */
> -       hw = clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION4, 31, 0,
> -                       &aspeed_g6_clk_lock);
> +       clk_hw_register_fixed_rate(NULL, "hclk", NULL, 0, 200000000);
> +
> +       regmap_read(map, 0x310, &val);

Use the #defines for the register number.

> +       hw = clk_hw_register_mux(dev, "sd_extclk_mux",
> +                                sd_extclk_parent_names,
> +                                ARRAY_SIZE(sd_extclk_parent_names), 0,
> +                                scu_g6_base + ASPEED_G6_CLK_SELECTION4, 8, 1,
> +                                0, &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> -       hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> -                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> -                       ast2600_div_table,
> -                       &aspeed_g6_clk_lock);
> +
> +       hw = clk_hw_register_gate(dev, "sd_extclk_gate", "sd_extclk_mux",
> +                                 0, scu_g6_base + ASPEED_G6_CLK_SELECTION4,
> +                                 31, 0, &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> +
> +       regmap_read(map, 0x14, &val);
> +       /* AST2600-A2/A3 clock divisor is different from AST2600-A1 */
> +       if (((val & GENMASK(23, 16)) >> 16) >= 2) {

I've got a little patch that I recommend you base your series on (feel
free to include it in your series when posting v2 to make it
self-contained):

https://lore.kernel.org/all/20210922235449.213631-1-joel@jms.id.au/

With this one you can do:

const struct clk_div_table* table;

 if (soc_rev >= 2)
   table = ast2600_sd_div_table;
else
   table = ast2600_a1_sd_div_table;

Then you don't need to duplicate the registration for each case:

               hw = clk_hw_register_divider_table(dev, "sd_extclk",
"sd_extclk_gate",
                                       0, scu_g6_base +
ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
                                       table,
                                       &aspeed_g6_clk_lock);
               if (IS_ERR(hw))
                       return PTR_ERR(hw);

> +               /* AST2600-A2/A3 */
> +               hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> +                                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> +                                       ast2600_sd_div_a2_table,
> +                                       &aspeed_g6_clk_lock);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +       } else {
> +               /* AST2600-A1 */
> +               hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> +                                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> +                                       ast2600_sd_div_a1_table,
> +                                       &aspeed_g6_clk_lock);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +       }
>         aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
>
>         /* MAC1/2 RMII 50MHz RCLK */
> --
> 2.17.1
>
