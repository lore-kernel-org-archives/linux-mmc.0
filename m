From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc: core: proper ocr negotiation during resume
Date: Thu, 16 May 2013 14:48:16 +0200
Message-ID: <CAPDyKFr6q9d+3VvMfoHY2cDvma5yo==jXX5JB0yuZDtTUVFBZg@mail.gmail.com>
References: <loom.20130516T070719-840@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:60676 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab3EPMsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 May 2013 08:48:17 -0400
Received: by mail-ve0-f175.google.com with SMTP id cz11so2949998veb.20
        for <linux-mmc@vger.kernel.org>; Thu, 16 May 2013 05:48:16 -0700 (PDT)
In-Reply-To: <loom.20130516T070719-840@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 16 May 2013 07:14, Prasanna NAVARATNA <prasanna.navaratna@gmail.com> wrote:
> Hello,
>
> There seems some problem with ocr negotiation during resume. While going for
> suspend, in mmc_power_off function, it resets ocr mask to be the highest
> possible voltage supported for this mmc host. This value will be used at
> next power up without actually negotiating with card's ocr by querying, as
> done during initialization. This results in higher voltage during resume
> compared to voltage used during initialization.
>
> To fix this issue, i propose the following patch. Please review :-
>
> From 305c151cb5b217ff7c622a769df120b14153c25a Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> Date: Thu, 4 Apr 2013 19:55:19 +0530
> Subject: [PATCH] mmc: core: proper ocr negotiation during resume
>
> Save the card ocr into struct mmc_card when read from card
> during initialization of sd/mmc/sdio.
> Druing mmc_resume_host, supply saved card's ocr to
> mmc_select_voltage so as to negotiate voltage appropriately.

We have already discussed this issue on the mailing list I believe.
Your patch will not solve anything on it's own.

> ---
>  drivers/mmc/core/core.c  |    1 +
>  drivers/mmc/core/mmc.c   |    3 +++
>  drivers/mmc/core/sd.c    |    3 +++
>  drivers/mmc/core/sdio.c  |    3 +++
>  include/linux/mmc/card.h |    1 +
>  5 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ad7decc..e61b5ab 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2680,6 +2680,7 @@ int mmc_resume_host(struct mmc_host *host)
>         if (host->bus_ops && !host->bus_dead) {
>                 if (!mmc_card_keep_power(host)) {
>                         mmc_power_up(host);
> +                       host->ocr = host->card ? host->card->ocr : host->ocr;
>                         mmc_select_voltage(host, host->ocr);

mmc_select_voltage will manipulate the vdd/ocr, but at this point the
card is already powered due to state is MMC_POWER_ON.

>                         /*
>                          * Tell runtime PM core we just powered up the card,
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0cbd1ef..9b4b3a5 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1566,6 +1566,9 @@ int mmc_attach_mmc(struct mmc_host *host)
>                 ocr &= ~0x7F;
>         }
>
> +       /* Save the card OCR */
> +       host->card->ocr = ocr;
> +
>         host->ocr = mmc_select_voltage(host, ocr);

dito

>
>         /*
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9e645e1..965504b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1185,6 +1185,9 @@ int mmc_attach_sd(struct mmc_host *host)
>                 ocr &= ~MMC_VDD_165_195;
>         }
>
> +       /* Save the card OCR */
> +       host->card->ocr = ocr;
> +
>         host->ocr = mmc_select_voltage(host, ocr);

dito

>
>         /*
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index aa0719a..3f9e08d 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1090,6 +1090,9 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 ocr &= ~0x7F;
>         }
>
> +       /* Save the card OCR */
> +       host->card->ocr = ocr;
> +
>         host->ocr = mmc_select_voltage(host, ocr);

dito

>
>         /*
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f31725b..1bbec2f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -273,6 +273,7 @@ struct mmc_card {
>         u32                     raw_cid[4];     /* raw card CID */
>         u32                     raw_csd[4];     /* raw card CSD */
>         u32                     raw_scr[2];     /* raw card SCR */
> +       u32                     ocr;            /* card OCR */
>         struct mmc_cid          cid;            /* card identification */
>         struct mmc_csd          csd;            /* card specific */
>         struct mmc_ext_csd      ext_csd;        /* mmc v4 extended card specific */
> --
> 1.7.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Nack!

This is not the proper way to solve this issue. We need a way to
negotiate _AND_ use the correct ocr mask already at the first card
initialization sequence, this is not done today. When that is solved,
we don't need mmc_select_voltage as a part of the mmc_resume_host
sequence I believe.

Kind regards
Ulf Hansson
