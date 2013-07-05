From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: shdma: fix a build failure on platforms
 with no DMA support
Date: Fri, 5 Jul 2013 10:23:50 +0530
Message-ID: <20130705045350.GA10947@intel.com>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
 <51A77CF1.7040105@ti.com>
 <20130531024438.GB32564@verge.net.au>
 <CAGa+x8413povhYWx+BSj=TdzQDAuYFXmjF4A2kXvQt+=n+380w@mail.gmail.com>
 <Pine.LNX.4.64.1306192125480.12502@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1306192125480.12502@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Dan Murphy <dmurphy@ti.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 19, 2013 at 09:32:18PM +0200, Guennadi Liakhovetski wrote:
> Hi Vinod
> 
> On Wed, 19 Jun 2013, Kevin Hilman wrote:
> 
> > On Thu, May 30, 2013 at 7:44 PM, Simon Horman <horms@verge.net.au> wrote:
> > 
> > [...]
> > 
> > > thanks for this. I will wait for a refresh (as we discussed earlier today).
> > > Can I confirm that this is a fix for v3.10? If so, could ou note
> > > that when you post your revised patch?
> > 
> > Any progress on this patch?
> > 
> > The SH-mobile defconfigs are still all failing in linux-next.
> 
> In
> 
> https://patchwork.kernel.org/patch/2640061/
And you havent CC maintainers on this patch, so I dont have it!
> 
> I proposed a simple immediate fix for this problem. Arnd at the same time 
> developed an alternative solution:
> 
> https://patchwork.kernel.org/patch/2644121/
> https://patchwork.kernel.org/patch/2644111/
Reading these patches I agree with Arnd that client drivers should not depend on
dma slave drivers. Existing issue need to be fixed

Arnd, Have you merged these changes?

--
~Vinod
> 
> Which, I think, is a much larger change and isn't suitable as a bug-fix 
> this late in the release cycle. Instead those patches address other issues 
> with the shdma drivers, which might need to be carefully studied and 
> solutions have to be found, which, however, would require more work and 
> need a longer time. What is your opinion on this? Would you agree to apply 
> v2 of this patch, as referenced above or would you prefer a different 
> solution?
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

-- 
