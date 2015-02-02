From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: pwrseq: add driver for emmc hardware reset
Date: Mon, 2 Feb 2015 13:53:46 +0100
Message-ID: <CAPDyKFr0YxFXSvknUE=CPbDwge0uSN0JJMCM=aP+JrXAMnFHCA@mail.gmail.com>
References: <CABxcv=nF3SJK7p1j=F08_9kHU2n+v=hmgr7-ikfZ7Xraz3J0_g@mail.gmail.com>
	<1422871549-5468-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422871549-5468-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-mmc@vger.kernel.org

On 2 February 2015 at 11:05, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch provides a simple mmc-pwrseq-emmc driver, which controls
> single gpio line. It perform standard eMMC hw reset procedure, as
> descibed by Jedec 4.4 specification. This procedure is performed just
> after MMC core enabled power to the given mmc host (to fix possible
> issues if bootloader has left eMMC card in initialized or unknown
> state), and before performing complete system reboot (also in case of
> emergency reboot call). The latter is needed on boards, which doesn't
> have hardware reset logic connected to emmc card and (limited or broken)
> ROM bootloaders are unable to read second stage from the emmc card if
> the card is left in unknown or already initialized state.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/mmc/mmc-pwrseq-emmc.txt    |  25 +++++
>  drivers/mmc/core/Makefile                          |   2 +-
>  drivers/mmc/core/pwrseq.c                          |   3 +
>  drivers/mmc/core/pwrseq.h                          |   1 +
>  drivers/mmc/core/pwrseq_emmc.c                     | 103 +++++++++++++++++++++
>  5 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
>  create mode 100644 drivers/mmc/core/pwrseq_emmc.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> new file mode 100644
> index 000000000000..4baeac828f6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
> @@ -0,0 +1,25 @@
> +* The simple eMMC hardware reset provider
> +
> +The purpose of this driver is to perform standard eMMC hw reset
> +procedure, as descibed by Jedec 4.4 specification. This procedure is
> +performed just after MMC core enabled power to the given mmc host (to
> +fix possible issues if bootloader has left eMMC card in initialized or
> +unknown state), and before performing complete system reboot (also in
> +case of emergency reboot call). The latter is needed on boards, which
> +doesn't have hardware reset logic connected to emmc card and (limited or
> +broken) ROM bootloaders are unable to read second stage from the emmc
> +card if the card is left in unknown or already initialized state.
> +
> +Required properties:
> +- compatible : contains "mmc-pwrseq-emmc".
> +- reset-gpios : contains a GPIO specifier. The reset GPIO is pulled
> +       down and then pulled up to perform eMMC card reset. To perform

Could we maybe use the word "(de)asserted" instead of "pulled down/up".

> +       reset procedure as described in Jedec 4.4 specification, the
> +       gpio line should be defined as GPIO_ACTIVE_LOW.
> +
> +Example:
> +
> +       sdhci0_pwrseq {
> +               compatible = "mmc-pwrseq-emmc";
> +               reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +       }
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index b39cbd2f830b..2c25138f28b7 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -8,5 +8,5 @@ mmc_core-y                      := core.o bus.o host.o \
>                                    sdio.o sdio_ops.o sdio_bus.o \
>                                    sdio_cis.o sdio_io.o sdio_irq.o \
>                                    quirks.o slot-gpio.o
> -mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o
> +mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o pwrseq_emmc.o
>  mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index 2cea00ed4e65..862356123d78 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -26,6 +26,9 @@ static struct mmc_pwrseq_match pwrseq_match[] = {
>         {
>                 .compatible = "mmc-pwrseq-simple",
>                 .alloc = mmc_pwrseq_simple_alloc,
> +       }, {
> +               .compatible = "mmc-pwrseq-emmc",
> +               .alloc = mmc_pwrseq_emmc_alloc,
>         },
>  };
>
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index bd860d88f116..aba3409e8d6e 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -28,6 +28,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev);
> +int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev);
>
>  #else
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> new file mode 100644
> index 000000000000..39dc43dd316f
> --- /dev/null
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright (C) 2015, Samsung Electronics Co., Ltd.
> + *
> + * Author: Marek Szyprowski <m.szyprowski@samsung.com>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + *
> + * Simple eMMC hardware reset provider
> + */
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/reboot.h>
> +
> +#include <linux/mmc/host.h>
> +
> +#include "pwrseq.h"
> +
> +struct mmc_pwrseq_emmc {
> +       struct mmc_pwrseq pwrseq;
> +       struct notifier_block reset_nb;
> +       struct gpio_desc *reset_gpio;
> +};
> +
> +static void mmc_pwrseq_perform_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)

