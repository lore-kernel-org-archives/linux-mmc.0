From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/5] tmio PM: aggressive clock gating, register layout
 limitation
Date: Tue, 8 Mar 2011 10:29:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103081004270.3903@axis700.grange>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
 <20110308084251.GB28316@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110308084251.GB28316@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Tue, 8 Mar 2011, Paul Mundt wrote:

> On Mon, Mar 07, 2011 at 07:47:45PM +0100, Guennadi Liakhovetski wrote:
> > 5 more patches, that fix high register access on sh-mobile in a correct 
> > way and implement aggressive clock gating. Marked as RFC because testing 
> > on non-SDHI platforms is required! The next step would be to add 
> > runtime-pm to clock gating, but I'm refraining from this for now, because 
> > similar patches for SDHCI have still not been committed and it seems, 
> > there are still doubts about the right way to do that.
> > 
> > Patches apply on top of my previous 2 patches from earlier today.
> > 
> I'm a bit confused about this series in general. Patch 1 and 5 are both
> marked RFC but 2/3/4 seem to be unrelated and intended for merging,
> despite the fact I find the approach itself to be rather suspect. So why
> exactly are these all lumped together?

They all affect the clocking behaviour, but yes, you're certainly right, 
they could and should be separated into two patch-series. Following your 
idea from a previous mail, patches 2, 3, and 4 should be using resource 
sizes.

It might, probably, be better to redo all these patches in a completely 
different way. Since none of them is a fix, I propose to drop the complete 
series for now. The previous series "tmio_mmc: improve DMA reliability" is 
anaffected.

Thanks
Guennadi

> Please do not create patch series that are intentionally muddled. Since
> you have two distinct things here with completely different intentions
> and you've not explicitly stated whether there's any dependencies between
> the two it simply creates a giant mess.
> 
> A patch series should be logically structured in some way other than
> "here's a bunch of random patches I have pending for this particular
> driver", particularly if only parts of it are intended to be merged.
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
