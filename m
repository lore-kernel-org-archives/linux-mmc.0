From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 01/10] mmc: return mmc_of_parse() errors to caller
Date: Tue, 14 May 2013 09:20:14 +0200
Message-ID: <CAPDyKFoyVCYDFkXWrj8zL8uGCTx4EYk=rM2i7rKx1+aA7LCbPg@mail.gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
	<1368479941-10084-2-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:58752 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab3ENHUP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 03:20:15 -0400
Received: by mail-ve0-f172.google.com with SMTP id b10so171872vea.31
        for <linux-mmc@vger.kernel.org>; Tue, 14 May 2013 00:20:14 -0700 (PDT)
In-Reply-To: <1368479941-10084-2-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 13 May 2013 23:18, Simon Baatz <gmbnomis@gmail.com> wrote:
> In addition to just logging errors encountered during DT parsing or
> allocating GPIO slots for CD/WP, mmc_of_parse() now returns with an
> error.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  drivers/mmc/core/host.c  |   24 +++++++++++++++++++-----
>  include/linux/mmc/host.h |    2 +-
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2a3593d..45122cc 100644
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
> @@ -372,13 +373,15 @@ void mmc_of_parse(struct mmc_host *host)
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
> @@ -394,9 +397,14 @@ void mmc_of_parse(struct mmc_host *host)
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
> @@ -413,6 +421,12 @@ void mmc_of_parse(struct mmc_host *host)
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
