From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] Patches to allow consistent mmc / mmcblk numbering
Date: Tue, 10 May 2016 13:09:12 +0200
Message-ID: <CAPDyKFqqxoczDH5B5Pmf0RH5uSC06UyKtEYvddO3tAsiqgoXig@mail.gmail.com>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
	<1659435.FBgTBXnguZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38294 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcEJLJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 07:09:14 -0400
Received: by mail-wm0-f49.google.com with SMTP id g17so21009580wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 04:09:13 -0700 (PDT)
In-Reply-To: <1659435.FBgTBXnguZ@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Douglas Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, linux-mmc <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Venu Byravarasu <vbyravarasu@nvidia.com>, =?UTF-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?= <justin.wang@spreadtrum.com>, Ken Sumrall <ksumrall@android.com>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dtor@chromium.org>, Jon Hunter <jonathanh@nvidia.com>, Tao Huang <huangtao@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Luca Porzio (lporzio)" <lporzi>

On 29 April 2016 at 19:39, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 April 2016 16:06:42 Douglas Anderson wrote:
>> This series picks patches from various different places to produce what
>> I consider the best solution to getting consistent mmc and mmcblk
>> ordering.
>>
>> Why consistent ordering and why not just use UUIDs?  IMHO consistent
>> ordering solves a few different problems:
>>
>> 1. For poor, feeble-minded humans like me, have sane numbering for
>>    devices helps a lot.  When grepping through dmesg it's terribly handy
>>    if a given SDMMC device has a consistent number.  I know that I can
>>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
>>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
>>    about the SD card slot.  I don't want it to matter which one probed
>>    first, I don't want it to matter if I'm working on a variant of the
>>    hardware that has the SD card slot disabled, and I don't want to care
>>    what my boot device was.  Worrying about what device number I got
>>    increases my cognitive load.
>>
>> 2. There are cases where it's not trivially easy during development to
>>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
>>    as a BIOS.  When configured properly, that BIOS has a nice feature to
>>    allow you to fetch the kernel and kernel command line from TFTP by
>>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
>>    know which disk I'd like for my root filesystem, so it's not so easy
>>    for it to put the right UUID into the command line.  For this
>>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
>>
>>
>> Jaehoon Chung (1):
>>   Documentation: mmc: Document mmc aliases
>>
>> Stefan Agner (2):
>>   mmc: read mmc alias from device tree
>>   mmc: use SD/MMC host ID for block device name ID
>>
>>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>>  drivers/mmc/card/block.c                      |  3 ++-
>>  drivers/mmc/core/host.c                       | 25 ++++++++++++++++++++-----
>>  3 files changed, 33 insertions(+), 6 deletions(-)
>
>
> Does this mean we can revert 9aaf343 ("mmc: block: Use the mmc host
> device index as the mmcblk device index") for now and wait until this
> is in as well?

No, as that one fixes an issue for a widely deployed product (family).

>
> The commit I mention here breaks a significant number of boots
> on Olof's test build setup, and it would be nice to avoid breaking
> them again when we get yet another device numbering system.

They don't have to break *again*. He just have to convert *once* to
use UUID/PARTID which is really what most should be doing.

Kind regards
Uffe
