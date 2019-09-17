From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
Date: Tue, 17 Sep 2019 14:28:26 +0100
Message-ID: <20190917132826.GP25745@shell.armlinux.org.uk>
References: <20190916171509.GG25745@shell.armlinux.org.uk>
 <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk>
 <1406d22f-fd2e-f101-3efb-63cc52e9ac5f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1406d22f-fd2e-f101-3efb-63cc52e9ac5f@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 02:03:04PM +0100, Robin Murphy wrote:
> On 17/09/2019 13:33, Russell King - ARM Linux admin wrote:
> [...]
> > Further debug shows:
> > 
> > coherent=0 - sdhci device is not cache coherent
> > swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000081cac000
> > [ffffff8010fd5200] pgd=000000237ffff003, pud=000000237ffff003,
> > pmd=000000237fffb003, pte=00e800236d62270f
> > 
> > The mapping for the ADMA table seems to be using MAIR index 3, which is
> > MT_MEMORY_NC, so should be non-cacheable.
> > 
> > vmallocinfo:
> > 0xffffff8010fd5000-0xffffff8010fd7000    8192 dma_direct_alloc+0x4c/0x54
> > user
> > 
> > So this memory has been remapped.  Could there be an alias that has
> > cache lines still in the cache for the physical address, and could we
> > be hitting those cache lines while accessing through a non-cacheable
> > mapping?  (On 32-bit ARM, this is "unpredictable" and this problem
> > definitely _feels_ like it has unpredictable attributes!)
> > 
> > Also, given that this memory is mapped NC, then surely
> > __dma_flush_area() should have no effect?  However, it _does_ have the
> > effect of reliably solving the problem, which to me implies that there
> > _are_ cache lines in this NC mapping.
> 
> The non-cacheable mapping of the descriptor table will still have its
> cacheable linear map alias, so it's quite likely that the invalidate aspect
> of __dma_flush_area(), rather than the clean, is what's making the
> difference - if using __dma_clean_area() instead doesn't help, it would more
> or less confirm that.
> 
> One possibility in that case is that you might actually have the rare
> backwards coherency problem - if the device *is* actually snooping the
> cache, then it could hit lines which were speculatively prefetched via the
> cacheable alias before the descriptors were fully written, rather than the
> up-to-date data which went straight to RAM via the NC mapping. I'd try
> declaring the device as "dma-coherent" to see if that's actually true (and
> it should become pretty obvious if it isn't).

As just mentioned in my previous reply, there's a commit to the
dma-contiguous which changes where the CMA memory comes from.

[ffffff8010fd5200] pgd=000000237ffff003, pud=000000237ffff003,
	pmd=000000237fffb003, pte=00e800236d62270f

vs

[ffffff8010fd5200] pgd=000000237ffff003, pud=000000237ffff003,
	pmd=000000237fffb003, pte=00e80000f9c9a70f

Former is with the patch applied, latter is with it reverted.

This makes me question whether the cache handling for a page that is
remapped is being performed.  If there's cache lines present for a
page that is being remapped as non-cacheable, what prevents those
cache lines from being dirty and possibly being written-back at some
point after the non-cacheable mapping as been started to be used?

And yes, it looks like adding "dma-coherent" to the SDHCI controller
with the SD card in resolves the issue, so your hypothesis may be
true.  On the other hand, I haven't added "dma-coherent" to the eMMC
side, and that's also working fine over several reboots without the
offending commit reverted _nor_ with my __dma_flush_area() hack in
place.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
