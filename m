From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmc_test: Add performance tests
Date: Mon, 26 Jul 2010 15:52:34 -0700
Message-ID: <20100726155234.3aca5a83.akpm@linux-foundation.org>
References: <4C49601B.5070900@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51474 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754780Ab0GZWwl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 18:52:41 -0400
In-Reply-To: <4C49601B.5070900@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, 23 Jul 2010 12:25:47 +0300
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> +/*
> + * Allocate a lot of memory, preferrably max_sz but at least min_sz.  In case
> + * there isn't much memory do not exceed 1/16th total RAM.
> + */
> +static struct mmc_test_mem *mmc_test_alloc_mem(unsigned int min_sz,
> +					       unsigned int max_sz)
> +{
> +	unsigned int max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
> +	unsigned int min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
> +	unsigned int page_cnt = 0;
> +	struct mmc_test_mem *mem;
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +	if (max_page_cnt > si.totalram >> 4)
> +		max_page_cnt = si.totalram >> 4;
> +	if (max_page_cnt < min_page_cnt)
> +		max_page_cnt = min_page_cnt;
> +
> +	mem = kzalloc(sizeof(struct mmc_test_mem), GFP_KERNEL);
>
> ...
>
> +		gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
> +				__GFP_NORETRY;
> +
> +		order = get_order(page_cnt << PAGE_SHIFT);
> +		while (1) {
> +			page = alloc_pages(flags, order);
>
> ...
>

struct sysinfo.totalram returns the total number of pages including
highmem.  But a GFP_KERNEL allocation can only return lowmem pages. 
The difference between the two can be 20x (on a 16G i386 box). 
nr_free_buffer_pages() would be a more accurate thing to use.

Also, I worry about overflows here.  For example, `page_cnt <<
PAGE_SHIFT' could overflow the unsigned int?  Please check all of that.
