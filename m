From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Wed, 18 Nov 2015 17:29:19 +0200
Message-ID: <CAHp75VfE2DWYB5GwSe1WLPb+gTnhNpYz5qo7jNfMK4tXbEWioQ@mail.gmail.com>
References: <28102387.ALpaBHpim0@wuerfel>
	<6288847.N1QBIiXedG@wuerfel>
	<CAHp75Vf4oaLZE27bC+aH9HD6W4E8Gditoz=HF0Z1WwcLWJnSKA@mail.gmail.com>
	<5141236.CHnzdS7Lto@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35890 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbbKRP3U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2015 10:29:20 -0500
In-Reply-To: <5141236.CHnzdS7Lto@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Wed, Nov 18, 2015 at 2:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 November 2015 11:35:27 Andy Shevchenko wrote:
>> On Fri, Nov 13, 2015 at 11:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 13 November 2015 03:10:13 Andy Shevchenko wrote:
>> >> On Thu, Nov 12, 2015 at 4:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:

[]

>> >> If dst_addr is dma_addr_t wouldn't be a problem when
>> >> resource_size_t is defined as 64-bit address, and dma_addr_t as 32-bit?
>> >>
>> >> Btw, for me casting to dma_addr_t looks sane.
>> >
>> > The background here is that the address comes from a resource_size_t
>> > that describes the MMIO register area as seen from the CPU, and that
>> > is normally a phys_addr_t (resource_size_t is defined as being long
>> > enough to store a phys_addr_t or various other things depending on
>> > resource->flags).
>> >
>> > dma_addr_t strictly speaking refers to a RAM location as seen by a
>> > DMA master, and that only comes out of dma_map_*() or
>> > dma_alloc_coherent().
>> >
>> > The DMA engine wants something else here, which is an MMIO register
>> > address as seen by a DMA master, and we don't have a separate typedef
>> > for that. Almost universally all of resource_size_t, phys_addr_t and
>> > dma_addr_t are the same type, and if we ever get a platform that
>> > wants something other than a phys_addr_t to put into cfg.dst_addr,
>> > we are in deep trouble.
>>
>> DMA operates with address space covered by dma_addr_t, if you use
>> phys_addr_t you may get address out of DMA boundaries. This is should
>> be done in hardware / firmware / platform representation.
>> So, I don't see any reason not to use dma_addr_t here.
>
> As I said above, this isn't really the same as DMA: all normal
> dma_addr_t are returned from dma_alloc_* or dma_map_*, point
> to RAM and might go trhough an IOMMU, all of which is not true
> here, hence the patch to change the type to phys_addr_t.
>
> You really can't get out of bounds because the data comes from a
> phys_addr_t and refers to a fixed location in hardware. If a
> platform has registers higher than a 32-bit address, its phys_addr_t
> must be 64-bit, but its dma_addr_t not necessarily so (even though
> the two are the same almost always in practice).

I understand most of the things here, what I don't is how a platform
is supposed to work if you have the following:
a) HW, that uses register space let's say higher than 32-bit;
b) DMA engine, which should provide a DMA capability for above HW block;
c) dma_addr_t which does not cover the HW register space.

For me it clearly looks like a platform (HW / SW) configuration issue.

In case of bounce buffers I can't understand how it helps there.

-- 
With Best Regards,
Andy Shevchenko
