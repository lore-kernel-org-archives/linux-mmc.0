From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv10 1/5] mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
Date: Mon, 11 Aug 2014 11:45:33 +0200
Message-ID: <CAPDyKFrbsFzTKSrM+sHrEuH9yd8kOX5vnWG7EiMZTGLU45hUOA@mail.gmail.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
	<1407397082-32495-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1407397082-32495-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 7 August 2014 09:37, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Slot quirks "disable-wp" is deprecated.
> Instead, use the host quirk "disable-wp".
> (Because the slot-node is removed in dt-file.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c  |   11 +++++++++--
>  include/linux/mmc/dw_mmc.h |    2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..47b52cc 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -997,7 +997,8 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
>         int gpio_ro = mmc_gpio_get_ro(mmc);
>
>         /* Use platform get_ro function, else try on board write protect */
> -       if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
> +       if ((slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) ||
> +                       (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT))
>                 read_only = 0;
>         else if (!IS_ERR_VALUE(gpio_ro))
>                 read_only = gpio_ro;
> @@ -2021,8 +2022,11 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>
>         /* get quirks */
>         for (idx = 0; idx < ARRAY_SIZE(of_slot_quirks); idx++)
> -               if (of_get_property(np, of_slot_quirks[idx].quirk, NULL))
> +               if (of_get_property(np, of_slot_quirks[idx].quirk, NULL)) {
> +                       dev_warn(dev, "Slot quirk %s is deprecated\n",
> +                                       of_slot_quirks[idx].quirk);
>                         quirks |= of_slot_quirks[idx].id;
> +               }
>
>         return quirks;
>  }
> @@ -2238,6 +2242,9 @@ static struct dw_mci_of_quirks {
>         {
>                 .quirk  = "broken-cd",
>                 .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> +       }, {
> +               .quirk  = "disable-wp",
> +               .id     = DW_MCI_QUIRK_NO_WRITE_PROTECT,
>         },
>  };
>
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index babaea9..29ce014 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -213,6 +213,8 @@ struct dw_mci_dma_ops {
>  #define DW_MCI_QUIRK_HIGHSPEED                 BIT(2)
>  /* Unreliable card detection */
>  #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION     BIT(3)
> +/* No write protect */
> +#define DW_MCI_QUIRK_NO_WRITE_PROTECT          BIT(4)
>
>  /* Slot level quirks */
>  /* This slot has no write protect */
> --
> 1.7.9.5
>
