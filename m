From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Enabled IOMMU kills MMC card access
Date: Tue, 3 Jan 2012 11:27:28 -0800
Message-ID: <20120103192728.GB17619@sequoia.sous-sol.org>
References: <4F034265.9040304@hartkopp.net>
 <20120103183919.GA17619@sequoia.sous-sol.org>
 <4F034F9F.5090301@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sous-sol.org ([216.99.217.87]:44791 "EHLO sequoia.sous-sol.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754848Ab2ACUQB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jan 2012 15:16:01 -0500
Content-Disposition: inline
In-Reply-To: <4F034F9F.5090301@hartkopp.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Chris Wright <chrisw@sous-sol.org>, iommu@lists.linux-foundation.org, linux-mmc <linux-mmc@vger.kernel.org>

* Oliver Hartkopp (socketcan@hartkopp.net) wrote:
> On 03.01.2012 19:39, Chris Wright wrote:
> 
> > * Oliver Hartkopp (socketcan@hartkopp.net) wrote:
> >> i have a Dell 6510 with i7 CPU (M 640  @ 2.80GHz) with integrated GPU.
> >>
> >> With 3.2-rc - even with the very latest Linux version from Linus' tree
> >> 3.2.0-rc7-w-iommu-00081-g733bbb7 from today - i encountered some problems with
> >> my built-in MMC adapter:
> > 
> > Ricoh device?  If so, appears to be a buggy device (issues DMA from 
> > pci function 0 despite programming pci function > 0).
> 
> 
> Yes. It is a Ricoh device - lspci says:
> 
> 03:00.0 CardBus bridge: Ricoh Co Ltd Device e476 (rev 02)
> 03:00.1 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 03)

Yeah, that's just buggy.  The driver is programming pci Bus:Dev.Func
(03:00.1) to do DMA (and so the IOMMU should have translations for that
device).  However, the device appears to issue the DMA from 03:00.0
giving the DMA errors you showed, like this:

> >> [   71.818618] DMAR:[DMA Write] Request device [03:00.0] fault addr fffff000
> >> [   71.818620] DMAR:[fault reason 02] Present bit in context entry is clear
> >> [   71.818800] mmc0: unrecognised EXT_CSD revision 112
> >> [   71.818808] mmc0: error -22 whilst initialising MMC card

<snip>
> >> I do not get this problem when using a Debian distribution kernel 3.1.0 config
> >> as a base for the 3.2-rc7. Therefore i assume that they enabled something with
> >> visualization, that i did not enable on my development box.
> > 
> > They may have IOMMU defaulting to off (CONFIG_INTEL_IOMMU_DEFAULT_ON
> > turned off).
> 
> 
> There is no CONFIG_INTEL_IOMMU_DEFAULT_ON in the 3.1.0 kernel.
> 
> They do it like this in 3.1:
> 
> CONFIG_IOMMU_HELPER=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> CONFIG_DMAR=y
> # CONFIG_DMAR_DEFAULT_ON is not set

This is the same config item (it's just been renamed).

> CONFIG_DMAR_FLOPPY_WA=y
> # CONFIG_VIRT_DRIVERS is not set
> 
> > 
> >> Are there probably wrong Kconfig depencies killing my MMC access??
> >>
> >> Attached you'll find both of my kernel configs with and without IOMMU enabled.
> >> Any idea?
> > 
> > You should be able to boot with either intel_iommu=off (disabled) or
> > intel_iommu=on iommu=pt (enabled in passthrough mode, so only useful for
> > pci device assignment to guest virtual machines).
> 
> 
> IMHO it should work even with everything is switched on.

Yes, it should.  Currently, just a bug (and a quirk in hw that we need
to work around in sw).

> I put the MMC people in CC if there's a 'correct' way to handle the Ricoh MMC
> together with IOMMU (e.g. disable DMA?).
