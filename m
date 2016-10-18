From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make sure usdhc clock enabled while
 doing suspend
Date: Tue, 18 Oct 2016 11:18:17 +0200
Message-ID: <CAPDyKFpwEKjyd02oj20_fQkLEPaAniAHZTo6AYJDdqzsdSWH2g@mail.gmail.com>
References: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32879 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcJRJST (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 05:18:19 -0400
Received: by mail-qk0-f175.google.com with SMTP id n189so279926430qke.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 02:18:19 -0700 (PDT)
In-Reply-To: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <dongas86@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>

On 18 October 2016 at 09:39, Haibo Chen <haibo.chen@nxp.com> wrote:
> When suspend usdhc, it will access usdhc register. So usdhc clock
> should be enabled, otherwise the access usdhc register will return
> error or cause system hung.
>
> Take this into consideration, if system enable a usdhc and do not
> connect any SD/SDIO/MMC card, after system boot up, this usdhc
> will do runtime suspend, and close all usdhc clock. At this time,
> if suspend the system, due to no card persent, usdhc runtime resume
> will not be called. So usdhc clock still closed, then in suspend,
> once access usdhc register, system hung or bus error return.
>
> This patch make sure usdhc clock always enabled while doing usdhc
> suspend.

Yes, and since the clocks are kept enabled during system suspend that
means wasting power, doesn't it!?

May I propose another solution. Currently you deal only with clock
gating/ungating during runtime suspend/resume. I am wondering whether
you could extend those operations to be similar to what is needed
during system suspend/resume?

If that is possible, you can instead deploy the runtime PM centric
approach and get system suspend/resume for free. All you would have to
do is to assign the system PM callbacks to
pm_runtime_force_suspend|resume(). In that way, the above problem
would be solved and you don't need to keep the clocks enabled during
system suspend/resume.

Kind regards
Uffe

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7123ef9..1df3846 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1322,17 +1322,28 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>
> +#ifdef CONFIG_PM
> +       pm_runtime_get_sync(host->mmc->parent);
> +#endif
> +
>         return sdhci_suspend_host(host);
>  }
>
>  static int sdhci_esdhc_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
> +       int ret;
>
>         /* re-initialize hw state in case it's lost in low power mode */
>         sdhci_esdhc_imx_hwinit(host);
> +       ret = sdhci_resume_host(host);
>
> -       return sdhci_resume_host(host);
> +#ifdef CONFIG_PM
> +       pm_runtime_mark_last_busy(host->mmc->parent);
> +       pm_runtime_put_autosuspend(host->mmc->parent);
> +#endif
> +
> +       return ret;
>  }
>  #endif
>
> --
> 1.9.1
>
