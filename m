From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] Revert "mmc: host: omap_hsmmc: use
 regulator_is_enabled to find pbias status"
Date: Wed, 7 Oct 2015 16:06:21 +0200
Message-ID: <CAPDyKFqK7hF2j60NfhL1EtwBrK43ZfK1t8=puGgNJVARfFUntA@mail.gmail.com>
References: <1444224145-24333-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38405 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbJGOGW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2015 10:06:22 -0400
Received: by wiclk2 with SMTP id lk2so30329761wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 07 Oct 2015 07:06:21 -0700 (PDT)
In-Reply-To: <1444224145-24333-1-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On 7 October 2015 at 15:22, Tony Lindgren <tony@atomide.com> wrote:
> This reverts commit c55d7a0553643a7e8f120688b82b594471084d3c.
>
> Without reverting this commit we get "unbalanced disables for pbias_mmc_omap4"
> errors on omap4430. It seems that 4430 and 4460 behave in a different way for
> the PBIAS regulator registers and until that has been debugged further we
> cannot rely on the regulator status registers in hardare on 4430.
>
> Fixes: 7d607f917008 ("mmc: host: omap_hsmmc: use
> devm_regulator_get_optional() for vmmc")
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 781e4db3..ae3a2b9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -182,6 +182,7 @@ struct omap_hsmmc_host {
>         struct  clk             *fclk;
>         struct  clk             *dbclk;
>         struct  regulator       *pbias;
> +       bool                    pbias_enabled;
>         void    __iomem         *base;
>         int                     vqmmc_enabled;
>         resource_size_t         mapbase;
> @@ -328,20 +329,22 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
>                         return ret;
>                 }
>
> -               if (!regulator_is_enabled(host->pbias)) {
> +               if (host->pbias_enabled == 0) {
>                         ret = regulator_enable(host->pbias);
>                         if (ret) {
>                                 dev_err(host->dev, "pbias reg enable fail\n");
>                                 return ret;
>                         }
> +                       host->pbias_enabled = 1;
>                 }
>         } else {
> -               if (regulator_is_enabled(host->pbias)) {
> +               if (host->pbias_enabled == 1) {
>                         ret = regulator_disable(host->pbias);
>                         if (ret) {
>                                 dev_err(host->dev, "pbias reg disable fail\n");
>                                 return ret;
>                         }
> +                       host->pbias_enabled = 0;
>                 }
>         }
>
> @@ -2053,6 +2056,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         host->base      = base + pdata->reg_offset;
>         host->power_mode = MMC_POWER_OFF;
>         host->next_data.cookie = 1;
> +       host->pbias_enabled = 0;
>         host->vqmmc_enabled = 0;
>
>         ret = omap_hsmmc_gpio_init(mmc, host, pdata);
> --
> 2.1.4
>
