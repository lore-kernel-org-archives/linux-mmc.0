From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and add IOMMU support.
Date: Tue, 06 Jan 2015 14:55:51 +0100
Message-ID: <3924494.iNyoV2USme@wuerfel>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com> <3866536.C6OiUcuGCr@wuerfel> <CAOHikRCV7RaxJz-A_s6g++ueg3CDe9Jrqcog1Lc2_+KXR9QqnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62858 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbbAFN4E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jan 2015 08:56:04 -0500
In-Reply-To: <CAOHikRCV7RaxJz-A_s6g++ueg3CDe9Jrqcog1Lc2_+KXR9QqnQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suman Tripathi <stripathi@apm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Masters <jcm@redhat.com>, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches@apm.com, Don Dutile <ddutile@redhat.com>, linuxppc-dev@lists.ozlabs.org

On Tuesday 06 January 2015 17:10:29 Suman Tripathi wrote:
> Hi Arnd,
> > On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
> > > @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct
> > > platform_device *pdev)> > > 
> > >                 goto clk_dis_ahb;
> > >         
> > >         }
> > > 
> > > +#if defined(CONFIG_IOMMU_SUPPORT)
> > > +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
> > > +       if (!sdhci_arasan->domain) {
> > > +               dev_err(&pdev->dev, "Unable to allocate iommu
> > > domain\n");
> > > +               return PTR_ERR(sdhci_arasan->domain);
> > > +       }
> > > +
> > > +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
> > > +#endif
> > > +
> > 
> > Device drivers should never care about the implementation details
> > of the iommu. Please change the code to use the regular dma_map_*
> > interfaces that will work both with and without IOMMU.
>
> After refer to iommu binding , there is a service that allows "Remap
> address space to allow devices to access physical memory ranges that
> they otherwise wouldn't be capable of accessing." eg : 32-bit to 64
> bit DMA .
> 
> So do we have any existing driver that uses this service ? Just asking
> for suggestions.

The interface is completely transparent to device drivers, it is
implemented as a separate 'struct dma_map_ops' that is normally
architecture independent, and that handles all sorts of DMA remapping
issues for the driver, including

- address space limits
- offsets between CPU and device addresses for the same memory
- cache flushes
- bus-level synchronization

On arm32, we currently support six sets of dma_map_ops including
two for IOMMU (coherent and noncoherent). On arm64, we currently
always use swiotlb, which solves your problem by copying memory to
bounce buffers. This is rather inefficient, and a new implementation
is being worked on, based on the arm32 implementation to support
IOMMUs in a generic way.

	Arnd
