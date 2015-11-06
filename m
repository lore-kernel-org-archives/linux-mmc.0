From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: fix read-only gpio detection polarity
Date: Fri, 6 Nov 2015 10:08:50 +0100
Message-ID: <CAPDyKFqUEJcdvmn_Aispisx7SSDC64Pm35SxFXxntfzTOjTr9g@mail.gmail.com>
References: <1446752813-26718-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1446752813-26718-1-git-send-email-robert.jarzmik@free.fr>
Sender: stable-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 5 November 2015 at 20:46, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> The commit converting pxamci to slot-gpio API inverted the logic of the
> read-only gpio. Fix it by inverting the logic again.
>
> Fixes: fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio API")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: stable@vger.kernel.org

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/pxamci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 8cadd74e8407..ce08896b9d69 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -805,7 +805,7 @@ static int pxamci_probe(struct platform_device *pdev)
>                 goto out;
>         } else {
>                 mmc->caps |= host->pdata->gpio_card_ro_invert ?
> -                       MMC_CAP2_RO_ACTIVE_HIGH : 0;
> +                       0 : MMC_CAP2_RO_ACTIVE_HIGH;
>         }
>
>         if (gpio_is_valid(gpio_cd))
> --
> 2.1.4
>
