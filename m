Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A5C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 07:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E20661426
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhDVHum (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 03:50:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhDVHul (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 22 Apr 2021 03:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619077806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=su1bUanZBBFnjAZp3SpTynnNbgpWN/gk32eetMFazGw=;
        b=dlYmr8ridtoVVd50wVwkzJh3E+LJSZSELrx3aCV1KzavKERuiXMfTf8S5Zfn+hqKayqSxU
        G6L91i0NtNoES/pQecZsmrNi4OLzFbo8b2QUs7Pe80MUfmpR2TdMYD2MM3Ant9uWov/QwC
        54zMlGy/YEZnLP0r3qGzTHXQ0Hqud/I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0107AAF45;
        Thu, 22 Apr 2021 07:50:06 +0000 (UTC)
Date:   Thu, 22 Apr 2021 09:49:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, l.stach@pengutronix.de,
        LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <OSalvador@suse.com>
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
Message-ID: <YIEqpIOAyrs26soC@dhcp22.suse.cz>
References: <dbdf7b8c-9165-f87c-92d4-cfb5a4f01221@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbdf7b8c-9165-f87c-92d4-cfb5a4f01221@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cc David and Oscar who are familiar with this code as well.

On Wed 21-04-21 11:36:01, Florian Fainelli wrote:
> Hi all,
> 
> I have been trying for the past few days to identify the source of a
> performance regression that we are seeing with the 5.4 kernel but not
> with the 4.9 kernel on ARM64. Testing something newer like 5.10 is a bit
> challenging at the moment but will happen eventually.
> 
> What we are seeing is a ~3x increase in the time needed for
> alloc_contig_range() to allocate 1GB in blocks of 2MB pages. The system
> is idle at the time and there are no other contenders for memory other
> than the user-space programs already started (DHCP client, shell, etc.).
> 
> I have tried playing with the compact_control structure settings but
> have not found anything that would bring us back to the performance of
> 4.9. More often than not, we see test_pages_isolated() returning an
> non-zero error code which would explain the slow down, since we have
> some logic that re-tries the allocation if alloc_contig_range() returns
> -EBUSY. If I remove the retry logic however, we don't get -EBUSY and we
> get the results below:
> 
> 4.9 shows this:
> 
> [  457.537634] allocating: size: 1024MB avg: 59172 (us), max: 137306
> (us), min: 44859 (us), total: 591723 (us), pages: 512, per-page: 115 (us)
> [  457.550222] freeing: size: 1024MB avg: 67397 (us), max: 151408 (us),
> min: 52630 (us), total: 673974 (us), pages: 512, per-page: 131 (us)
> 
> 5.4 show this:
> 
> [  222.388758] allocating: size: 1024MB avg: 156739 (us), max: 157254
> (us), min: 155915 (us), total: 1567394 (us), pages: 512, per-page: 306 (us)
> [  222.401601] freeing: size: 1024MB avg: 209899 (us), max: 210085 (us),
> min: 209749 (us), total: 2098999 (us), pages: 512, per-page: 409 (us)
> 
> This regression is not seen when MIGRATE_CMA is specified instead of
> MIGRATE_MOVABLE.
> 
> A few characteristics that you should probably be aware of:
> 
> - There is 4GB of memory populated with the memory being mapped into the
> CPU's address starting at space at 0x4000_0000 (1GB), PAGE_SIZE is 4KB
> 
> - there is a ZONE_DMA32 that starts at 0x4000_0000 and ends at
> 0xE480_0000, from there on we have a ZONE_MOVABLE which is comprised of
> 0xE480_0000 - 0xfdc00000 and another range spanning 0x1_0000_0000 -
> 0x1_4000_0000
> 
> Attached is the kernel configuration.
> 
> Thanks!
> -- 
> Florian



-- 
Michal Hocko
SUSE Labs
