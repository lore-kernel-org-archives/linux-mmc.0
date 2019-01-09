From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when
 "cd-inverted" is set
Date: Thu, 10 Jan 2019 00:24:58 +0530
Message-ID: <CANAwSgQVaeAb5ta+zC6Fhc3xLjSCMY5-XzQpK7SwdS4LNAYfNA@mail.gmail.com>
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel <linux-kernel@vger.kernel.org>, bgolaszewski@baylibre.com, linux-amlogic@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-mmc@vger.kernel.org

Hi Martin,

On Wed, 2 Jan 2019 at 01:14, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> if "cd-inverted" is also set. This results in the "cd-inverted" property
> being evaluated twice, which effectively makes it a no-op:
> - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
>   setting up the CD GPIO
> - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
>   reading the CD GPIO value at runtime
>
> On boards which are using device-tree with the "cd-inverted" property
> being set any inserted card are not detected anymore. This is due to the
> MMC core treating the CD GPIO with the wrong polarity.
>
> Disable "override_cd_active_level" for the card detection GPIO which is
> parsed using mmc_of_parse. This fixes SD card detection on the boards
> which are currently using the "cd-inverted" device-tree property (tested
> on Meson8b Odroid-C1 and Meson8b EC-100).
>
> This does not remove the CD GPIO inversion logic from the MMC core
> because there's at least one driver (sdhci-pci-core for Intel BayTrail
> based boards) which still passes "override_cd_active_level = true" to
> mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> untouched.
> In the future the GPIO inversion logic for both, card and read-only
> detection can be removed once no driver is using it anymore.
>
> Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f57f5de54206..cf58ccaf22d5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,7 +234,7 @@ int mmc_of_parse(struct mmc_host *host)
>                 if (device_property_read_bool(dev, "broken-cd"))
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
> -               ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> +               ret = mmc_gpiod_request_cd(host, "cd", 0, false,
>                                            cd_debounce_delay_ms * 1000,
>                                            &cd_gpio_invert);
>                 if (!ret)
> --
> 2.20.1
>

Please add my.
Tested on Odroidc1+ and Odroidc2 both booted up fine.

Tested-by: Anand Moon <linux.amoon@gmail.com>

>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
