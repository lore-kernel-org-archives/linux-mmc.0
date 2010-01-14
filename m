From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] omap_hsmmc: set DVFS/PM constraints
Date: Thu, 14 Jan 2010 12:53:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001141158290.7813@utopia.booyaka.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com> <20100113114041.7615.830.sendpatchset@ahunter-work.research.nokia.com> <alpine.DEB.2.00.1001131538560.4769@utopia.booyaka.com> <4B4ED5AE.1090807@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483Ab0ANTxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2010 14:53:33 -0500
In-Reply-To: <4B4ED5AE.1090807@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "Karpov Denis.2 (EXT-Teleca/Helsinki)" <ext-denis.2.karpov@nokia.com>, Tony Lindgren <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

Hello Adrian,

On Thu, 14 Jan 2010, Adrian Hunter wrote:

> Paul Walmsley wrote:
> > (added Denis and Kevin)
> > 
> > Hello Denis, Adrian,
> > 
> > On Wed, 13 Jan 2010, Adrian Hunter wrote:
> > 
> > > >From afab8b432b37ae1f42b281e58989c8d607ed7183 Mon Sep 17 00:00:00 2001
> > > From: Denis Karpov <ext-denis.2.karpov@nokia.com>
> > > Date: Wed, 8 Jul 2009 16:15:08 +0200
> > > Subject: [PATCH] omap_hsmmc: set DVFS/PM constraints
> > > 
> > > Set constraint for MPU minimal frequency to maintain good
> > > I/O performance.
> > > 
> > > The constraint is set in MMC host 'ENABLED' state and dropped
> > > when MMC host enters 'DISABLED' state which currently happens
> > > upon 100ms of inactivity.
> > > 
> > > Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
> > > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> > > ---
> > >  arch/arm/mach-omap2/board-rx51-peripherals.c |   18 ++++++++++++++++++
> > >  arch/arm/mach-omap2/hsmmc.c                  |    2 ++
> > >  arch/arm/mach-omap2/hsmmc.h                  |    2 ++
> > >  arch/arm/plat-omap/include/plat/mmc.h        |    3 +++
> > >  drivers/mmc/host/omap_hsmmc.c                |   17 +++++++++++++++++
> > >  5 files changed, 42 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c
> > > b/arch/arm/mach-omap2/board-rx51-peripherals.c
> > > index ab07ca2..b6318b1 100644
> > > --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> > > +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> > > @@ -209,6 +209,22 @@ static struct twl4030_madc_platform_data
> > > rx51_madc_data = {
> > >  	.irq_line		= 1,
> > >  };
> > >  +#if defined(CONFIG_BRIDGE_DVFS)
> > > +/*
> > > + * This handler can be used for setting other DVFS/PM constraints:
> > > + * intr latency, wakeup latency, DMA start latency, bus throughput
> > > + * according to API in mach/omap-pm.h.  Currently we only set constraints
> > > + * for MPU frequency.
> > > + */
> > > +#define MMC_MIN_MPU_FREQUENCY	500000000	/* S500M at OPP3 */
> > > +static void rx51_mmc_set_pm_constraints(struct device *dev, int on)
> > > +{
> > > +	omap_pm_set_min_mpu_freq(dev, (on ? MMC_MIN_MPU_FREQUENCY : 0));
> > > +}
> > 
> > NAK.  The MMC driver (or any other driver, for that matter) must not set MPU
> > frequency constraints merely to boost performance.  Drivers have no way of
> > knowing what the power vs. performance policy is for a given device or use
> > case.
> 
> The driver doesn't but RX-51 does, which is why the code is in the RX-51
> board file.  

I don't think that changes the situation.  The RX-51 board file represents 
the hardware integration on the device, not MPU power policy.  That's the 
CPUFreq governor's responsibility.  It shouldn't be necessary to hack a 
board file to change the CPU power management policy.  Maybe that is 
acceptable on a device that has been locked down by the manufacturer to 
only boot kernels signed by them, but that's not the case for RX-51.

Denis didn't go into detail on the performance problem that you and he 
observed.  Further info would be welcome.  Hypothesizing, if the problem 
is that MMC does a lot of MPU work before the CPUFreq timer fires to 
re-evaluate performance, then maybe some CPUFreq function call needs to 
exist to ask the CPUFreq governor to elevate MPU speed in advance.  But 
it's hard to say without knowing more about the problem you observed.

> We know exactly the use cases and the effect on performance.

Certainly for Maemo 5 Harmattan as shipped that is true.  It's not 
necessarily true if someone wants to boot another distribution like Debian 
and use (for example) a userspace CPUFreq governor on the device.

> > If the system is not upscaling MPU frequency quickly enough, then the power
> > management policy code -- CPUFreq, in the MPU case -- or the parameters for
> > that code -- need to be adjusted.  (Of course, integrators can always dump
> > hacks like this in their own trees if they get lazy, but these should be
> > kept far, far away from mainline.)
> 
> It is unreasonable to override the policy decisions of the board maker
> as defined in their board files.

Could you explain why?  MPU power management policy for an on-chip device 
such as MMC, which is located internally in the OMAP SoC, is board 
hardware-invariant, and so doesn't belong in the board file.  I agree that 
this is dependent on the software distribution.  So we either need to 
understand the problem and come up with a clean way to resolve it, or keep 
hacks like this distribution-specific.

> Instead you must remove the omap_pm_set_min_mpu_freq() function entirely
> or suffer the consequence that it can be used. i.e. it should not exist
> if you don't want anyone to use it.

This function, omap_pm_set_min_mpu_freq(), does not even exist in 
mainline, Tony's kernel, or the current PM branch.  Nor does 
CONFIG_BRIDGE_DVFS.  When you look at the file that defines the interface 
for these functions, arch/arm/plat-omap/include/plat/omap-pm.h, you'll 
find this:

   /*
    * CPUFreq-originated constraint
    *
    * In the future, this should be handled by custom OPP clocktype
    * functions.
    */

[...]

   /**
    * omap_pm_cpu_set_freq - set the current minimum MPU frequency
    * @f: MPU frequency in Hz
    *
    * Set the current minimum CPU frequency.  The actual CPU frequency
    * used could end up higher if the DSP requested a higher OPP.
    * Intended to be called by plat-omap/cpu_omap.c:omap_target().  No
    * return value.
    */
   void omap_pm_cpu_set_freq(unsigned long f);

To my reading, this file is quite clear that this function is intended to 
be called only from CPUFreq.

> > N.B.  As a separate matter, the MMC driver should call
> > omap_pm_set_min_bus_tput() with the maximum throughput that the current MMC
> > card can sustain to memory.  A reasonable upper bound should be easy to
> > calculate based on the MMC clock speed and the width of the MMC transfers.
> > This will allow the kernel to adjust the bus frequency appropriately as the
> > OMAP PM core's bus utilization model improves.
> 
> Many different constraints were tried.  min_mpu_freq was the only one that
> worked.
> 
> In the future, improvements to DMA and changes to PM may be able to get the
> same performance without the min_mpu_freq constraint.

omap_pm_set_min_bus_tput() addresses a different case than 
omap_pm_cpu_set_freq().  It's just intended to ensure that the 
interconnect clock frequency is high enough to sustain the desired data 
rate.  It presumably won't affect the performance problem that this patch 
is intended to address.


regards,

- Paul
