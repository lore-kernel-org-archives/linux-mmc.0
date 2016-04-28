From: Doug Anderson <dianders@google.com>
Subject: Re: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Thu, 28 Apr 2016 16:07:09 -0700
Message-ID: <CAD=FV=UWUbvT-j4hfE6=GmPg6g1xV5zfBjfDXP6wewKNC11KPQ@mail.gmail.com>
References: <56FA5C56.9080009@samsung.com>
	<20160329184920.29a240fc@xhacker>
	<56FB1AA2.8050005@rock-chips.com>
	<5701CCAF.4090102@samsung.com>
	<CAPDyKFqOJ1+ngcSjnyS4ysYJHBGvuOQLCD5oVcB3t-QrTN3b=g@mail.gmail.com>
	<57046DB8.5000107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36856 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcD1XHK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 19:07:10 -0400
Received: by mail-yw0-f173.google.com with SMTP id o66so151839066ywc.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 16:07:10 -0700 (PDT)
In-Reply-To: <57046DB8.5000107@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jisheng Zhang <jszhang@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi,

On Tue, Apr 5, 2016 at 7:00 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> I am not immediately opposed to this patch, although let me think a
>> bit more about it.
>>
>> What I would like to understand is why UUID/PARTUUID isn't working for
>> your case. Did you try to use that?
>
> I have used with UUID/PARTUUID/PARTLABEL and etc.. I think it's not problem.
> But that is why some guys wants to use the fixed index.
> (Almost all SoCs are still using "root=mmcblk0pX" in bootloader.)
>
> I'm considering more what is better. :)

I like the idea of consistent numbering here.  IMHO that solves a few
different problems:

1. For poor, feeble-minded humans like me, have sane numbering for
devices helps a lot.  When grepping through dmesg it's terribly handy
if a given SDMMC device has a consistent number.  I know that I can do
"dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about the
eMMC.  I know that I can do "dmesg | grep mmc1" to find info about the
SD card slot.  I don't want it to matter which one probed first, I
don't want it to matter if I'm working on a variant of the hardware
that has the SD card slot disabled, and I don't want to care what my
boot device was.  Worrying about what device number I got increases my
cognitive load.

2. There are cases where it's not trivially easy during development to
use the UUID.  Specifically I work a lot with coreboot / depthcharge
as a BIOS.  When configured properly, that BIOS has a nice feature to
allow you to fetch the kernel and kernel command line from TFTP by
pressing Ctrl-N.  In this particular case the BIOS doesn't actually
know which disk I'd like for my root filesystem, so it's not so easy
for it to put the right UUID into the command line.  For this purpose,
knowing that "mmcblk0" will always refer to eMMC is handy.


Note that I would personally prefer that the old patches to solve this
problem were resurrected.  Those old patches:

* Also ensure consistent numbering for "mmc", not just "mmcblk"

* Are slightly cleaner in the "mmcblk".


I've just rebased and cleaned up those patches and included the
Documentation from here.  I'll post them now.


-Doug
