From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4 v2] mmc: mmci: augment driver to handle gpio descriptors
Date: Fri, 29 Aug 2014 14:17:24 +0200
Message-ID: <CAPDyKFo0tP3EWtzUst2wL0j9jb=NgyBYqoJSjLGTaRX8RXoEtw@mail.gmail.com>
References: <1409145234-18761-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1409145234-18761-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On 27 August 2014 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> Currently the MMCI driver will only handle GPIO descriptors
> implicitly through the device tree probe glue in mmc_of_init(),
> but devices instatiated other ways such as through board files
> and passing descriptors using the GPIO descriptor table will
> not be able to exploit descriptors.
>
> Augment the driver to look for a GPIO descriptor if device
> tree is not used for the device, and if that doesn't work,
> fall back to platform data GPIO assignment using the old
> API. The end goal is to get rid of the platform data integer
> GPIO assingments from the kernel.
>
> This enable the MMCI-embedding platforms to be converted to
> GPIO descritor tables.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! Applied for next.

Kind regards
Uffe


> ---
> ChangeLog v1->v2:
> - Skip excess error/info/debug report prints.
> ---
>  drivers/mmc/host/mmci.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e4d470704150..4aec22439d0e 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1658,16 +1658,35 @@ static int mmci_probe(struct amba_device *dev,
>         writel(0, host->base + MMCIMASK1);
>         writel(0xfff, host->base + MMCICLEAR);
>
> -       /* If DT, cd/wp gpios must be supplied through it. */
> -       if (!np && gpio_is_valid(plat->gpio_cd)) {
> -               ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
> -               if (ret)
> -                       goto clk_disable;
> -       }
> -       if (!np && gpio_is_valid(plat->gpio_wp)) {
> -               ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
> -               if (ret)
> -                       goto clk_disable;
> +       /*
> +        * If:
> +        * - not using DT but using a descriptor table, or
> +        * - using a table of descriptors ALONGSIDE DT, or
> +        * look up these descriptors named "cd" and "wp" right here, fail
> +        * silently of these do not exist and proceed to try platform data
> +        */
> +       if (!np) {
> +               ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> +               if (ret < 0) {
> +                       if (ret == -EPROBE_DEFER)
> +                               goto clk_disable;
> +                       else if (gpio_is_valid(plat->gpio_cd)) {
> +                               ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
> +                               if (ret)
> +                                       goto clk_disable;
> +                       }
> +               }
> +
> +               ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0);
> +               if (ret < 0) {
> +                       if (ret == -EPROBE_DEFER)
> +                               goto clk_disable;
> +                       else if (gpio_is_valid(plat->gpio_wp)) {
> +                               ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
> +                               if (ret)
> +                                       goto clk_disable;
> +                       }
> +               }
>         }
>
>         ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
