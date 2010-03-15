From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: Patch: eMMC boot partition needs to be deactivated for linux
 to find user partitions
Date: Mon, 15 Mar 2010 10:08:02 +0200
Message-ID: <4B9DEAE2.3030707@nokia.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45983 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab0COIIW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2010 04:08:22 -0400
In-Reply-To: <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, "pierre@ossman.eu" <pierre@ossman.eu>

Philip Rakity wrote:
> Some eMMC chips have a boot partition that is meant to be used to load in low level boot code.
> This partition is available when the chip is powered up.  Normally the boot loader would disable
> access to the partition once boot code was loaded in before passing control to linux.  
> 
> if booting occurs from another device (not the eMMC chip) the partition will not be disabled by
> the boot loader and control will be passed to linux.  This will cause linux to not recognize user
> partitions on the chip unless access to the boot partition is deactivated.
> 
> See JEDEC Standard 84-A44 (eMMC 4.4 spec) -- Page 139

Page 139 doesn't say anything about why you need that switch command.
Please provide a more useful reference or delete this.

Boot mode is terminated by CMD1, so that switch command should not
be needed.  Please explain why it is needed in more detail.

That switch command should not be used for devices that do not
support it e.g. eMMC 4.3 and before.


> 
> signed off by:  Philip Rakity <prakity@marvell.com>
> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/mmc/core/mmc.c
> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -0800
> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.000000000 -0800
> @@ -430,6 +432,13 @@
>  	}
>  
>  	/*
> +	* ensure eMMC private booting PARTITION is not enabled
> +	* see JEDEC Standard No. 84-A44 - Page 139 
> +	*/
> +	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +		EXT_CSD_BOOT_CONFIG, 0x0);
> +
> +	/*
>  	 * Compute bus speed.
>  	 */
>  	max_dtr = (unsigned int)-1;
> diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include/linux/mmc/mmc.h
> --- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0800
> +++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-12 20:53:48.000000000 -0800
> @@ -251,6 +252,7 @@
>   * EXT_CSD fields
>   */
>  
> +#define EXT_CSD_BOOT_CONFIG	179 /* R/W */
>  #define EXT_CSD_BUS_WIDTH	183	/* R/W */
>  #define EXT_CSD_HS_TIMING	185	/* R/W */
>  #define EXT_CSD_CARD_TYPE	196	/* RO */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

