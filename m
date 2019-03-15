From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 15 Mar 2019 14:52:10 -0700
Message-ID: <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org> <yw1x5zsx5wc7.fsf@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1x5zsx5wc7.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Marek Vasut <marex@denx.de>
Cc: Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, stefan@agner.ch, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, vbyravarasu@nvidia.com, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Pawel
List-Id: linux-mmc@vger.kernel.org

Tim Harvey - Principal Software EngineerGateworks Corporation -
http://www.gateworks.com/3026 S. Higuera St. San Luis Obispo CA
93401805-781-2000
On Tue, Mar 5, 2019 at 4:39 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wro=
te:
>
> Douglas Anderson <dianders@chromium.org> writes:
>
> > This series picks patches from various different places to produce what
> > I consider the best solution to getting consistent mmc and mmcblk
> > ordering.
> >
> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
> > ordering solves a few different problems:
> >
> > 1. For poor, feeble-minded humans like me, have sane numbering for
> >    devices helps a lot.  When grepping through dmesg it's terribly hand=
y
> >    if a given SDMMC device has a consistent number.  I know that I can
> >    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
> >    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
> >    about the SD card slot.  I don't want it to matter which one probed
> >    first, I don't want it to matter if I'm working on a variant of the
> >    hardware that has the SD card slot disabled, and I don't want to car=
e
> >    what my boot device was.  Worrying about what device number I got
> >    increases my cognitive load.
> >
> > 2. There are cases where it's not trivially easy during development to
> >    use the UUID.  Specifically I work a lot with coreboot / depthcharge
> >    as a BIOS.  When configured properly, that BIOS has a nice feature t=
o
> >    allow you to fetch the kernel and kernel command line from TFTP by
> >    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
> >    know which disk I'd like for my root filesystem, so it's not so easy
> >    for it to put the right UUID into the command line.  For this
> >    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
> >
> > Changes in v2:
> > - Rebased atop mmc-next
> > - Stat dynamic allocation after fixed allocation; thanks Wolfram!
> > - rk3288 patch new for v2
> >
> > Douglas Anderson (1):
> >   ARM: dts: rockchip: Add mmc aliases for rk3288 platform
> >
> > Jaehoon Chung (1):
> >   Documentation: mmc: Document mmc aliases
> >
> > Stefan Agner (2):
> >   mmc: read mmc alias from device tree
> >   mmc: use SD/MMC host ID for block device name ID
> >
> >  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
> >  arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
> >  drivers/mmc/card/block.c                      |  2 +-
> >  drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
> >  4 files changed, 32 insertions(+), 2 deletions(-)
>
> Did anyone ever come up with an acceptable solution for this?  After
> three years, I'm getting tired of rebasing these patches onto every new
> kernel.
>
> UUIDs or similar are NOT an option for multiple reasons:
>
> - We have two rootfs partitions for ping-pong updates, so simply
>   referring to "the thing with ID foo" doesn't work.
>
> - Installing said updates needs direct access the device/partition,
>   which may not even have a filesystem.
>
> - The u-boot environment is stored in an eMMC "boot" partition, and
>   userspace needs to know where to find it.
>
> I'm sure I'm not the only one in a similar situation.
>
> Russel, feel free to shout abuse at me.  I don't care, but it makes you
> look stupid.
>

Completely agree here - we need a dt solution that allows us to
specify ordering.

I support a variety of IMX6 boards where for PCB routing reasons the
bootable MMC device is not always the first sdhc (sometimes the first
one is an SDIO radio for example). It seems ridiculous that I can't
handle this with:

        aliases {
                mmc0 =3D &usdhc3; /* MMC boot device */
                mmc1 =3D &usdhc2; /* SDIO radio */
        };

I see the imx6q-dhcom-som added in
52c7a088badd665a09ca9307ffa91e88d5686a7d re-defines the default
imx6qdl.dtsi mmc0-mmc3 aiases but I don't see any handling of this in
code anywhere - am I missing something?

Marek, why did you change the alias ordering for imx6q-dhcom-som.dtsi?
(maybe your carrying around a patch to make this useful?)

+       aliases {
+               mmc0 =3D &usdhc2;
+               mmc1 =3D &usdhc3;
+               mmc2 =3D &usdhc4;
+               mmc3 =3D &usdhc1;
+       };

Regards,

Tim
