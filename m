From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: sg_dma_page_iter offset & length considerations
Date: Wed, 24 Apr 2019 09:57:28 +0200
Message-ID: <CAK8P3a2cGnTP_Qr4AjPvLA8X7cP+u_dNQQWZsWreKkKkqOwLdw@mail.gmail.com>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, Imre Deak <imre.deak@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 24, 2019 at 9:22 AM Daniel Drake <drake@endlessm.com> wrote:
> In drivers/mmc/alcor.c we're working with a MMC controller which
> supports DMA transfers split up into page-sized chunks. A DMA transfer
> consists of multiple pages, after each page is transferred there is an
> interrupt so that the driver can program the DMA address of the next
> page in the sequence. All pages must be complete in length, only the
> last one can be a partial transfer.
>
> I thought that the sg_dma_page_iter API looked like a great fit here:
> the driver can accept any old sglist, and then use this new API to
> collapse it into a list of pages that can be easily iterated over, and
> fed to the hardware one at a time.
>
> But looking closer I think I may have made some bad assumptions, and
> I'm left with some fundamental questions about this API.
>
> Specifically I can see userspace generates requests which present a
> sglist such as:
>  - first entry with offset=1536 length=2560
>  - 7 entries with offset=0 length=4096
>  - last entry with offset=0 length=1536
>
> I gather that dma_map_sg() will take care off the offsets, i.e. any
> physical address I get with sg_page_iter_dma_address() will already
> have the offset applied, so I don't have to worry about tracking that.
>
> But what about the length? For every page returned by the iterator, I
> can't assume that I am being asked to work with the full page, right?
> Such as the first and last page in the above example. I need to go
> back to the sglist to check the corresponding length variable, and
> having to go back to check the sglist seems to defeat the convenience
> of having the sglist collapsed into a list of pages by the iterator.
>
> Any comments?

I would assume that 4K aligned data is the common case, as that
is the smallest page size we allow in the page cache, and SDHC
cards expect FAT32 with at least 4K aligned clusters as well
in order to get into their fast path.

I'd keep that assumption by default, and would suggest you fall
back to to a kmalloc() bounce buffer if you get a buffer from user
space that is not fully aligned. I suppose the only way to create
those would be using O_DIRECT writes.

     Arnd
