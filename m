From: Philip Rakity <prakity@marvell.com>
Subject: Re: A MMC card transfer issue
Date: Tue, 30 Nov 2010 19:15:38 -0800
Message-ID: <80435536-39CC-4513-B738-99C60CA8DAA4@marvell.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
 <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com>
 <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com>
 <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com>
 <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:32816 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754168Ab0LADQO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Nov 2010 22:16:14 -0500
In-Reply-To: <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "\"\\\"\\\\\\\"Andrew\\\\\\\\\\\\\\\"\\\\\\\"
	<andrew.chih.howe.khor@intel.com>\\\"
	<andrew.chih.howe.khor@intel.com>\" <andrew.chih.howe.khor@intel.com>" <andrew.chih.howe.khor@intel.com>, "kok.howg.ewe@intel.com" <kok.howg.ewe@intel.com>


resend as plain text

On Nov 30, 2010, at 5:31 PM, Philip Rakity wrote:

> 
> take the 8 bit patch that chris put on the mailing list.  It may fix this.
> 
> Hi Philip,
> 
> On Sun, Nov 21, 2010 at 11:17:09AM -0800, Philip Rakity wrote:
>> a) QUIRK removed for 8 bit support since platform issue - not quirk
>> b) platform Flag defined for sdhci-pxa.c and plat-pxa
>> c) comments added to sdhci.c on usage
> 
> Thanks very much, I'll plan on sending this to Linus tomorrow, along
> with the rest of my .37 queue, unless there are any more review
> comments from anyone.
> 
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=15ec44611904be0dcc97b84c29fbf964e5e2b36f
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 
> On Nov 30, 2010, at 5:08 PM, Tomoya MORINAGA wrote:
> 
>> Hi Park,
>> 
>> How's the issue going ?
>> 
>> With best regards.
>> ---
>> Tomoya MORINAGA
>> OKI SEMICONDUCTOR CO., LTD.
>> ----- Original Message ----- 
>> From: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
>> To: "Kyungmin Park" <kmpark@infradead.org>
>> Cc: <kok.howg.ewe@intel.com>; "Andrew"" <andrew.chih.howe.khor@intel.com>; <linux-kernel@vger.kernel.org>;
>> <linux-mmc@vger.kernel.org>
>> Sent: Thursday, November 11, 2010 11:59 AM
>> Subject: Re: A MMC card transfer issue
>> 
>> 
>>> Hi Park,
>>> 
>>> Though I  tried to patch yours to "sdhci.c" of linux-2.6.36,
>>> but it seems your patch has already patched in linux-2.6.36.
>>> 
>>> Using this linux, MMC card is not recognized.
>>> Inserting the MMC card, I saw the following erro message.
>>> 
>>> [   11.035441] sdhci: Secure Digital Host Controller Interface driver
>>> [   11.035450] sdhci: Copyright(c) Pierre Ossman
>>> [   11.058295] sdhci-pci 0000:02:04.0: SDHCI controller found [8086:8809] (rev 1)
>>> [   11.058342]   alloc irq_desc for 18 on node -1
>>> [   11.058350]   alloc kstat_irqs on node -1
>>> [   11.058373] sdhci-pci 0000:02:04.0: PCI INT C -> GSI 18 (level, low) -> IRQ 18
>>> [   11.058385] sdhci-pci 0000:02:04.0: Invalid iomem size. You may experience problems.
>>> [   11.058487] sdhci-pci 0000:02:04.0: setting latency timer to 64
>>> [   11.058623] Registered led device: mmc0::
>>> [   11.058736] mmc0: SDHCI controller on PCI [0000:02:04.0] using DMA
>>> [   11.058774] sdhci-pci 0000:02:04.1: SDHCI controller found [8086:880a] (rev 1)
>>> [   11.058816] sdhci-pci 0000:02:04.1: PCI INT C -> GSI 18 (level, low) -> IRQ 18
>>> [   11.058828] sdhci-pci 0000:02:04.1: Invalid iomem size. You may experience problems.
>>> [   11.058904] sdhci-pci 0000:02:04.1: setting latency timer to 64
>>> [   11.059047] Registered led device: mmc1::
>>> [   11.059153] mmc1: SDHCI controller on PCI [0000:02:04.1] using DMA
>>> [   11.547645] mmc1: new high speed SD card at address 0ec7
>>> [   11.629400] mmcblk0: mmc1:0ec7 SV02G 1.87 GiB (ro)
>>> [   11.630314]  mmcblk0: p1
>>> [   12.076459] gzip used greatest stack depth: 6008 bytes left
>>> [   12.321795] ip used greatest stack depth: 5724 bytes left
>>> [   13.786510] EXT3-fs (dm-0): using internal journal
>>> [   13.887463] EXT3-fs: barriers not enabled
>>> [   13.887872] kjournald starting.  Commit interval 5 seconds
>>> [   13.888154] EXT3-fs (sda1): using internal journal
>>> [   13.888178] EXT3-fs (sda1): mounted filesystem with writeback data mode
>>> [   23.183874] Adding 2064380k swap on /dev/mapper/VolGroup00-LogVol01.  Priority:-1 extents:1 across:2064380k
>>> [   39.171225] gconfd-2 used greatest stack depth: 5692 bytes left
>>> [   86.545435] metacity[2318]: segfault at 0 ip 080aa093 sp bfd899a0 error 4 in metacity[8048000+82000]
>>> [  115.124784] hda-intel: Invalid position buffer, using LPIB read method instead.
>>> [  115.124821] hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
>>> [  346.630117] mmc1: card 0ec7 removed
>>> [  408.266730] mmc1: new MMC card at address 0001
>>> [  408.268142] mmcblk0: mmc1:0001 MMC    1.87 GiB
>>> [  408.275970] mmcblk0: retrying using single block read
>>> [  408.278451] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
>>> [  408.278464] end_request: I/O error, dev mmcblk0, sector 0
>>> [  408.280966] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
>>> [  408.280978] end_request: I/O error, dev mmcblk0, sector 1
>>> 
>>> 
>>> I have suspected mmc.c is buggy.
>>> I tried to disable like the following in "mmc_init_card".
>>> As a result, the MMC card to be recognized correctly.
>>> What's do you think ?
>>> 
>>> */
>>> static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>> struct mmc_card *oldcard)
>>> {
>>> ......
>>> 
>>> /*
>>>  * Activate wide bus (if supported).
>>>  */
>>> #if 0 //101111
>>> if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
>>>     (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>>>  unsigned ext_csd_bit, bus_width;
>>> 
>>>  if (host->caps & MMC_CAP_8_BIT_DATA) {
>>>   ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
>>>   bus_width = MMC_BUS_WIDTH_8;
>>>  } else {
>>>   ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
>>>   bus_width = MMC_BUS_WIDTH_4;
>>>  }
>>> 
>>>  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>     EXT_CSD_BUS_WIDTH, ext_csd_bit);
>>> 
>>>  if (err && err != -EBADMSG)
>>>   goto free_card;
>>> 
>>>  if (err) {
>>>   printk(KERN_WARNING "%s: switch to bus width %d "
>>>          "failed\n", mmc_hostname(card->host),
>>>          1 << bus_width);
>>>   err = 0;
>>>  } else {
>>>   mmc_set_bus_width(card->host, bus_width);
>>>  }
>>> }
>>> #endif //101111
>>> 
>>> 
>>> 
>>> 
>>> ------
>>> Thanks,
>>> 
>>> Tomoya MORINAGA
>>> OKI SEMICONDUCTOR CO., LTD.
>>> 
>>> 
>>> ----- Original Message ----- 
>>> From: "Kyungmin Park" <kmpark@infradead.org>
>>> To: "Tomoya MORINAGA" <tomoya-linux@dsn.okisemi.com>
>>> Cc: <linux-mmc@vger.kernel.org>; <linux-kernel@vger.kernel.org>; "Andrew"" <andrew.chih.howe.khor@intel.com>;
>>> <kok.howg.ewe@intel.com>
>>> Sent: Tuesday, November 09, 2010 2:53 PM
>>> Subject: Re: A MMC card transfer issue
>>> 
>>> 
>>>> 2010/11/9 Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>:
>>>>> I am facing the issue about some MMC cards on Intel EG20T PCH (Platform Controller Hub).
>>>>> The linux version is 2.6.36.
>>>>> I can not transfer data the MMC cards (e.g. Transcned MMC card).
>>>>> The card is 1 bit bus width. And the card is according to MMC specification V3.x.
>>>>> And the EG20T has a 4 bit bus width capability
>>>>> Linux MMC standard driver decides the card bus width as 4 bit,
>>>>> if the MMC specification version is larger than or equal to V4.0 like below.
>>>>> 
>>>>> linux/drivers/mmc/core/mmc.c
>>>>> 
>>>>> 505 /*
>>>>> 506 * Activate wide bus (if supported).
>>>>> 507 */
>>>>> 508 if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
>>>>> 509 (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>>>>> 510 unsigned ext_csd_bit, bus_width;
>>>>> 511
>>>>> 512 if (host->caps & MMC_CAP_8_BIT_DATA) {
>>>>> 513 ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
>>>>> 514 bus_width = MMC_BUS_WIDTH_8;
>>>>> 515 } else {
>>>>> 516 ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
>>>>> 517 bus_width = MMC_BUS_WIDTH_4;
>>>>> 518 }
>>>>> 519
>>>>> 520 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>> 521 EXT_CSD_BUS_WIDTH, ext_csd_bit);
>>>>> 522
>>>>> 523 if (err && err != -EBADMSG)
>>>>> 524 goto free_card;
>>>>> 525
>>>>> 526 if (err) {
>>>>> 527 printk(KERN_WARNING "%s: switch to bus width %d "
>>>>> 528 "failed\n", mmc_hostname(card->host),
>>>>> 529 1 << bus_width);
>>>>> 530 err = 0;
>>>>> 531 } else {
>>>>> 532 mmc_set_bus_width(card->host, bus_width);
>>>>> 533 }
>>>>> 534 }
>>>>> 535
>>>>> 
>>>>> However the MMC specification version id is the same as V3.x and V4.0.
>>>>> Therefore the driver uses the 4 bit bus width for the MMC card
>>>>> even if the card has only 1 bit bus width.
>>>>> I modified the driver to use 1 bit bus width only tentatively and confirmed that
>>>>> we can mount the card and R/W correctly.
>>>>> 
>>>>> I think we can not support MMC_CAP_4_BIT_DATA or MMC_CAP_8_BIT_DATA in MMC V4.0.
>>>>> 
>>>>> How do you think ?
>>>> 
>>>> You can find a patch for 4-bit support. the problem is there's some
>>>> bug related so it set the 4 & 8 bit support both.
>>>> So line 512 is always true. you can just remove the one line like this.
>>>> 
>>>> It's quirk-and-dirty patch. now we try to find a generic solution to
>>>> solve this issue.
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1849,7 +1849,7 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>        mmc->caps |= MMC_CAP_SDIO_IRQ;
>>>> 
>>>>        if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>>>> -               mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>>>> +               mmc->caps |= MMC_CAP_4_BIT_DATA;
>>>> 
>>>>        if (caps & SDHCI_CAN_DO_HISPD)
>>>>                mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>>>> 
>>>> Thank you,
>>>> Kyungmin Park
>>>>> 
>>>>> --
>>>>> Thanks,
>>>>> Tomoya MORINAGA(OKI SEMICONDUCTOR CO., LTD.)
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>> 
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

