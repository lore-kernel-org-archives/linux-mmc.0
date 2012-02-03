From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/7 v2] dmaengine: add a simple dma library
Date: Fri, 3 Feb 2012 11:21:46 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202031114560.6211@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de> <4F22624E.2090201@renesas.com>
 <Pine.LNX.4.64.1201270946150.32661@axis700.grange> <4F27CA7D.601@renesas.com>
 <Pine.LNX.4.64.1202022317560.13860@axis700.grange> <4F2B9F34.60308@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62989 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab2BCKV6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 05:21:58 -0500
In-Reply-To: <4F2B9F34.60308@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On Fri, 3 Feb 2012, Shimoda, Yoshihiro wrote:

> Hi Guennadi-san,
> 
> 2012/02/03 7:19, Guennadi Liakhovetski wrote:
> [ snip ]
> >>
> >> Thank you for your comment.
> >>
> >> I investigaed the issue. I found out the renesas_usbhs driver may
> >> call tx_submit() in the callback() of the dma-simple finally.
> > 
> > Sorry, in my first reply to this your email I misread the renesas_usbhs 
> > for an issue with your new SUDMAC driver. Since this is not the case and 
> > my patch seems to be causing a regression, I'll look at it.
> 
> Thank you for the comment.
> 
> I found out that if the "power_up" is 0 in the sample_tx_submit(),
> the pm_state will be changed to "PENDING".
> And then, even if the renesas_usbhs calls dma_async_issue_pending(),
> the dma-simple driver doesn't call the simple_chan_xfer_ld_queue().
> This is because the driver will call the simple_chan_xfer_ld_queue()
> when the pm_state is "ESTABLISHED" only.
> 
> So I guess that we have to modify the simple_issue_pending().

Ok, I looked at this code, there's now a comment in simple_tx_submit():

	if (power_up) {
		...
	} else {
		/*
		 * Tell .device_issue_pending() not to run the queue, interrupts
		 * will do it anyway
		 */
		schan->pm_state = DMA_SIMPLE_PM_PENDING;
	}

And that's exactly what should be happening: an interrupt should trigger 
the IRQ thread should call simple_chan_xfer_ld_queue(), so, looks like the 
interrupt is not coming? It's also strange, why and how it worked without 
dma-simple? I don't think I changed that with the transition... 
Investigating.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
