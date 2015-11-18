From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Wed, 18 Nov 2015 13:38:59 +0100
Message-ID: <5141236.CHnzdS7Lto@wuerfel>
References: <28102387.ALpaBHpim0@wuerfel> <6288847.N1QBIiXedG@wuerfel> <CAHp75Vf4oaLZE27bC+aH9HD6W4E8Gditoz=HF0Z1WwcLWJnSKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf4oaLZE27bC+aH9HD6W4E8Gditoz=HF0Z1WwcLWJnSKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 18 November 2015 11:35:27 Andy Shevchenko wrote:
> On Fri, Nov 13, 2015 at 11:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 13 November 2015 03:10:13 Andy Shevchenko wrote:
> >> On Thu, Nov 12, 2015 at 4:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > The dw_mmc driver stores the physical address of the MMIO registers
> >> > in a pointer, which requires the use of type casts, and is actually
> >> > broken if anyone ever has this device on a 32-bit SoC in registers
> >> > above 4GB. Gcc warns about this possibility when the driver is built
> >> > with ARM LPAE enabled:
> >>
> >> > -       host->phy_regs = (void *)(regs->start);
> >> > +       host->phy_regs = regs->start;
> >>
> >> >         /* Set external dma config: burst size, burst width */
> >> > -       cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
> >> > +       cfg.dst_addr = host->phy_regs + fifo_offset;
> >>
> >> dst_addr is dma_addr_t?
> >
> > Sort of. It doesn't really fit into any of the categories, and we actually
> > had a patch to change the type in the past, see
> > https://lkml.org/lkml/2015/7/10/167. Not sure what is going on there.
> >
> >> >         /* Registers's physical base address */
> >> > -       void                    *phy_regs;
> >> > +       resource_size_t         phy_regs;
> >>
> >> If dst_addr is dma_addr_t wouldn't be a problem when
> >> resource_size_t is defined as 64-bit address, and dma_addr_t as 32-bit?
> >>
> >> Btw, for me casting to dma_addr_t looks sane.
> >
> > The background here is that the address comes from a resource_size_t
> > that describes the MMIO register area as seen from the CPU, and that
> > is normally a phys_addr_t (resource_size_t is defined as being long
> > enough to store a phys_addr_t or various other things depending on
> > resource->flags).
> >
> > dma_addr_t strictly speaking refers to a RAM location as seen by a
> > DMA master, and that only comes out of dma_map_*() or
> > dma_alloc_coherent().
> >
> > The DMA engine wants something else here, which is an MMIO register
> > address as seen by a DMA master, and we don't have a separate typedef
> > for that. Almost universally all of resource_size_t, phys_addr_t and
> > dma_addr_t are the same type, and if we ever get a platform that
> > wants something other than a phys_addr_t to put into cfg.dst_addr,
> > we are in deep trouble.
> 
> DMA operates with address space covered by dma_addr_t, if you use
> phys_addr_t you may get address out of DMA boundaries. This is should
> be done in hardware / firmware / platform representation.
> So, I don't see any reason not to use dma_addr_t here.

As I said above, this isn't really the same as DMA: all normal
dma_addr_t are returned from dma_alloc_* or dma_map_*, point
to RAM and might go trhough an IOMMU, all of which is not true
here, hence the patch to change the type to phys_addr_t.

You really can't get out of bounds because the data comes from a
phys_addr_t and refers to a fixed location in hardware. If a
platform has registers higher than a 32-bit address, its phys_addr_t
must be 64-bit, but its dma_addr_t not necessarily so (even though
the two are the same almost always in practice).

	Arnd
