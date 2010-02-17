From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Wed, 17 Feb 2010 13:49:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46388 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab0BQUtF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2010 15:49:05 -0500
In-Reply-To: <4B7C4608.5010008@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Madhusudhan <madhu.cr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 17 Feb 2010, David Vrabel wrote:

> Madhusudhan wrote:
> > 
> > > -----Original Message-----
> > > From: David Vrabel [mailto:david.vrabel@csr.com]
> > > Sent: Wednesday, February 10, 2010 5:52 AM
> > > To: linux-mmc@vger.kernel.org
> > > Cc: David Vrabel; linux-omap@vger.kernel.org; madhu.cr@ti.com
> > > Subject: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> > > 
> > > Enable the use of SDIO card interrupts.  This requires setting ENAWAKEUP
> > > in SYSCONFIG and IWE in HTCL to allow the MMC block to wake-up when in
> > > smart-idle mode.
> > > 
> > > FCLK must be enabled while SDIO interrupts are enabled or the MMC block
> > > won't wake-up.
> > > 
> > 
> > I am curious to know the system behavior with this patch. Does the FCLK
> > remain enabled forever if a SDIO card is detected on the bus?
> 
> Only if card interrupts are enabled.  The card irq is disabled when the
> sdio_irq_thread exits.
> 
> This is why I think that smart-idle mode needs to be used (it's turned
> on by default on the MMC controller) but I don't understand the
> clock/clockdomain code to see if that's doing the right thing.

The easiest way to observe the operation of the clock and clockdomain code 
is to change the "#undef DEBUG" to "#define DEBUG" at the top of the clock 
or clockdomain code files that you're interested in observing, recompile 
the kernel, and boot it.  You'll want to use an "ignore_loglevel" kernel 
command line parameter or something similar.  This will alter the behavior 
of some power management situations, since the output of the debug 
messages will keep a UART active, but should be sufficient for the MMC 
work.

> If smart-idle mode is used then we don't need to disable FCLK manually to save
> power.  This will simplify the driver a bit.

Perhaps I'm misunderstanding what you're referring to, but it seems there 
is some confusion as to what target smart-idle mode does.  It's the PRCM 
that requests that the module enter idle.  This process is not dependent 
on the target idle mode bits, and happens when the PRCM concludes that 
clocks can potentially be disabled.  In the case of functional clocks, 
this process is triggered when some code (i.e., the clock code) disables 
the CM_FCLKEN_x.EN_y bit.

After the PRCM requests the module enter idle, depending on the 
OCP_SYSCONFIG.SIDLEMODE bits, the module either does not acknowledge the 
idle request (no-idle mode), always acknowledges the request (force-idle 
mode), or, acknowledges the idle request when the module believes it is 
internally quiescent (smart-idle mode).  This acknowledgement signal 
originates from the module and goes back to the PRCM.  Once this happens, 
the PRCM can switch off some clocks.  As can be seen in the HSMMC TRM 
docs, the HSMMC module expects the PRCM to disable both the interface and 
the functional clock when it acknowledges the idle request.

My point is that the target idle mode is unlikely to have any impact on 
the need to disable and enable the functional clock in software.

That said, I don't really know the details of the SDIO wakeup issue that 
you mention, but it might be worth observing that if your SDIO card 
doesn't generate its own internal clock, then it's unlikely to be able to 
provide an interrupt to wake up the controller when the HSMMC functional 
clock is off.  This is because the only other available clock for the card 
would come from the HSMMC's functional clock.

It seems to me that this issue could be diagnosed fairly easily by 
triggering the SDIO interrupt line by hand while the HSMMC functional 
clock is kept off.  If a wakeup is generated, then it's a card issue.  
Otherwise, you'll need to do some more intensive diagnostics.  For 
example, if the CORE powerdomain isn't on when you do the test, presumably 
you'll need to make sure that an IO ring wakeup is set for the SDIO card's 
interrupt line.  (In these situations, the interrupt response latency will 
be quite high, since the chip will need to boot from off-mode.  The driver 
can request a lower bound on the interrupt response latency via an OMAP PM 
layer function, which will likely keep the chip from entering off mode.)  

But if the CORE powerdomain is on or in retention when you do the test, 
then perhaps there is indeed some issue with the HSMMC controller where it 
cannot generate wakeups when its functional clock is off.  You'd want to 
verify that your HSMMC register settings are correct, though, before 
coming to that conclusion.


- Paul
