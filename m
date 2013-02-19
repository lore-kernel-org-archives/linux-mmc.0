From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v4 13/13] mmc: tmio: add barriers to IO operations
Date: Tue, 19 Feb 2013 22:59:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302192257240.22058@axis700.grange>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
 <201302181634.02751.arnd@arndb.de>
 <Pine.LNX.4.64.1302181808510.4526@axis700.grange>
 <201302182211.46697.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201302182211.46697.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 18 Feb 2013, Arnd Bergmann wrote:

> On Monday 18 February 2013, Guennadi Liakhovetski wrote:
> > On Mon, 18 Feb 2013, Arnd Bergmann wrote:
> > 
> > Sorry, I'm not sure how best to describe it, and I don't have sufficient 
> > information myself. In any case on a block-diagram of sh73a0 SDHI devices 
> > aren't directly connected to a common super-highway bus, instead they are 
> > on a bus-splitter. One more thing I forgot to mention - this error has 
> > been observed on SMP.
> 
> Ah, I guess that explains it. If you have one CPU filling the buffer
> and another CPU reading it, you need an smp_wmb/wmp_rmb pair.
> 
> That case can easily happen with tmio interrupt handler in PIO
> mode.

Ok, I also managed to reproduce it on UP, and it definitely is related to 
MMC_CAP_POWER_OFF_CARD, but I'll have to do some more work on it. I asked 
Chris to hold back on this patch for now.

Thanks
Guennadi

> > I checked clock code under drivers/sh/clk, I don't see any relevant 
> > __raw_* operations there. One I do see, however, GIC code does use 
> > *_relaxed() accessors, but under raw spinlocks... Do those provide 
> > sufficient barriers?
> 
> A spinlock by definition contains an SMP barrier, which seems to be
> what is missing here. I don't know if that is enough here, because
> the spinlock only needs barriers to protect against other users
> behind the same spinlock.
> 
> In architecture independent code, any smp_wmb() on the writer side
> must be paired with an smp_rmb on the reader. You probably have the
> sufficient barriers on the side that initiates the I/O because
> that uses a dmb() in the MMIO instructions, but that is only
> by accident and not portable.
> 
> Also, in the uniprocessor case, you have more barriers than you
> need, which limits the performance. The best solution for
> both performance and readability would be to use readw_relaxed()
> and writew_relaxed() and manually add the barriers you actually
> need, i.e. two smp_rmb()/smp_wmb() in the PIO case, and a
> wmb() before you start a real DMA to the device and an rmb()
> after a DMA from the device is complete.
> 
> 	Arnd
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
