From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: select GPIOLIB for MMC support
Date: Mon, 18 Aug 2014 18:00:37 +0200
Message-ID: <CAPDyKFoUO7GLfZxVFq0c5BtpnVUSCv0cnb1uz6S2A_4_OcVhqw@mail.gmail.com>
References: <1408375217-20500-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1408375217-20500-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 18 August 2014 17:20, Linus Walleij <linus.walleij@linaro.org> wrote:
> The slot-gpio support has been compiled into the core for some time,
> and it basically requires GPIOLIB to be present, very few systems
> are using the archaic GPIO API (just defined function names) and
> those should be migrated to GPIOLIB anyway.
>
> The rewrite to use GPIO descriptors require that we enable GPIOLIB,
> so make CONFIG_MMC select CONFIG_GPIOLIB.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! Applied for next.

I put it prior the other GPIO descriptor patches to not break bisectability.

Kind regards
Uffe

> ---
>  drivers/mmc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index f2eeb38efa65..bf44002793c4 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -5,6 +5,7 @@
>  menuconfig MMC
>         tristate "MMC/SD/SDIO card support"
>         depends on HAS_IOMEM
> +       select GPIOLIB
>         help
>           This selects MultiMediaCard, Secure Digital and Secure
>           Digital I/O support.
> --
> 1.9.3
>
