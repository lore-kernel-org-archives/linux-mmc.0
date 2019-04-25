From: Daniel Drake <drake@endlessm.com>
Subject: Re: sg_dma_page_iter offset & length considerations
Date: Thu, 25 Apr 2019 15:38:45 +0800
Message-ID: <CAD8Lp47uacAFKTz8dtpDq3AXuQE9UKoBtw9VqxZdLeL5UoHCXA@mail.gmail.com>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
 <20190424112153.GB16077@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424112153.GB16077@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "imre.deak@intel.com" <imre.deak@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 24, 2019 at 7:22 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> A driver that simply wants a SGL with a capped max size (ie 4k?)
> should use the dma_set_max_seg_size() API and just never get a SGE
> with a larger length.

That sounds like exactly what we want here. However I tried that
function and it seems to have no effect. Larger SGEs still appear just
as readily as before.

I tried to find the code that honours the value set here, but didn't
find anything. Sure there are some non-x86 archs and some iommu
drivers that appear to do something with it, but in this case
(standard Intel x86_64) it seems like nothing observes/honours this
value.

That did lead me back to the similarly-named mmc_host.max_seg_size
though, which is passed through to blk_queue_max_segment_size().
That is documented as "Enables a low level driver to set an upper
limit on the size of a coalesced segment", but perhaps I don't fully
grasp what it means by "coalesced segment".

The alcor driver currently has:
    mmc->max_segs = 64;
    mmc->max_seg_size = 240 * 512;

which I had interpreted to mean "we can accept a sglist with maximum
64 entries, and if you sum the size of all entries in that sglist, the
total must not exceed 240 sectors". i.e. with "coalesced" referring to
the overall sum; the description does not suggest to me that we can
influence the size of an individual segment here.

Other mmc drivers may also share a similar interpretation, e.g. see atmel-mci.c:
    mmc->max_seg_size = mmc->max_blk_size * mmc->max_segs;

but I just experimented with the driver again, and setting
mmc_host.max_seg_size to 4096 does seem to do what we want here. Now
we get multi-entry sg lists but each sge is max 4096 bytes in size.

I'll do some more verification and then send a patch along these
lines. Thanks for your comments!

Daniel
