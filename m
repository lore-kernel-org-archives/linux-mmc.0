From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] dmaengine: shdma: fix a build failure on platforms with
 no DMA support
Date: Wed, 19 Jun 2013 21:32:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306192125480.12502@axis700.grange>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
 <51A77CF1.7040105@ti.com> <20130531024438.GB32564@verge.net.au>
 <CAGa+x8413povhYWx+BSj=TdzQDAuYFXmjF4A2kXvQt+=n+380w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59661 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935087Ab3FSTca (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2013 15:32:30 -0400
In-Reply-To: <CAGa+x8413povhYWx+BSj=TdzQDAuYFXmjF4A2kXvQt+=n+380w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Dan Murphy <dmurphy@ti.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Koul, Vinod" <vinod.koul@intel.com>

Hi Vinod

On Wed, 19 Jun 2013, Kevin Hilman wrote:

> On Thu, May 30, 2013 at 7:44 PM, Simon Horman <horms@verge.net.au> wrote:
> 
> [...]
> 
> > thanks for this. I will wait for a refresh (as we discussed earlier today).
> > Can I confirm that this is a fix for v3.10? If so, could ou note
> > that when you post your revised patch?
> 
> Any progress on this patch?
> 
> The SH-mobile defconfigs are still all failing in linux-next.

In

https://patchwork.kernel.org/patch/2640061/

I proposed a simple immediate fix for this problem. Arnd at the same time 
developed an alternative solution:

https://patchwork.kernel.org/patch/2644121/
https://patchwork.kernel.org/patch/2644111/

Which, I think, is a much larger change and isn't suitable as a bug-fix 
this late in the release cycle. Instead those patches address other issues 
with the shdma drivers, which might need to be carefully studied and 
solutions have to be found, which, however, would require more work and 
need a longer time. What is your opinion on this? Would you agree to apply 
v2 of this patch, as referenced above or would you prefer a different 
solution?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
