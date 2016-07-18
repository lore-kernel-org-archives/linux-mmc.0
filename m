From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: fix potential oops
Date: Mon, 18 Jul 2016 13:19:45 +0200
Message-ID: <CAPDyKFooCW8ROLkYT2D7tEwRmm7rSZzaRpGH5Xf8izmxgdEUuQ@mail.gmail.com>
References: <1468508750-28631-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468508750-28631-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 July 2016 at 17:05, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> As reported by Dan in his report in [1], there is a potential NULL
> pointer derefence if these conditions are met :
>  - there is no platform_data provided, ie. host->pdata = NULL
>
> Fix this by only using the platform data ro_invert when a gpio for
> read-only is provided by the platform data.
>
> This doesn't appear yet as every pxa board provides a platform_data, and
> calls pxa_set_mci_info() with a non NULL pointer.
>
> [1] [bug report] mmc: pxamci: fix card detect with slot-gpio API.
> The commit fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio
> API") from Sep 26, 2015, leads to the following static checker warning:
>
>         drivers/mmc/host/pxamci.c:809 pxamci_probe()
>         warn: variable dereferenced before check 'host->pdata' (see line 798)
>
> Fixes: fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio API")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/pxamci.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 86fac3e86833..c763b404510f 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -789,14 +789,16 @@ static int pxamci_probe(struct platform_device *pdev)
>                 gpio_direction_output(gpio_power,
>                                       host->pdata->gpio_power_invert);
>         }
> -       if (gpio_is_valid(gpio_ro))
> +       if (gpio_is_valid(gpio_ro)) {
>                 ret = mmc_gpio_request_ro(mmc, gpio_ro);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
> -               goto out;
> -       } else {
> -               mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
> -                       0 : MMC_CAP2_RO_ACTIVE_HIGH;
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n",
> +                               gpio_ro);
> +                       goto out;
> +               } else {
> +                       mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
> +                               0 : MMC_CAP2_RO_ACTIVE_HIGH;
> +               }
>         }
>
>         if (gpio_is_valid(gpio_cd))
> --
> 2.1.4
>
