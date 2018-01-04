From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock
 during runtime suspend
Date: Thu, 4 Jan 2018 15:08:03 +0100
Message-ID: <CAPDyKFo0Joc1dRaw3zy_yV0+YMpSYZ2S7FkNrOkBpaA=Dng+_Q@mail.gmail.com>
References: <1515074324-12933-1-git-send-email-michael@amarulasolutions.com> <1515074324-12933-2-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33825 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeADOIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 09:08:04 -0500
Received: by mail-io0-f195.google.com with SMTP id q188so2333559iod.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 06:08:04 -0800 (PST)
In-Reply-To: <1515074324-12933-2-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 4 January 2018 at 14:58, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> mmc clock can be stopped during runtime suspend and restart during runtime
> resume if the sdio irq is not enabled. Stop sdio clock reduce EMI of
> the device when the bus is not in use.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> Changes V1->V2:
>         - rebase to latest linux
>         - address sdio irq wakeup
>         - move the clock enable clk_ahb up to be balance
>           with the runtime suspend function and to make
>           function more clean by the end without two if
>           condition
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d08c21e..53cc1b6 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -193,6 +193,7 @@ struct pltfm_imx_data {
>         struct clk *clk_ipg;
>         struct clk *clk_ahb;
>         struct clk *clk_per;
> +       unsigned int actual_clock;
>         enum {
>                 NO_CMD_PENDING,      /* no multiblock command pending */
>                 MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
> @@ -1396,6 +1397,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>                 mmc_retune_needed(host->mmc);
>
>         if (!sdhci_sdio_irq_enabled(host)) {
> +               imx_data->actual_clock = host->mmc->actual_clock;
> +               esdhc_pltfm_set_clock(host, 0);
>                 clk_disable_unprepare(imx_data->clk_per);
>                 clk_disable_unprepare(imx_data->clk_ipg);
>         }
> @@ -1411,31 +1414,34 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int err;
>
> +       err = clk_prepare_enable(imx_data->clk_ahb);
> +       if (err)
> +               return err;
> +

So this changes the order of how clocks are being re-enabled. I think
the change makes sense, as normally we do things in the reverse order
as compared what is being done during ->runtime_suspend().

However, I think you should have this being a separate patch,
preceding the one that actually calls esdhc_pltfm_set_clock() in in
the runtime PM callbacks.

>         if (!sdhci_sdio_irq_enabled(host)) {
>                 err = clk_prepare_enable(imx_data->clk_per);
>                 if (err)
> -                       return err;
> +                       goto disable_ahb_clk;
>                 err = clk_prepare_enable(imx_data->clk_ipg);
>                 if (err)
>                         goto disable_per_clk;
> +               esdhc_pltfm_set_clock(host, imx_data->actual_clock);
>         }
> -       err = clk_prepare_enable(imx_data->clk_ahb);
> -       if (err)
> -               goto disable_ipg_clk;
> +
>         err = sdhci_runtime_resume_host(host);
>         if (err)
> -               goto disable_ahb_clk;
> +               goto disable_ipg_clk;
>
>         return 0;
>
> -disable_ahb_clk:
> -       clk_disable_unprepare(imx_data->clk_ahb);
>  disable_ipg_clk:
>         if (!sdhci_sdio_irq_enabled(host))
>                 clk_disable_unprepare(imx_data->clk_ipg);
>  disable_per_clk:
>         if (!sdhci_sdio_irq_enabled(host))
>                 clk_disable_unprepare(imx_data->clk_per);
> +disable_ahb_clk:
> +       clk_disable_unprepare(imx_data->clk_ahb);
>         return err;
>  }
>  #endif
> --
> 2.7.4
>

Otherwise this looks good to me.

Kind regards
Uffe
