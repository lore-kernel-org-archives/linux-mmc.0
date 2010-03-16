From: Philip Rakity <prakity@marvell.com>
Subject: Re: Patch: eMMC boot partition needs to be deactivated for linux to
 find user partitions
Date: Mon, 15 Mar 2010 18:44:32 -0700
Message-ID: <1EB6A91B-CBF1-4B35-BC60-F0C5E3C74D2D@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:60197 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965901Ab0CPBof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2010 21:44:35 -0400
In-Reply-To: <4B9DEAE2.3030707@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, "pierre@ossman.eu" <pierre@ossman.eu>


Adiran,

snip for mmc_debug below

I will forward to you under full logs.

Philip

Without mod the following error occurs
==============================

mmc1: req done (CMD6): 0: 00000900 00000000 00000000 00000000
mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 3 timing 1
pxa-sdh [platform_set_8_bit()]: EXIT: mmc1 SD_CE_ATA_2 = 1100
mmc1: new high speed MMC card at address 0001
mmc1: starting CMD16 arg 00000200 flags 00000095
pxa-sdh [platform_specific_card_detect()]: EXIT: mmc1 card_detect_ok = 0000
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD16): 0: 00000900 00000000 00000000 00000000
mmcblk0: mmc1:0001 M2G1DD 1.90 GiB
 mmcblk0:<7>mmc1: starting CMD18 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 8 flags 00000200 tsac 150 ms nsac 1000
mmc1:     CMD12 arg 00000000 flags 0000049d
pxa-sdh [platform_specific_card_detect()]: EXIT: mmc1 card_detect_ok = 0000
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     4096 bytes transferred: 0
mmc1:     (CMD12): 0: 00000b00 00000000 00000000 00000000
 unknown partition table


with the patch 
===========

mmc1: req done (CMD6): 0: 00000900 00000000 00000000 00000000
mmc1: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 7 width 3 timing 1
pxa-sdh [platform_set_8_bit()]: EXIT: mmc1 SD_CE_ATA_2 = 1100
mmc1: new high speed MMC card at address 0001
mmc1: starting CMD16 arg 00000200 flags 00000095
pxa-sdh [platform_specific_card_detect()]: EXIT: mmc1 card_detect_ok = 0000
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD16): 0: 00000900 00000000 00000000 00000000
mmcblk0: mmc1:0001 M2G1DD 1.90 GiB
 mmcblk0:<7>mmc1: starting CMD18 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 8 flags 00000200 tsac 150 ms nsac 1000
mmc1:     CMD12 arg 00000000 flags 0000049d
pxa-sdh [platform_specific_card_detect()]: EXIT: mmc1 card_detect_ok = 0000
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
pxa-sdh [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     4096 bytes transferred: 0
mmc1:     (CMD12): 0: 00000b00 00000000 00000000 00000000
 p1 p2 p3 p4




On Mar 15, 2010, at 1:08 AM, Adrian Hunter wrote:

> Philip Rakity wrote:
>> Some eMMC chips have a boot partition that is meant to be used to load in low level boot code.
>> This partition is available when the chip is powered up.  Normally the boot loader would disable
>> access to the partition once boot code was loaded in before passing control to linux.  
>> 
>> if booting occurs from another device (not the eMMC chip) the partition will not be disabled by
>> the boot loader and control will be passed to linux.  This will cause linux to not recognize user
>> partitions on the chip unless access to the boot partition is deactivated.
>> 
>> See JEDEC Standard 84-A44 (eMMC 4.4 spec) -- Page 139
> 
> Page 139 doesn't say anything about why you need that switch command.
> Please provide a more useful reference or delete this.
> 
> Boot mode is terminated by CMD1, so that switch command should not
> be needed.  Please explain why it is needed in more detail.
> 
> That switch command should not be used for devices that do not
> support it e.g. eMMC 4.3 and before.
> 
> 
>> 
>> signed off by:  Philip Rakity <prakity@marvell.com>
>> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/mmc/core/mmc.c
>> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -0800
>> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.000000000 -0800
>> @@ -430,6 +432,13 @@
>> 	}
>> 
>> 	/*
>> +	* ensure eMMC private booting PARTITION is not enabled
>> +	* see JEDEC Standard No. 84-A44 - Page 139 
>> +	*/
>> +	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +		EXT_CSD_BOOT_CONFIG, 0x0);
>> +
>> +	/*
>> 	 * Compute bus speed.
>> 	 */
>> 	max_dtr = (unsigned int)-1;
>> diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include/linux/mmc/mmc.h
>> --- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0800
>> +++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-12 20:53:48.000000000 -0800
>> @@ -251,6 +252,7 @@
>>  * EXT_CSD fields
>>  */
>> 
>> +#define EXT_CSD_BOOT_CONFIG	179 /* R/W */
>> #define EXT_CSD_BUS_WIDTH	183	/* R/W */
>> #define EXT_CSD_HS_TIMING	185	/* R/W */
>> #define EXT_CSD_CARD_TYPE	196	/* RO */
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 

