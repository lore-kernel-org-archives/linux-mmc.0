From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/3] mmc: add MMC_QUIRK_BROKEN_CLK_GATING
Date: Mon, 10 Jan 2011 07:58:30 -0800
Message-ID: <ADE0108D-6DF1-4230-B7FB-39D7AC7F63D1@marvell.com>
References: <cover.1294588491.git.tardyp@gmail.com>
 <4663ceeebbd267abb11515570ac17702a6a482f4.1294588491.git.tardyp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50185 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751098Ab1AJP6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 10:58:55 -0500
In-Reply-To: <4663ceeebbd267abb11515570ac17702a6a482f4.1294588491.git.tardyp@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On Jan 9, 2011, at 8:26 AM, Pierre Tardy wrote:

> Some sdio card are not following sdio standard, and does not work
> when the sdio bus's clock is gated
> 
> To keep functionnality for all legacy driver, we turn this quirk on
> for every sdio card.
> Drivers needs to disable the quirk manually when someone verified that their
> supported card works with clock gating.
> 
> Signed-off-by: Pierre Tardy <tardyp@gmail.com>
> ---
> drivers/mmc/core/host.c   |    5 +----
> drivers/mmc/core/quirks.c |   11 +++++++++++
> include/linux/mmc/card.h  |    1 +
> 3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b3ac6c5..461e6a1 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -160,10 +160,7 @@ static bool mmc_host_may_gate_card(struct mmc_card *card)
> 	 * gate the clock, because there is somebody out there that may still
> 	 * be using it.
> 	 */
> -	if (mmc_card_sdio(card))
> -		return false;
> -
> -	return true;
> +	return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);
> }


Since the code is not called that often could you change the above code to:  

> 	if (mmc_card_sdio(card))
> 		return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);
	return true;

more obvious that quirk only applies to sdio.

> 
> /**
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index d8a5fec..fe467c8 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -32,7 +32,18 @@ static void add_quirk(struct mmc_card *card, int data)
> 	card->quirks |= data;
> }
> 
> +/*
> + * This hook just adds a quirk for all sdio devices
> + */
> +static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
> +{
> +	if (mmc_card_sdio(card))
> +		card->quirks |= data;
> +}
> +
> static const struct mmc_fixup mmc_fixup_methods[] = {
> +	{ SDIO_ANY_ID, SDIO_ANY_ID,
> +		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING }
> 	{ 0 }
> };
> 
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index a498d53..3fe9db0 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -121,6 +121,7 @@ struct mmc_card {
> 						/* for byte mode */
> #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
> 						/* (missing CIA registers) */
> +#define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
> 
> 	unsigned int		erase_size;	/* erase size in sectors */
>  	unsigned int		erase_shift;	/* if erase unit is power 2 */
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

