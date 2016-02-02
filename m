From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: fix again read-only gpio detection polarity
Date: Tue, 2 Feb 2016 14:11:12 +0100
Message-ID: <CAPDyKFpAHpPVZ4TEEscESr2=wZCbi+ERxCG_MSawkeqqR02g3w@mail.gmail.com>
References: <1454023286-25832-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1454023286-25832-1-git-send-email-robert.jarzmik@free.fr>
Sender: stable-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 January 2016 at 00:21, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> The commit fixing the conversion of pxamci to slot-gpio API fixed the
> inverted the logic of the read-only gpio. Unfortunately, the commit was
> tested on a non-inverted gpio, and not on the inverted one. And the fix
> did work partially, by luck.
>
> This is the remaining missing part of the fix, trivial but still necessary.
>
> Fixes: Fixes: 26d49fe71953 ("mmc: pxamci: fix read-only gpio detection polarity")
> Reported-by: Andrea Adami <andrea.adami@gmail.com>
> Tested-by: Andrea Adami <andrea.adami@gmail.com>
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
> index ce08896b9d69..28a057fae0a1 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -804,7 +804,7 @@ static int pxamci_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
>                 goto out;
>         } else {
> -               mmc->caps |= host->pdata->gpio_card_ro_invert ?
> +               mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
>                         0 : MMC_CAP2_RO_ACTIVE_HIGH;
>         }
>
> --
> 2.1.4
>
