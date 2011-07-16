From: Lukas Razik <linux@razik.name>
Subject: Re: mmcblk0: error -123 sending status command
Date: Sat, 16 Jul 2011 21:49:44 +0200
Message-ID: <f91b3d7164908539eb3bcbff410f9076@mb8-2.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ms16-1.1blu.de ([89.202.0.34]:43269 "EHLO ms16-1.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445Ab1GPTtq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Jul 2011 15:49:46 -0400
Received: from [89.202.0.19] (helo=webmail.1blu.de)
	by ms16-1.1blu.de with esmtpa (Exim 4.69)
	(envelope-from <linux@razik.name>)
	id 1QiArw-0004RR-JO
	for linux-mmc@vger.kernel.org; Sat, 16 Jul 2011 21:49:44 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

On Sat, 16 Jul 2011 11:06:43 -0700, Philip Rakity <prakity@marvell.com>
wrote:
> Not hopeful but one never knows until one tries !!
> 
> Not a MMC card.   So the code I was thinking of will not be invoked.
> 
> This assumes that label on the SD card means IT IS a SD card!

I hope it is one! :D


> Are you able to hack the code ?

That depends on what you mean by "hack the code". ;)
If you write me what I have to change in which file then it's no problem.
:)


> comfortable enabling CONFIG_MMC_DEBUG ?
> 
> if the card is inserted after boot then
> echo 17 > /proc/sys/kernel/printk
> 
> before inserting the card.
> 
> Send complete console log.

I guess you mean in linux-3.0.0-rc-7 ?
I'll try to do these steps.

Best regards,
Lukas


> On Jul 16, 2011, at 10:57 AM, Lukas Razik wrote:
> 
>> Hello Philip!
>> 
>> On Sat, 16 Jul 2011 10:02:25 -0700, Philip Rakity <prakity@marvell.com>
>> wrote:
>>> Can you try 3.0 rc7 ? 
>> 
>> I must see if it works...
>> 
>> 
>>> The error looks like it could be the card does not
>>> support
>>> 4 bit operation. (assuming it is a mmc 1GB card).
>>> 
>>> Some things to check.
>>> 
>>> Now many pins are on the SD/MMC card.  Are their 9 pins ?  
>> 
>> Yes, it has 9 pins (one pin is narrower).
>> 
>> 
>>> Who makes the card?  Is there any vendor information. (Transcend ?)
>> 
>> It's this PLATINUM 1GB SD card:
>>
http://media.shopping.de/images/cache/a6/3c/71/a63c716bce98df0319cbf43ec39db465.jpg
>> 
>> Regards and many tanks for your fast answer!
>> Lukas
>> 
>> 
>>> On Jul 16, 2011, at 6:01 AM, Lukas Razik wrote:
>>> 
>>>> Hello!
>>>> 
>>>> I have a x86 gentoo system with vanilla 2.6.39.3 kernel and a
>>>> Texas Instruments PCI7420/7620 Combo CardBus, 1394a-2000 OHCI and
>>>> SD/MS-Pro Controller
>>>> (that's what lscpi -v says).
>>>> 
>>>> When I insert an SD-card in my reader then I get this in syslog:
>>>> ---
>>>> tifm_core: MMC/SD card detected in socket 0:0
>>>> mmc0: new SD card at address 1234
>>>> mmcblk0: mmc0:1234 SD01G 972 MiB
>>>> mmcblk0: p1
>>>> ---
>>>> 
>>>> I can mount the card but if I try to read some files from it I get
>> these
>>>> errors in syslog:
>>>> ---
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: retrying using single
block
>>>> read
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending status
>>>> command
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>> read/write
>>>> command, response 0x0, card status 0x0
>>>> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev
mmcblk0,
>>>> sector 1206304
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending status
>>>> command
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>> read/write
>>>> command, response 0x0, card status 0x0
>>>> [...]
>>>> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev
mmcblk0,
>>>> sector 975808
>>>> Jul 15 12:40:54 consystor6 klogd: Buffer I/O error on device
mmcblk0p1,
>>>> logical block 975559
>>>> Jul 15 12:40:54 consystor6 klogd: lost page write due to I/O error on
>>>> mmcblk0p1
>>>> Jul 15 12:40:54 consystor6 klogd: tifm_core: MMC/SD card detected in
>>>> socket 0:0
>>>> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block 1205959)
>>>> failed
>>>> [...]
>>>> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block 1205988)
>>>> failed
>>>> Jul 15 12:40:54 consystor6 hald: unmounted /dev/mmcblk0p1 from
>>>> '/media/disk' on behalf of uid 0
>>>> Jul 15 12:40:54 consystor6 klogd: mmc0: new SD card at address 1234
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: mmc0:1234 SD01G 972 MiB
>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: p1
>>>> ---
>>>> 
>>>> After that the card is unmounted as you can see in the log - so I
can't
>>>> read any files.
>>>> Same with
>>>> - genkernel-x86-2.6.37-gentoo-r4 (with gentoo's default config)
>>>> - genkernel-x86-2.6.38-gentoo-r1 (and my own config)
>>>> 
>>>> The SD-card works in the same system under windows without any
>> problems.
>>>> Can anyone help me?
>>>> 
>>>> Best regards,
>>>> Lukas
>>>> 
>>>> 
>>>> PS:
>>>> The MMC part of my kernel config:
>>>> ---
>>>> grep MMC 2.6.39.3-2011-07-15-01
>>>> CONFIG_MMC=m
>>>> # CONFIG_MMC_DEBUG is not set
>>>> # CONFIG_MMC_UNSAFE_RESUME is not set
>>>> # CONFIG_MMC_CLKGATE is not set
>>>> # MMC/SD/SDIO Card Drivers
>>>> CONFIG_MMC_BLOCK=m
>>>> CONFIG_MMC_BLOCK_MINORS=8
>>>> CONFIG_MMC_BLOCK_BOUNCE=y
>>>> # CONFIG_MMC_TEST is not set
>>>> # MMC/SD/SDIO Host Controller Drivers
>>>> CONFIG_MMC_SDHCI=m
>>>> # CONFIG_MMC_SDHCI_PCI is not set
>>>> # CONFIG_MMC_SDHCI_PLTFM is not set
>>>> CONFIG_MMC_WBSD=m
>>>> CONFIG_MMC_TIFM_SD=m
>>>> # CONFIG_MMC_SDRICOH_CS is not set
>>>> # CONFIG_MMC_CB710 is not set
>>>> # CONFIG_MMC_VIA_SDMMC is not set
>>>> # CONFIG_MMC_USHC is not set
>>>> ---
>>>> 
>>>> Complete lspci -v for the controller:
>>>> ---
>>>> 3:04.3 Mass storage controller: Texas Instruments PCI7420/7620 Combo
>>>> CardBus, 1394a-2000 OHCI and SD/MS-Pro Controller
>>>>       Subsystem: Wistron Corp. Device 3006
>>>>       Flags: bus master, medium devsel, latency 57, IRQ 22
>>>>       Memory at d2014000 (32-bit, non-prefetchable) [size=4K]
>>>>       Capabilities: [44] Power Management version 2
>>>>       Kernel driver in use: tifm_7xx1
>>>>       Kernel modules: tifm_7xx1
>>>> ----
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
