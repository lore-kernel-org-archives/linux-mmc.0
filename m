From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] mmc: dw_mmc: Use core to handle absent write
 protect line
Date: Mon, 11 May 2015 12:30:47 +0200
Message-ID: <CAPDyKFrKoEKimogCQH30X4Rek85r0XONJ90Awaz6TnGPhjGJCQ@mail.gmail.com>
References: <1430937082-27149-1-git-send-email-lars@metafoo.de>
	<1430937082-27149-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430937082-27149-4-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 6 May 2015 at 20:31, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> Use the new MMC_CAP2_NO_WRITE_PROTECT to let the core handle the case where
> no write protect line is present instead of having custom driver code to
> handle it.
>
> dw_mci_of_get_slot_quirks() is slightly refactored to directly modify the
> mmc_host capabilities instead of returning a quirk mask.
>
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

This looks good to me, but I leave it to Jaehoon to pick it up once tested.

Kind regards
Uffe

> ---
> Only compile tested.
> ---
>  drivers/mmc/host/dw_mmc.c  | 53 +++++++++++++++-------------------------------
>  drivers/mmc/host/dw_mmc.h  |  3 ---
>  include/linux/mmc/dw_mmc.h |  6 ------
>  3 files changed, 17 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 38b2926..0eedc5a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1276,10 +1276,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
> -       if ((slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) ||
> -                       (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT))
> -               read_only = 0;
> -       else if (!IS_ERR_VALUE(gpio_ro))
> +       if (!IS_ERR_VALUE(gpio_ro))
>                 read_only = gpio_ro;
>         else
>                 read_only =
> @@ -2277,9 +2274,10 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  }
>
>  #ifdef CONFIG_OF
> -/* given a slot id, find out the device node representing that slot */
> -static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
> +/* given a slot, find out the device node representing that slot */
> +static struct device_node *dw_mci_of_find_slot_node(struct dw_mci_slot *slot)
>  {
> +       struct device *dev = slot->mmc->parent;
>         struct device_node *np;
>         const __be32 *addr;
>         int len;
> @@ -2291,42 +2289,28 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>                 addr = of_get_property(np, "reg", &len);
>                 if (!addr || (len < sizeof(int)))
>                         continue;
> -               if (be32_to_cpup(addr) == slot)
> +               if (be32_to_cpup(addr) == slot->id)
>                         return np;
>         }
>         return NULL;
>  }
>
> -static struct dw_mci_of_slot_quirks {
> -       char *quirk;
> -       int id;
> -} of_slot_quirks[] = {
> -       {
> -               .quirk  = "disable-wp",
> -               .id     = DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
> -       },
> -};
> -
> -static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
> +static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
>  {
> -       struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
> -       int quirks = 0;
> -       int idx;
> +       struct device_node *np = dw_mci_of_find_slot_node(slot);
>
> -       /* get quirks */
> -       for (idx = 0; idx < ARRAY_SIZE(of_slot_quirks); idx++)
> -               if (of_get_property(np, of_slot_quirks[idx].quirk, NULL)) {
> -                       dev_warn(dev, "Slot quirk %s is deprecated\n",
> -                                       of_slot_quirks[idx].quirk);
> -                       quirks |= of_slot_quirks[idx].id;
> -               }
> +       if (!np)
> +               return;
>
> -       return quirks;
> +       if (of_property_read_bool(np, "disable-wp")) {
> +               slot->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
> +               dev_warn(slot->mmc->parent,
> +                       "Slot quirk 'disable-wp' is deprecated\n");
> +       }
>  }
>  #else /* CONFIG_OF */
> -static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
> +static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
>  {
> -       return 0;
>  }
>  #endif /* CONFIG_OF */
>
> @@ -2349,8 +2333,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>         slot->host = host;
>         host->slot[id] = slot;
>
> -       slot->quirks = dw_mci_of_get_slot_quirks(host->dev, slot->id);
> -
>         mmc->ops = &dw_mci_ops;
>         if (of_property_read_u32_array(host->dev->of_node,
>                                        "clock-freq-min-max", freq, 2)) {
> @@ -2388,6 +2370,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>         if (host->pdata->caps2)
>                 mmc->caps2 = host->pdata->caps2;
>
> +       dw_mci_slot_of_parse(slot);
> +
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto err_host_allocated;
> @@ -2615,9 +2599,6 @@ static struct dw_mci_of_quirks {
>         {
>                 .quirk  = "broken-cd",
>                 .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> -       }, {
> -               .quirk  = "disable-wp",
> -               .id     = DW_MCI_QUIRK_NO_WRITE_PROTECT,
>         },
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f45ab91..2c6d350 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -227,7 +227,6 @@ extern int dw_mci_resume(struct dw_mci *host);
>   * struct dw_mci_slot - MMC slot state
>   * @mmc: The mmc_host representing this slot.
>   * @host: The MMC controller this slot is using.
> - * @quirks: Slot-level quirks (DW_MCI_SLOT_QUIRK_XXX)
>   * @ctype: Card type for this slot.
>   * @mrq: mmc_request currently being processed or waiting to be
>   *     processed, or NULL when the slot is idle.
> @@ -245,8 +244,6 @@ struct dw_mci_slot {
>         struct mmc_host         *mmc;
>         struct dw_mci           *host;
>
> -       int                     quirks;
> -
>         u32                     ctype;
>
>         struct mmc_request      *mrq;
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 1211199..5be9767 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -226,12 +226,6 @@ struct dw_mci_dma_ops {
>  #define DW_MCI_QUIRK_HIGHSPEED                 BIT(2)
>  /* Unreliable card detection */
>  #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION     BIT(3)
> -/* No write protect */
> -#define DW_MCI_QUIRK_NO_WRITE_PROTECT          BIT(4)
> -
> -/* Slot level quirks */
> -/* This slot has no write protect */
> -#define DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT     BIT(0)
>
>  struct dma_pdata;
>
> --
> 1.8.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
