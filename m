From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Wed, 27 Mar 2019 10:37:19 -0700
Message-ID: <CAJ+vNU0v8FXStXCfJUk5uJXiPuGGFLNW7aHOYfSoNJgu9qXHKw@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com> <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de> <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de> <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
 <c23d6c4edf92d58aec86da811eaa97a5@agner.ch> <yw1xbm2930rr.fsf@mansr.com> <20190317165957.k6lxxaq3hbs2owqz@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190317165957.k6lxxaq3hbs2owqz@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, Venu Byravarasu IN <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.comlinu
List-Id: linux-mmc@vger.kernel.org

On Sun, Mar 17, 2019 at 10:00 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sun, Mar 17, 2019 at 04:48:24PM +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > Stefan Agner <stefan@agner.ch> writes:
> >
> > > On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
> > >> On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
> > >>> If you have a FS or partition table there, it does.
> > >>> If you don't, I agree ... that's a problem.
> > >>
> > >> eMMC boot partitions are called mmcblkXbootY, and unless you have mo=
re
> > >> than one eMMC device on the system, they can be found either by look=
ing
> > >> for /dev/mmcblk*boot* or by querying udev.  The advantage of using u=
dev
> > >> is you can discover the physical device behind it by looking at DEVP=
ATH,
> > >> ID_PATH, etc, but you may not have that installed on an embedded dev=
ice.
> > >>
> > >> However, as I say, just looking for /dev/mmcblk*boot* is sufficient =
to
> > >> find the eMMC boot partitions where there is just one eMMC device
> > >> present (which seems to be the standard setup.)
> > >>
> > >>> > I don't care the slightest what the numbering is, as long as it i=
s
> > >>> > stable.  On some hardware, with an unpatched kernel, the mmc devi=
ce
> > >>> > numbering changes depending on whether or not an SD card is inser=
ted on
> > >>> > boot.  Getting rid of that behaviour is really all I want.
> > >>>
> > >>> Agreed, that would be an improvement.
> > >>
> > >> The mmc device numbering was tied to the mmc host numbering a while =
back
> > >> and the order that the hosts are probed should be completely indepen=
dent
> > >> of whether a card is inserted or not:
> > >>
> > >>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> > >>                  "mmcblk%u%s", card->host->index, subname ? subname =
: "");
> > >>
> > >>         snprintf(rpmb_name, sizeof(rpmb_name),
> > >>                  "mmcblk%u%s", card->host->index, subname ? subname =
: "");
> > >>
> > >> I suspect that Mans is quoting something from the dim and distant pa=
st
> > >> to confuse the issue - as shown above, it is now dependent on the ho=
st
> > >> numbering order not the order in which cards are inserted.
> > >
> > > Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as th=
e
> > > mmcblk device index") which came in with v4.6 enables constant mmc bl=
ock
> > > device numbering. I can confirm that it works nicely, and it improved
> > > the situation a lot.
> >
> > That's the answer I was looking for.  I guess we can drop these patches
> > from our kernels then.
> >
> > > That being said, we still use a patch downstream which allows
> > > renumbering using an alias. We deal with a bunch of different boards
> > > with different SoC's. I have a couple of SD cards with various rootfs
> > > and use internal eMMC boot quite often as well. Remembering which boa=
rd
> > > uses which numbering is a pain. Maintaining a patch is just easier...
> > > Furthermore, U-Boot allows reordering and all boards I deal with use =
mmc
> > > 0 for the internal eMMC. The aliases allow consistency.
> >
> > Since pretty much every other device type supports renumbering with DT
> > aliases, it would make sense to do this for mmc as well.
>
> SATA does not.  SCSI devices, whether they are disks, cdroms, tape
> drives or whatever have always been allocated dynamically in the
> order that they are discovered.
>
> Ethernet also does not, and davem remains opposed the idea of fixed
> allocation in the kernel.
>
> It's only a minority that demand fixed enumeration of devices.
>

Russell,

How does this case differ form defining a 'stdout-path' in the chosen
node of the device-tree [1] purposed to provide a path to the boot
console device among multiple UART's a board may have.

Again, I'm merely trying to overcome the fact that on one of my IMX6
boards usdhc2 registers as 'mmcblk0' and is an SDIO radio while usdhc3
registers as 'mmcblk1' and is the only 'bootable' device. I'm not all
that familiar with SDIO drivers... perhaps its completely wrong that
the IMX6 MMC driver is registering usdhc2 as a 'block device'?

Tim
[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt
