From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: add MMC_QUIRK_DISABLE_CD
Date: Tue, 05 Apr 2011 11:26:26 -0400
Message-ID: <m3y63o4t3x.fsf@pullcord.laptop.org>
References: <1302015746-8414-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53125 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab1DEPU7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2011 11:20:59 -0400
In-Reply-To: <1302015746-8414-1-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 5 Apr 2011 18:02:25 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 05 2011, Ohad Ben-Cohen wrote:
> 006ebd5d introduced sdio_disable_cd(), which disconnects the pull-up
> resistor on CD/DAT[3] (pin 1) of the card.
>
> Make it possible to start using sdio_disable_cd() by introducing
> MMC_QUIRK_DISABLE_CD.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> Chris, I've posted this one before. Sending it again, this time with a follow-up patch that uses the new mmc quirks facility. thanks!
>
>  drivers/mmc/core/sdio.c  |    2 +-
>  include/linux/mmc/card.h |    6 ++++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index c3c2bd0..a5840c0 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -187,7 +187,7 @@ static int sdio_disable_cd(struct mmc_card *card)
>  	int ret;
>  	u8 ctrl;
>  
> -	if (!card->cccr.disable_cd)
> +	if (!mmc_card_disable_cd(card))
>  		return 0;
>  
>  	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_IF, 0, &ctrl);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c7f1532..4e03be8 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -126,6 +126,7 @@ struct mmc_card {
>  						/* (missing CIA registers) */
>  #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
> +#define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
>  
>  	unsigned int		erase_size;	/* erase size in sectors */
>   	unsigned int		erase_shift;	/* if erase unit is power 2 */
> @@ -181,6 +182,11 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
>  }
>  
> +static inline int mmc_card_disable_cd(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_DISABLE_CD;
> +}
> +
>  static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
>  {
>  	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
