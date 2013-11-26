From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc/sdio: add a quirk for broken SDIO_CCCR_INTx polling
Date: Wed, 27 Nov 2013 00:28:06 +0100
Message-ID: <CAPDyKFrrBpVw+J8zF8n8_9LGGvWET3WQ1vEqAS3hytKOapApJg@mail.gmail.com>
References: <1385496293-26365-1-git-send-email-bzhao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:58031 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796Ab3KZX2H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Nov 2013 18:28:07 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so5053103qae.19
        for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2013 15:28:06 -0800 (PST)
In-Reply-To: <1385496293-26365-1-git-send-email-bzhao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Paul Stewart <pstew@chromium.org>, Doug Anderson <dianders@chromium.org>

On 26 November 2013 21:04, Bing Zhao <bzhao@marvell.com> wrote:
> Polling SDIO_CCCR_INTx could create a fake interrupt with Marvell
> SD8797 card. Add a quirk to handle this case. The fixup here is
> to issue a dummy CMD52 read to function 0 register 0xff, and this
> dummy read must be right after SDIO_CCCR_INTx is read.
>
> Patch has been verified on a dw_mmc controller (Samsung Chromebook)
> with MMC_CAP_SDIO_IRQ disabled.
>
> Reviewed-by: Paul Stewart <pstew@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> v2: remove mmc_fixup_broken_irq_polling() and add inline
>     mmc_card_broken_irq_polling(). (Ulf Hansson)
>     invoke the quirk handling after 'ret' value is validated.
>
>  drivers/mmc/core/quirks.c   | 10 ++++++++++
>  drivers/mmc/core/sdio_irq.c | 11 +++++++++++
>  include/linux/mmc/card.h    |  8 +++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index 06ee1ae..02c94b5 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -13,6 +13,9 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/sdio_ids.h>
> +
> +#include "sdio_ops.h"

So these includes is not needed any more, I guess.

>
>  #ifndef SDIO_VENDOR_ID_TI
>  #define SDIO_VENDOR_ID_TI              0x0097
> @@ -30,6 +33,10 @@
>  #define SDIO_DEVICE_ID_STE_CW1200      0x2280
>  #endif
>
> +#ifndef SDIO_DEVICE_ID_MARVELL_8797_F0
> +#define SDIO_DEVICE_ID_MARVELL_8797_F0 0x9128
> +#endif
> +
>  /*
>   * This hook just adds a quirk for all sdio devices
>   */
> @@ -58,6 +65,9 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
>         SDIO_FIXUP(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200,
>                    add_quirk, MMC_QUIRK_BROKEN_BYTE_MODE_512),
>
> +       SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_F0,
> +                  add_quirk, MMC_QUIRK_BROKEN_IRQ_POLLING),
> +
>         END_FIXUP
>  };
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 3d8ceb4..417d2f0 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -53,6 +53,17 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>                 return ret;
>         }
>
> +       if (pending && mmc_card_broken_irq_polling(card) &&
> +           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> +               unsigned char dummy;
> +
> +               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> +                * register with a Marvell SD8797 card. A dummy CMD52 read to
> +                * function 0 register 0xff can aviod this.
> +                */
> +               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> +       }
> +
>         count = 0;
>         for (i = 1; i <= 7; i++) {
>                 if (pending & (1 << i)) {
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 176fdf8..b730272 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -271,9 +271,10 @@ struct mmc_card {
>  #define MMC_QUIRK_INAND_CMD38  (1<<6)          /* iNAND devices have broken CMD38 */
>  #define MMC_QUIRK_BLK_NO_CMD23 (1<<7)          /* Avoid CMD23 for regular multiblock */
>  #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)  /* Avoid sending 512 bytes in */
> +                                               /* byte mode */
>  #define MMC_QUIRK_LONG_READ_TIME (1<<9)                /* Data read time > CSD says */
>  #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)        /* Skip secure for erase/trim */
> -                                               /* byte mode */
> +#define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
> @@ -505,6 +506,11 @@ static inline int mmc_card_long_read_time(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_LONG_READ_TIME;
>  }
>
> +static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING;
> +}
> +
>  #define mmc_card_name(c)       ((c)->cid.prod_name)
>  #define mmc_card_id(c)         (dev_name(&(c)->dev))

This looks good! Feel free to add my ack once you fix the minor comment above.

Kind regards
Ulf Hansson


>
> --
> 1.8.0
>
