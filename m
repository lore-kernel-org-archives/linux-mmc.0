From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: poll ESDHC_CLOCK_STABLE bit with udelay
Date: Fri, 28 Apr 2017 14:53:57 +0200
Message-ID: <CAPDyKFpq-i1WsO1oRVED+QXq0L0xWok_mgCYhHfancrhbc9=kw@mail.gmail.com>
References: <1493174749-31003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35716 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993785AbdD1MyE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 08:54:04 -0400
Received: by mail-qt0-f182.google.com with SMTP id y33so49041849qta.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Apr 2017 05:54:04 -0700 (PDT)
In-Reply-To: <1493174749-31003-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 26 April 2017 at 04:45, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> The loop to poll ESDHC_CLOCK_STABLE bit with mdelay would waste time
> because the time to stabilize is much less than 1 ms. This patch is
> to use udelay instead to avoid time wasting.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7518360..77dfc59 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -445,7 +445,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         int pre_div = 1;
>         int div = 1;
> -       u32 timeout;
> +       ktime_t timeout;
>         u32 temp;
>
>         host->mmc->actual_clock = 0;
> @@ -489,15 +489,14 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>
>         /* Wait max 20 ms */
> -       timeout = 20;
> +       timeout = ktime_add_ms(ktime_get(), 20);
>         while (!(sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)) {
> -               if (timeout == 0) {
> +               if (ktime_after(ktime_get(), timeout)) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                 mmc_hostname(host->mmc));
>                         return;
>                 }
> -               timeout--;
> -               mdelay(1);
> +               udelay(10);
>         }
>
>         temp |= ESDHC_CLOCK_SDCLKEN;
> --
> 2.1.0.27.g96db324
>
