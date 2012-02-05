From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc:core: Fix comparison issue in mmc_compare_ext_csds
Date: Sat, 04 Feb 2012 21:08:02 -0500
Message-ID: <m2vcnm6ni5.fsf@bob.laptop.org>
References: <cover.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
	<d6bc8a99fb26a999ac17c793065333ccbf374b67.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49382 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404Ab2BECIK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:08:10 -0500
In-Reply-To: <d6bc8a99fb26a999ac17c793065333ccbf374b67.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
	(Jurgen Heeks's message of "Wed, 1 Feb 2012 13:30:55 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jurgen Heeks <JURGEN.HEEKS@NOKIA.COM>
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com

Hi,

On Wed, Feb 01 2012, Jurgen Heeks wrote:
> Found this issue during code review. Actually, there are two
> issues which both compensate together in lucky case.
> In unlucky case the bus width probing might not work as expected.
>
> Signed-off-by: Jurgen Heeks <JURGEN.HEEKS@NOKIA.COM>
> ---
>  drivers/mmc/core/mmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f6ac0a4..4f06c43 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -353,7 +353,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	}
>  
>  	card->ext_csd.raw_hc_erase_gap_size =
> -		ext_csd[EXT_CSD_PARTITION_ATTRIBUTE];
> +		ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
>  	card->ext_csd.raw_sec_trim_mult =
>  		ext_csd[EXT_CSD_SEC_TRIM_MULT];
>  	card->ext_csd.raw_sec_erase_mult =
> @@ -451,7 +451,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>  		goto out;
>  
>  	/* only compare read only fields */
> -	err = (!(card->ext_csd.raw_partition_support ==
> +	err = !((card->ext_csd.raw_partition_support ==
>  			bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
>  		(card->ext_csd.raw_erased_mem_count ==
>  			bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&

Thanks very much, Jurgen!  Pushed to mmc-next for 3.3 with Namjae's
Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
