From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Date: Tue, 14 Aug 2018 15:38:10 +0800
Message-ID: <20180814073810.m7ewuyvuhptgsm22@shbuild888>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
 <20180802091539.m5k7cdoad6hfkdfy@shbuild888>
 <20180814063959.45bddz42ytz3e4jb@shbuild888>
 <20180814071834.GB24616@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814071834.GB24616@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, arjan@linux.intel.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

On Tue, Aug 14, 2018 at 09:18:34AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 14, 2018 at 02:39:59PM +0800, Feng Tang wrote:
> > Hi Greg, Ulf
> > 
> > Could you help to review this? many thanks!
> 
> Review what?  I see no patch here.  And why would I need to review a mmc
> patch in the middle of the merge window?
> 
> totally confused,

Sorry for the confusion! I didn't noticed the 4.19 merge window.

The patch was originally posted in June, and has gone through some
review discussions with mmc maintainers, my last mail was trying
to keep some discussion info.

Thanks,
Feng


The original patch is:
-----

>From 1514c7d56e887ace37466dded09bc43f2a4c9a4a Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 8 Jun 2018 17:10:30 +0800
Subject: [PATCH] mmc: Move the mmc driver init earlier

When doing some boot time optimization for an eMMC rootfs NUCs,
we found the rootfs may spend around 100 microseconds waiting
for eMMC card to be initialized, then the rootfs could be
mounted.
	[    1.216561] Waiting for root device /dev/mmcblk1p1...
	[    1.289262] mmc1: new HS400 MMC card at address 0001
	[    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
	[    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
	[    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
	[    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
	[    1.292798]  mmcblk1: p1 p2 p3
	[    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
	[    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities

And this is a common problem for smartphones, tablets, embedded
devices and automotive products. This patch will make the eMMC/SD
card  start initializing earlier, by changing its order in drivers/Makefile.

On our platform, the waiting for eMMC card is almost eliminated with the patch,
which is critical to boot time. And it should benefit other non-x86 platforms
which see the similar waiting for emmc rootfs.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..c473afd3c688 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)		+= regulator/
 # reset controllers early, since gpu drivers might rely on them to initialize
 obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
 
+# put mmc early as many morden devices use emm/sd card as rootfs storage
+obj-y				+= mmc/
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
@@ -128,7 +131,6 @@ obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_PM_OPP)		+= opp/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
-obj-y				+= mmc/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-- 
2.14.1
