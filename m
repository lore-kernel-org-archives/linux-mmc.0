From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH] Tight check of pfn_valid on sparsemem - v4
Date: Tue, 27 Jul 2010 15:11:12 +0900
Message-ID: <AANLkTimtTVvorrR9pDVTyPKj0HbYOYY3aR7B-QWGhTei@mail.gmail.com>
References: <1280159163-23386-1-git-send-email-minchan.kim@gmail.com>
	<alpine.DEB.2.00.1007261136160.5438@router.home>
	<pfn.valid.v4.reply.1@mdm.bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41134 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab0G0GLR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jul 2010 02:11:17 -0400
In-Reply-To: <pfn.valid.v4.reply.1@mdm.bga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: miltonm@bga.com
Cc: Christoph Lameter <cl@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Mel Gorman <mel@csn.ul.ie>, Johannes Weiner <hannes@cmpxchg.org>, Kukjin Kim <kgene.kim@samsung.com>

On Tue, Jul 27, 2010 at 2:55 PM,  <miltonm@bga.com> wrote:
> [Sorry if i missed or added anyone on cc, patchwork.kernel.org =A0LKM=
L is not
> working and I'm not subscribed to the list ]

Readd them. :)

>
> On Mon Jul 26 2010 about 12:47:37 EST, Christoph Lameter wrote:
>> On Tue, 27 Jul 2010, Minchan Kim wrote:
>>
>> > This patch registers address of mem_section to memmap itself's pag=
e struct's
>> > pg->private field. This means the page is used for memmap of the s=
ection.
>> > Otherwise, the page is used for other purpose and memmap has a hol=
e.
>
>>
>> > +void mark_valid_memmap(unsigned long start, unsigned long end);
>> > +
>> > +#ifdef CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
>> > +static inline int memmap_valid(unsigned long pfn)
>> > +{
>> > + struct page *page =3D pfn_to_page(pfn);
>> > + struct page *__pg =3D virt_to_page(page);
>> > + return page_private(__pg) =3D=3D (unsigned long)__pg;
>>
>>
>> What if page->private just happens to be the value of the page struc=
t?
>> Even if that is not possible today, someday someone may add new
>> functionality to the kernel where page->pivage =3D=3D page is used f=
or some
>> reason.
>>
>> Checking for PG_reserved wont work?
>
> I had the same thought and suggest setting it to the memory section b=
lock,
> since that is a uniquie value (unlike PG_reserved),

You mean setting pg->private to mem_section address?
I hope I understand your point.

Actually, KAMEZAWA tried it at first version but I changed it.
That's because I want to support this mechanism to ARM FLATMEM.(It
doesn't have mem_section)


>
>> > static inline int pfn_valid(unsigned long pfn)
>> > {
>> > + struct mem_section *ms;
>> > if (pfn_to_section_nr(pfn) >=3D NR_MEM_SECTIONS)
>> > return 0;
>> > - return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
>> > + ms =3D __nr_to_section(pfn_to_section_nr(pfn));
>> > + return valid_section(ms) && memmap_valid(pfn);
>
> .. and we already have computed it when we use it so we could pass it=
 as
> a parameter (to both _valid and mark_valid).

I hope this can support FALTMEM which have holes(ex, ARM).

>
> milton
>



--=20
Kind regards,
Minchan Kim
