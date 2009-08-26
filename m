From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] sdio: add MMC_QUIRK_LENIENT_FN0
Date: Wed, 26 Aug 2009 16:42:27 -0700
Message-ID: <20090826164227.24783e4c.akpm@linux-foundation.org>
References: <1251249001.31954.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57379 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196AbZHZXm1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2009 19:42:27 -0400
In-Reply-To: <1251249001.31954.8.camel@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@bencohen.org>
Cc: linux-mmc@vger.kernel.org

On Wed, 26 Aug 2009 04:10:01 +0300
Ohad Ben-Cohen <ohad@bencohen.org> wrote:

> From: Ohad Ben-Cohen <ohad@wizery.com>
> 
> Normally writes to SDIO function 0 outside the vendor
> specific CCCR registers are prohibited. To support embedded
> devices that require writes to SDIO function 0 outside this
> range (e.g. TI WL127x embedded sdio wifi device),
> MMC_QUIRK_LENIENT_FN0 is introduced.
> 

It hardly seems worthwhile doing this in two separate patches so I
rolled them together and fiddled the changelog a bit.


> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index f61fc2d..f9aa8a7 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -624,7 +624,7 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
>  
>  	BUG_ON(!func);
>  
> -	if (addr < 0xF0 || addr > 0xFF) {
> +	if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
>  		if (err_ret)
>  			*err_ret = -EINVAL;
>  		return;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index eac86fe..bff96cf 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -95,6 +95,7 @@ struct mmc_card {
>  #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
>  #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
>  	unsigned int		quirks; 	/* card quirks */
> +#define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
>  
>  	u32			raw_cid[4];	/* raw card CID */
>  	u32			raw_csd[4];	/* raw card CSD */
> @@ -130,6 +131,8 @@ struct mmc_card {
>  #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  
> +#define mmc_card_lenient_fn0(c)	((c)->quirks & MMC_QUIRK_LENIENT_FN0)
> +
>  #define mmc_card_name(c)	((c)->cid.prod_name)
>  #define mmc_card_id(c)		(dev_name(&(c)->dev))

No, please don't use macros unless the function HAS to be implemented
in a macro.  If it simply cannot be implemented in C.

The code you have there will silently compile if passed the address of
any struct which contains a field called "quirks".  That's bad.  Using
a C function provides typechecking.

--- a/include/linux/mmc/card.h~sdio-add-mmc_quirk_lenient_fn0-fix
+++ a/include/linux/mmc/card.h
@@ -134,7 +134,10 @@ struct mmc_card {
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 
-#define mmc_card_lenient_fn0(c)	((c)->quirks & MMC_QUIRK_LENIENT_FN0)
+static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_LENIENT_FN0;
+}
 
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
_


A nice side-effect of using C is that for some reason people are more
likely to document C functions than with macros.  Although in this case
the MMC_QUIRK_LENIENT_FN0 documentation suffices.

