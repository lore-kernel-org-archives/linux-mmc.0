From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: fix address in kunmap_atomic() calls
Date: Mon, 14 Mar 2011 23:54:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103142349490.6125@axis700.grange>
References: <Pine.LNX.4.64.1103110822160.23675@axis700.grange>
 <m38vwhuzb8.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64827 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab1CNWy3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 18:54:29 -0400
In-Reply-To: <m38vwhuzb8.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Chris

On Mon, 14 Mar 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Fri, Mar 11 2011, Guennadi Liakhovetski wrote:
> > Currently kunmap_atomic() doesn't take into account the offset, used
> > with kmap_atomic(). On platforms, where kunmap_atomic() is not a NOP,
> > this will lead to problems, when offset != 0.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > No, I've never seen this bug trigger, so, not sure whether we need it for 
> > .38 / stable.
> 
> Thanks, I've pushed this to mmc-next for .39.
> 
> Could I get your ACK on the sh/tmio patches in Linus W's "[PATCH 00/11]
> MMC DMA-API/dmaengine fixups" patchset, please?

Hm, I've looked at them briefly and nothing in them struck me in them, but 
if you want a formal reviewed-by or such I'll have to look at them in more 
detail. I'm away from tomorrow until Saturday at a V4L2 meeting, so, will 
have little time... I'll try to do that, but, will not be able to test 
them. So, either just a review this week or a review + test not before 
next weekend, sorry.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
