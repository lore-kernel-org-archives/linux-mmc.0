From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: + mmc-recognize-csd-structure.patch added to -mm tree
Date: Mon, 07 Jun 2010 10:27:20 +0300
Message-ID: <4C0C9F58.4010504@nokia.com>
References: <201006042236.o54MaLod022299@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48442 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab0FGH1z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2010 03:27:55 -0400
In-Reply-To: <201006042236.o54MaLod022299@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "kmpark@infradead.org" <kmpark@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

ext akpm@linux-foundation.org wrote:
> The patch titled
>      mmc: recognize CSD structure
> has been added to the -mm tree.  Its filename is
>      mmc-recognize-csd-structure.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: mmc: recognize CSD structure
> From: Kyungmin Park <kmpark@infradead.org>
> 
> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structure
> version 3 and version 3 have to check the CSD_STRUCTURE byte in the
> EXT_CSD register.

>From my understanding there is no CSD structure version 3, so the comment
is a bit misleading.  The '3' value is used to mean something else i.e.
look for the actual version value in another register.  The actual version
is still '2'.  Also v4.3 and v4.4 eMMCs do not need to use the '3' value
and (apart from Samsung) probably won't because it is essentially
meaningless.

The comment doesn't matter but the unsupported 0 value needs to be
checked in EXT_CSD too - see below.

> 
> Also fix EXT_CSD revision message.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/mmc/core/mmc.c   |   26 +++++++++++++++++++-------
>  include/linux/mmc/card.h |    1 +
>  include/linux/mmc/mmc.h  |    1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/mmc/core/mmc.c~mmc-recognize-csd-structure drivers/mmc/core/mmc.c
> --- a/drivers/mmc/core/mmc.c~mmc-recognize-csd-structure
> +++ a/drivers/mmc/core/mmc.c
> @@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_car
>  static int mmc_decode_csd(struct mmc_card *card)
>  {
>  	struct mmc_csd *csd = &card->csd;
> -	unsigned int e, m, csd_struct;
> +	unsigned int e, m;
>  	u32 *resp = card->raw_csd;
>  
>  	/*
>  	 * We only understand CSD structure v1.1 and v1.2.
>  	 * v1.2 has extra information in bits 15, 11 and 10.
> +	 * also support the for eMMC v4.4 & v4.41.
>  	 */
> -	csd_struct = UNSTUFF_BITS(resp, 126, 2);
> -	if (csd_struct != 1 && csd_struct != 2) {
> +	csd->structure = UNSTUFF_BITS(resp, 126, 2);
> +	if (csd->structure == 0) {
>  		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
> -			mmc_hostname(card->host), csd_struct);
> +			mmc_hostname(card->host), csd->structure);
>  		return -EINVAL;
>  	}
>  
> @@ -207,11 +208,22 @@ static int mmc_read_ext_csd(struct mmc_c
>  		goto out;
>  	}
>  
> +	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
> +	if (card->csd.structure == 3) {
> +		int ext_csd_struct = ext_csd[EXT_CSD_STRUCTURE];
> +		if (ext_csd_struct > 2) {

0 still isn't supported i.e.

		if (ext_csd_struct < 1 || ext_csd_struct > 2) {


> +			printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
> +				"version %d\n", mmc_hostname(card->host),
> +					ext_csd_struct);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
>  	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
>  	if (card->ext_csd.rev > 5) {
> -		printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
> -			"version %d\n", mmc_hostname(card->host),
> -			card->ext_csd.rev);
> +		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
> +			mmc_hostname(card->host), card->ext_csd.rev);
>  		err = -EINVAL;
>  		goto out;
>  	}
> diff -puN include/linux/mmc/card.h~mmc-recognize-csd-structure include/linux/mmc/card.h
> --- a/include/linux/mmc/card.h~mmc-recognize-csd-structure
> +++ a/include/linux/mmc/card.h
> @@ -24,6 +24,7 @@ struct mmc_cid {
>  };
>  
>  struct mmc_csd {
> +	unsigned char		structure;
>  	unsigned char		mmca_vsn;
>  	unsigned short		cmdclass;
>  	unsigned short		tacc_clks;
> diff -puN include/linux/mmc/mmc.h~mmc-recognize-csd-structure include/linux/mmc/mmc.h
> --- a/include/linux/mmc/mmc.h~mmc-recognize-csd-structure
> +++ a/include/linux/mmc/mmc.h
> @@ -254,6 +254,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BUS_WIDTH	183	/* R/W */
>  #define EXT_CSD_HS_TIMING	185	/* R/W */
>  #define EXT_CSD_CARD_TYPE	196	/* RO */
> +#define EXT_CSD_STRUCTURE	194	/* RO */
>  #define EXT_CSD_REV		192	/* RO */
>  #define EXT_CSD_SEC_CNT		212	/* RO, 4 bytes */
>  #define EXT_CSD_S_A_TIMEOUT	217
> _
> 
> Patches currently in -mm which might be from kmpark@infradead.org are
> 
> mmc-recognize-csd-structure.patch
> 
> 

