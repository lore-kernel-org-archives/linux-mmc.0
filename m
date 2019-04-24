From: Daniel Drake <drake@endlessm.com>
Subject: sg_dma_page_iter offset & length considerations
Date: Wed, 24 Apr 2019 15:22:18 +0800
Message-ID: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgg@mellanox.com, imre.deak@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

In drivers/mmc/alcor.c we're working with a MMC controller which
supports DMA transfers split up into page-sized chunks. A DMA transfer
consists of multiple pages, after each page is transferred there is an
interrupt so that the driver can program the DMA address of the next
page in the sequence. All pages must be complete in length, only the
last one can be a partial transfer.

I thought that the sg_dma_page_iter API looked like a great fit here:
the driver can accept any old sglist, and then use this new API to
collapse it into a list of pages that can be easily iterated over, and
fed to the hardware one at a time.

But looking closer I think I may have made some bad assumptions, and
I'm left with some fundamental questions about this API.

Specifically I can see userspace generates requests which present a
sglist such as:
 - first entry with offset=1536 length=2560
 - 7 entries with offset=0 length=4096
 - last entry with offset=0 length=1536

I gather that dma_map_sg() will take care off the offsets, i.e. any
physical address I get with sg_page_iter_dma_address() will already
have the offset applied, so I don't have to worry about tracking that.

But what about the length? For every page returned by the iterator, I
can't assume that I am being asked to work with the full page, right?
Such as the first and last page in the above example. I need to go
back to the sglist to check the corresponding length variable, and
having to go back to check the sglist seems to defeat the convenience
of having the sglist collapsed into a list of pages by the iterator.

Any comments?

Thanks
Daniel
