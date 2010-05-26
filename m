From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 9/9] ARM: add DMA support to sh7372, enable DMA for SDHI
Date: Wed, 26 May 2010 23:23:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005262316330.22516@axis700.grange>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
 <Pine.LNX.4.64.1005041424330.4925@axis700.grange>
 <20100512155224.65eba9ee.akpm@linux-foundation.org>
 <Pine.LNX.4.64.1005130851030.4671@axis700.grange>
 <20100526141231.38e85b58.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100526141231.38e85b58.akpm@linux-foundation.org>
Sender: linux-sh-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Andrew

On Wed, 26 May 2010, Andrew Morton wrote:

> On Thu, 13 May 2010 08:57:06 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > On Wed, 12 May 2010, Andrew Morton wrote:
> > 
> > > On Tue, 4 May 2010 16:07:15 +0200 (CEST)
> > > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > > 
> > > > This patch depends on patch series from Magnus for shmobile, adding INTC 
> > > > and clock support. This patch wasn't there in the first version of this 
> > > > series.
> > > 
> > > Where is that patch series now?
> > 
> > AFAIU, these are two patch series - for the interrupt controller and for 
> > the clock framework, and they are not upstream yet. So, I think, we can 
> > leave patch 9/9 for later to be merged via the respective platform tree.
> > 
> 
> Again, because of your lack of specificity in identifying patches I am
> unable to determine whether
> arm-add-dma-support-to-sh7372-enable-dma-for-sdhi.patch is presently
> mergeable.
> 
> So I won't merge it.

Thanks for keeping an eye on these patches! Actually, my above sentence "I 
think, we can leave patch 9/9 for later to be merged via the respective 
platform tree" was supposed to mean, that you can drop _this_ specific 
patch, because it will be merged via the platform tree - in this case this 
is the "genesis-2.6" tree, maintained by Paul Mundt. Sorry for not being 
clear enough, please drop this patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
