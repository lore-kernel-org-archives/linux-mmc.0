From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 6/7] mmc: dw_mmc: remove the dw_mci_of_cd_gpio/wp_gpio()
Date: Thu, 6 Mar 2014 08:35:31 +0100
Message-ID: <CAPDyKFrmQ0=gaHinHQ_1+CHpQdeg9u=5pVxbHTZc7Fj-sQ6j7Q@mail.gmail.com>
References: <5313EABE.3050405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:32928 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCFHfc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 02:35:32 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so2398171qcy.26
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 23:35:31 -0800 (PST)
In-Reply-To: <5313EABE.3050405@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> If mmc_of_parse() is used, dw_mci_of_get_cd_gpio/wp_gpio didn't need.
> Already implemented into mmc_of_parse().
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Nice cleanup!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Changelog V4:
>         - Remove the wp_gpio code.
> Changelog V3:
>         - None
>
>  drivers/mmc/host/dw_mmc.c |   60 +++------------------------------------------
>  drivers/mmc/host/dw_mmc.h |    2 --
>  2 files changed, 3 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1418d33..22184c1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -994,12 +994,13 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>  {
>         int read_only;
>         struct dw_mci_slot *slot = mmc_priv(mmc);
> +       int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
>         if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
>                 read_only = 0;
> -       else if (gpio_is_valid(slot->wp_gpio))
> -               read_only = gpio_get_value(slot->wp_gpio);
> +       else if (!IS_ERR_VALUE(gpio_ro))
> +               read_only = gpio_ro;
>         else
>                 read_only =
>                         mci_readl(slot->host, WRTPRT) & (1 << slot->id) ? 1 : 0;
> @@ -2025,49 +2026,6 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>
>         return quirks;
>  }
> -
> -/* find the write protect gpio for a given slot; or -1 if none specified */
> -static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
> -{
> -       struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
> -       int gpio;
> -
> -       if (!np)
> -               return -EINVAL;
> -
> -       gpio = of_get_named_gpio(np, "wp-gpios", 0);
> -
> -       /* Having a missing entry is valid; return silently */
> -       if (!gpio_is_valid(gpio))
> -               return -EINVAL;
> -
> -       if (devm_gpio_request(dev, gpio, "dw-mci-wp")) {
> -               dev_warn(dev, "gpio [%d] request failed\n", gpio);
> -               return -EINVAL;
> -       }
> -
> -       return gpio;
> -}
> -
> -/* find the cd gpio for a given slot */
> -static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
> -                                       struct mmc_host *mmc)
> -{
> -       struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
> -       int gpio;
> -
> -       if (!np)
> -               return;
> -
> -       gpio = of_get_named_gpio(np, "cd-gpios", 0);
> -
> -       /* Having a missing entry is valid; return silently */
> -       if (!gpio_is_valid(gpio))
> -               return;
> -
> -       if (mmc_gpio_request_cd(mmc, gpio, 0))
> -               dev_warn(dev, "gpio [%d] request failed\n", gpio);
> -}
>  #else /* CONFIG_OF */
>  static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>  {
> @@ -2077,15 +2035,6 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>  {
>         return NULL;
>  }
> -static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
> -{
> -       return -EINVAL;
> -}
> -static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
> -                                       struct mmc_host *mmc)
> -{
> -       return;
> -}
>  #endif /* CONFIG_OF */
>
>  static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> @@ -2164,9 +2113,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  #endif /* CONFIG_MMC_DW_IDMAC */
>         }
>
> -       slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
> -       dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
> -
>         ret = mmc_add_host(mmc);
>         if (ret)
>                 goto err_setup_bus;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..0c75f2c 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -195,7 +195,6 @@ extern int dw_mci_resume(struct dw_mci *host);
>   * @mmc: The mmc_host representing this slot.
>   * @host: The MMC controller this slot is using.
>   * @quirks: Slot-level quirks (DW_MCI_SLOT_QUIRK_XXX)
> - * @wp_gpio: If gpio_is_valid() we'll use this to read write protect.
>   * @ctype: Card type for this slot.
>   * @mrq: mmc_request currently being processed or waiting to be
>   *     processed, or NULL when the slot is idle.
> @@ -214,7 +213,6 @@ struct dw_mci_slot {
>         struct dw_mci           *host;
>
>         int                     quirks;
> -       int                     wp_gpio;
>
>         u32                     ctype;
>
> --
> 1.7.9.5
