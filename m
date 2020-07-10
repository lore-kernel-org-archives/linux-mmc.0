Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DFC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 03:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70432078B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 03:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="OXG6ZPCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGJDDW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJDDW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 23:03:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C12C08C5CE;
        Thu,  9 Jul 2020 20:03:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so4434560ejb.2;
        Thu, 09 Jul 2020 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KRtR9SdpYUMidTMu6Xmuj8Q02i63whibThkqFtREHc=;
        b=OXG6ZPCAxCCAFxKGeTL6Oy1pdHDCjLE7HmgixA5c+sRgOyvyagscU036gw792Jyvro
         3ApdT4aFjcKGMIsGHK9bR2eNPTljVrUkQMhnn2ty4A2hcBYb5GlR7nQdsVN71AcTsm84
         dz/ySub8Vy57uB369VOkcXgz9JwwkjVndGkx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KRtR9SdpYUMidTMu6Xmuj8Q02i63whibThkqFtREHc=;
        b=lmJRZCnh6/1OXEBhTSrFIy7+SO56pn1QTzFpgtoxkACDvcm2oCftER1giJxAHxnO7l
         1JNUfVTwM6qYyYO9JYixptWpnsrAsXemJ0KRDLLDfsin917GSS5igmjQWDNeW3YyTyiw
         ONVQb4Qs9rqwZ2SjAIBq3esKvHozR9zZJWEhJHPp4OJOo7ofBV3/mG/S41roQX3rAEV3
         hUin9dl/N/FNmA2Ygm3lll8RFW/rwie6SK0whACnEZyzaj0I6zxcLBNm2opHlgt1ghLk
         Q0RTOOkDRFVIBSeEndbXxE5HnezwaqzgKdtvgo7kF9qP4GV2s0kL2sKg0mkjxykML0Wx
         wO8A==
X-Gm-Message-State: AOAM530NLhn9x6aljevtYq2AhpPJ8XwtQBWRvyb70apZVSnt3MKPtMXa
        iKLPeqVzV3PVnHPNiRBSbjEdztpBkVzHRx5VQwk=
X-Google-Smtp-Source: ABdhPJybxKH1f3z78Ubuw7bl1ZVf6foagkpmQuQSht982jLtNvxBTTVwTwgziMcBKS0m9Ulr5MgSCknrai84CeLlCCk=
X-Received: by 2002:a17:906:841:: with SMTP id f1mr25340332ejd.229.1594350200465;
 Thu, 09 Jul 2020 20:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-2-eajames@linux.ibm.com>
In-Reply-To: <20200709195706.12741-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 10 Jul 2020 03:03:08 +0000
Message-ID: <CACPK8Xd1RMXooVR99xZLxWdgb+Suw8KZrSX6nN1Ua0eUM=mH3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-mmc@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 Jul 2020 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
>
> The EMMC clock can be derived from either the HPLL or the MPLL. Register
> a clock mux so that the rate is calculated correctly based upon the
> parent.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Stephen, I think this should go to stable too.

Cheers,

Joel

> ---
>  drivers/clk/clk-ast2600.c | 49 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 99afc949925f..177368cac6dd 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -131,6 +131,18 @@ static const struct clk_div_table ast2600_eclk_div_table[] = {
>         { 0 }
>  };
>
> +static const struct clk_div_table ast2600_emmc_extclk_div_table[] = {
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
>  static const struct clk_div_table ast2600_mac_div_table[] = {
>         { 0x0, 4 },
>         { 0x1, 4 },
> @@ -390,6 +402,11 @@ static struct clk_hw *aspeed_g6_clk_hw_register_gate(struct device *dev,
>         return hw;
>  }
>
> +static const char *const emmc_extclk_parent_names[] = {
> +       "emmc_extclk_hpll_in",
> +       "mpll",
> +};
> +
>  static const char * const vclk_parent_names[] = {
>         "dpll",
>         "d1pll",
> @@ -459,16 +476,32 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_UARTX] = hw;
>
> -       /* EMMC ext clock divider */
> -       hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "hpll", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 15, 0,
> -                       &aspeed_g6_clk_lock);
> +       /* EMMC ext clock */
> +       hw = clk_hw_register_fixed_factor(dev, "emmc_extclk_hpll_in", "hpll",
> +                                         0, 1, 2);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> -       hw = clk_hw_register_divider_table(dev, "emmc_extclk", "emmc_extclk_gate", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 12, 3, 0,
> -                       ast2600_div_table,
> -                       &aspeed_g6_clk_lock);
> +
> +       hw = clk_hw_register_mux(dev, "emmc_extclk_mux",
> +                                emmc_extclk_parent_names,
> +                                ARRAY_SIZE(emmc_extclk_parent_names), 0,
> +                                scu_g6_base + ASPEED_G6_CLK_SELECTION1, 11, 1,
> +                                0, &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "emmc_extclk_mux",
> +                                 0, scu_g6_base + ASPEED_G6_CLK_SELECTION1,
> +                                 15, 0, &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       hw = clk_hw_register_divider_table(dev, "emmc_extclk",
> +                                          "emmc_extclk_gate", 0,
> +                                          scu_g6_base +
> +                                               ASPEED_G6_CLK_SELECTION1, 12,
> +                                          3, 0, ast2600_emmc_extclk_div_table,
> +                                          &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
> --
> 2.24.0
>
