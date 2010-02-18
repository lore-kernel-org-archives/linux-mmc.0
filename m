From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Wed, 17 Feb 2010 18:26:48 -0600
Message-ID: <001b01cab031$0f34e010$544ff780@am.dhcp.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com> <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab0BRA1A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Feb 2010 19:27:00 -0500
In-Reply-To: <4B7C4608.5010008@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'David Vrabel' <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: David Vrabel [mailto:david.vrabel@csr.com]
> Sent: Wednesday, February 17, 2010 1:40 PM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> 
> Madhusudhan wrote:
> >
> >> -----Original Message-----
> >> From: David Vrabel [mailto:david.vrabel@csr.com]
> >> Sent: Wednesday, February 10, 2010 5:52 AM
> >> To: linux-mmc@vger.kernel.org
> >> Cc: David Vrabel; linux-omap@vger.kernel.org; madhu.cr@ti.com
> >> Subject: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> >>
> >> Enable the use of SDIO card interrupts.  This requires setting
> ENAWAKEUP
> >> in SYSCONFIG and IWE in HTCL to allow the MMC block to wake-up when in
> >> smart-idle mode.
> >>
> >> FCLK must be enabled while SDIO interrupts are enabled or the MMC block
> >> won't wake-up.
> >>
> >
> > I am curious to know the system behavior with this patch. Does the FCLK
> > remain enabled forever if a SDIO card is detected on the bus?
> 
> Only if card interrupts are enabled.  The card irq is disabled when the
> sdio_irq_thread exits.
> 

Your patch sets up the capability to enable sdio irqs anyway. My question
was more related to the idle path. In a scenario where you start using the
SDIO functionality and after some time you leave the SDIO card idle, does
the FCLK still remain enabled? Or do you see that sdio_irq_thread exits and
disables the FCLK?

Regards,
Madhu


> This is why I think that smart-idle mode needs to be used (it's turned
> on by default on the MMC controller) but I don't understand the
> clock/clockdomain code to see if that's doing the right thing.
> 
> If smart-idle mode is used then we don't need to disable FCLK manually
> to save power.  This will simplify the driver a bit.
> 
> David

