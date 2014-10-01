From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: restore detect line inversion semantics
Date: Wed, 1 Oct 2014 10:24:16 +0200
Message-ID: <CAPDyKFoQ3h0aza8YfRgZoz2JmES2_qCwHjH4xiGDo903w3vkVQ@mail.gmail.com>
References: <1412149918-25648-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34963 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaJAIYR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 04:24:17 -0400
Received: by mail-qg0-f43.google.com with SMTP id j107so191701qga.30
        for <linux-mmc@vger.kernel.org>; Wed, 01 Oct 2014 01:24:16 -0700 (PDT)
In-Reply-To: <1412149918-25648-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Javier Martinez Canillas <javier@dowhile0.org>

On 1 October 2014 09:51, Linus Walleij <linus.walleij@linaro.org> wrote:
> commit 98e90de99a0c43bd434da814c882c4332441871e
> "mmc: host: switch OF parser to use gpio descriptors"
> switched the semantic behaviour of card detect and read
> only flags such that the inversion capability flag would
> only be set if inversion was explicitly specified in the
> device tree, in the hopes that no-one was using double
> inversion.
>
> It turns out that the XOR:ing between the explicit
> inversion was indeed in use, so we need to restore the
> old semantics where both ways of inversion are checked
> and the end result XOR:ed.
>
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Tested-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Always set override_active_level when getting CD GPIO
> - Invert the return value from gpiod_is_active_low() to
>   follow the old semantics
> ---
>  drivers/mmc/core/host.c       | 32 ++++++++++++++++++++++++++++----
>  drivers/mmc/core/slot-gpio.c  | 10 ++++++++--
>  drivers/mmc/host/mmci.c       |  5 +++--
>  include/linux/mmc/slot-gpio.h |  4 ++--
>  4 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 31969436d77c..03c53b72a2d6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -311,6 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>         struct device_node *np;
>         u32 bus_width;
>         int len, ret;
> +       bool cap_invert, gpio_invert;
>
>         if (!host->parent || !host->parent->of_node)
>                 return 0;
> @@ -359,12 +360,15 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps |= MMC_CAP_NONREMOVABLE;
>         } else {
>                 if (of_property_read_bool(np, "cd-inverted"))
> -                       host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> +                       cap_invert = true;
> +               else
> +                       cap_invert = false;
>
>                 if (of_find_property(np, "broken-cd", &len))
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
> -               ret = mmc_gpiod_request_cd(host, "cd", 0, false, 0);
> +               ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> +                                          0, &gpio_invert);
>                 if (ret) {
>                         if (ret == -EPROBE_DEFER)
>                                 return ret;
> @@ -375,13 +379,29 @@ int mmc_of_parse(struct mmc_host *host)
>                         }
>                 } else
>                         dev_info(host->parent, "Got CD GPIO\n");
> +
> +               /*
> +                * There are two ways to flag that the CD line is inverted:
> +                * through the cd-inverted flag and by the GPIO line itself
> +                * being inverted from the GPIO subsystem. This is a leftover
> +                * from the times when the GPIO subsystem did not make it
> +                * possible to flag a line as inverted.
> +                *
> +                * If the capability on the host AND the GPIO line are
> +                * both inverted, the end result is that the CD line is
> +                * not inverted.
> +                */
> +               if (cap_invert ^ gpio_invert)
> +                       host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>         }
>
>         /* Parse Write Protection */
>         if (of_property_read_bool(np, "wp-inverted"))
> -               host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> +               cap_invert = true;
> +       else
> +               cap_invert = false;
>
> -       ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0);
> +       ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);
>         if (ret) {
>                 if (ret == -EPROBE_DEFER)
>                         goto out;
> @@ -393,6 +413,10 @@ int mmc_of_parse(struct mmc_host *host)
>         } else
>                 dev_info(host->parent, "Got WP GPIO\n");
>
> +       /* See the comment on CD inversion above */
> +       if (cap_invert ^ gpio_invert)
> +               host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> +
>         if (of_find_property(np, "cap-sd-highspeed", &len))
>                 host->caps |= MMC_CAP_SD_HIGHSPEED;
>         if (of_find_property(np, "cap-mmc-highspeed", &len))
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 38f76555d4bf..411f643fa369 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -281,6 +281,7 @@ EXPORT_SYMBOL(mmc_gpio_free_cd);
>   * @idx: index of the GPIO to obtain in the consumer
>   * @override_active_level: ignore %GPIO_ACTIVE_LOW flag
>   * @debounce: debounce time in microseconds
> + * @gpio_invert: will return whether the GPIO line is inverted or not
>   *
>   * Use this function in place of mmc_gpio_request_cd() to use the GPIO
>   * descriptor API.  Note that it is paired with mmc_gpiod_free_cd() not
> @@ -291,7 +292,7 @@ EXPORT_SYMBOL(mmc_gpio_free_cd);
>   */
>  int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
> -                        unsigned int debounce)
> +                        unsigned int debounce, bool *gpio_invert)
>  {
>         struct mmc_gpio *ctx;
>         struct gpio_desc *desc;
> @@ -316,6 +317,8 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                         return ret;
>         }
>
> +       *gpio_invert = !gpiod_is_active_low(desc);
> +

