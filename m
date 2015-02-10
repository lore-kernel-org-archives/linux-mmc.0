From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH V4 3/4] mmc: pwrseq: Initial support for the simple MMC
 power sequence provider
Date: Tue, 10 Feb 2015 17:34:33 +0900
Message-ID: <CAAVeFu+ubZZGQd=zPPYm--PVCO9q-A3503Y5g50+sU4ztxU+iA@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org> <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41922 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbBJIez (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 03:34:55 -0500
In-Reply-To: <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

On Mon, Jan 19, 2015 at 6:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To add the core part for the MMC power sequence, let's start by adding
> initial support for the simple MMC power sequence provider.
>
> In this initial step, the MMC power sequence node are fetched and the
> compatible string for the simple MMC power sequence provider are
> verified.
>
> At this point we don't parse the node for any properties, but instead
> that will be handled from following patches. Since there are no
> properties supported yet, let's just implement the ->alloc() and the
> ->free() callbacks.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v4:
>         - Fixed call to kfree().
>
> ---
>  drivers/mmc/core/Makefile        |  2 +-
>  drivers/mmc/core/pwrseq.c        | 61 +++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/pwrseq.h        |  2 ++
>  drivers/mmc/core/pwrseq_simple.c | 48 +++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/core/pwrseq_simple.c
>
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index ccdd35f..b39cbd2 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -8,5 +8,5 @@ mmc_core-y                      := core.o bus.o host.o \
>                                    sdio.o sdio_ops.o sdio_bus.o \
>                                    sdio_cis.o sdio_io.o sdio_irq.o \
>                                    quirks.o slot-gpio.o
> -mmc_core-$(CONFIG_OF)          += pwrseq.o
> +mmc_core-$(CONFIG_OF)          += pwrseq.o pwrseq_simple.o
>  mmc_core-$(CONFIG_DEBUG_FS)    += debugfs.o
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index bd08772..2cea00e 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -7,14 +7,73 @@
>   *
>   *  MMC power sequence management
>   */
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
>  #include <linux/mmc/host.h>
>
>  #include "pwrseq.h"
>
> +struct mmc_pwrseq_match {
> +       const char *compatible;
> +       int (*alloc)(struct mmc_host *host, struct device *dev);
> +};
> +
> +static struct mmc_pwrseq_match pwrseq_match[] = {
> +       {
> +               .compatible = "mmc-pwrseq-simple",
> +               .alloc = mmc_pwrseq_simple_alloc,
> +       },
> +};
> +
> +static struct mmc_pwrseq_match *mmc_pwrseq_find(struct device_node *np)
> +{
> +       struct mmc_pwrseq_match *match = ERR_PTR(-ENODEV);
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(pwrseq_match); i++) {
> +               if (of_device_is_compatible(np, pwrseq_match[i].compatible)) {
> +                       match = &pwrseq_match[i];
> +                       break;
> +               }
> +       }
> +
> +       return match;
> +}
>
>  int mmc_pwrseq_alloc(struct mmc_host *host)
>  {
> -       return 0;
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       struct mmc_pwrseq_match *match;
> +       int ret = 0;
> +
> +       np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
> +       if (!np)
> +               return 0;
> +
> +       pdev = of_find_device_by_node(np);
> +       if (!pdev) {
> +               ret = -ENODEV;
> +               goto err;
> +       }
> +
> +       match = mmc_pwrseq_find(np);
> +       if (IS_ERR(match)) {
> +               ret = PTR_ERR(match);
> +               goto err;
> +       }
> +
> +       ret = match->alloc(host, &pdev->dev);
> +       if (!ret)
> +               dev_info(host->parent, "allocated mmc-pwrseq\n");
> +
> +err:
> +       of_node_put(np);
> +       return ret;
>  }
>
>  void mmc_pwrseq_pre_power_on(struct mmc_host *host)
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 12aaf2b..bd860d8 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -27,6 +27,8 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host);
>  void mmc_pwrseq_power_off(struct mmc_host *host);
>  void mmc_pwrseq_free(struct mmc_host *host);
>
> +int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev);
> +
>  #else
>
>  static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> new file mode 100644
> index 0000000..61c991e
> --- /dev/null
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -0,0 +1,48 @@
> +/*
> + *  Copyright (C) 2014 Linaro Ltd
> + *
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + *
> + *  Simple MMC power sequence management
> + */
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +
> +#include <linux/mmc/host.h>
> +
> +#include "pwrseq.h"
> +
> +struct mmc_pwrseq_simple {
> +       struct mmc_pwrseq pwrseq;
> +};
> +
> +static void mmc_pwrseq_simple_free(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
> +                                       struct mmc_pwrseq_simple, pwrseq);
> +
> +       kfree(pwrseq);
> +       host->pwrseq = NULL;
> +}
> +
> +static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> +       .free = mmc_pwrseq_simple_free,
> +};
> +
> +int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
> +{
> +       struct mmc_pwrseq_simple *pwrseq;
> +
> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
> +       if (!pwrseq)
> +               return -ENOMEM;
> +
> +       pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
> +       host->pwrseq = &pwrseq->pwrseq;

How about making this function return a struct mmc_pwrseq * so this
last line can be moved to mmc_pwrseq_alloc() instead of requiring all
power sequences to do it?

The same applies to

    host->pwrseq = NULL;

in mmc_pwrseq_simple_free(), which could be done in mmc_pwrseq_free() it seems.
