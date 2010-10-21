From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: sdhci: mmc:  determining card type and dynamic clocks
Date: Thu, 21 Oct 2010 14:04:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010211350590.2764@xanadu.home>
References: <AED80D39-301D-490D-8729-C2CAA765F192@marvell.com>
 <alpine.LFD.2.00.1010211243250.2764@xanadu.home>
 <63E87425-A910-4658-AE78-DFD6D7852422@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:55826 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab0JUSET (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 14:04:19 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAN00K2IJIHEBB0@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 21 Oct 2010 14:03:53 -0400 (EDT)
In-reply-to: <63E87425-A910-4658-AE78-DFD6D7852422@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>

On Thu, 21 Oct 2010, Philip Rakity wrote:

> 
> On Oct 21, 2010, at 9:57 AM, Nicolas Pitre wrote:
> 
> > I don't like this.  Again we should strive to make the controller driver 
> > as simple as possible and let the core code handle this kind of clocking 
> > logic as much as possible.  The OMAP driver is again a terribly bad 
> > example to follow.
> 
> Not looking at OMAP

I know... I'm just dropping a hint in the passing to those who may be 
concerned.

> > 
> > If there are cases where the clock still has to remain active with some 
> > cards, it is far better to take care of such exceptions in only one 
> > place instead of having to add a card quirk in every controller drivers.  
> > The controller driver should remain card agnostic as much as possible 
> > and not take decisions on its own based on card type.
> 
> Was not going to add a quirk.  The low level platform specific code for
> sdhci.c can handle this if it knows the card type.  It can program the
> appropriate hardware registers.

NO!!!  That's EXACTLY what I'm against!

> > Stopping the clock would also be a good thing even for those controllers 
> > without dynamic clock support. The core could certainly stop the clock 
> > manually after a period of inactivity for example.
> 
> 
> agree except that stopping the clock for SDIO cards is not a good thing to do in our experience.
> if the core can signal this via set_ios this works for me.  This is why I suggested the code telling
> set_ios the card type which allowed the platform specific code to enable or not dynamic 
> clocks.

NO!  The core should tell the platform specific code via set_ios() 
whether or not to enable dynamic clock, period.  The _decision_ to do so 
(is it a SDIO card, is it a broken SDHC card which requires the clock 
all the time, etc.) should remain in the core code.  The controller 
drivers have no business duplicating the code for making such decisions 
on their own.

> > So if your controller hardware has the ability to dynamically stop the 
> > clock on its own, then the driver should simply expose that knowledge to 
> > the core with a capability bit, and the core should tell the driver to 
> > enable that mode through mmc_set_ios() when applicable.
> 
> sd 3.0 spec (not marvell specific) suppports dynamic clocking as well as marvell v2.0
> controller.
> 
> I can add a CAP bit -- but for SDIO cards we will certainly set this to not disable the clocks.

Again, the "for SDIO cards" has to be decided in the *core* code, not in 
your driver.

> 100,000 foot summary
> a) add new mmc->caps bit indicating dynamic clocks can be supported in the controller
> b) add new field in ios that indicates if clocks should be dynamic
> c) pass this to set_ios
> d) add platform specific hook to set_ios to control the dynamic clocking option.
> 
> Is my understanding correct ?

Yes!  And then the core code may either set the dynamic clock bit in the 
ios structure if the host controller supports it, or manually turn off 
the clock after a delay of inactivity, but only when this makes sense 
i.e. not with SDIO cards (and even for SDIO that might be possible if no 
IRQ is claimed).


Nicolas
