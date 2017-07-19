From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
Date: Wed, 19 Jul 2017 15:44:46 +0800
Message-ID: <9168c429-125e-e810-b3b1-1c0500f3b822@rock-chips.com>
References: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
 <f2428951-3cf3-273f-33a3-c0b3147be2be@rock-chips.com>
 <AM4PR0401MB2324236198EFAB4D89190AD890A60@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:57999 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753290AbdGSHoz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 03:44:55 -0400
In-Reply-To: <AM4PR0401MB2324236198EFAB4D89190AD890A60@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Bough,

On 2017/7/19 13:48, Bough Chen wrote:
> 
>> -----Original Message-----
>> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
>> Sent: Wednesday, July 19, 2017 11:42 AM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>
>> Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>;
>> Bough Chen <haibo.chen@nxp.com>; Alex Lemberg
>> <alex.lemberg@sandisk.com>; Mateusz Nowak <mateusz.nowak@intel.com>;
>> Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>> Linus Walleij <linus.walleij@linaro.org>
>> Subject: Re: [PATCH V3 00/11] mmc: Add Command Queue support
>>
>> Hi Adrian,
>>
>> On 2017/6/15 19:06, Adrian Hunter wrote:
>>> Hi
>>>
>>> Here is V3 of the hardware command queue patches without the software
>>> command queue patches.
>>>
>>
>> I can now boot my board with v4.13 finally this morning[1] and apply this
>> patchset and add my private patch for supporting CQE for sdhci-of-arasan.
>> Great to see it works and I don't see any regression until now. I need more test
>> but I would appreciate it if Ulf can pick all these up into linux-next that folks can
>> help to test and not need to manually apply them. And it will be easy for me to
>> submit patch for sdhci-of-arasan to support CQE later.
>>
>> I haven't have time to review all these, but I will do it next week.
>> And I will also try to run more iozone/fio to see how much it gains when
>> enabling CQE, comparing to non-CQE support.
>>
>> But at least currently feels free to add:
>>
>> Tested-by: Shawn Lin <shawn.lin@rock-chip.com>
>>
> Hi Shawn,
> 
> Do you enable Runtime PM for cqhci? On my side, once enable cqhci runtime PM, always get timeout issue, I'm debug this issue these days. If not add runtime PM support for cqhci, everything work fine including DCMD.
> 

Aha, no!

I said "I need more test" which should include runtime PM. As you could
see sdhci-of-arsan still lacks proper runtime PM support, so I will try
to hack it locally and re-test cqe then.

Thanks.


> Haibo Chen
>   
>> Thanks.
>>
>> [1]:
>>
>> [    2.859981] Synopsys Designware Multimedia Card Interface Driver
>> [    2.924875] sdhci-pltfm: SDHCI platform and OF driver helper
>> [    2.994768] mmc0: CQHCI version 5.10
>> [    3.053787] mmc0: SDHCI controller on fe330000.sdhci [fe330000.sdhci]
>> using ADMA
>> [    3.073534] ledtrig-cpu: registered to indicate activity on CPUs
>> [    3.079239] usbcore: registered new interface driver usbhid
>> [    3.080183] usbhid: USB HID core driver
>> [    3.094221] NET: Registered protocol family 17
>> [    3.095069] 9pnet: Installing 9P2000 support
>> [    3.095710] Key type dns_resolver registered
>> [    3.098371] registered taskstats version 1
>> [    3.155130] hctosys: unable to open rtc device (rtc0)
>> [    3.166186] mmc0: Command Queue Engine enabled
>> [    3.168514] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>> [    3.188861] mmcblk0: mmc0:0001 AJNB4R 14.6 GiB
>> [    3.200381] mmcblk0boot0: mmc0:0001 AJNB4R partition 1 4.00 MiB
>> [    3.200702] ALSA device list:
>> [    3.200747]   No soundcards found.
>> [    3.204146] ttyS2 - failed to request DMA
>> [    3.212363] mmcblk0boot1: mmc0:0001 AJNB4R partition 2 4.00 MiB
>> [    3.221031] mmcblk0rpmb: mmc0:0001 AJNB4R partition 3 4.00 MiB
>> [    3.277636]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>> [    3.522777] EXT4-fs (mmcblk0p7): recovery complete
>> [    3.523907] EXT4-fs (mmcblk0p7): mounted filesystem with ordered data
>> mode. Opts: (null)
>> [    3.524699] VFS: Mounted root (ext4 filesystem) on device 179:7.
>>
>>
>>> Is there any chance of this being queued for v4.13?
>>>
>>>
>>> Changes since V2:
>>> 	Dropped patches that have been applied.
>>> 	Re-based
>>> 	Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"
>>>
>>> Changes since V1:
>>>
>>> 	"Share mmc request array between partitions" is dependent
>>> 	on changes in "Introduce queue semantics", so added that
>>> 	and block fixes:
>>>
>>> 	Added "Fix is_waiting_last_req set incorrectly"
>>> 	Added "Fix cmd error reset failure path"
>>> 	Added "Use local var for mqrq_cur"
>>> 	Added "Introduce queue semantics"
>>>
>>> Changes since RFC:
>>>
>>> 	Re-based on next.
>>> 	Added comment about command queue priority.
>>> 	Added some acks and reviews.
>>>
>>>
>>> Adrian Hunter (10):
>>>         mmc: core: Add mmc_retune_hold_now()
>>>         mmc: core: Add members to mmc_request and mmc_data for CQE's
>>>         mmc: host: Add CQE interface
>>>         mmc: core: Turn off CQE before sending commands
>>>         mmc: core: Add support for handling CQE requests
>>>         mmc: mmc: Enable Command Queuing
>>>         mmc: mmc: Enable CQE's
>>>         mmc: block: Prepare CQE data
>>>         mmc: block: Add CQE support
>>>         mmc: sdhci-pci: Add CQHCI support for Intel GLK
>>>
>>> Venkat Gopalakrishnan (1):
>>>         mmc: cqhci: support for command queue enabled host
>>>
>>>    drivers/mmc/core/block.c          |  240 +++++++-
>>>    drivers/mmc/core/block.h          |    7 +
>>>    drivers/mmc/core/bus.c            |    7 +
>>>    drivers/mmc/core/core.c           |  156 ++++-
>>>    drivers/mmc/core/host.c           |    6 +
>>>    drivers/mmc/core/host.h           |    1 +
>>>    drivers/mmc/core/mmc.c            |   30 +-
>>>    drivers/mmc/core/queue.c          |  273 ++++++++-
>>>    drivers/mmc/core/queue.h          |   42 +-
>>>    drivers/mmc/host/Kconfig          |   14 +
>>>    drivers/mmc/host/Makefile         |    1 +
>>>    drivers/mmc/host/cqhci.c          | 1146
>> +++++++++++++++++++++++++++++++++++++
>>>    drivers/mmc/host/cqhci.h          |  240 ++++++++
>>>    drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
>>>    include/linux/mmc/core.h          |   18 +-
>>>    include/linux/mmc/host.h          |   24 +
>>>    include/trace/events/mmc.h        |   36 +-
>>>    17 files changed, 2354 insertions(+), 40 deletions(-)
>>>    create mode 100644 drivers/mmc/host/cqhci.c
>>>    create mode 100644 drivers/mmc/host/cqhci.h
>>>
>>>
>>> Regards
>>> Adrian
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

