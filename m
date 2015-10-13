From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix initialization order of mmc block devices
Date: Tue, 13 Oct 2015 08:24:08 -0500
Message-ID: <CAGo_u6oDMH+Aj41fCsqEuTK1TXocUe=zU9No4=_QmZWg3FXb0w@mail.gmail.com>
References: <1444714193-24816-1-git-send-email-hs@denx.de>
	<561CA8D3.2090507@ti.com>
	<561CB653.5020707@denx.de>
	<561CBAE3.3020707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561CBAE3.3020707@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lokesh Vutla <a0131933@ti.com>
Cc: hs@denx.de, lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@bosch.com>, Georg.Soffel@bosch-si.com, linux-omap <linux-omap@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 13, 2015 at 3:03 AM, Lokesh Vutla <a0131933@ti.com> wrote:
>
>
> On Tuesday 13 October 2015 01:14 PM, Heiko Schocher wrote:
>> Hello Lokesh,
>>
>> Am 13.10.2015 um 08:46 schrieb Lokesh Vutla:
>>> +Nishanth,
>>>
>>> On Tuesday 13 October 2015 10:59 AM, Heiko Schocher wrote:
>>>> On embedded devices, often there is a combination of
>>>> removable mmc devices (e.g. MMC/SD cards) and hard
>>>> wired ones (e.g. eMMC). Depending on the hardware
>>>> configuration, the 'mmcblkN' node might change if
>>>> the removable device is available or not at boot time.
>>>>
>>>> E.g. if the removable device is attached at boot time,
>>>> it might become mmxblk0. And the hard wired one mmcblk1.
>>>> But if the removable device isn't there at boot time,
>>>> the hard wired one will become mmcblk0. This makes it
>>>> somehow difficult to hard code the root device to the
>>>> non-removable device and boot fast.
>>>
>>> Why not use "root=PARTUUID=${uuid}" option instead of relying on
>>> mmcblk no?
>>> U-Boot can easily detect your partuuid. Refer to [1] on how TI platforms
>>> does this in u-boot.
>>
>> Good tip ... I do not know, if it is possible to update U-Boot
>> on this boards...
>>
>> Current U-Boot says:
>> U-Boot 2013.01.01_heads/master-gc7900a0 (2015-05-06 - 20:37:15)
>>
>> I2C:   ready
>> DRAM:  512 MiB
>> [...]
>> U-Boot# mmc rescan
>> U-Boot# mmc part
>>
>> Partition Map for MMC device 0  --   Partition Type: DOS
>>
>> Part    Start Sector    Num Sectors     UUID            Type
>>   1     63              144522          000ce343-01     0e Boot
>>   2     144585          659861          000ce343-02     83
>> U-Boot# part uuid mmc 0:2 uuid
>> Unknown command 'part' - try 'help'
>> U-Boot#
>>
>> So, if this patch has no chance for mainline, please let me
>> know it, thanks!
>>
>
> IIRC, Nishanth had posted a patch something similar but got rejected for
> some reason. Probably Nishanth can comment more here.
>

overall the feedback I received was for block devices, there is
already an unique method(PARTUUID/uuid) of referencing required device
and mmcxblky aliasing was not really needed - hence dropped my patch
and switched over to partuuid.

CC Tom and u-boot list as well.
for reference the current thread: http://marc.info/?t=144471421700002&r=1&w=2
-- 
---
Regards,
Nishanth Menon
