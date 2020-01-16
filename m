Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31A3C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B772077C
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1Q6ohWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgAPOkM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39654 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:12 -0500
Received: by mail-vs1-f65.google.com with SMTP id y125so12795828vsb.6
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWfBK5b8xbjKGM4Ky9MDCp6ZllJaIuZTmxUmj1+vzV0=;
        b=M1Q6ohWVxoVPjyMIV0rK2OgkKrhkJTpDSEKlpDQ5QW7D9fBZz7s6r49JYmQ5KwI2ZI
         q/o5+qASJw4GhGTg6WK9BAL+jo8XjvAkEGc/M+e3+8YnSeSG7DYmTVwUV2JxI+vFjnYQ
         hYL3ptDYMq8f7Z8XvyQSw7vmBfLOghokXA7dSc1LOlka2bCImd8EDzSeo6e14JuoC9q6
         LzOFUgrldpXu5UudefW0DadE6xpRUMUr8DkdcrfiOu83vJ5Drzouzz2Y+aKdH95mns/A
         +sWjNKgiOzpk4DUuJiyxOjIc74bwtFuyzYAE9O8RQDsQe0iruGfWfN4eEEbBf4X/n0c2
         5WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWfBK5b8xbjKGM4Ky9MDCp6ZllJaIuZTmxUmj1+vzV0=;
        b=UO1f9t5H/N42i3fDpieJVdve1M4IqhCUqAe951IOSQF8kL8ju509t5dNwlPciAw3BB
         zfhiztsk+cKYn2MPCbk+XE7gr+btbmcYo1brCJAY1OKogLOtcIysZx1U0HUNgz8I80Yk
         maxj99FilbsSR2C3jQl1j+D3wysO/FCzcEe5rtPhoDCf71l7Gd6pTkI0F+6K89K0MBC0
         ildEC/tIslYaz61D1Ltm4KlDy2SG+jgkjGYJpzsLGeTNNSRJgC0w4pSc0nEFmwFuf1Sb
         XK+sAnB1v8tDkpDa8VesgpdT9li1KcDsfip3o+Ah9G0IS7+W0bpeeC7nb9UhrSFgwDV2
         sW1A==
X-Gm-Message-State: APjAAAUqCCHHsSaH1MTypWoX7gsIeqn+4RNSJvKjWMBkwuHDc5oar5e8
        MLsl57Li+aYNdoFPkS8lXXPHIno7NBGNExqSM2Uw0w==
X-Google-Smtp-Source: APXvYqw5+yoA4bjLrAFu0vR4x1xOyRoh+/qcdhkUy5E6uBIbH2PQP/Q0vabe/HQmUge1xlAoplfe0mlnslBKWrHK4Ws=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr1682601vsm.200.1579185611089;
 Thu, 16 Jan 2020 06:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20200108040713.38888-1-yangbo.lu@nxp.com>
In-Reply-To: <20200108040713.38888-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:34 +0100
Message-ID: <CAPDyKFr2k7j0PU5xOXqre_sQsEgMP13N9=sPgU15S_-=B_jyAw@mail.gmail.com>
Subject: Re: [v2, 1/2] mmc: sdhci-of-esdhc: fix esdhc_reset() for different
 controller versions
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jan 2020 at 05:08, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> This patch is to fix operating in esdhc_reset() for different
> controller versions, and to add bus-width restoring after data
> reset for eSDHC (verdor version <= 2.2).
>
> Also add annotation for understanding.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes for v2:
>         - Added ACK from Adrian.
>         - Used preferred style for comments.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 43 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index cd3b676..1110f90 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -758,23 +758,58 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> -       u32 val;
> +       u32 val, bus_width = 0;
>
> +       /*
> +        * Add delay to make sure all the DMA transfers are finished
> +        * for quirk.
> +        */
>         if (esdhc->quirk_delay_before_data_reset &&
>             (mask & SDHCI_RESET_DATA) &&
>             (host->flags & SDHCI_REQ_USE_DMA))
>                 mdelay(5);
>
> +       /*
> +        * Save bus-width for eSDHC whose vendor version is 2.2
> +        * or lower for data reset.
> +        */
> +       if ((mask & SDHCI_RESET_DATA) &&
> +           (esdhc->vendor_ver <= VENDOR_V_22)) {
> +               val = sdhci_readl(host, ESDHC_PROCTL);
> +               bus_width = val & ESDHC_CTRL_BUSWIDTH_MASK;
> +       }
> +
>         sdhci_reset(host, mask);
>
> -       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> -       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +       /*
> +        * Restore bus-width setting and interrupt registers for eSDHC
> +        * whose vendor version is 2.2 or lower for data reset.
> +        */
> +       if ((mask & SDHCI_RESET_DATA) &&
> +           (esdhc->vendor_ver <= VENDOR_V_22)) {
> +               val = sdhci_readl(host, ESDHC_PROCTL);
> +               val &= ~ESDHC_CTRL_BUSWIDTH_MASK;
> +               val |= bus_width;
> +               sdhci_writel(host, val, ESDHC_PROCTL);
> +
> +               sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +               sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +       }
>
> -       if (mask & SDHCI_RESET_ALL) {
> +       /*
> +        * Some bits have to be cleaned manually for eSDHC whose spec
> +        * version is higher than 3.0 for all reset.
> +        */
> +       if ((mask & SDHCI_RESET_ALL) &&
> +           (esdhc->spec_ver >= SDHCI_SPEC_300)) {
>                 val = sdhci_readl(host, ESDHC_TBCTL);
>                 val &= ~ESDHC_TB_EN;
>                 sdhci_writel(host, val, ESDHC_TBCTL);
>
> +               /*
> +                * Initialize eSDHC_DLLCFG1[DLL_PD_PULSE_STRETCH_SEL] to
> +                * 0 for quirk.
> +                */
>                 if (esdhc->quirk_unreliable_pulse_detection) {
>                         val = sdhci_readl(host, ESDHC_DLLCFG1);
>                         val &= ~ESDHC_DLL_PD_PULSE_STRETCH_SEL;
> --
> 2.7.4
>
