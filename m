From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: atmel-mci: Add support for non-removable slots
Date: Tue, 4 Nov 2014 08:41:51 +0100
Message-ID: <CAPDyKFpTVedeMOnL1FRYt8orzYy4YinYuosCH5pWT+tCZPN45g@mail.gmail.com>
References: <CAPDyKFpMGk4M=fjBKufxb9iMbV6FmRTEfE_ptXPmM=CHx3Q7iQ@mail.gmail.com>
	<1415013179-16823-1-git-send-email-timo.kokkonen@offcode.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:45827 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaKDHlw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 02:41:52 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so9660589qaq.30
        for <linux-mmc@vger.kernel.org>; Mon, 03 Nov 2014 23:41:52 -0800 (PST)
In-Reply-To: <1415013179-16823-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>

On 3 November 2014 12:12, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> Add support for non-removable slots which have no card detection GPIO
> and which should not be polled for a card change.
>
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 11 +++++++++--
>  include/linux/atmel-mci.h    |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 77250d4..4de1a31 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -560,6 +560,9 @@ atmci_of_init(struct platform_device *pdev)
>                 pdata->slot[slot_id].detect_is_active_high =
>                         of_property_read_bool(cnp, "cd-inverted");
>
> +               pdata->slot[slot_id].non_removable =
> +                       of_property_read_bool(cnp, "non-removable");
> +
>                 pdata->slot[slot_id].wp_pin =
>                         of_get_named_gpio(cnp, "wp-gpios", 0);
>         }
> @@ -2206,8 +2209,12 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>                 }
>         }
>
> -       if (!gpio_is_valid(slot->detect_pin))
> -               mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       if (!gpio_is_valid(slot->detect_pin)) {
> +               if (slot_data->non_removable)
> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
> +               else
> +                       mmc->caps |= MMC_CAP_NEEDS_POLL;
> +       }
>
>         if (gpio_is_valid(slot->wp_pin)) {
>                 if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 91b77f8..9177947 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -11,6 +11,7 @@
>   * @detect_pin: GPIO pin wired to the card detect switch
>   * @wp_pin: GPIO pin wired to the write protect sensor
>   * @detect_is_active_high: The state of the detect pin when it is active
> + * @non_removable: The slot is not removable, only detect once
>   *
>   * If a given slot is not present on the board, @bus_width should be
>   * set to 0. The other fields are ignored in this case.
> @@ -26,6 +27,7 @@ struct mci_slot_pdata {
>         int                     detect_pin;
>         int                     wp_pin;
>         bool                    detect_is_active_high;
> +       bool                    non_removable;
>  };
>
>  /**
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
