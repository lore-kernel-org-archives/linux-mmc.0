From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/1] mmc: sdhci-s3c: Use mmc_gpio_request_cd function
Date: Wed, 30 Apr 2014 10:15:24 +0200
Message-ID: <CAPDyKFr_h1dsiS433vNKMn8udKCKbb28oLh9Z+gJWoPCjUaEFA@mail.gmail.com>
References: <536072D6.4020009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:52282 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbaD3IPZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 04:15:25 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so1451728qgd.24
        for <linux-mmc@vger.kernel.org>; Wed, 30 Apr 2014 01:15:25 -0700 (PDT)
In-Reply-To: <536072D6.4020009@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>

On 30 April 2014 05:49, Beomho Seo <beomho.seo@samsung.com> wrote:
> This patch use mmc_gpio_request_cd function.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v3:
> - rebased to recent mmc-next branch.
>
> changes in v2:
> - Fix "err_req_cd:".
> - Remove mmc_gpio_free_cd() and then, used sdhci_remove_host().
> ---
>  drivers/mmc/host/sdhci-s3c.c |   56 +++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index c12301e..9c0ccdc 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
>
>  #include "sdhci-s3c-regs.h"
>  #include "sdhci.h"
> @@ -396,44 +397,6 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>         }
>  }
>
> -static irqreturn_t sdhci_s3c_gpio_card_detect_thread(int irq, void *dev_id)
> -{
> -       struct sdhci_s3c *sc = dev_id;
> -       int status = gpio_get_value(sc->ext_cd_gpio);
> -       if (sc->pdata->ext_cd_gpio_invert)
> -               status = !status;
> -       sdhci_s3c_notify_change(sc->pdev, status);
> -       return IRQ_HANDLED;
> -}
> -
> -static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
> -{
> -       struct s3c_sdhci_platdata *pdata = sc->pdata;
> -       struct device *dev = &sc->pdev->dev;
> -
> -       if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
> -               sc->ext_cd_gpio = pdata->ext_cd_gpio;
> -               sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
> -               if (sc->ext_cd_irq &&
> -                   request_threaded_irq(sc->ext_cd_irq, NULL,
> -                                        sdhci_s3c_gpio_card_detect_thread,
> -                                        IRQF_TRIGGER_RISING |
> -                                        IRQF_TRIGGER_FALLING |
> -                                        IRQF_ONESHOT,
> -                                        dev_name(dev), sc) == 0) {
> -                       int status = gpio_get_value(sc->ext_cd_gpio);
> -                       if (pdata->ext_cd_gpio_invert)
> -                               status = !status;
> -                       sdhci_s3c_notify_change(sc->pdev, status);
> -               } else {
> -                       dev_warn(dev, "cannot request irq for card detect\n");
> -                       sc->ext_cd_irq = 0;
> -               }
> -       } else {
> -               dev_err(dev, "cannot request gpio for card detect\n");
> -       }
> -}
> -
>  #ifdef CONFIG_OF
>  static int sdhci_s3c_parse_dt(struct device *dev,
>                 struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
> @@ -685,8 +648,14 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>         if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
>                 pdata->ext_cd_init(&sdhci_s3c_notify_change);
>         if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
> -           gpio_is_valid(pdata->ext_cd_gpio))
> -               sdhci_s3c_setup_card_detect_gpio(sc);
> +           gpio_is_valid(pdata->ext_cd_gpio)) {
> +               ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio, 0);
> +               if (ret) {
> +                       dev_err(dev,
> +                               "failed to reqeust card detect gpio\n");
> +                       goto err_req_cd;
> +               }
> +       }
>
>  #ifdef CONFIG_PM_RUNTIME
>         if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
> @@ -694,6 +663,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  #endif
>         return 0;
>
> + err_req_cd:
> +       sdhci_remove_host(host, 1);
> +
>   err_req_regs:
>   err_no_busclks:
>         clk_disable_unprepare(sc->clk_io);
> @@ -713,8 +685,8 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
>         if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
>                 pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>
> -       if (sc->ext_cd_irq)
> -               free_irq(sc->ext_cd_irq, sc);
> +       if (pdata->ext_cd_gpio)
> +               mmc_gpio_free_cd(host->mmc);

This should not be needed since it's handled by the devm* functions.

Kind regards
Ulf Hansson

>
>  #ifdef CONFIG_PM_RUNTIME
>         if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
> --
> 1.7.9.5
