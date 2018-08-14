From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Date: Tue, 14 Aug 2018 17:49:02 +0800
Message-ID: <20180814094902.a7pnioc6kytt4k5n@shbuild888>
References: <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
 <20180802091539.m5k7cdoad6hfkdfy@shbuild888>
 <20180814063959.45bddz42ytz3e4jb@shbuild888>
 <20180814071834.GB24616@kroah.com>
 <20180814073810.m7ewuyvuhptgsm22@shbuild888>
 <20180814074041.GB28982@kroah.com>
 <20180814080851.jazg3qebsleklqa5@shbuild888>
 <20180814084241.GA7208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814084241.GA7208@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, arjan@linux.intel.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

On Tue, Aug 14, 2018 at 10:42:41AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 14, 2018 at 04:08:51PM +0800, Feng Tang wrote:
> > Hi Greg,
> > 
> > Thanks for the prompt review.
> > 
> > On Tue, Aug 14, 2018 at 09:40:41AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 14, 2018 at 03:38:10PM +0800, Feng Tang wrote:
> > > > Hi Greg,
> > > > 
> > > > On Tue, Aug 14, 2018 at 09:18:34AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Tue, Aug 14, 2018 at 02:39:59PM +0800, Feng Tang wrote:
> > > > > > Hi Greg, Ulf
> > > > > > 
> > > > > > Could you help to review this? many thanks!
> > > > > 
> > > > > Review what?  I see no patch here.  And why would I need to review a mmc
> > > > > patch in the middle of the merge window?
> > > > > 
> > > > > totally confused,
> > > > 
> > > > Sorry for the confusion! I didn't noticed the 4.19 merge window.
> > > > 
> > > > The patch was originally posted in June, and has gone through some
> > > > review discussions with mmc maintainers, my last mail was trying
> > > > to keep some discussion info.
> > > 
> > > Ok, then why ask me?  I'm not the mmc maintainer.
> > 
> > The reason is this patch not only touches the mmc, but also affects many other
> > subsystems in drivers/ as the init order is changed. And the get_maintainer.pl
> > shows you are the first suggested reviewer for changes to drivers/Makefile :)
> 
> Fair enough, but then I could not make that change without the mmc
> maintainer agreeing with it.
> 
> > 
> > > 
> > > > The original patch is:
> > > > -----
> > > > 
> > > > >From 1514c7d56e887ace37466dded09bc43f2a4c9a4a Mon Sep 17 00:00:00 2001
> > > > From: Feng Tang <feng.tang@intel.com>
> > > > Date: Fri, 8 Jun 2018 17:10:30 +0800
> > > > Subject: [PATCH] mmc: Move the mmc driver init earlier
> > > > 
> > > > When doing some boot time optimization for an eMMC rootfs NUCs,
> > > > we found the rootfs may spend around 100 microseconds waiting
> > > > for eMMC card to be initialized, then the rootfs could be
> > > > mounted.
> > > > 	[    1.216561] Waiting for root device /dev/mmcblk1p1...
> > > > 	[    1.289262] mmc1: new HS400 MMC card at address 0001
> > > > 	[    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
> > > > 	[    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
> > > > 	[    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
> > > > 	[    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
> > > > 	[    1.292798]  mmcblk1: p1 p2 p3
> > > > 	[    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
> > > > 	[    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
> > > > 
> > > > And this is a common problem for smartphones, tablets, embedded
> > > > devices and automotive products. This patch will make the eMMC/SD
> > > > card  start initializing earlier, by changing its order in drivers/Makefile.
> > > > 
> > > > On our platform, the waiting for eMMC card is almost eliminated with the patch,
> > > > which is critical to boot time. And it should benefit other non-x86 platforms
> > > > which see the similar waiting for emmc rootfs.
> > > > 
> > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > > ---
> > > >  drivers/Makefile | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > index 24cd47014657..c473afd3c688 100644
> > > > --- a/drivers/Makefile
> > > > +++ b/drivers/Makefile
> > > > @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)		+= regulator/
> > > >  # reset controllers early, since gpu drivers might rely on them to initialize
> > > >  obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
> > > >  
> > > > +# put mmc early as many morden devices use emm/sd card as rootfs storage
> > > 
> > > Spelling error :)
> > 
> > Will change it.
> > 
> > > 
> > > > +obj-y				+= mmc/
> > > > +
> > > >  # tty/ comes before char/ so that the VT console is the boot-time
> > > >  # default.
> > > >  obj-y				+= tty/
> > > 
> > > Everyone wants to be first.  Watch out if you try to put stuff before
> > > tty, you have to be very careful.  There are sd serial devices, right?
> > 
> > As the eMMC/SD card initialization takes quite some time, the SDHCI
> > host controller's module init function will quickly return, while leaving 
> > a worker to do the real card detection/initialization, so other subsystems
> > should not be blocked.
> > 
> > And yes, it is safer to move it after tty/
> 
> Again, everyone wants to be first, saving 100ms is great, but make sure
> this will not break anything else.  It's a huge change to a
> long-standing "we know this works" linker order.  Personally, I would
> not want to accept this patch for that reason alone.

Valid concern.

> 
> Also given you ignored the comment for the tty line doesn't make me feel
> comfortable either.
> 
> If you really really need this, I would suggest just doing it in your
> device-specific tree for a few years and when this is the only
> out-of-tree patch you are carrying, then revisit it :)

It's already in one of our tree, and we'll keep testing it. Actually I've
asked some developer to test on their arm or other socs, but got no
response so far :) Anyway, thanks for the suggestion!

- Feng
