From: Chris Ball <cjb@laptop.org>
Subject: Re: [PatchRebased] MMC: Fix erase/trim for certain SanDisk cards.
Date: Tue, 12 Apr 2011 15:37:14 -0400
Message-ID: <m3wrizxnv9.fsf@pullcord.laptop.org>
References: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
	<1302638813-32155-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36338 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937Ab1DLTcX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2011 15:32:23 -0400
In-Reply-To: <1302638813-32155-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Tue, 12 Apr 2011 15:06:53 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Tue, Apr 12 2011, Andrei Warkentin wrote:
> CMD38 argument is passed through EXT_CSD[113].
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/card/block.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h |    1 +
>  2 files changed, 43 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1bf1c5d..863f810 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -48,6 +48,13 @@ MODULE_ALIAS("mmc:block");
>  #endif
>  #define MODULE_PARAM_PREFIX "mmcblk."
>  
> +#define INAND_CMD38_ARG_EXT_CSD  113
> +#define INAND_CMD38_ARG_ERASE    0x00
> +#define INAND_CMD38_ARG_TRIM     0x01
> +#define INAND_CMD38_ARG_SECERASE 0x80
> +#define INAND_CMD38_ARG_SECTRIM1 0x81
> +#define INAND_CMD38_ARG_SECTRIM2 0x88
> +
>  #define REL_WRITES_SUPPORTED(card) (mmc_card_mmc((card)) &&	\
>      (((card)->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||	\
>       ((card)->ext_csd.rel_sectors)))
> @@ -356,6 +363,16 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  	else
>  		arg = MMC_ERASE_ARG;
>  
> +	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 INAND_CMD38_ARG_EXT_CSD,
> +				 arg == MMC_TRIM_ARG ?
> +				 INAND_CMD38_ARG_TRIM :
> +				 INAND_CMD38_ARG_ERASE,
> +				 0);
> +		if (err)
> +			goto out;
> +	}
>  	err = mmc_erase(card, from, nr, arg);
>  out:
>  	spin_lock_irq(&md->lock);
> @@ -386,9 +403,28 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>  	else
>  		arg = MMC_SECURE_ERASE_ARG;
>  
> +	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 INAND_CMD38_ARG_EXT_CSD,
> +				 arg == MMC_SECURE_TRIM1_ARG ?
> +				 INAND_CMD38_ARG_SECTRIM1 :
> +				 INAND_CMD38_ARG_SECERASE,
> +				 0);
> +		if (err)
> +			goto out;
> +	}
>  	err = mmc_erase(card, from, nr, arg);
> -	if (!err && arg == MMC_SECURE_TRIM1_ARG)
> +	if (!err && arg == MMC_SECURE_TRIM1_ARG) {
> +		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					 INAND_CMD38_ARG_EXT_CSD,
> +					 INAND_CMD38_ARG_SECTRIM2,
> +					 0);
> +			if (err)
> +				goto out;
> +		}
>  		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
> +	}
>  out:
>  	spin_lock_irq(&md->lock);
>  	__blk_end_request(req, err, blk_rq_bytes(req));
> @@ -941,6 +977,11 @@ static int mmc_add_disk(struct mmc_blk_data *md)
>  
>  static const struct mmc_fixup blk_fixups[] =
>  {
> +	MMC_FIXUP("SEM02G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
> +	MMC_FIXUP("SEM04G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
> +	MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
> +	MMC_FIXUP("SEM16G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
> +	MMC_FIXUP("SEM32G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
>  	END_FIXUP
>  };
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ac96f7..0a2be01 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -133,6 +133,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
> +#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
>  
>  	unsigned int		erase_size;	/* erase size in sectors */
>   	unsigned int		erase_shift;	/* if erase unit is power 2 */

Pushed to mmc-next for .40 along with the other patchsets.  Thanks very much!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
