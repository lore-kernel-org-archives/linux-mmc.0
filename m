From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make sure usdhc clock enabled while
 doing suspend
Date: Wed, 19 Oct 2016 17:23:32 +0800
Message-ID: <CAA+hA=QtEn7-cfq8yBGC50NtWcn59kU+T+CDVqRdfBqsfVuOVw@mail.gmail.com>
References: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35060 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbcJSPtW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 11:49:22 -0400
Received: by mail-qt0-f196.google.com with SMTP id g49so1038609qtc.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 08:49:21 -0700 (PDT)
In-Reply-To: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>

Hi Haibo,

On Tue, Oct 18, 2016 at 3:39 PM, Haibo Chen <haibo.chen@nxp.com> wrote:
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
>

Besides the former comments in my last reply, it would be good
to explain a bit more why the former SoC series do not have this issue
in the patch commit message.
That would make people more clear about it.

And more minor comment below:

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

Do you really need this?

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

ditto

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

Regards
Dong Aisheg
