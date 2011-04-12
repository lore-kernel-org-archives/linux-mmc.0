From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix erase/trim for certain SanDisk cards.
Date: Tue, 12 Apr 2011 15:33:28 -0400
Message-ID: <m31v17z2lz.fsf@pullcord.laptop.org>
References: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
	<1302638625-32106-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36267 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758Ab1DLT2h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2011 15:28:37 -0400
In-Reply-To: <1302638625-32106-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Tue, 12 Apr 2011 15:03:45 -0500")
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
>  drivers/mmc/card/block.c |   40 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h |    1 +
>  2 files changed, 40 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1bf1c5d..8895bb9 100644
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
> @@ -356,6 +363,15 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  	else
>  		arg = MMC_ERASE_ARG;
>  
> +	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 INAND_CMD38_ARG_EXT_CSD,
> +				 arg == MMC_TRIM_ARG ?
> +				 INAND_CMD38_ARG_TRIM :
> +				 INAND_CMD38_ARG_ERASE);

You're still missing the final argument to mmc_switch(), no?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
