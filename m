From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: outstanding tmio patches
Date: Fri, 25 Mar 2011 09:04:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103250858400.22824@axis700.grange>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
 <m3k4folztx.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m3k4folztx.fsf@pullcord.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Thu, 24 Mar 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Wed, Mar 23 2011, Guennadi Liakhovetski wrote:
> > I thought it might help to list all the recent patches in the order they 
> > should apply to make it a bit easier...
> >
> > [1/2] mmc: tmio: Improve DMA stability on sh-mobile
> 
> Some serious merge conflicts with Linus W's dmaengine cleanup here.

Sorry, I must be missing something. I'm basing my patches on the current 
(of yesterday) next tree, which already contains Linus' patches:

mmc: tmio_mmc: use dmaengine helpers, drop submit check
mmc: tmio_mmc: drop dma_sglen state variable
mmc: tmio_mmc: unmap with the proper sglen
mmc: tmio_mmc: map DMA buffers on the DMA engine device

or which his patches do you mean?

Thanks
Guennadi

> > [2/2] mmc: tmio: use PIO for short transfers
> > [1/6,v2] mmc: tmio: split core functionality, DMA and MFD glue
> 
> And again here.  These flag-day patches that move around thousands of
> lines of code are extremely difficult to pull off without announcing
> them far ahead of time and getting everyone else to hold off from
> merging code first; you're essentially saying that development is closed
> and everyone else has to wait for your patch to be merged and then
> rebase onto it.
> 
> I'm open to suggestions on what to do next -- if you find it easier
> to prepare a git tree with everything applied for me to pull from
> I'd be happy to do that, although I think we should be preparing this
> much churn long before the merge window opens if it's supposed to go
> into mainline for the current cycle; the merge window should be for
> merging linux-next into mainline.
> 
> I think my own suggestion, without knowing too much about tmio, would be
> to apply the four patches that provide hardware fixes now, for -rc2:
> 
> [1/4,v3] mmc: tmio: only access registers above 0xff, if available
> [2/4,v3] ARM: mach-shmobile: fix SDHI IO address-range
> [3/4,v3] sh: fix SDHI IO address-range
> [4/4,v3] mmc: tmio: remove work-around for unmasked SDIO interrupts
> 
> and push the module split and clock gating work out to the start of the
> next merge window.
> 
> Let me know what you think, thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
