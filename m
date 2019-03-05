From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering w/ device tree
Date: Tue, 05 Mar 2019 12:39:36 +0000
Message-ID: <yw1x5zsx5wc7.fsf@mansr.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461951139-6109-1-git-send-email-dianders@chromium.org> (Douglas
        Anderson's message of "Fri, 29 Apr 2016 10:32:15 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, Heiko Stuebner <heiko@sntech.de>, jszhang@marvell.com, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, vbyravarasu@nvidia.com, lars@metafoo.de, linux@arm.linux.org.uk, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, grundler@chromium.org, galak@codeaurora.org, lporzio@micron.com, robh+dt@kernel.org, chaotian.jing@mediatek.com, sergei.shtylyov@cogentembedded.com, sudeep.holla@arm.com, zhonghui.fu@linux.intel.com, kirill.shutem
List-Id: linux-mmc@vger.kernel.org

Douglas Anderson <dianders@chromium.org> writes:

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
> Changes in v2:
> - Rebased atop mmc-next
> - Stat dynamic allocation after fixed allocation; thanks Wolfram!
> - rk3288 patch new for v2
>
> Douglas Anderson (1):
>   ARM: dts: rockchip: Add mmc aliases for rk3288 platform
>
> Jaehoon Chung (1):
>   Documentation: mmc: Document mmc aliases
>
> Stefan Agner (2):
>   mmc: read mmc alias from device tree
>   mmc: use SD/MMC host ID for block device name ID
>
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
>  drivers/mmc/card/block.c                      |  2 +-
>  drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
>  4 files changed, 32 insertions(+), 2 deletions(-)

Did anyone ever come up with an acceptable solution for this?  After
three years, I'm getting tired of rebasing these patches onto every new
kernel.

UUIDs or similar are NOT an option for multiple reasons:

- We have two rootfs partitions for ping-pong updates, so simply
  referring to "the thing with ID foo" doesn't work.

- Installing said updates needs direct access the device/partition,
  which may not even have a filesystem.

- The u-boot environment is stored in an eMMC "boot" partition, and
  userspace needs to know where to find it.

I'm sure I'm not the only one in a similar situation.

Russel, feel free to shout abuse at me.  I don't care, but it makes you
look stupid.

-- 
Måns Rullgård
