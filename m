From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] sh: ecovec: switch SDHI controllers to card polling
Date: Wed, 28 Mar 2012 08:58:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1203280856320.4583@axis700.grange>
References: <Pine.LNX.4.64.1201281929450.27970@axis700.grange>
 <20120328062753.GU26543@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120328062753.GU26543@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Paul

On Wed, 28 Mar 2012, Paul Mundt wrote:

> On Sat, Jan 28, 2012 at 07:36:24PM +0100, Guennadi Liakhovetski wrote:
> > Polling for card hotplug events is a better option than using SDHI native
> > hotplug interrupt, because the latter option forces the controller to stay
> > permanently powered up and enabled.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > It is a kind of an RFC. We do in general prefer SDHI polling to SDHI 
> > native hotplug detection for the above reason, but there might well be 
> > other reasons, why this is not a good idea in this specific case. If there 
> > are such, I'd love to hear about them.
> > 
> I've not heard any more about this one way or the other, so should I
> assume you still want it applied? At least we can revert it if one of
> these cases pops up, and in the interim it's always preferable to lean
> towards better power management for a default.

Yes, agree, since noone objected so far (as if I really expected dozens of 
people to pay attention to random RFC patches on the sh list;-)) let's 
apply it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
