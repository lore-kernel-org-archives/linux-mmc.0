From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP4 bust: MMC causes hung tasks
Date: Wed, 20 Feb 2013 23:43:49 +0000
Message-ID: <20130220234349.GA17852@n2100.arm.linux.org.uk>
References: <20130220170003.GW17833@n2100.arm.linux.org.uk> <87txp6gb3s.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87txp6gb3s.fsf@octavius.laptop.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 20, 2013 at 12:15:51PM -0500, Chris Ball wrote:
> Hi,
> 
> On Wed, Feb 20 2013, Russell King - ARM Linux wrote:
> > MMC looks sick - not sure what's going on with it though.  mmc0 I believe
> > is the onboard eMMC, mmc1 is the external SD card with the rootfs.  Any
> > ideas?
> 
> Is this with 3.8 final, or mmc-next?

You chopped off the version line printed by the kernel which gave you
some of that information.  It's v3.8-rc7 based, no external trees
pulled in.

> > [    1.253265] mmc0: new high speed MMC card at address 0001
> > [    1.260650] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> > [    1.265594] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
> > [    1.272003] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
> > [    1.278411] mmcblk0rpmb: mmc0:0001 SEM08G partition 3 128 KiB
> > [    1.289947]  mmcblk0: unknown partition table
> > [    1.297851]  mmcblk0boot1: unknown partition table
> > [    1.304321]  mmcblk0boot0: unknown partition table
> > [    1.471282] twl6040 1-004b: timeout waiting for READYINT
> > ...
> > [    1.603820] mmc1: host does not support reading read-only switch. assuming wr
> > ite-enable.
> > [    1.614105] mmc1: new high speed SD card at address 0002
> > [    1.620086] mmcblk1: mmc1:0002 00000 971 MiB
> > [    1.626129]  mmcblk1: p1 p2
> > ...
> > [    4.698455] VFS: Mounted root (ext3 filesystem) on device 179:34.
> > ...
> > [ 10.123077] mmcblk0rpmb: timed out sending r/w cmd command, card
> > status 0x400900
> 
> Ah, I think you need this patch from mmc-next:
> 
> 30bedc8b4c99b0da585a8e983d6346773cb50794
> mmc: core: expose RPMB partition only for CMD23 capable hosts
> 
> It's already got a stable@ tag on it.  I'll be sending mmc-next to Linus
> shortly and will make sure it gets into 3.8-stable; sorry it didn't make
> it into 3.8-final.

Yup, that's missing.  Thanks Chris.
