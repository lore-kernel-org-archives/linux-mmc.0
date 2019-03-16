From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Date: Sat, 16 Mar 2019 15:39:01 +0000
Message-ID: <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
 <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Tim Harvey <tharvey@gateworks.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, stefan@agner.ch, Linux MMC List <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, linux-rockchip@lists.infradead.org, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>, vbyravarasu@nvidia.com, Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
> If you have a FS or partition table there, it does.
> If you don't, I agree ... that's a problem.

eMMC boot partitions are called mmcblkXbootY, and unless you have more
than one eMMC device on the system, they can be found either by looking
for /dev/mmcblk*boot* or by querying udev.  The advantage of using udev
is you can discover the physical device behind it by looking at DEVPATH,
ID_PATH, etc, but you may not have that installed on an embedded device.

However, as I say, just looking for /dev/mmcblk*boot* is sufficient to
find the eMMC boot partitions where there is just one eMMC device
present (which seems to be the standard setup.)

> > I don't care the slightest what the numbering is, as long as it is
> > stable.  On some hardware, with an unpatched kernel, the mmc device
> > numbering changes depending on whether or not an SD card is inserted on
> > boot.  Getting rid of that behaviour is really all I want.
> 
> Agreed, that would be an improvement.

The mmc device numbering was tied to the mmc host numbering a while back
and the order that the hosts are probed should be completely independent
of whether a card is inserted or not:

        snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
                 "mmcblk%u%s", card->host->index, subname ? subname : "");

        snprintf(rpmb_name, sizeof(rpmb_name),
                 "mmcblk%u%s", card->host->index, subname ? subname : "");

I suspect that Mans is quoting something from the dim and distant past
to confuse the issue - as shown above, it is now dependent on the host
numbering order not the order in which cards are inserted.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
