From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test: fix performance tests that go over max_blk_count
Date: Fri, 10 Sep 2010 21:39:57 +0100
Message-ID: <20100910203957.GA2966@void.printf.net>
References: <4C89ED69.8000301@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57483 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab0IJUkC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 16:40:02 -0400
Content-Disposition: inline
In-Reply-To: <4C89ED69.8000301@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Adrian,

On Fri, Sep 10, 2010 at 11:33:45AM +0300, Adrian Hunter wrote:
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Mon, 6 Sep 2010 12:54:06 +0300
> Subject: [PATCH] mmc_test: fix performance tests that go over max_blk_count
>
> The host controller driver limits I/O transfers to maximum
> transfer size, maximum block count, maximum segment size
> and maximum segment count.  The performance tests were
> not obeying these limits which meant they would not work
> with some drivers.  This patch fixes that.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>

Thanks, applied to mmc-next.

My test machine (Dell m6300, Sandisk Extreme III 4GB) no longer BUG()s,
but it's still failing all of the transfer tests:

mmc0: Test case 22. Multi-block highmem read...
mmc0: Result: OK
mmc0: Test case 23. Best-case read performance...
mmc0: Result: Prepare stage failed! (-12)
mmc0: Test case 24. Best-case write performance...
mmc0: Result: Prepare stage failed! (-12)
mmc0: Test case 25. Best-case read performance into scattered pages...
mmc0: Result: Prepare stage failed! (-12)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
