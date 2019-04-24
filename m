From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: sg_dma_page_iter offset & length considerations
Date: Wed, 24 Apr 2019 11:21:59 +0000
Message-ID: <20190424112153.GB16077@mellanox.com>
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
Content-Language: en-US
Content-ID: <47B74799A8FD6B4B8FA5AB4B76B8868C@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: "imre.deak@intel.com" <imre.deak@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 24, 2019 at 03:22:18PM +0800, Daniel Drake wrote:
> Hi,
>=20
> In drivers/mmc/alcor.c we're working with a MMC controller which
> supports DMA transfers split up into page-sized chunks.

Keep in mind that sg_page_iter_page splits into PAGE_SIZE chuncks, so
if you HW needs exactly a 4k chunk or something then it is not the
right API.

I have in mind the idea to move this code:

https://patchwork.kernel.org/patch/10909379/

Into the global scatterlist someday if there are other users in the
tree that need arbitary splitting..

> Specifically I can see userspace generates requests which present a
> sglist such as:
>  - first entry with offset=3D1536 length=3D2560
>  - 7 entries with offset=3D0 length=3D4096
>  - last entry with offset=3D0 length=3D1536
>=20
> I gather that dma_map_sg() will take care off the offsets, i.e. any
> physical address I get with sg_page_iter_dma_address() will already
> have the offset applied, so I don't have to worry about tracking that.

Well the DMA iter aligns everything to pages so all the offsets are
lost.

> But what about the length? For every page returned by the iterator, I
> can't assume that I am being asked to work with the full page,
> right?

So far no user has required the length/offset, but it would be easy
enough to make a function to calculate these values for the current
step.

This is because this API is used by drivers building page lists for
HW, and they usually have additional information outside the SGL that
indicates what the start/end offsets are.

A driver that simply wants a SGL with a capped max size (ie 4k?)
should use the dma_set_max_seg_size() API and just never get a SGE
with a larger length.=20

But the SGE may still cross a page boundary..

Jason
