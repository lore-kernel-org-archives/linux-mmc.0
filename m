From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 01/10] mmc: return mmc_of_parse() errors to caller
Date: Tue, 21 May 2013 09:00:09 +0200
Message-ID: <CAPDyKFoE-_Kpn_FBmrePEGF84jwSADC+=6ibBmA_ePVg7B4z9Q@mail.gmail.com>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
	<1369090911-1479-2-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40394 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab3EUHAL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 May 2013 03:00:11 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so163334vcb.21
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2013 00:00:10 -0700 (PDT)
In-Reply-To: <1369090911-1479-2-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 21 May 2013 01:01, Simon Baatz <gmbnomis@gmail.com> wrote:
> In addition to just logging errors encountered during DT parsing or
> allocating GPIO slots for CD/WP, mmc_of_parse() now returns with an error.
>
> In particular, this is needed if the GPIO allocation may return
> EPROBE_DEFER.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>
> changes in V3:
> - Handle EPROBE_DEFER case
>
>  drivers/mmc/core/host.c  |   30 +++++++++++++++++++++++++-----
>  include/linux/mmc/host.h |    2 +-
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2a3593d..89f5849 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -306,7 +306,7 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
>   * parse the properties and set respective generic mmc-host flags and
>   * parameters.
>   */
> -void mmc_of_parse(struct mmc_host *host)
> +int mmc_of_parse(struct mmc_host *host)
>  {
>         struct device_node *np;
>         u32 bus_width;
> @@ -315,7 +315,7 @@ void mmc_of_parse(struct mmc_host *host)
>         int len, ret, gpio;
>
>         if (!host->parent || !host->parent->of_node)
> -               return;
> +               return 0;
>
>         np = host->parent->of_node;
>
> @@ -338,6 +338,7 @@ void mmc_of_parse(struct mmc_host *host)
>         default:
>                 dev_err(host->parent,
>                         "Invalid \"bus-width\" value %ud!\n", bus_width);
> +               return -EINVAL;
>         }
>
>         /* f_max is obtained from the optional "max-frequency" property */
> @@ -367,18 +368,22 @@ void mmc_of_parse(struct mmc_host *host)
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
>                 gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
> +               if (gpio == -EPROBE_DEFER)
> +                       return gpio;
>                 if (gpio_is_valid(gpio)) {
>                         if (!(flags & OF_GPIO_ACTIVE_LOW))
>                                 gpio_inv_cd = true;
>
>                         ret = mmc_gpio_request_cd(host, gpio);
> -                       if (ret < 0)
> +                       if (ret < 0) {
>                                 dev_err(host->parent,
>                                         "Failed to request CD GPIO #%d: %d!\n",
>                                         gpio, ret);
> -                       else
> +                               return ret;
> +                       } else {
>                                 dev_info(host->parent, "Got CD GPIO #%d.\n",
>                                          gpio);
> +                       }
>                 }
>
>                 if (explicit_inv_cd ^ gpio_inv_cd)
> @@ -389,14 +394,23 @@ void mmc_of_parse(struct mmc_host *host)
>         explicit_inv_wp = of_property_read_bool(np, "wp-inverted");
>
>         gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
> +       if (gpio == -EPROBE_DEFER) {
> +               ret = -EPROBE_DEFER;
> +               goto out;
> +       }
>         if (gpio_is_valid(gpio)) {
>                 if (!(flags & OF_GPIO_ACTIVE_LOW))
>                         gpio_inv_wp = true;
>
>                 ret = mmc_gpio_request_ro(host, gpio);
> -               if (ret < 0)
> +               if (ret < 0) {
>                         dev_err(host->parent,
>                                 "Failed to request WP GPIO: %d!\n", ret);
> +                       goto out;
> +               } else {
> +                               dev_info(host->parent, "Got WP GPIO #%d.\n",
> +                                        gpio);
> +               }
>         }
>         if (explicit_inv_wp ^ gpio_inv_wp)
>                 host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> @@ -413,6 +427,12 @@ void mmc_of_parse(struct mmc_host *host)
>                 host->pm_caps |= MMC_PM_KEEP_POWER;
>         if (of_find_property(np, "enable-sdio-wakeup", &len))
>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +
> +       return 0;
> +
> +out:
> +       mmc_gpio_free_cd(host);
> +       return ret;
>  }
>
>  EXPORT_SYMBOL(mmc_of_parse);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e326ae2..c8c4fbc 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -369,7 +369,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> -void mmc_of_parse(struct mmc_host *host);
> +int mmc_of_parse(struct mmc_host *host);
>
>  static inline void *mmc_priv(struct mmc_host *host)
>  {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