May I suggest to add "if (!gpio_invert)" before assigning the value to it.

That means callers of this function gets to decide whether the result
of gpio_invert is interesting. Those that think not, can provide
"NULL".

Kind regards
Uffe


>         ctx->override_cd_active_level = override_active_level;
>         ctx->cd_gpio = desc;
>
> @@ -330,6 +333,7 @@ EXPORT_SYMBOL(mmc_gpiod_request_cd);
>   * @idx: index of the GPIO to obtain in the consumer
>   * @override_active_level: ignore %GPIO_ACTIVE_LOW flag
>   * @debounce: debounce time in microseconds
> + * @gpio_invert: will return whether the GPIO line is inverted or not
>   *
>   * Use this function in place of mmc_gpio_request_ro() to use the GPIO
>   * descriptor API.  Note that it is paired with mmc_gpiod_free_ro() not
> @@ -339,7 +343,7 @@ EXPORT_SYMBOL(mmc_gpiod_request_cd);
>   */
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
> -                        unsigned int debounce)
> +                        unsigned int debounce, bool *gpio_invert)
>  {
>         struct mmc_gpio *ctx;
>         struct gpio_desc *desc;
> @@ -364,6 +368,8 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                         return ret;
>         }
>
> +       *gpio_invert = !gpiod_is_active_low(desc);
> +
>         ctx->override_ro_active_level = override_active_level;
>         ctx->ro_gpio = desc;
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index c9dafed550f2..5c9f2d543144 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1512,6 +1512,7 @@ static int mmci_probe(struct amba_device *dev,
>         struct variant_data *variant = id->data;
>         struct mmci_host *host;
>         struct mmc_host *mmc;
> +       bool dummy;
>         int ret;
>
>         /* Must have platform data or Device Tree. */
> @@ -1682,7 +1683,7 @@ static int mmci_probe(struct amba_device *dev,
>          * silently of these do not exist and proceed to try platform data
>          */
>         if (!np) {
> -               ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> +               ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, &dummy);
>                 if (ret < 0) {
>                         if (ret == -EPROBE_DEFER)
>                                 goto clk_disable;
> @@ -1693,7 +1694,7 @@ static int mmci_probe(struct amba_device *dev,
>                         }
>                 }
>
> -               ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0);
> +               ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, &dummy);
>                 if (ret < 0) {
>                         if (ret == -EPROBE_DEFER)
>                                 goto clk_disable;
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index a0d0442c15bf..e56fa24c9322 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -24,10 +24,10 @@ void mmc_gpio_free_cd(struct mmc_host *host);
>
>  int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
> -                        unsigned int debounce);
> +                        unsigned int debounce, bool *gpio_invert);
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, bool override_active_level,
> -                        unsigned int debounce);
> +                        unsigned int debounce, bool *gpio_invert);
>  void mmc_gpiod_free_cd(struct mmc_host *host);
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>
> --
> 1.9.3
>
