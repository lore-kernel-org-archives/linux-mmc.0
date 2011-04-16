From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [patchv3 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Sat, 16 Apr 2011 11:19:27 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB44438C@SAUSEXMBP01.amd.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
 <1302950458-1969-5-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:25517
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165Ab1DPQT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Apr 2011 12:19:29 -0400
In-Reply-To: <1302950458-1969-5-git-send-email-andreiw@motorola.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>

Hi Andrei,


> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Saturday, April 16, 2011 4:11 PM
> To: linux-mmc@vger.kernel.org
> Cc: Nath, Arindam; Andrei Warkentin; cjb@laptop.org; arnd@arndb.de
> Subject: [patchv3 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
> 
> SD cards operating at UHS104 or better support SET_BLOCK_COUNT.
> 
> Cc: arindam.nath@amd.com
> Cc: cjb@laptop.org
> Cc: arnd@arndb.de
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/card/block.c |    9 ++++++---
>  drivers/mmc/core/sd.c    |    1 +
>  include/linux/mmc/card.h |    1 +
>  include/linux/mmc/sd.h   |    1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4b1a58e..23da6e6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -851,9 +851,12 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>  	blk_queue_logical_block_size(md->queue.queue, 512);
>  	set_capacity(md->disk, size);
> 
> -	if (mmc_host_cmd23(card->host) &&
> -	    mmc_card_mmc(card))
> -		md->flags |= MMC_BLK_CMD23;
> +	if (mmc_host_cmd23(card->host)) {
> +		if (mmc_card_mmc(card) ||
> +		    (mmc_card_sd(card) &&
> +		     card->scr.cmds & SCR_CMDS_CMD23))
> +			md->flags |= MMC_BLK_CMD23;
> +	}
> 
>  	if (mmc_card_mmc(card) &&
>  	    md->flags & MMC_BLK_CMD23 &&
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6dac89f..16a1f10 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -195,6 +195,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>  	else
>  		card->erased_byte = 0x0;
> 
> +	scr->cmds = UNSTUFF_BITS(resp, 32, 2);

Since support for CMD20 and CMD23 have been added in Physical Layer Spec v3.01, IMO it is better to set scr->cmds based on the spec version, rather than doing it unconditionally. Something like,

+       if (scr->sda_vsn == SCR_SPEC_VER_2) {
+               /* Check if Physical Layer Spec v3.0 is supported*/
+               scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
+               if (scr->sda_spec3)
+                       scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+       }

>  	return 0;
>  }
> 
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c758181..b33186a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -70,6 +70,7 @@ struct sd_scr {
>  	unsigned char		bus_widths;
>  #define SD_SCR_BUS_WIDTH_1	(1<<0)
>  #define SD_SCR_BUS_WIDTH_4	(1<<2)
> +	unsigned char		cmds;
>  };

How about...

struct sd_scr {
       unsigned char           sda_vsn;
+       unsigned char           sda_spec3;
       unsigned char           bus_widths;
 #define SD_SCR_BUS_WIDTH_1     (1<<0)
 #define SD_SCR_BUS_WIDTH_4     (1<<2)
+       unsigned char           cmds;
+#define SD_SCR_CMD20_SUPPORT   (1<<0)
+#define SD_SCR_CMD23_SUPPORT   (1<<1)
 };

This way we can let go of...

> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 3fd85e0..81ba37b 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> +#define SCR_CMDS_CMD23		(1 << 1) /* Supports CMD23 */

Thanks,
Arindam
 


