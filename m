Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA8C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 11:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F4820723
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 11:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJ2dTgIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgEYLND (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389897AbgEYLNC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 07:13:02 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E780C061A0E
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 04:13:01 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id f126so1588768vkb.13
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERC+Xl0BgKn7/zwCGuvjRjAlFVLpKsWW3yEcqO2kzsU=;
        b=eJ2dTgIapAN+q61WdlynGNe+eAdn+A2aw2uF+1UAqZuDear0I4B1Q2mjIS3xQ46C0+
         WuxPIetxveBDACKrjW9z/vi0RFLYmirt2EkvIbY79wrXcvHXtAc6HhcWG5sBNn1RaLZ0
         sm6bKOYnjVvIq3fPNPU1HIIiK/h/tCnCAHxuu4poOd8YBiXfX00m7XWtUvANNTWXJ71C
         5UAU5Nkcr5I5ZT5g0zoEPmSKrjwc51QWh3GeKSzzyKEIC4mP5pcb9Ts3SYpjSHgle4mC
         gKtKFOqGfs9jnzZAx1EfydPknsGp9t8U7AeJeaY/XWi3PiW0Ugp9zBapyawg0OjxayMA
         OHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERC+Xl0BgKn7/zwCGuvjRjAlFVLpKsWW3yEcqO2kzsU=;
        b=BQWfhkLLU8a1jFahh/Xs5Xs4uXjAlkikUl3nDk8ZrDbBDNS7mZnEOdQU8KDzmtzwsc
         bDK7vZF6E9rgR+TTJkaVfnSvvdxz91/AUXToZXU4J2UCpqCEACt9FsSpzQAO+kqKJq92
         B7VlLQJf40nPbsiymOxQWZb9nys1gbqIXhyTyI5g1KlVwsJj8ce4GEhMgdUfEyabP5GK
         cKHNKZMoe380TCerCaexGyIw2/xtI21LUTl7YQqfsevoj9ZP/UWYK4wnUIzFA96x5dhG
         PItotXCZL4chFjbrmWtnjmbT7i+xc4E684DUg4ofMMEFtTIx2y1jBA2pL4arC0d+cPmD
         RR1w==
X-Gm-Message-State: AOAM532AVQ++S9zJGj5YZX8MqWnF3c6PSl015QWilOX11UAUpa5NF8/o
        hbdjwn+ys9jSgQ+Se6WlcmGWICp3WpDPi91MY/rFHg==
X-Google-Smtp-Source: ABdhPJzzQZ7Whz6xN4KbEGSJoE0Ewg4CVKYVgNwgiypPhpB4LHoz80wEacaikyixTOTa9edjHBXEmbeqJW7Tf9aNhr8=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr19122405vkl.53.1590405180154;
 Mon, 25 May 2020 04:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200525102324.2723438-1-angelo.dureghello@timesys.com>
In-Reply-To: <20200525102324.2723438-1-angelo.dureghello@timesys.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 13:12:23 +0200
Message-ID: <CAPDyKFryv1VncT+kNk18jC03rJch6RFiHOuuHk3-hRD0rSf00A@mail.gmail.com>
Subject: Re: [PATCH for-next] m68k: coldfire/clk.c: move m5441x specific code
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 May 2020 at 12:17, Angelo Dureghello
<angelo.dureghello@timesys.com> wrote:
>
> Moving specific m5441x clk-related code in more appropriate location,
> since breaking compilation for other targets.
>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>

Applied for next, to get this tested asap, thanks!

Kind regards
Uffe

> ---
>  arch/m68k/coldfire/clk.c    | 15 ---------------
>  arch/m68k/coldfire/m5441x.c | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 75a057445472..7bc666e482eb 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -73,21 +73,6 @@ struct clk_ops clk_ops1 = {
>  #endif /* MCFPM_PPMCR1 */
>  #endif /* MCFPM_PPMCR0 */
>
> -static void __clk_enable2(struct clk *clk)
> -{
> -       __raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
> -}
> -
> -static void __clk_disable2(struct clk *clk)
> -{
> -       __raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
> -}
> -
> -struct clk_ops clk_ops2 = {
> -       .enable         = __clk_enable2,
> -       .disable        = __clk_disable2,
> -};
> -
>  struct clk *clk_get(struct device *dev, const char *id)
>  {
>         const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> index ffa02de1a3fb..1e5259a652d1 100644
> --- a/arch/m68k/coldfire/m5441x.c
> +++ b/arch/m68k/coldfire/m5441x.c
> @@ -204,6 +204,21 @@ static struct clk * const disable_clks[] __initconst = {
>         &__clk_1_29, /* uart 9 */
>  };
>
> +static void __clk_enable2(struct clk *clk)
> +{
> +       __raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
> +}
> +
> +static void __clk_disable2(struct clk *clk)
> +{
> +       __raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
> +}
> +
> +struct clk_ops clk_ops2 = {
> +       .enable         = __clk_enable2,
> +       .disable        = __clk_disable2,
> +};
> +
>  static void __init m5441x_clk_init(void)
>  {
>         unsigned i;
> --
> 2.26.2
>
