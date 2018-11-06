From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 06 Nov 2018 16:01:50 +0100
Message-ID: <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
         <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2018-11-06 at 19:34 +0530, Faiz Abbas wrote:
> Hi Sjoerd,
> 
> On Tuesday 06 November 2018 07:00 PM, Sjoerd Simons wrote:
> > On some of our boards containing Micron eMMC chips compatible with
> > the eMMC 5.0 specification we starting seeing boot failures due to
> > timeouts:
> >   mmc1: error -110 whilst initialising MMC card
> > 
> > It turns out that switching the cache on after a power loss event
> > can
> > take quite long. In some simple testing thusfar we've seen values
> > up to
> > 700ms, which is far longer then the GENERIC_CMD6_TIME of the chip
> > (250ms).
> > 
> > Looking at both the eMMC 4.51 and 5.0 specification there doesn't
> > seem
> > to be a defined upper bound for the CACHE_CTRL ON command. For both
> > CACHE_CTRL OFF and FLUSH_CACHE it is documented that they can take
> > essentially unbounded time, but CACHE_CTRL ON i get the impression
> > that
> > it's assumed to be "fast". Unfortunately this is not true in
> > reality.
> > 
> > To resolve this, simply drop the timeout from CACHE_CTRL ON and
> > assume
> > it might take an unbounded time similar to the FLUSH_CACHE command.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > 
> 
> I have the exact same problem with micron cards. Specifically with
> CID: 
> R1J56L
> 
> The correct way to solve this would be to add a quirk for the
> specific 
> card. Does this patch solve your issue?

It would yes (unfortunately my google-foo failed to find your patch); 

That also happens to be one of the cards we deploy; However i did
wonder about adding a quirk but decided against it as it was not clear
to me from the specification that CACHE ON really is meant to complete
within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
mole games as the failure is really quite tedious (boot failure). 

Our approved parts lists has more Micron eMMC 5.0 parts, I'm trying to
find out whether we actually had batches build with those and then we
check if they have the same behaviour or not.

  Sjoerd

> ---8<---
> From 9d470be59acd82859beb4c965a620c9a32858bb4 Mon Sep 17 00:00:00
> 2001
> From: Faiz Abbas <faiz_abbas@ti.com>
> Date: Wed, 20 Jun 2018 20:36:38 +0530
> Subject: [PATCH] mmc: core: Add QUIRK for eMMC CMD6 timeout for some
> Micron
>  cards
> 
> It seems that on some Micron eMMC cards present on TI's AM654 EVM
> the CACHE_CTRL_ENABLE function in CMD6 takes longer (~750 ms) than
> the specified timeout in the GENERIC_CMD6_TIMEOUT byte of the
> Extended CSD (~250 ms).
> 
> Therefore, add a quirk to detect this card and use a value of 1 sec
> for
> timeout.
> 
> Reported-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/mmc/core/card.h   |  7 +++++++
>  drivers/mmc/core/mmc.c    | 14 +++++++++++++-
>  drivers/mmc/core/quirks.h |  8 ++++++++
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 9c821eedd156..6b5e3c6253f5 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -84,6 +84,8 @@ struct mmc_fixup {
>  #define CID_MANFID_HYNIX	0x90
>  #define CID_MANFID_NUMONYX	0xFE
>  
> +#define CID_NAME_R1J56L	"R1J56L"
> +
>  #define END_FIXUP { NULL }
>  
>  #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	
> \
> @@ -221,4 +223,9 @@ static inline int mmc_card_broken_hpi(const
> struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BROKEN_HPI;
>  }
>  
> +static inline int mmc_card_long_cache_ctrl(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_LONG_CACHE_ENABLE_TIME;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bad5c1bf4ed9..667caeb640a3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1522,6 +1522,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  	struct mmc_card *oldcard)
>  {
>  	struct mmc_card *card;
> +	unsigned int cache_ctrl_timeout;
>  	int err;
>  	u32 cid[4];
>  	u32 rocr;
> @@ -1766,9 +1767,20 @@ static int mmc_init_card(struct mmc_host
> *host, u32 ocr,
>  	 */
>  	if (!mmc_card_broken_hpi(card) &&
>  	    card->ext_csd.cache_size > 0) {
> +
> +		/*
> +		 * Some cards require a longer timeout than given in
> CSD.
> +		 * Use a one second timeout here which can be increased
> +		 * further if more cards needing larger timeouts are
> found
> +		 */
> +		if (mmc_card_long_cache_ctrl(card))
> +			cache_ctrl_timeout = 1000;
> +		else
> +			cache_ctrl_timeout = card-
> >ext_csd.generic_cmd6_time;
> +
>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				EXT_CSD_CACHE_CTRL, 1,
> -				card->ext_csd.generic_cmd6_time);
> +				cache_ctrl_timeout);
>  		if (err && err != -EBADMSG)
>  			goto free_card;
>  
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 5153577754f0..934ca72ef2b1 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -116,6 +116,14 @@ static const struct mmc_fixup
> mmc_ext_csd_fixups[] = {
>  	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
>  			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI,
> 6),
>  
> +	/*
> +	 * Certain Micron eMMC cards need a longer CMD6:CACHE_CTRL
> timeout
> +	 * than indicated in CSD
> +	 */
> +	MMC_FIXUP_EXT_CSD_REV(CID_NAME_R1J56L, CID_MANFID_MICRON,
> +			      0x14e, add_quirk,
> +			      MMC_QUIRK_LONG_CACHE_ENABLE_TIME, 7),
> +
>  	END_FIXUP
>  };
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 279b39008a33..5a8ce0bb222e 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -268,6 +268,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling
> SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim
> */
>  #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI
> support */
> +#define MMC_QUIRK_LONG_CACHE_ENABLE_TIME	(1 << 14) /* CACHE_CTRL
> enable time > CSD says */
>  
>  	bool			reenable_cmdq;	/* Re-enable Command
> Queue */
>  
-- 
Sjoerd Simons
Collabora Ltd.
