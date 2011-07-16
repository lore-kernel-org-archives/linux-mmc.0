From: Philip Rakity <prakity@marvell.com>
Subject: Re: mmcblk0: error -123 sending status command
Date: Sat, 16 Jul 2011 10:02:25 -0700
Message-ID: <D7758F13-1211-417B-B42B-5B1FDC013061@marvell.com>
References: <e055bdce527a22d1a6543aa2f62475e6@mb8-2.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:50558 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398Ab1GPRCb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Jul 2011 13:02:31 -0400
In-Reply-To: <e055bdce527a22d1a6543aa2f62475e6@mb8-2.1blu.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lukas Razik <linux@razik.name>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Lukas,

Can you try 3.0 rc7 ?   The error looks like it could be the card does not support
4 bit operation. (assuming it is a mmc 1GB card).

Some things to check.

Now many pins are on the SD/MMC card.  Are their 9 pins ?  

Who makes the card?  Is there any vendor information. (Transcend ?)

regards,

Philip

On Jul 16, 2011, at 6:01 AM, Lukas Razik wrote:

> Hello!
> 
> I have a x86 gentoo system with vanilla 2.6.39.3 kernel and a
> Texas Instruments PCI7420/7620 Combo CardBus, 1394a-2000 OHCI and
> SD/MS-Pro Controller
> (that's what lscpi -v says).
> 
> When I insert an SD-card in my reader then I get this in syslog:
> ---
> tifm_core: MMC/SD card detected in socket 0:0
> mmc0: new SD card at address 1234
> mmcblk0: mmc0:1234 SD01G 972 MiB
> mmcblk0: p1
> ---
> 
> I can mount the card but if I try to read some files from it I get these
> errors in syslog:
> ---
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: retrying using single block
> read
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending status
> command
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending read/write
> command, response 0x0, card status 0x0
> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev mmcblk0,
> sector 1206304
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending status
> command
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending read/write
> command, response 0x0, card status 0x0
> [...]
> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev mmcblk0,
> sector 975808
> Jul 15 12:40:54 consystor6 klogd: Buffer I/O error on device mmcblk0p1,
> logical block 975559
> Jul 15 12:40:54 consystor6 klogd: lost page write due to I/O error on
> mmcblk0p1
> Jul 15 12:40:54 consystor6 klogd: tifm_core: MMC/SD card detected in
> socket 0:0
> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block 1205959)
> failed
> [...]
> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block 1205988)
> failed
> Jul 15 12:40:54 consystor6 hald: unmounted /dev/mmcblk0p1 from
> '/media/disk' on behalf of uid 0
> Jul 15 12:40:54 consystor6 klogd: mmc0: new SD card at address 1234
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: mmc0:1234 SD01G 972 MiB
> Jul 15 12:40:54 consystor6 klogd: mmcblk0: p1
> ---
> 
> After that the card is unmounted as you can see in the log - so I can't
> read any files.
> Same with
> - genkernel-x86-2.6.37-gentoo-r4 (with gentoo's default config)
> - genkernel-x86-2.6.38-gentoo-r1 (and my own config)
> 
> The SD-card works in the same system under windows without any problems.
> Can anyone help me?
> 
> Best regards,
> Lukas
> 
> 
> PS:
> The MMC part of my kernel config:
> ---
> grep MMC 2.6.39.3-2011-07-15-01
> CONFIG_MMC=m
> # CONFIG_MMC_DEBUG is not set
> # CONFIG_MMC_UNSAFE_RESUME is not set
> # CONFIG_MMC_CLKGATE is not set
> # MMC/SD/SDIO Card Drivers
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_MMC_BLOCK_BOUNCE=y
> # CONFIG_MMC_TEST is not set
> # MMC/SD/SDIO Host Controller Drivers
> CONFIG_MMC_SDHCI=m
> # CONFIG_MMC_SDHCI_PCI is not set
> # CONFIG_MMC_SDHCI_PLTFM is not set
> CONFIG_MMC_WBSD=m
> CONFIG_MMC_TIFM_SD=m
> # CONFIG_MMC_SDRICOH_CS is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_USHC is not set
> ---
> 
> Complete lspci -v for the controller:
> ---
> 3:04.3 Mass storage controller: Texas Instruments PCI7420/7620 Combo
> CardBus, 1394a-2000 OHCI and SD/MS-Pro Controller
>        Subsystem: Wistron Corp. Device 3006
>        Flags: bus master, medium devsel, latency 57, IRQ 22
>        Memory at d2014000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: [44] Power Management version 2
>        Kernel driver in use: tifm_7xx1
>        Kernel modules: tifm_7xx1
> ----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

