From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test: fix performance tests that go over max_blk_count
Date: Sun, 12 Sep 2010 00:47:07 +0100
Message-ID: <20100911234706.GA14042@void.printf.net>
References: <4C89ED69.8000301@nokia.com> <20100910203957.GA2966@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45615 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886Ab0IKXrQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Sep 2010 19:47:16 -0400
Content-Disposition: inline
In-Reply-To: <20100910203957.GA2966@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Adrian,

On Fri, Sep 10, 2010 at 09:39:57PM +0100, Chris Ball wrote:
> My test machine (Dell m6300, Sandisk Extreme III 4GB) no longer BUG()s,
> but it's still failing all of the transfer tests:
> 
> mmc0: Test case 22. Multi-block highmem read...
> mmc0: Result: OK
> mmc0: Test case 23. Best-case read performance...
> mmc0: Result: Prepare stage failed! (-12)

Tracked this down a little farther.  mmc_test_alloc_mem() is bailing
out here:

                if (mem->cnt >= max_segs) {
                        if (page_cnt < min_page_cnt)
                                goto out_free;
                        break;
                }

with vars mem->cnt=1, max_segs=1, page_cnt=0, min_page_cnt=16.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
