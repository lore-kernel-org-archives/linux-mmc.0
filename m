From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: core: add support for hardware reset gpio line
Date: Wed, 28 Jan 2015 15:24:03 +0100
Message-ID: <CAPDyKFpowidghwadJS+gYP0EVo6gRUhAG8s14CMEbwatFadP2Q@mail.gmail.com>
References: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
	<1422453595-21160-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422453595-21160-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 28 January 2015 at 14:59, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> There are boards (like Hardkernel's Odroid boards) on which eMMC card's
> reset line is connected to GPIO line instead of the hardware reset
> logic. In case of such boards, if first stage of bootloader is loaded
> from such eMMC card, before performing system reboot, additional reset
> of eMMC card is required to properly boot the whole system again. This
> patch adds code for handling reset gpio lines defined in device tree.


I don't follow the above sequence. Can you try to elaborate and
describe for what exact scenario we require the hardware reset to be
done?

Also, I wonder whether we could extend the mmc-pwrseq to cover your
case? Did you consider that as an option?

Kind regards
Uffe

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |  35 +++++----
>  drivers/mmc/core/core.c                       |   2 +
>  drivers/mmc/core/host.c                       |  11 +++
>  drivers/mmc/core/slot-gpio.c                  | 101 +++++++++++++++++++++++++-
>  include/linux/mmc/slot-gpio.h                 |   7 ++
>  5 files changed, 139 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 438899e8829b..c952cdea0201 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -21,6 +21,9 @@ Optional properties:
>    below for the case, when a GPIO is used for the CD line
>  - wp-inverted: when present, polarity on the WP line is inverted. See the note
>    below for the case, when a GPIO is used for the WP line
> +- reset-gpios: Specify GPIO for hardware reset of a card, see gpio binding
> +- reset-inverted: when present, polarity on the reset line is inverted. See
> +  the note below for the case, when a GPIO is used for the reset line
>  - max-frequency: maximum operating clock frequency
>  - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>    this system, even if the controller claims it is.
> @@ -43,22 +46,24 @@ Optional properties:
>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>    programmed with. Valid range: [0 .. 0xffff].
>
> -*NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
> -polarity properties, we have to fix the meaning of the "normal" and "inverted"
> -line levels. We choose to follow the SDHCI standard, which specifies both those
> -lines as "active low." Therefore, using the "cd-inverted" property means, that
> -the CD line is active high, i.e. it is high, when a card is inserted. Similar
> -logic applies to the "wp-inverted" property.
> -
> -CD and WP lines can be implemented on the hardware in one of two ways: as GPIOs,
> -specified in cd-gpios and wp-gpios properties, or as dedicated pins. Polarity of
> -dedicated pins can be specified, using *-inverted properties. GPIO polarity can
> -also be specified using the OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity
> -in the latter case. We choose to use the XOR logic for GPIO CD and WP lines.
> -This means, the two properties are "superimposed," for example leaving the
> +*NOTE* on CD, WP and RESET polarity. To use common for all SD/MMC host
> +controllers line polarity properties, we have to fix the meaning of the
> +"normal" and "inverted" line levels. We choose to follow the SDHCI
> +standard, which specifies both those lines as "active low." Therefore,
> +using the "cd-inverted" property means, that the CD line is active high,
> +i.e. it is high, when a card is inserted. Similar logic applies to the
> +"wp-inverted" and "reset-inverted" property.
> +
> +CD, WP and RESET lines can be implemented on the hardware in one of two
> +ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or as
> +dedicated pins. Polarity of dedicated pins can be specified, using
> +*-inverted properties. GPIO polarity can also be specified using the
> +OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity in the latter case.
> +We choose to use the XOR logic for GPIO CD and WP lines. This means, the
> +two properties are "superimposed," for example leaving the
>  OF_GPIO_ACTIVE_LOW flag clear and specifying the respective *-inverted
> -property results in a double-inversion and actually means the "normal" line
> -polarity is in effect.
> +property results in a double-inversion and actually means the "normal"
> +line polarity is in effect.
>
>  Optional SDIO properties:
>  - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1be7055548cb..b556c3b5d83d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2520,6 +2520,7 @@ void mmc_start_host(struct mmc_host *host)
>                 mmc_power_off(host);
>         else
>                 mmc_power_up(host, host->ocr_avail);
> +       mmc_gpiod_request_restart_handler(host);
>         mmc_gpiod_request_cd_irq(host);
>         _mmc_detect_change(host, 0, false);
>  }
> @@ -2557,6 +2558,7 @@ void mmc_stop_host(struct mmc_host *host)
>
>         BUG_ON(host->card);
>
> +       mmc_gpiod_free_restart_handler(host);
>         mmc_power_off(host);
>  }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8be0df758e68..644d0f41b8f6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -317,6 +317,7 @@ int mmc_of_parse(struct mmc_host *host)
>         int len, ret;
>         bool cd_cap_invert, cd_gpio_invert = false;
>         bool ro_cap_invert, ro_gpio_invert = false;
> +       bool rst_cap_invert;
>
>         if (!host->parent || !host->parent->of_node)
>                 return 0;
> @@ -404,6 +405,16 @@ int mmc_of_parse(struct mmc_host *host)
>         if (ro_cap_invert ^ ro_gpio_invert)
>                 host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>
> +       /* Parse HW Reset */
> +       rst_cap_invert = of_property_read_bool(np, "reset-inverted");
> +
> +       ret = mmc_gpiod_request_rst(host, "reset", 0, rst_cap_invert);
> +       if (!ret) {
> +               dev_info(host->parent, "Got HW Reset GPIO\n");
> +               host->caps |= MMC_CAP_HW_RESET;
> +       } else if (ret != -ENOENT)
> +               return ret;
> +
>         if (of_find_property(np, "cap-sd-highspeed", &len))
>                 host->caps |= MMC_CAP_SD_HIGHSPEED;
>         if (of_find_property(np, "cap-mmc-highspeed", &len))
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 27117ba47073..5a2ca43e0e8d 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
> @@ -17,17 +18,22 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/reboot.h>
>
>  #include "slot-gpio.h"
>
>  struct mmc_gpio {
>         struct gpio_desc *ro_gpio;
>         struct gpio_desc *cd_gpio;
> +       struct gpio_desc *rst_gpio;
>         bool override_ro_active_level;
>         bool override_cd_active_level;
> +       bool rst_raw_active_level;
> +       struct notifier_block rst_nb;
>         irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>         char *ro_label;
> -       char cd_label[0];
> +       char *cd_label;
> +       char rst_label[0];
>  };
>
>  static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
> @@ -45,12 +51,14 @@ int mmc_gpio_alloc(struct mmc_host *host)
>  {
>         size_t len = strlen(dev_name(host->parent)) + 4;
>         struct mmc_gpio *ctx = devm_kzalloc(host->parent,
> -                               sizeof(*ctx) + 2 * len, GFP_KERNEL);
> +                               sizeof(*ctx) + 3 * len + 1, GFP_KERNEL);
>
>         if (ctx) {
> +               ctx->cd_label = ctx->rst_label + len + 1;
>                 ctx->ro_label = ctx->cd_label + len;
>                 snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
>                 snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
> +               snprintf(ctx->rst_label, len, "%s rst", dev_name(host->parent));
>                 host->slot.handler_priv = ctx;
>                 host->slot.cd_irq = -EINVAL;
>         }
> @@ -88,6 +96,21 @@ int mmc_gpio_get_cd(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);
>
> +void mmc_gpio_do_hw_reset(struct mmc_host *host)
> +{
> +       struct mmc_gpio *ctx = host->slot.handler_priv;
> +       if (!ctx || !ctx->rst_gpio)
> +               return;
> +
> +       gpiod_set_raw_value_cansleep(ctx->rst_gpio, ctx->rst_raw_active_level);
> +       /* For eMMC, minimum is 1us but give it 10us for good measure */
> +       udelay(10);
> +       gpiod_set_raw_value_cansleep(ctx->rst_gpio, !ctx->rst_raw_active_level);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       usleep_range(300, 1000);
> +}
> +EXPORT_SYMBOL(mmc_gpio_do_hw_reset);
> +
>  /**
>   * mmc_gpio_request_ro - request a gpio for write-protection
>   * @host: mmc host
> @@ -167,6 +190,48 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
>  }
>  EXPORT_SYMBOL(mmc_gpio_set_cd_isr);
>
> +static int mmc_gpio_rst_nb(struct notifier_block *this, unsigned long mode,
> +                          void *cmd)
> +{
> +       struct mmc_gpio *ctx = container_of(this, struct mmc_gpio, rst_nb);
> +
> +       gpiod_set_raw_value(ctx->rst_gpio, ctx->rst_raw_active_level);
> +       /* For eMMC, minimum is 1us but give it 10us for good measure */
> +       udelay(10);
> +       gpiod_set_raw_value(ctx->rst_gpio, !ctx->rst_raw_active_level);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       udelay(300);
> +
> +       return NOTIFY_DONE;
> +}
> +
> +void mmc_gpiod_request_restart_handler(struct mmc_host *host)
> +{
> +       struct mmc_gpio *ctx = host->slot.handler_priv;
> +
> +       if (!ctx || !ctx->rst_gpio)
> +               return;
> +
> +       ctx->rst_nb.notifier_call = mmc_gpio_rst_nb;
> +       ctx->rst_nb.priority = 255;
> +
> +       register_restart_handler(&ctx->rst_nb);
> +       return;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_request_restart_handler);
> +
> +void mmc_gpiod_free_restart_handler(struct mmc_host *host)
> +{
> +       struct mmc_gpio *ctx = host->slot.handler_priv;
> +
> +       if (!ctx || !ctx->rst_gpio)
> +               return;
> +
> +       unregister_restart_handler(&ctx->rst_nb);
> +       return;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_free_restart_handler);
> +
>  /**
>   * mmc_gpio_request_cd - request a gpio for card-detection
>   * @host: mmc host
> @@ -303,3 +368,35 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>         return 0;
>  }
>  EXPORT_SYMBOL(mmc_gpiod_request_ro);
> +
> +/**
> + * mmc_gpiod_request_rst - request a gpio descriptor for hw reset
> + * @host: mmc host
> + * @con_id: function within the GPIO consumer
> + * @idx: index of the GPIO to obtain in the consumer
> + * @inverted: indicated the polarity of reset line should be inverted
> + * (xored with GPIO_ACTIVE_LOW flag of gpio descriptor)
> + *
> + * Returns zero on success, else an error.
> + */
> +int mmc_gpiod_request_rst(struct mmc_host *host, const char *con_id,
> +                         unsigned int idx, bool inverted)
> +{
> +       struct mmc_gpio *ctx = host->slot.handler_priv;
> +       struct gpio_desc *desc;
> +
> +       if (!con_id)
> +               con_id = ctx->rst_label;
> +
> +       desc = devm_gpiod_get_index(host->parent, con_id, idx);
> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);
> +
> +       ctx->rst_raw_active_level = !inverted ^ gpiod_is_active_low(desc);
> +       ctx->rst_gpio = desc;
> +
> +       gpiod_direction_output_raw(desc, !ctx->rst_raw_active_level);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(mmc_gpiod_request_rst);
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index 3945a8c9d3cb..48f814e1bbeb 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -26,8 +26,15 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
>                          unsigned int debounce, bool *gpio_invert);
> +int mmc_gpiod_request_rst(struct mmc_host *host, const char *con_id,
> +                        unsigned int idx, bool inverted);
>  void mmc_gpio_set_cd_isr(struct mmc_host *host,
>                          irqreturn_t (*isr)(int irq, void *dev_id));
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>
> +void mmc_gpio_do_hw_reset(struct mmc_host *host);
> +void mmc_gpiod_request_restart_handler(struct mmc_host *host);
> +void mmc_gpiod_free_restart_handler(struct mmc_host *host);
> +
> +
>  #endif
> --
> 1.9.2
>