I would prefer the name of this function to be __mmc_pwrseq_emmc_reset()

> +{
> +       gpiod_set_value(pwrseq->reset_gpio, 1);
> +       /* For eMMC, minimum is 1us but give it 10us for good measure */
> +       udelay(10);
> +       gpiod_set_value(pwrseq->reset_gpio, 0);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       udelay(300);

These delays will affect the total power up time for the card.
According to the specification 1 us and 200 us, should be enough. Do
you think there are a good reason to have them extended to the values
you suggested?

> +}
> +
> +static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
> +                                       struct mmc_pwrseq_emmc, pwrseq);
> +
> +       mmc_pwrseq_perform_emmc_reset(pwrseq);
> +}
> +
> +static void mmc_pwrseq_emmc_free(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
> +                                       struct mmc_pwrseq_emmc, pwrseq);
> +
> +       gpiod_put(pwrseq->reset_gpio);
> +       unregister_restart_handler(&pwrseq->reset_nb);

I suggest you to move the unregister_restart_handler() to be done
prior gpiod_put(), since else (theoretically) the notifier may be
called without a valid gpio requested.

> +       kfree(pwrseq);
> +       host->pwrseq = NULL;
> +}
> +
> +static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
> +       .post_power_on = mmc_pwrseq_emmc_reset,
> +       .power_off = mmc_pwrseq_emmc_reset,

I don't think you should assign the ->power_off() callback, unless you
think there are a reason to reset the card while cutting powering for
it!?

> +       .free = mmc_pwrseq_emmc_free,
> +};
> +
> +static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
> +                                   unsigned long mode, void *cmd)
> +{
> +       struct mmc_pwrseq_emmc *pwrseq;
> +       pwrseq = container_of(this, struct mmc_pwrseq_emmc, reset_nb);
> +
> +       mmc_pwrseq_perform_emmc_reset(pwrseq);
> +       return NOTIFY_DONE;
> +}
> +
> +int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev)
> +{
> +       struct mmc_pwrseq_emmc *pwrseq;
> +       int ret = 0;
> +
> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
> +       if (!pwrseq)
> +               return -ENOMEM;
> +
> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
> +       if (IS_ERR(pwrseq->reset_gpio)) {
> +               ret = PTR_ERR(pwrseq->reset_gpio);
> +               goto free;
> +       }
> +
> +       /*
> +        * register reset handler to ensure emmc reset also from
> +        * emergency_reboot()
> +        */
> +       pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> +       pwrseq->reset_nb.priority = 255;

Why 255? I guess it could deserve a comment!?

> +       register_restart_handler(&pwrseq->reset_nb);
> +
> +       pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
> +       host->pwrseq = &pwrseq->pwrseq;
> +
> +       return 0;
> +free:
> +       kfree(pwrseq);
> +       return ret;
> +}
> --
> 1.9.2
>

Some final generic thoughts; since the reset GPIO will be toggled for
each call to mmc_power_up(), that means the card will be reset for
each system PM suspend to resume cycle. Is that really what we want?

For some cases that also means the card will be reset when it's in
sleep state (CMD5). Do you know if that's okay?

Kind regards
Uffe
