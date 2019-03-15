From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 15 Mar 2019 16:13:53 -0700
Message-ID: <CAJ+vNU21LyXBbFUdTU3LioTbu6uFAWh9Jf6wM2b5LJWucBwzmg@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com> <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, stefan@agner.ch, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, Venu Byravarasu IN <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, jonathanh@nvidia.co
List-Id: linux-mmc@vger.kernel.org

Tim Harvey - Principal Software EngineerGateworks Corporation -
http://www.gateworks.com/3026 S. Higuera St. San Luis Obispo CA
93401805-781-2000
On Fri, Mar 15, 2019 at 4:00 PM Marek Vasut <marex@denx.de> wrote:
>
> On 3/15/19 10:52 PM, Tim Harvey wrote:
> > Tim Harvey - Principal Software EngineerGateworks Corporation -
> > http://www.gateworks.com/3026 S. Higuera St. San Luis Obispo CA
> > 93401805-781-2000
> > On Tue, Mar 5, 2019 at 4:39 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>=
 wrote:
> >>
> >> Douglas Anderson <dianders@chromium.org> writes:
> >>
> >>> This series picks patches from various different places to produce wh=
at
> >>> I consider the best solution to getting consistent mmc and mmcblk
> >>> ordering.
> >>>
> >>> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> >>> ordering solves a few different problems:
> >>>
> >>> 1. For poor, feeble-minded humans like me, have sane numbering for
> >>>    devices helps a lot.  When grepping through dmesg it's terribly ha=
ndy
> >>>    if a given SDMMC device has a consistent number.  I know that I ca=
n
> >>>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info abou=
t
> >>>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
> >>>    about the SD card slot.  I don't want it to matter which one probe=
d
> >>>    first, I don't want it to matter if I'm working on a variant of th=
e
> >>>    hardware that has the SD card slot disabled, and I don't want to c=
are
> >>>    what my boot device was.  Worrying about what device number I got
> >>>    increases my cognitive load.
> >>>
> >>> 2. There are cases where it's not trivially easy during development t=
o
> >>>    use the UUID.  Specifically I work a lot with coreboot / depthchar=
ge
> >>>    as a BIOS.  When configured properly, that BIOS has a nice feature=
 to
> >>>    allow you to fetch the kernel and kernel command line from TFTP by
> >>>    pressing Ctrl-N.  In this particular case the BIOS doesn't actuall=
y
> >>>    know which disk I'd like for my root filesystem, so it's not so ea=
sy
> >>>    for it to put the right UUID into the command line.  For this
> >>>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy=
.
> >>>
> >>> Changes in v2:
> >>> - Rebased atop mmc-next
> >>> - Stat dynamic allocation after fixed allocation; thanks Wolfram!
> >>> - rk3288 patch new for v2
> >>>
> >>> Douglas Anderson (1):
> >>>   ARM: dts: rockchip: Add mmc aliases for rk3288 platform
> >>>
> >>> Jaehoon Chung (1):
> >>>   Documentation: mmc: Document mmc aliases
> >>>
> >>> Stefan Agner (2):
> >>>   mmc: read mmc alias from device tree
> >>>   mmc: use SD/MMC host ID for block device name ID
> >>>
> >>>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
> >>>  arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
> >>>  drivers/mmc/card/block.c                      |  2 +-
> >>>  drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
> >>>  4 files changed, 32 insertions(+), 2 deletions(-)
> >>
> >> Did anyone ever come up with an acceptable solution for this?  After
> >> three years, I'm getting tired of rebasing these patches onto every ne=
w
> >> kernel.
> >>
> >> UUIDs or similar are NOT an option for multiple reasons:
> >>
> >> - We have two rootfs partitions for ping-pong updates, so simply
> >>   referring to "the thing with ID foo" doesn't work.
> >>
> >> - Installing said updates needs direct access the device/partition,
> >>   which may not even have a filesystem.
> >>
> >> - The u-boot environment is stored in an eMMC "boot" partition, and
> >>   userspace needs to know where to find it.
> >>
> >> I'm sure I'm not the only one in a similar situation.
> >>
> >> Russel, feel free to shout abuse at me.  I don't care, but it makes yo=
u
> >> look stupid.
> >>
> >
> > Completely agree here - we need a dt solution that allows us to
> > specify ordering.
>
> Nope, ordering would be a policy and does not describe hardware, thus it
> shouldn't be in the DT. Use UUID or PARTUUID, they apply both to raw FS
> (fsuuid) and to partitions (part uuid). Linux kernel can mount FS using
> PARTUUID, to support UUID you need initramfs.

Marek,

Sure... a 'policy' decision would be which bootable device to boot
from but the issue I see that needs solving is for the vendor to be
able to describe via dt what devices are bootable for MMC (an SDIO
wifi device is not bootable yet a eMMC/microSD is).

Isn't this exactly the same issue as what the stdout-path specifies in
the chosen node? Modern SoC's have multiple UART's yet boot firmware
needs to know which one is the serial console just like boot firmware
should be able to figure out what device or devices are bootable.

Perhaps we can add a 'bootdev-path' in the chosen node?

Regards,

Tim
