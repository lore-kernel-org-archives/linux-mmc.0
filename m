From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/3] Patches to allow consistent mmc / mmcblk numbering
Date: Fri, 29 Apr 2016 10:32:33 -0700
Message-ID: <CAD=FV=UYfKfiiBNaDSk9nFi2vuRzV4dHTT=WH7D-ea=M_fgNEg@mail.gmail.com>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
	<CAPDyKFrip0M_hqVxqnTN=-UF7PnL6peEVR2o1dJRjYkHVMR-1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35732 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcD2Rcf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 13:32:35 -0400
Received: by mail-yw0-f173.google.com with SMTP id g133so178565036ywb.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 10:32:34 -0700 (PDT)
In-Reply-To: <CAPDyKFrip0M_hqVxqnTN=-UF7PnL6peEVR2o1dJRjYkHVMR-1Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, linux-mmc <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Venu Byravarasu <vbyravarasu@nvidia.com>, =?UTF-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?= <justin.wang@spreadtrum.com>, ksumrall@android.com, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dtor@chromium.org>, Jon Hunter <jonathanh@nvidia.com>, Tao Huang <huangtao@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Rob Herring <robh+dt@kernel.org>, Dong,

Ulf,

On Fri, Apr 29, 2016 at 12:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 April 2016 at 01:06, Douglas Anderson <dianders@chromium.org> wrote:
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
>>
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>
> I believe you need to re-base this patchset as things have changed.
>
> Currently the mmc host index that gets picked at host registration
> point, will also be given to the corresponding mmc block device index.
> That's probably solving most of your concerns, but I am open to extend
> this to cover aliases as well, as to allow it to be *really*
> deterministic.

OK, got it.  Send new patch now.  :)  PTAL.
