From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: Patch: eMMC boot partition needs to be deactivated for linux
 to find user partitions
Date: Mon, 22 Mar 2010 10:25:21 +0200
Message-ID: <4BA72971.1070804@nokia.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com> <4B9DEAE2.3030707@nokia.com> <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34570 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab0CVI0e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2010 04:26:34 -0400
In-Reply-To: <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, Andrew Morton <akpm@linux-foundation.org>

Philip Rakity wrote:
> Adrian,
> 
> Thank you for the feedback.  I have amended the patch.  I tested the patch against mmc4.3 or earlier cards and it works.
> Your comment about the switch boot config not being supported by earlier cards is handled by NOT checking for any errors. 

I am not sure I see the value in doing a switch command
when it is not needed or expected.

In addition, messing with the reserved bits and bits that do
not need to be changed seems like a bad idea.

I would go for something more complicated:

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0eac6c8..cb8b2d0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -247,6 +247,9 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		if (sa_shift > 0 && sa_shift <= 0x17)
 			card->ext_csd.sa_timeout =
 					1 << ext_csd[EXT_CSD_S_A_TIMEOUT];
+
+		card->ext_csd.partition_access = ext_csd[EXT_CSD_BOOT_CONFIG] &
+						 MMC_BOOT_PART_ACC_MASK;
 	}
 
 out:
@@ -430,6 +433,18 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Ensure eMMC private booting PARTITION is not enabled.
+	 */
+	if (card->ext_csd.partition_access != 0) {
+		err = mmc_do_switch(card, MMC_SWITCH_MODE_CLEAR_BITS, 0,
+				    EXT_CSD_BOOT_CONFIG,
+				    MMC_BOOT_PART_ACC_MASK);
+		if (err)
+			goto free_card;
+		card->ext_csd.partition_access = 0;
+	}
+
+	/*
 	 * Compute bus speed.
 	 */
 	max_dtr = (unsigned int)-1;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d2cb5c6..86800b3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -386,7 +386,7 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 	return err;
 }
 
-int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
+int mmc_do_switch(struct mmc_card *card, u8 access, u8 set, u8 index, u8 value)
 {
 	int err;
 	struct mmc_command cmd;
@@ -398,7 +398,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 	memset(&cmd, 0, sizeof(struct mmc_command));
 
 	cmd.opcode = MMC_SWITCH;
-	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+	cmd.arg = (access << 24) |
 		  (index << 16) |
 		  (value << 8) |
 		  set;
@@ -433,6 +433,12 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
 	return 0;
 }
 
+int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value)
+{
+	return mmc_do_switch(card, MMC_SWITCH_MODE_WRITE_BYTE, set, index,
+			     value);
+}
+
 int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 653eb8e..df07950 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,6 +20,7 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
+int mmc_do_switch(struct mmc_card *card, u8 access, u8 set, u8 index, u8 value);
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d02d2c6..8ac4351 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -41,6 +41,7 @@ struct mmc_csd {
 
 struct mmc_ext_csd {
 	u8			rev;
+	unsigned int		partition_access:3;
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index c02c8db..14a161c 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -251,6 +251,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_BOOT_CONFIG	179	/* R/W */
 #define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */
@@ -273,6 +274,8 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
 #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
 
+#define MMC_BOOT_PART_ACC_MASK	0x3
+
 /*
  * MMC_SWITCH access modes
  */
> 
> The reason the patch is needed is because when our  boot loader gets loaded from the private boot area, it sets the partition to the private boot area and then hands control to a secondary loader.  Normally our boot loader would disable access to the partition once boot code was loaded in before passing control to linux but if the process is stopped or the kernel is loaded from another device the partition number is not reset.  
> 
> We can fix this but it seems good practice for linux to reset the flash to a normal state.
> 
> The other concerns I believe were addressed earlier.  The trace showing what was happening with and without the patch.
> 
> regards,
> Philip
> 
> signed-off-by: Philip Rakity <prakity@marvell.com>
> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/mmc/core/mmc.c
> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -0800
> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.000000000 -0800
> @@ -430,6 +432,13 @@
>  	}
>  
>  	/*
> +	* ensure eMMC private booting PARTITION is not enabled
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
> 
> 
> On Mar 15, 2010, at 1:08 AM, Adrian Hunter wrote:
> 
>> Philip Rakity wrote:
>>> Some eMMC chips have a boot partition that is meant to be used to load in low level boot code.
>>> This partition is available when the chip is powered up.  Normally the boot loader would disable
>>> access to the partition once boot code was loaded in before passing control to linux.  
>>>
>>> if booting occurs from another device (not the eMMC chip) the partition will not be disabled by
>>> the boot loader and control will be passed to linux.  This will cause linux to not recognize user
>>> partitions on the chip unless access to the boot partition is deactivated.
>>>
>>> See JEDEC Standard 84-A44 (eMMC 4.4 spec) -- Page 139
>> Page 139 doesn't say anything about why you need that switch command.
>> Please provide a more useful reference or delete this.
>>
>> Boot mode is terminated by CMD1, so that switch command should not
>> be needed.  Please explain why it is needed in more detail.
>>
>> That switch command should not be used for devices that do not
>> support it e.g. eMMC 4.3 and before.
>>
>>
>>> signed off by:  Philip Rakity <prakity@marvell.com>
>>> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/mmc/core/mmc.c
>>> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -0800
>>> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-12 20:56:16.000000000 -0800
>>> @@ -430,6 +432,13 @@
>>> 	}
>>>
>>> 	/*
>>> +	* ensure eMMC private booting PARTITION is not enabled
>>> +	* see JEDEC Standard No. 84-A44 - Page 139 
>>> +	*/
>>> +	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +		EXT_CSD_BOOT_CONFIG, 0x0);
>>> +
>>> +	/*
>>> 	 * Compute bus speed.
>>> 	 */
>>> 	max_dtr = (unsigned int)-1;
>>> diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include/linux/mmc/mmc.h
>>> --- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0800
>>> +++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-12 20:53:48.000000000 -0800
>>> @@ -251,6 +252,7 @@
>>>  * EXT_CSD fields
>>>  */
>>>
>>> +#define EXT_CSD_BOOT_CONFIG	179 /* R/W */
>>> #define EXT_CSD_BUS_WIDTH	183	/* R/W */
>>> #define EXT_CSD_HS_TIMING	185	/* R/W */
>>> #define EXT_CSD_CARD_TYPE	196	/* RO */
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>

