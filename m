From: Bin Wang <arletoly@gmail.com>
Subject: mmc: sdhci: is d-cache flush required for read requests?
Date: Thu, 7 Jul 2011 14:26:01 +0800
Message-ID: <CAELmcknoHxpWu1+Grf5=Pugw6OnSPfWB7=OGqxf6pt1rsohkwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60713 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1GGG0C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 02:26:02 -0400
Received: by iyb12 with SMTP id 12so594504iyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 23:26:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

I'm working on an ARM V7 SMP processor, with L1 cache set to write allocate.
In the mmc driver, that use the sdhci.c, there's no d-cache flush after the read
requests. Thus in some cases, like pio mode or using the bounce buffer, the
valid data may only in the d-cache after the read requests. If the read data is
instructions,  and the i-cache is not filled from d-cache, the i-cache
may filled with
invalid data from memory, and cause kernel panic in the 2.6.35 kernel.

I found the latest kernel introduced the __sync_icache_dcache() to
handle the i/d
cache sync in a upper layer, and the kernel panic thing goes away after applying
the following patches:

  6012191 ARM: 6380/1: Introduce __sync_icache_dcache() for VIPT caches
  c017780 ARM: 6379/1: Assume new page cache pages have dirty D-cache
  0fc7309 ARM: 6378/1: Allow lazy cache flushing via PG_arch_1 for highmem pages

I'm not sure whether the above patches are enough to handle all the
i/d cache sync
problems.

By the way, I saw  flush_dcache_page() was added to the MTD driver:
  2d4dc89 block: add helpers to run flush_dcache_page() against a bio
and a request's pages

Would someone help to give advise whether I need to flush the d-cache in the
mmc driver?

Thanks,
Bin Wang
