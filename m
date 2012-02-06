From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] usb: fix renesas_usbhs to not schedule in atomic
 context
Date: Mon, 6 Feb 2012 11:11:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202061058430.10363@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de> <4F22624E.2090201@renesas.com>
 <Pine.LNX.4.64.1201270946150.32661@axis700.grange> <4F27CA7D.601@renesas.com>
 <Pine.LNX.4.64.1202022317560.13860@axis700.grange> <4F2B9F34.60308@renesas.com>
 <Pine.LNX.4.64.1202031623000.6211@axis700.grange>
 <20120205145358.GA13762@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2BFKMH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 05:12:07 -0500
In-Reply-To: <20120205145358.GA13762@legolas.emea.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-usb@vger.kernel.org

Hi Felipe

On Sun, 5 Feb 2012, Felipe Balbi wrote:

> Hi,
> 
> On Fri, Feb 03, 2012 at 04:43:20PM +0100, Guennadi Liakhovetski wrote:
> > The current renesas_usbhs driver triggers
> > 
> > BUG: scheduling while atomic: ksoftirqd/0/3/0x00000102
> > 
> > with enabled CONFIG_DEBUG_ATOMIC_SLEEP, by submitting DMA transfers from 
> > an atomic (tasklet) context, which is not supported by the shdma dmaengine 
> > driver. Fix it by switching to a work. Also simplify some list 
> > manipulations.
> 
> you are doing much more than what you say.

Are those two list macro changes what you refer to as "a lot?" ;-) You're 
right in principle, they are not directly related to the purpose of this 
patch, they are just something that occurred to me, while tracking down 
DMA packets. But yes, it can be extracted to a separate cosmetic patch...

> Also, instead of using a
> workqueue, have you considered using threaded_irqs ?
> 
> (I didn't go over the driver again to see if it makes sense to use
> threaded_irqs in this case, but doesn't hurt asking)

>From a first glance these tasklets are not directly enough related to 
IRQs, so, doing that is either impossible, or would require a _much_ 
deeper change to the driver and _this_ would indeed be a much bigger 
change than just fixing the Oops.

Thanks
Guennadi

> > Shimoda-san, this is the problem, that you were observing. However, it 
> > exists with the present version of shdma just as well as with the new one 
> > - on top of the simple DMA library. I marked it an RFC because (1) I only 
> > lightly tested it with the gadget device on mackerel with the mass storage 
> > gadget, and (2) I am somewhat concerned about races. Currently the work 
> > function runs with no locking and there are no usual cancel_work_sync() 
> > points in the patch. However, it has also been like this before with the 
> > tasklet implementation, which is not much better, and it looks like there 
> > are no asynchronous operations on the same packets like timeouts. Only 
> > asynchronous events, that I can think about are things like unloading the 
> > driver or unplugging the cable, but these have been there before too. It 
> > would become worse on SMP, I think. Comments welcome.
> > 
> > diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> > index 72339bd..4d739ec 100644
> > --- a/drivers/usb/renesas_usbhs/fifo.c
> > +++ b/drivers/usb/renesas_usbhs/fifo.c
> > @@ -75,8 +75,7 @@ void usbhs_pkt_push(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt,
> >  		pipe->handler = &usbhsf_null_handler;
> >  	}
> >  
> > -	list_del_init(&pkt->node);
> > -	list_add_tail(&pkt->node, &pipe->list);
> > +	list_move_tail(&pkt->node, &pipe->list);
> >  
> >  	/*
> >  	 * each pkt must hold own handler.
> > @@ -106,7 +105,7 @@ static struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe)
> >  	if (list_empty(&pipe->list))
> >  		return NULL;
> >  
> > -	return list_entry(pipe->list.next, struct usbhs_pkt, node);
> > +	return list_first_entry(&pipe->list, struct usbhs_pkt, node);
> 
> these two hunks are not part of $SUBJECT
> 
> -- 
> balbi
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
