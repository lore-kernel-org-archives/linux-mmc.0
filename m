Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE2C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 07:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF522465E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 07:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Acgp5tZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfLSHRt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:17:49 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46846 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfLSHRt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 02:17:49 -0500
Received: by mail-ua1-f65.google.com with SMTP id l6so1579203uap.13
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFrmnqEPPbDY1/f3NYkyVvMb3oZcHiAyKnagA8L56L0=;
        b=Acgp5tZ9wIxJ29UK5vYdxSWCvy4tq0bgEF9to7rD6AkLM2B0CFfjffg7nlJOh+WFXe
         oQvfO3Vo0okr+u627XvyBztEUgkbXRJgj0l+oJbBUEsqn5ilBd5UaZfchRriBiVXns3K
         4gDBP9kQTVCexOtXbj4qKwUutQ1n/9yMmdehCKedwMg5fNxj5IRRSmYKpSe+rF/mCEMw
         RGhAxA15p1NCDJIqVQMw6d8JEnh0kDcuhza8bLCsSEdiTpk6IQCnjPbciEA+tcThtyI2
         +DcdcHB4KJzgPV5GTNrjvUuGO6gpHwAwlDy+bIEqobnnvHfyH0xIYGc2Cwg/1YvW4aX7
         2+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFrmnqEPPbDY1/f3NYkyVvMb3oZcHiAyKnagA8L56L0=;
        b=pFb0GAmCEp4GDzJ6elOeyQjRFbpWeIrzhJ4JNykdg73yrIedXLMjvy/a+aJ5LAckTS
         yf+c3tkQTvj3WN8+/idIs7Kd+HPhye5TIRvZhej+/IR/WPqcT1JVHZ2p18OjdsdDu9q7
         L0Weh4tbGS42nSs0yE/REgivfsRttZ5b/aP/fN9op2iJgXIIu56qGQsmK/N5WzSNwXRS
         hRCIYfjJvqxQaSKWUCcp6S30QzO+8tRXAeLsZg3EFgrLT/t/5/Ev/tqQ95ElTMoH7t+f
         7BCF180rjL3l3vjcvfgN31V/lbrJ1Sj4Oo4A6akFwjI2Tl1cTFfOh4ZHHkSye7HPuYu2
         BmHw==
X-Gm-Message-State: APjAAAW+W4wJlIT4RZjvhv5vpAhrXt7RWDR5FWF28/Km90PTS1whqqvE
        zriod+PgEv3m8nlxRh81/UMQSXHOM8z6gB86tsWhHw==
X-Google-Smtp-Source: APXvYqxYyPkdqYqfGrvieUc9K+I/bpyQ463HOZQgmh+TwMfYB8fHt/c89IByMqF1FlUI6hkWest17gE/8QzeR0LCHoo=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr4478267uar.100.1576739868391;
 Wed, 18 Dec 2019 23:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20191219032335.26528-1-yangbo.lu@nxp.com>
In-Reply-To: <20191219032335.26528-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 08:17:11 +0100
Message-ID: <CAPDyKFrO1x_a-UpeRHYqczJYjgXGMC9Qdmtc+sQu6nexerjJ4A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Dec 2019 at 04:24, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The erratum A-009204 workaround patch was reverted because of
> incorrect implementation.
>
> 8b6dc6b mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
>         erratum A-009204 support"
>
> This patch is to re-implement the workaround (add a 5 ms delay
> before setting SYSCTL[RSTD] to make sure all the DMA transfers
> are finished).
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

That was quick! :-)

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4abb781..cd3b676 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -80,6 +80,7 @@ struct sdhci_esdhc {
>         bool quirk_tuning_erratum_type1;
>         bool quirk_tuning_erratum_type2;
>         bool quirk_ignore_data_inhibit;
> +       bool quirk_delay_before_data_reset;
>         bool in_sw_tuning;
>         unsigned int peripheral_clock;
>         const struct esdhc_clk_fixup *clk_fixup;
> @@ -759,6 +760,11 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         u32 val;
>
> +       if (esdhc->quirk_delay_before_data_reset &&
> +           (mask & SDHCI_RESET_DATA) &&
> +           (host->flags & SDHCI_REQ_USE_DMA))
> +               mdelay(5);
> +
>         sdhci_reset(host, mask);
>
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> @@ -1218,6 +1224,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>         if (match)
>                 esdhc->clk_fixup = match->data;
>         np = pdev->dev.of_node;
> +
> +       if (of_device_is_compatible(np, "fsl,p2020-esdhc"))
> +               esdhc->quirk_delay_before_data_reset = true;
> +
>         clk = of_clk_get(np, 0);
>         if (!IS_ERR(clk)) {
>                 /*
> --
> 2.7.4
>
