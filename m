From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] Patches to allow consistent mmc / mmcblk numbering
Date: Fri, 29 Apr 2016 19:39:09 +0200
Message-ID: <1659435.FBgTBXnguZ@wuerfel>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:62425 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbcEDTZM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 15:25:12 -0400
In-Reply-To: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, mark.rutland@arm.com, vbyravarasu@nvidia.com, justin.wang@spreadtrum.com, ksumrall@android.com, lars@metafoo.de, dtor@chromium.org, jonathanh@nvidia.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lporzio@micron.com, robh+dt@kernel.org, chuanxiao.dong@intel.com, chaotian.jing@mediatek.com, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, sudeep.holla@arm.com

On Thursday 28 April 2016 16:06:42 Douglas Anderson wrote:
> This series picks patches from various different places to produce what
> I consider the best solution to getting consistent mmc and mmcblk
> ordering.
> 
> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> ordering solves a few different problems:
> 
> 1. For poor, feeble-minded humans like me, have sane numbering for
>    devices helps a lot.  When grepping through dmesg it's terribly handy
>    if a given SDMMC device has a consistent number.  I know that I can
>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
>    about the SD card slot.  I don't want it to matter which one probed
>    first, I don't want it to matter if I'm working on a variant of the
>    hardware that has the SD card slot disabled, and I don't want to care
>    what my boot device was.  Worrying about what device number I got
>    increases my cognitive load.
> 
> 2. There are cases where it's not trivially easy during development to
>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
>    as a BIOS.  When configured properly, that BIOS has a nice feature to
>    allow you to fetch the kernel and kernel command line from TFTP by
>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
>    know which disk I'd like for my root filesystem, so it's not so easy
>    for it to put the right UUID into the command line.  For this
>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
> 
> 
> Jaehoon Chung (1):
>   Documentation: mmc: Document mmc aliases
> 
> Stefan Agner (2):
>   mmc: read mmc alias from device tree
>   mmc: use SD/MMC host ID for block device name ID
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  drivers/mmc/card/block.c                      |  3 ++-
>  drivers/mmc/core/host.c                       | 25 ++++++++++++++++++++-----
>  3 files changed, 33 insertions(+), 6 deletions(-)


Does this mean we can revert 9aaf343 ("mmc: block: Use the mmc host
device index as the mmcblk device index") for now and wait until this
is in as well?

The commit I mention here breaks a significant number of boots
on Olof's test build setup, and it would be nice to avoid breaking
them again when we get yet another device numbering system.

	Arnd

