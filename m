From: Lukas Razik <linux@razik.name>
Subject: Re: mmcblk0: error -123 sending status command
Date: Tue, 19 Jul 2011 16:09:09 +0200
Message-ID: <1b33157df53af18083d867d48a1dd425@mb8-2.1blu.de>
References: <4c687016ece95eb55f80760621ad76c6@mb8-2.1blu.de> <016AA905-D0B7-45E6-A6CB-7FFF4DB1AA71@marvell.com> <4df569825519756d15842bc5916a1ed4@mb8-2.1blu.de> <2C3EBED2-0A46-4B69-8578-E723896DFA17@marvell.com> <0fa828ea4f194f57a7febdae5e74f1b7@mb8-2.1blu.de> <637B8DF0-0CDD-46BF-98B1-B6FE11F3830D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ms16-1.1blu.de ([89.202.0.34]:47699 "EHLO ms16-1.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab1GSOJP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jul 2011 10:09:15 -0400
In-Reply-To: <637B8DF0-0CDD-46BF-98B1-B6FE11F3830D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org

I'll try that but I don't think that's a problem of the sd card.
I get same errors with a SanDisk 4GB SD card.

So I sumarized all we wrote in a bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=39572

Best regards,
Lukas


On Mon, 18 Jul 2011 13:53:26 -0700, Philip Rakity <prakity@marvell.com>
wrote:
> Could you please put the SD disk into windows and ask it to check and
> repair the file system.
> 
> very curious if that "fixes" the problem.  Another data point.
> 
> Philip
> 
> On Jul 18, 2011, at 1:54 AM, Lukas Razik wrote:
> 
>> Hi!
>>
>> You write that you would post the snippet of the trace with your notes.
>> OK, I understand but where would you post them?
>> Do you mean kernel.bugzilla.org or linux-mmc@vger.kernel.org ?
>> Because you don't write to the linux-mmc at this moment...
>>
>> Many thanks again!
>>
>> Regards,
>> Lukas
>>
>>
>> On Sun, 17 Jul 2011 21:50:54 -0700, Philip Rakity <prakity@marvell.com>
>> wrote:
>>> I have never seen this before.   I would post the snippet of the trace
>>> below to the list
>>> with the following notes
>>>
>>> 24Mbs - 4 bit data works for quite
>>>
>>> Then 243 block request and boom.
>>>
>>> questions
>>>
>>> a) is this normal for fat16 ?
>>> b) could someone look at the sd driver.
>>>
>>> The driver may have to split the 243 block request into multiple
>> requests
>>> if this is normal.
>>> The driver is not one I am familiar with.
>>>
>>> Philip
>>>
>>>
>>> On Jul 17, 2011, at 5:07 PM, Lukas Razik wrote:
>>>
>>>> Hi!
>>>>
>>>> Why are 243 blocks strange?
>>>> And is there anything I or you could do?
>>>>
>>>> Regards,
>>>> Lukas
>>>>
>>>>
>>>> On Sun, 17 Jul 2011 10:35:53 -0700, Philip Rakity
<prakity@marvell.com>
>>>> wrote:
>>>>> <snip>
>>>>>
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0: starting CMD17 arg 0005fc00
>>>> flags
>>>>> 000000b5
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     blksz 512 blocks 1 flags
>>>>> 00000200 tsac 100 ms nsac 0
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 1
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: executing
opcode
>>>>> 0x11, arg: 0x5fc00, mask: 0xb100
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: host event:
>>>>> host_status 1, flags 0
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: host event:
>>>>> host_status 8, flags 3
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0: req done (CMD17): 0:
00000900
>>>>> 00000000 00000000 00000000
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     512 bytes transferred: 0
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0: starting CMD17 arg 0005fe00
>>>> flags
>>>>> 000000b5
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     blksz 512 blocks 1 flags
>>>>> 00000200 tsac 100 ms nsac 0
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 1
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: executing
opcode
>>>>> 0x11, arg: 0x5fe00, mask: 0xb100
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: host event:
>>>>> host_status 1, flags 0
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: host event:
>>>>> host_status 8, flags 3
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0: req done (CMD17): 0:
00000900
>>>>> 00000000 00000000 00000000
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     512 bytes transferred: 0
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0: starting CMD18 arg 0001f400
>>>> flags
>>>>> 000000b5
>>>>>
>>>>> ******* THIS IS VERY STRANGE --- blocks 243 Never See this ******
>>>>>
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     blksz 512 blocks 243
flags
>>>>> 00000200 tsac 100 ms nsac 0
>>>>>
>>>>> ******* THIS IS VERY STRANGE ******
>>>>>
>>>>>
>>>>> Jul 17 00:08:59 consystor6 klogd: mmc0:     CMD12 arg 00000000 flags
>>>>> 0000049d
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 7
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: executing
opcode
>>>>> 0x12, arg: 0x1f400, mask: 0xb100
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: host event:
>>>>> host_status 1, flags 0
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 32
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 16
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 32
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 16
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 16
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 16
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 16
>>>>> blocks
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: data event:
>>>>> fifo_status 1, flags 1
>>>>> Jul 17 00:08:59 consystor6 klogd: tifm_sd tifm_sd0:0: setting dma
for
>> 64
>>>>> blocks
>>>>> Jul 17 00:09:00 consystor6 klogd: tifm_sd0:0 : card failed to
respond
>>>> for
>>>>> a long period of time (12, 1)
>>>>> Jul 17 00:09:00 consystor6 klogd: tifm0 : demand removing card from
>>>> socket
>>>>> 0:0
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: card 1234 removed
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: req done (CMD18): -123:
>> 00000900
>>>>> 00000000 00000000 00000000
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0:     78410 bytes transferred:
0
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0:     (CMD12): -123: 00000000
>>>>> 00000000 00000000 00000000
>>>>> Jul 17 00:09:00 consystor6 klogd: mmcblk0: retrying using single
block
>>>> read
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: starting CMD17 arg 0001f400
>>>> flags
>>>>> 000000b5
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0:     blksz 512 blocks 1 flags
>>>>> 00000200 tsac 100 ms nsac 0
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: req done (CMD17): -123:
>> 00000000
>>>>> 00000000 00000000 00000000
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0:     0 bytes transferred: 0
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: starting CMD13 arg 12340000
>>>> flags
>>>>> 00000195
>>>>> Jul 17 00:09:00 consystor6 klogd: mmc0: req done (CMD13): -123:
>> 00000000
>>>>> 00000000 00000000 00
>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>
>>>>> On Jul 17, 2011, at 4:03 AM, Lukas Razik wrote:
>>>>>
>>>>>> Hello Philip!
>>>>>>
>>>>>> In the night I had some problems with my eMail-Service so I dont't
>> know
>>>>>> if
>>>>>> you got my email below.
>>>>>> It also was not distributed by linux-mmc although I sent it again
to
>>>> the
>>>>>> right email-address linux-mmc@vger.kernel.org. Maybe it's because
of
>>>> the
>>>>>> attachment...
>>>>>>
>>>>>> If you wrote me an answer then send me the answer again, please,
>>>> because
>>>>>> I
>>>>>> haven't received one.
>>>>>>
>>>>>> Best regards and many thanks,
>>>>>> Lukas
>>>>>>
>>>>>>
>>>>>> -------- Original Message --------
>>>>>> Subject: Re: mmcblk0: error -123 sending status command
>>>>>> Date: Sun, 17 Jul 2011 00:30:16 +0200
>>>>>> From: Lukas Razik <linux@razik.name>
>>>>>> To: Philip Rakity <prakity@marvell.com>
>>>>>>
>>>>>> Hi again!
>>>>>>
>>>>>> I can't boot 3.0.0-rc7 because of an error regarding my root device
>> so
>>>>>> I've enabled CONFIG_MMC_DEBUG of linux-2.6.39.3.
>>>>>>
>>>>>> In the appended syslog you see all messages since system start.
>>>>>> The following tags which occur in the syslog show you when I've
done
>>>> the
>>>>>> belonging action:
>>>>>> *** CARD INSERT ***
>>>>>> *** CARD MOUNT ***
>>>>>> *** CARD REMOVE ***
>>>>>>
>>>>>> I hope that I've done it right. Otherwise tell me what I should do
>>>>>> different.
>>>>>>
>>>>>> Best regards,
>>>>>> Lukas
>>>>>>
>>>>>>
>>>>>> On Sat, 16 Jul 2011 11:06:43 -0700, Philip Rakity
>> <prakity@marvell.com>
>>>>>> wrote:
>>>>>>> Lukas,
>>>>>>>
>>>>>>> OFF LIST.
>>>>>>>
>>>>>>> Not hopeful but one never knows until one tries !!
>>>>>>>
>>>>>>> Not a MMC card.   So the code I was thinking of will not be
invoked.
>>>>>>>
>>>>>>> This assumes that label on the SD card means IT IS a SD card!
>>>>>>>
>>>>>>> Are you able to hack the code ?
>>>>>>>
>>>>>>> comfortable enabling CONFIG_MMC_DEBUG ?
>>>>>>>
>>>>>>> if the card is inserted after boot then
>>>>>>> echo 17 > /proc/sys/kernel/printk
>>>>>>>
>>>>>>> before inserting the card.
>>>>>>>
>>>>>>> Send complete console log.
>>>>>>>
>>>>>>> regards,
>>>>>>>
>>>>>>> Philip
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Jul 16, 2011, at 10:57 AM, Lukas Razik wrote:
>>>>>>>
>>>>>>>> Hello Philip!
>>>>>>>>
>>>>>>>> On Sat, 16 Jul 2011 10:02:25 -0700, Philip Rakity
>>>> <prakity@marvell.com>
>>>>>>>> wrote:
>>>>>>>>> Can you try 3.0 rc7 ?
>>>>>>>>
>>>>>>>> I must see if it works...
>>>>>>>>
>>>>>>>>
>>>>>>>>> The error looks like it could be the card does not
>>>>>>>>> support
>>>>>>>>> 4 bit operation. (assuming it is a mmc 1GB card).
>>>>>>>>>
>>>>>>>>> Some things to check.
>>>>>>>>>
>>>>>>>>> Now many pins are on the SD/MMC card.  Are their 9 pins ?
>>>>>>>>
>>>>>>>> Yes, it has 9 pins (one pin is narrower).
>>>>>>>>
>>>>>>>>
>>>>>>>>> Who makes the card?  Is there any vendor information. (Transcend
>> ?)
>>>>>>>>
>>>>>>>> It's this PLATINUM 1GB SD card:
>>>>>>>>
>>>>>>
>>>>
>>
http://media.shopping.de/images/cache/a6/3c/71/a63c716bce98df0319cbf43ec39db465.jpg
>>>>>>>>
>>>>>>>> Regards and many tanks for your fast answer!
>>>>>>>> Lukas
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Jul 16, 2011, at 6:01 AM, Lukas Razik wrote:
>>>>>>>>>
>>>>>>>>>> Hello!
>>>>>>>>>>
>>>>>>>>>> I have a x86 gentoo system with vanilla 2.6.39.3 kernel and a
>>>>>>>>>> Texas Instruments PCI7420/7620 Combo CardBus, 1394a-2000 OHCI
and
>>>>>>>>>> SD/MS-Pro Controller
>>>>>>>>>> (that's what lscpi -v says).
>>>>>>>>>>
>>>>>>>>>> When I insert an SD-card in my reader then I get this in
syslog:
>>>>>>>>>> ---
>>>>>>>>>> tifm_core: MMC/SD card detected in socket 0:0
>>>>>>>>>> mmc0: new SD card at address 1234
>>>>>>>>>> mmcblk0: mmc0:1234 SD01G 972 MiB
>>>>>>>>>> mmcblk0: p1
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> I can mount the card but if I try to read some files from it I
>> get
>>>>>>>> these
>>>>>>>>>> errors in syslog:
>>>>>>>>>> ---
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: retrying using
single
>>>>>> block
>>>>>>>>>> read
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>>>> status
>>>>>>>>>> command
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>>>>>>>> read/write
>>>>>>>>>> command, response 0x0, card status 0x0
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev
>>>>>> mmcblk0,
>>>>>>>>>> sector 1206304
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>>>> status
>>>>>>>>>> command
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: error -123 sending
>>>>>>>> read/write
>>>>>>>>>> command, response 0x0, card status 0x0
>>>>>>>>>> [...]
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: end_request: I/O error, dev
>>>>>> mmcblk0,
>>>>>>>>>> sector 975808
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: Buffer I/O error on device
>>>>>> mmcblk0p1,
>>>>>>>>>> logical block 975559
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: lost page write due to I/O
>> error
>>>> on
>>>>>>>>>> mmcblk0p1
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: tifm_core: MMC/SD card
detected
>>>> in
>>>>>>>>>> socket 0:0
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block
>>>> 1205959)
>>>>>>>>>> failed
>>>>>>>>>> [...]
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: FAT: Directory bread(block
>>>> 1205988)
>>>>>>>>>> failed
>>>>>>>>>> Jul 15 12:40:54 consystor6 hald: unmounted /dev/mmcblk0p1 from
>>>>>>>>>> '/media/disk' on behalf of uid 0
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmc0: new SD card at address
>> 1234
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: mmc0:1234 SD01G 972
>> MiB
>>>>>>>>>> Jul 15 12:40:54 consystor6 klogd: mmcblk0: p1
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> After that the card is unmounted as you can see in the log - so
I
>>>>>> can't
>>>>>>>>>> read any files.
>>>>>>>>>> Same with
>>>>>>>>>> - genkernel-x86-2.6.37-gentoo-r4 (with gentoo's default config)
>>>>>>>>>> - genkernel-x86-2.6.38-gentoo-r1 (and my own config)
>>>>>>>>>>
>>>>>>>>>> The SD-card works in the same system under windows without any
>>>>>>>> problems.
>>>>>>>>>> Can anyone help me?
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Lukas
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> PS:
>>>>>>>>>> The MMC part of my kernel config:
>>>>>>>>>> ---
>>>>>>>>>> grep MMC 2.6.39.3-2011-07-15-01
>>>>>>>>>> CONFIG_MMC=m
>>>>>>>>>> # CONFIG_MMC_DEBUG is not set
>>>>>>>>>> # CONFIG_MMC_UNSAFE_RESUME is not set
>>>>>>>>>> # CONFIG_MMC_CLKGATE is not set
>>>>>>>>>> # MMC/SD/SDIO Card Drivers
>>>>>>>>>> CONFIG_MMC_BLOCK=m
>>>>>>>>>> CONFIG_MMC_BLOCK_MINORS=8
>>>>>>>>>> CONFIG_MMC_BLOCK_BOUNCE=y
>>>>>>>>>> # CONFIG_MMC_TEST is not set
>>>>>>>>>> # MMC/SD/SDIO Host Controller Drivers
>>>>>>>>>> CONFIG_MMC_SDHCI=m
>>>>>>>>>> # CONFIG_MMC_SDHCI_PCI is not set
>>>>>>>>>> # CONFIG_MMC_SDHCI_PLTFM is not set
>>>>>>>>>> CONFIG_MMC_WBSD=m
>>>>>>>>>> CONFIG_MMC_TIFM_SD=m
>>>>>>>>>> # CONFIG_MMC_SDRICOH_CS is not set
>>>>>>>>>> # CONFIG_MMC_CB710 is not set
>>>>>>>>>> # CONFIG_MMC_VIA_SDMMC is not set
>>>>>>>>>> # CONFIG_MMC_USHC is not set
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Complete lspci -v for the controller:
>>>>>>>>>> ---
>>>>>>>>>> 3:04.3 Mass storage controller: Texas Instruments PCI7420/7620
>>>> Combo
>>>>>>>>>> CardBus, 1394a-2000 OHCI and SD/MS-Pro Controller
>>>>>>>>>>    Subsystem: Wistron Corp. Device 3006
>>>>>>>>>>    Flags: bus master, medium devsel, latency 57, IRQ 22
>>>>>>>>>>    Memory at d2014000 (32-bit, non-prefetchable) [size=4K]
>>>>>>>>>>    Capabilities: [44] Power Management version 2
>>>>>>>>>>    Kernel driver in use: tifm_7xx1
>>>>>>>>>>    Kernel modules: tifm_7xx1
>>>>>>>>>> ----
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-mmc"
>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>> linux-mmc"
>>>>>> in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at 
http://vger.kernel.org/majordomo-info.html
>>>>>> <syslog_consystor6_linux-2.6.39.3-2011-07-16-01.txt>
