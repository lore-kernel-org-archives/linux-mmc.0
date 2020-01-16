Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7616C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B602075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9o6vSTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPOkD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:40:03 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37141 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:40:03 -0500
Received: by mail-ua1-f67.google.com with SMTP id h32so7709339uah.4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD/qHIHndlwBDVuKHvnlqnBtblQMaOPXn6P56Zfr34w=;
        b=u9o6vSTda2g1UhFLDhbkJCTHCIlVWNhJWRQLtLwwCyxOXyZl/zdnkWkV1zBGRDih26
         wUKjgkEkTpvs/WoAYC9AJo9luxUqrmDqWkT6DW8ifUNeBrYC7ioIbeFSuyHWRc4CmS5Y
         WumKCQhMmj9hDyWERTLYbctLVCEY3Y8rGq+HS7zxj0bKxKbbjtXPHTjWJP6b3s5OdHL9
         3rTRP0e7H1VbkxSDHi8W1eVaS5nhQVIVQJfh/7CP0JLCasRs9qgeFGs0g1XnI3TRxrye
         Br1/+zUdMcPxOsSJmKfiDlt2+J/m7uzO2cLUOZ2vfz7sFsPcLgtDXz2/c2QScXn156hp
         cyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD/qHIHndlwBDVuKHvnlqnBtblQMaOPXn6P56Zfr34w=;
        b=FibfIDPFmYgyEaoPFkEIGO6Jmouh2DLUs+YovAfhjFNQNWAim/wimgqt5yasELDtpm
         0XKm0hfcvQneL1uJGa2wUTbNwUISNeYefZpqm7y3sylnXU3SuL586M4XvSRqBXggRqy4
         gQMZo9ZsknJo4C9cM0pAYnS219ae4FJUMoFee/PJk3tGFmvJQ4gbwo3LogVtbDFvK0Js
         g2qwW4LnpVKiN81AsPVfzC2ngeDLl0klExkf3qfP6eBAd5oUAox+DC3rgl9q7s9RVQ5k
         EnlALKf4Cp7MDgBO+MOl5lvzEskXrehREtytvqOfdJ7QsdXxtRfV/UJ2hCSpaEiiVuIS
         I4ag==
X-Gm-Message-State: APjAAAXmYneLrrgMwGF95tqtUYOPeXuEEfFE/n+aQbWdbVsxsd6FQdu0
        5sCURy90WsHF36V49tr7MNNUleGKzHa0rOAcjnw+VA==
X-Google-Smtp-Source: APXvYqzOJc7QWlFWvGVgr88Mjl2YLK/D+fIMmFrL1BjTN2aOfDwrzzuoQ70YGeK3gvuMEV4khIUFQFhDk2aPEnCdRx4=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr18067444uar.100.1579185602134;
 Thu, 16 Jan 2020 06:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
In-Reply-To: <20191212075219.48625-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:26 +0100
Message-ID: <CAPDyKFrobSCLT+p0O3EbkdNMQroEH8S9+UkPjbFLLgAPvtuO_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use esdhc_tuning_window_ptr()
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Dec 2019 at 08:53, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> Convert to use a new function esdhc_tuning_window_ptr() to
> get tuning window start point and end point.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7f87a90..cd0f21e 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -882,20 +882,11 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
>         esdhc_clock_enable(host, true);
>  }
>
> -static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
> +static void esdhc_tuning_window_ptr(struct sdhci_host *host, u8 *window_start,
>                                     u8 *window_end)
>  {
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> -       u8 tbstat_15_8, tbstat_7_0;
>         u32 val;
>
> -       if (esdhc->quirk_tuning_erratum_type1) {
> -               *window_start = 5 * esdhc->div_ratio;
> -               *window_end = 3 * esdhc->div_ratio;
> -               return;
> -       }
> -
>         /* Write TBCTL[11:8]=4'h8 */
>         val = sdhci_readl(host, ESDHC_TBCTL);
>         val &= ~(0xf << 8);
> @@ -914,6 +905,25 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>         val = sdhci_readl(host, ESDHC_TBSTAT);
>         val = sdhci_readl(host, ESDHC_TBSTAT);
>
> +       *window_end = val & 0xff;
> +       *window_start = (val >> 8) & 0xff;
> +}
> +
> +static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
> +                                   u8 *window_end)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> +       u8 start_ptr, end_ptr;
> +
> +       if (esdhc->quirk_tuning_erratum_type1) {
> +               *window_start = 5 * esdhc->div_ratio;
> +               *window_end = 3 * esdhc->div_ratio;
> +               return;
> +       }
> +
> +       esdhc_tuning_window_ptr(host, &start_ptr, &end_ptr);
> +
>         /* Reset data lines by setting ESDHCCTL[RSTD] */
>         sdhci_reset(host, SDHCI_RESET_DATA);
>         /* Write 32'hFFFF_FFFF to IRQSTAT register */
> @@ -924,10 +934,8 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>          * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
>          * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
>          */
> -       tbstat_7_0 = val & 0xff;
> -       tbstat_15_8 = (val >> 8) & 0xff;
>
> -       if (abs(tbstat_15_8 - tbstat_7_0) > (4 * esdhc->div_ratio)) {
> +       if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
>                 *window_start = 8 * esdhc->div_ratio;
>                 *window_end = 4 * esdhc->div_ratio;
>         } else {
> --
> 2.7.4
>
