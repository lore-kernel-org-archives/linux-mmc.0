From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Mon, 9 Feb 2015 05:51:27 +0100
Message-ID: <CAPDyKFpxYcRu1s8jwtoV5SVCANwX90yEYxED+w45eVuwZJUGEQ@mail.gmail.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423134801-23219-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Alexandru Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWPdpHbCvnp+Ag@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 5 February 2015 at 12:13, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>
> Because of some uncertain factors, such as worse card or worse hardware,
> DAT[3:0](the data lines) may be pulled down by card, and mmc controller
> will be in busy state. This should not happend when mmc controller
> send command to update card clocks. If this happends, mci_send_cmd will
> be failed and we will get 'Timeout sending command', and then system will
> be blocked. To avoid this, we need reset mmc controller.
>
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>


Hi Addy,

Should I consider $subject patch as a better option to the one below?

[PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
https://lkml.org/lkml/2015/1/13/562

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4d2e3c2..b1d6dfb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -100,6 +100,7 @@ struct idmac_desc {
>  };
>  #endif /* CONFIG_MMC_DW_IDMAC */
>
> +static int dw_mci_card_busy(struct mmc_host *mmc);
>  static bool dw_mci_reset(struct dw_mci *host);
>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>
> @@ -888,6 +889,26 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>                 cmd, arg, cmd_status);
>  }
>
> +static void dw_mci_wait_busy(struct dw_mci_slot *slot)
> +{
> +       struct dw_mci *host = slot->host;
> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +
> +       while (time_before(jiffies, timeout)) {
> +               if (!dw_mci_card_busy(slot->mmc))
> +                       return;
> +       }
> +       dev_err(host->dev, "Data busy (status %#x)\n",
> +               mci_readl(slot->host, STATUS));
> +
> +       /*
> +        * Data busy, this should not happend when mmc controller send command
> +        * to update card clocks in non-volt-switch state. If it happends, we
> +        * should reset controller to avoid getting "Timeout sending command".
> +        */
> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
> +}
> +
>  static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  {
>         struct dw_mci *host = slot->host;
> @@ -899,6 +920,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>         /* We must continue to set bit 28 in CMD until the change is complete */
>         if (host->state == STATE_WAITING_CMD11_DONE)
>                 sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
> +       else
> +               dw_mci_wait_busy(slot);
>
>         if (!clock) {
>                 mci_writel(host, CLKENA, 0);
> --
> 1.8.3.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
