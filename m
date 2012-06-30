From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Sat, 30 Jun 2012 12:45:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206301243320.19932@axis700.grange>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
 <87sjdf8q8h.fsf@octavius.laptop.org> <Pine.LNX.4.64.1206291701110.9084@axis700.grange>
 <87ehoy84oy.fsf@octavius.laptop.org> <Pine.LNX.4.64.1206292041340.9152@axis700.grange>
 <87lij5aefy.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54895 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab2F3KqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Jun 2012 06:46:09 -0400
In-Reply-To: <87lij5aefy.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Fri, 29 Jun 2012, Chris Ball wrote:

> Hi Guennadi,
> 
> On Fri, Jun 29 2012, Guennadi Liakhovetski wrote:
> > Ah, ok, right, sorry, I thought, it would be a part of the "git 
> > request-pull" output.
> 
> It is for newer versions of git, FWIW.
> 
> > So, the top commit has hash
> >
> > 7c4cf5b31b98f51ebfc8db89b022e4f52f93f5db
> >
> > Hope, this is what's required :-)
> 
> Yes, perfect -- pulled and pushed out to mmc-next.  Thanks!

Great, thanks!

> Could we get a file in Documentation/devicetree/bindings/mmc/ for the
> new sh_mmcif DT bindings you've added, please?  It can come as a new
> patch on top of these.  I know it'll be very short right now; you can
> at least show an example of a DT node that works.

I added OF support to both sh_mmcif and sh_mobile_sdhi (tmio_mmc), but in 
both cases it's just at the most primitive level. This means, those 
drivers will only use reg and interrupts DT properties, nothing else so 
far. More shall be added in the future. Does this level of support also 
have to be documented?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
