From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3
 sd controller
Date: Mon, 8 Nov 2010 01:15:06 -0800
Message-ID: <BEEAC96D-9F8F-4B19-9778-FDEBAB8E6E44@marvell.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
 <20101107220411.GB5376@pengutronix.de>
 <BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
 <AANLkTik8fQrBwx2fzbOP3PMcZafkPv0rkZ-3kvLu9-P0@mail.gmail.com>
 <66B2D668-F5FD-4D91-8B97-921638E23276@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45088 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753965Ab0KHJ1P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Nov 2010 04:27:15 -0500
In-Reply-To: <66B2D668-F5FD-4D91-8B97-921638E23276@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Snippet for code to handle 8 bit  --- from current system not mmc-next for handling quirk on a per slot basis

platform specific configuration file in arch/arm/mach-mmp
============================================


struct pxasdh_platform_data {
	unsigned int ocr_mask;			/* available voltages */
	unsigned long detect_delay;		/* delay in jiffies before detecting cards after interrupt */
	int (*init)(struct device *, irq_handler_t , void *);
	int (*get_ro)(struct device *);
	void (*setpower)(struct device *, unsigned int);
	void (*exit)(struct device *, void *);
	int (*mfp_config)(void);
	int (*get_cd)(struct device *);
	unsigned int max_speed;
	unsigned int quirks;
};


static struct pxasdh_platform_data mmp2brownstone_sdh_platform_data_mmc2 = {
	.detect_delay	= 20,
	.mfp_config	= sdh2_mfp_config,
	.pfn_table	= mmc2_pfn_cfg,
	.quirks 	= QUIRK_SDH_PLATFORM_CARD_PRESENT | SDHCI_QUIRK_SLOT_CAN_DO_8_BITS,
};

static mfp_cfg_t mmp2brownstone_sdh3_pins[] = {
	GPIO165_MMC3_DAT7_PULL_HIGH,
	GPIO162_MMC3_DAT6_PULL_HIGH,
	GPIO166_MMC3_DAT5_PULL_HIGH,
	GPIO163_MMC3_DAT4_PULL_HIGH,
	GPIO167_MMC3_DAT3_PULL_HIGH,
	GPIO164_MMC3_DAT2_PULL_HIGH,
	GPIO168_MMC3_DAT1_PULL_HIGH,
	GPIO111_MMC3_DAT0_PULL_HIGH,
	GPIO112_MMC3_CMD_PULL_HIGH,
	GPIO151_MMC3_CLK,
};

in my platform specific sdio driver
==========================

	struct platform_device	*pdev;
	struct resource	*res;
	struct sdhci_mmc_fixes 	*fixes;
	unsigned int	quirks;
	int	num_slots;	/* Slots on controller */
	struct sdhci_mmc_slot	*slots[MAX_SLOTS];
	struct pxasdh_platform_data *pdata;
};


static int pxa_sdh_probe(struct platform_device *pdev)
{

<snip>
 		chip->quirks |= slot->chip->pdata->quirks;

etc

}


On Nov 8, 2010, at 12:31 AM, Philip Rakity wrote:

> 
> I have the same issue -- in my case 2 slots can support 8 bits and one cannot.
> 
> I set the QURK in the platform data and the platform specific driver sets the quirk on the specific slot that has 8 bit support.
> 
> Philip
> 
> 
> On Nov 8, 2010, at 12:24 AM, Kyungmin Park wrote:
> 
>> On Mon, Nov 8, 2010 at 4:21 PM, Philip Rakity <prakity@marvell.com> wrote:
>>> 
>>> On Nov 7, 2010, at 2:04 PM, Wolfram Sang wrote:
>>> 
>>>> On Fri, Oct 08, 2010 at 12:31:34PM -0700, Philip Rakity wrote:
>>>>> 
>>>>> 8 bit width is a new feature in the sd 3.0 spec.  Add checks to
>>>>> ensure HOST_CONTROL register set 8 bit mode only if sd 3.0
>>>>> 
>>>>> add quirk to indicate that board design supports 8 data lines.
>>>>> The controller can support 8 data bits but the board design may
>>>>> only bring out 4 data bits.
>>>> 
>>>> This isn't a quirk, this is platform_data, no?
>>> 
>>> Never sure of the difference between a quirk and platform data.
>>> example:  Broken card detect is a quirk but maybe some slots on the board work and some do not
>> 
>> In my case, one slot uses the 8-bit but another is 4-bit so host quirk
>> is not acceptable.
>> I prefer the platform data also.
>> 
>> Thank you,
>> Kyungmin Park
>> 
>>> 
>>>> 
>>>> Without looking deeply into it, I think we need to use the callback you
>>>> introduced in the other patch?
>>>> 
>>> 
>>> It is needed in my experience because of how board design is done.  The controller can support 8 bits
>>> but the board may not have DAT4-DAT7 connected.
>>> 
>>>> Regards,
>>>> 
>>>>  Wolfram
>>>> 
>>>> PS: Sorry if there already was a discussion I might have missed. The bus width
>>>> thingie became a bit scattered, so I lost track...
>>>> 
>>>> --
>>>> Pengutronix e.K.                           | Wolfram Sang                |
>>>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
> 

