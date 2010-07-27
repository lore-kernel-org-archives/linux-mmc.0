From: <miltonm@bga.com>
Subject: Re: [PATCH] Tight check of pfn_valid on sparsemem - v4
Date: Tue, 27 Jul 2010 00:55:35 -0500
Message-ID: <pfn.valid.v4.reply.1@mdm.bga.com>
References: <alpine.DEB.2.00.1007261136160.5438@router.home>
	<1280159163-23386-1-git-send-email-minchan.kim@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail4.comsite.net ([205.238.176.238]:12080 "EHLO
	mail4.comsite.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0G0Fzt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jul 2010 01:55:49 -0400
In-Reply-To: <alpine.DEB.2.00.1007261136160.5438@router.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Minchan Kim <minchan.kim@gmail.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>

[Sorry if i missed or added anyone on cc, patchwork.kernel.org  LKML is not
working and I'm not subscribed to the list ]

On Mon Jul 26 2010 about 12:47:37 EST, Christoph Lameter wrote:
> On Tue, 27 Jul 2010, Minchan Kim wrote:
> 
> > This patch registers address of mem_section to memmap itself's page struct's
> > pg->private field. This means the page is used for memmap of the section.
> > Otherwise, the page is used for other purpose and memmap has a hole.

> 
> > +void mark_valid_memmap(unsigned long start, unsigned long end);
> > +
> > +#ifdef CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
> > +static inline int memmap_valid(unsigned long pfn)
> > +{
> > + struct page *page = pfn_to_page(pfn);
> > + struct page *__pg = virt_to_page(page);
> > + return page_private(__pg) == (unsigned long)__pg;
> 
> 
> What if page->private just happens to be the value of the page struct?
> Even if that is not possible today, someday someone may add new
> functionality to the kernel where page->pivage == page is used for some
> reason.
> 
> Checking for PG_reserved wont work?

I had the same thought and suggest setting it to the memory section block,
since that is a uniquie value (unlike PG_reserved),

> > static inline int pfn_valid(unsigned long pfn)
> > {
> > + struct mem_section *ms;
> > if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> > return 0;
> > - return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> > + ms = __nr_to_section(pfn_to_section_nr(pfn));
> > + return valid_section(ms) && memmap_valid(pfn);

.. and we already have computed it when we use it so we could pass it as
a parameter (to both _valid and mark_valid).

milton
