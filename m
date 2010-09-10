From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test: fix performance tests that go over max_blk_count
Date: Fri, 10 Sep 2010 16:29:04 +0100
Message-ID: <20100910152904.GA31914@void.printf.net>
References: <4C89ED69.8000301@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56049 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab0IJP3Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 11:29:16 -0400
Content-Disposition: inline
In-Reply-To: <4C89ED69.8000301@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Adrian,

On Fri, Sep 10, 2010 at 11:33:45AM +0300, Adrian Hunter wrote:
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -56,7 +56,9 @@ struct mmc_test_mem {
>  * struct mmc_test_area - information for performance tests.
>  * @max_sz: test area size (in bytes)
>  * @dev_addr: address on card at which to do performance tests
> - * @max_segs: maximum segments in scatterlist @sg
> + * @max_tfr: maximum transfer size allowed by driver (in bytes)
> + * @max_segs: maximum segments allowed by driver in scatterlist @sg
> + * @max_seg_sz: maximum segment size allowed by driver
>  * @blocks: number of (512 byte) blocks currently mapped by @sg
>  * @sg_len: length of currently mapped scatterlist @sg
>  * @mem: allocated memory
> @@ -65,7 +67,9 @@ struct mmc_test_mem {
> struct mmc_test_area {
> 	unsigned long max_sz;
> 	unsigned int dev_addr;
> +	unsigned int max_tfr;
> 	unsigned int max_segs;
> +	unsigned int max_seg_sz;
> 	unsigned int blocks;
> 	unsigned int sg_len;
> 	struct mmc_test_mem *mem;

This patch is corrupt, I think due to missing leading spaces on context
lines; it's suspicious that the first hunk doesn't line up properly.
Could you check and resend?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
