Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,FSL_HELO_FAKE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F1C6377B
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4415561222
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 21:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGUUbd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:31:33 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:36427 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGUUbc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 16:31:32 -0400
Received: by mail-il1-f172.google.com with SMTP id j5so3544315ilk.3;
        Wed, 21 Jul 2021 14:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6emFuEs+Cp21In58GbbJwSn/QkgwmzlGR4vG5dksQrU=;
        b=fHqRQozQlLm16+S68x9pAgXZqWU61SZ9cVkdLi9r4/W0qoOdCh/5BNcAvGX1deZquH
         HiEB7HJe/HpjwR8mGvGzxGByymugB8jt3xa8VpSPtr9Oi7sc292HEarKJYsMSvVGpyQV
         /f87gPZW+9f0EnSF1ECua/qvRpgzHL2a9uVZwEbQbN4Dg2oqbi4l71maNJeIihAURHH2
         uOmjoVAinPtZs7NLBwl438n40mm12re+gfaSFKs6WDjwn0lA6TzSeFKnitaXZLWhfe+5
         0XE75g01zmzjva0zA6UHlv8SFs3plEAihRi5/eGYLGjdDA5T6Ntl1lTv44yCe8zTaFP7
         UxUw==
X-Gm-Message-State: AOAM530ONICMoDvL5EqTertTV77JV/iVyr3OHWeRLEpeTJq+/NJbzHEC
        JguuZB9VoQ0IChiAyFm0K1E=
X-Google-Smtp-Source: ABdhPJw+v/mzLOME+y3R6DsVrGAphEwkeYEhiqq5wQd4Tls5eb5IU37hEfcf4MYy/BodukOjoVL8EA==
X-Received: by 2002:a92:cdae:: with SMTP id g14mr24613273ild.123.1626901928640;
        Wed, 21 Jul 2021 14:12:08 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id z6sm13825135ilz.54.2021.07.21.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:12:07 -0700 (PDT)
Date:   Wed, 21 Jul 2021 21:12:05 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] bitmap: unify find_bit operations
Message-ID: <YPiNpQskvmuGd/qW@google.com>
References: <20210719021755.883182-1-yury.norov@gmail.com>
 <20210719021755.883182-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719021755.883182-3-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jul 18, 2021 at 07:17:53PM -0700, Yury Norov wrote:
> bitmap_for_each_{set,clear}_region() are similar to for_each_bit()
> macros in include/linux/find.h, but interface and implementation
> of them are different.
> 
> This patch adds for_each_bitrange() macros and drops unused
> bitmap_*_region() API in sake of unification.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c |  2 +-
>  include/linux/bitmap.h               | 41 --------------------
>  include/linux/find.h                 | 56 ++++++++++++++++++++++++++++
>  mm/percpu.c                          | 20 ++++------
>  4 files changed, 65 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index e49ca0f7fe9a..efd33b1fc467 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -647,7 +647,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
>  	 * is at least SH_MOBILE_SDHI_MIN_TAP_ROW probes long then use the
>  	 * center index as the tap, otherwise bail out.
>  	 */
> -	bitmap_for_each_set_region(bitmap, rs, re, 0, taps_size) {
> +	for_each_set_bitrange(rs, re, bitmap, taps_size) {
>  		if (re - rs > tap_cnt) {
>  			tap_end = re;
>  			tap_start = rs;
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 3f7c6731b203..96670abf49bd 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -55,12 +55,6 @@ struct device;
>   *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
>   *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
>   *  bitmap_find_next_zero_area_off(buf, len, pos, n, mask, mask_off)  as above
> - *  bitmap_next_clear_region(map, &start, &end, nbits)  Find next clear region
> - *  bitmap_next_set_region(map, &start, &end, nbits)  Find next set region
> - *  bitmap_for_each_clear_region(map, rs, re, start, end)
> - *  						Iterate over all clear regions
> - *  bitmap_for_each_set_region(map, rs, re, start, end)
> - *  						Iterate over all set regions
>   *  bitmap_shift_right(dst, src, n, nbits)      *dst = *src >> n
>   *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
>   *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
> @@ -459,41 +453,6 @@ static inline void bitmap_replace(unsigned long *dst,
>  		__bitmap_replace(dst, old, new, mask, nbits);
>  }
>  
> -static inline void bitmap_next_clear_region(unsigned long *bitmap,
> -					    unsigned int *rs, unsigned int *re,
> -					    unsigned int end)
> -{
> -	*rs = find_next_zero_bit(bitmap, end, *rs);
> -	*re = find_next_bit(bitmap, end, *rs + 1);
> -}
> -
> -static inline void bitmap_next_set_region(unsigned long *bitmap,
> -					  unsigned int *rs, unsigned int *re,
> -					  unsigned int end)
> -{
> -	*rs = find_next_bit(bitmap, end, *rs);
> -	*re = find_next_zero_bit(bitmap, end, *rs + 1);
> -}
> -
> -/*
> - * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
> - * @rs and @re should be integer variables and will be set to start and end
> - * index of the current clear or set region.
> - */
> -#define bitmap_for_each_clear_region(bitmap, rs, re, start, end)	     \
> -	for ((rs) = (start),						     \
> -	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end));	     \
> -	     (rs) < (re);						     \
> -	     (rs) = (re) + 1,						     \
> -	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end)))
> -
> -#define bitmap_for_each_set_region(bitmap, rs, re, start, end)		     \
> -	for ((rs) = (start),						     \
> -	     bitmap_next_set_region((bitmap), &(rs), &(re), (end));	     \
> -	     (rs) < (re);						     \
> -	     (rs) = (re) + 1,						     \
> -	     bitmap_next_set_region((bitmap), &(rs), &(re), (end)))
> -
>  /**
>   * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
>   * @n: u64 value
> diff --git a/include/linux/find.h b/include/linux/find.h
> index ae9ed52b52b8..5bb6db213bcb 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -301,6 +301,62 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>  	     (bit) < (size);					\
>  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>  
> +/**
> + * for_each_set_bitrange - iterate over all set bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first set bit)
> + * @e: bit offset of end of current bitrange (first unset bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_set_bitrange(b, e, addr, size)			\
> +	for ((b) = find_next_bit((addr), (size), 0),		\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
> +	     (b) < (size);					\
> +	     (b) = find_next_bit((addr), (size), (e) + 1),	\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_set_bitrange_from - iterate over set bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first set bit); must be initialized
> + * @e: bit offset of end of current bitrange (first unset bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_set_bitrange_from(b, e, addr, size)		\
> +	for ((b) = find_next_bit((addr), (size), (b)),		\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
> +	     (b) < (size);					\
> +	     (b) = find_next_bit((addr), (size), (e) + 1),	\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_clear_bitrange - iterate over all unset bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first unset bit)
> + * @e: bit offset of end of current bitrange (first set bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_clear_bitrange(b, e, addr, size)		\
> +	for ((b) = find_next_zero_bit((addr), (size), 0),	\
> +	     (e) = find_next_bit((addr), (size), (b) + 1);	\
> +	     (b) < (size);					\
> +	     (b) = find_next_zero_bit((addr), (size), (e) + 1),	\
> +	     (e) = find_next_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_clear_bitrange_from - iterate over unset bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first unset bit); must be initialized
> + * @e: bit offset of end of current bitrange (first set bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_clear_bitrange_from(b, e, addr, size)		\
> +	for ((b) = find_next_zero_bit((addr), (size), (b)),	\
> +	     (e) = find_next_bit((addr), (size), (b) + 1);	\
> +	     (b) < (size);					\
> +	     (b) = find_next_zero_bit((addr), (size), (e) + 1),	\
> +	     (e) = find_next_bit((addr), (size), (b) + 1))
> +
>  /**
>   * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
>   * @start: bit offset to start search and to store the current iteration offset
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 25461571dcc5..6d518e822983 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -780,7 +780,7 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
>  {
>  	struct pcpu_block_md *block = chunk->md_blocks + index;
>  	unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
> -	unsigned int rs, re, start;	/* region start, region end */
> +	unsigned int start, end;	/* region start, region end */
>  
>  	/* promote scan_hint to contig_hint */
>  	if (block->scan_hint) {
> @@ -796,9 +796,8 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
>  	block->right_free = 0;
>  
>  	/* iterate over free areas and update the contig hints */
> -	bitmap_for_each_clear_region(alloc_map, rs, re, start,
> -				     PCPU_BITMAP_BLOCK_BITS)
> -		pcpu_block_update(block, rs, re);
> +	for_each_clear_bitrange_from(start, end, alloc_map, PCPU_BITMAP_BLOCK_BITS)
> +		pcpu_block_update(block, start, end);
>  }
>  
>  /**
> @@ -1856,13 +1855,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  
>  	/* populate if not all pages are already there */
>  	if (!is_atomic) {
> -		unsigned int page_start, page_end, rs, re;
> +		unsigned int page_end, rs, re;
>  
> -		page_start = PFN_DOWN(off);
> +		rs = PFN_DOWN(off);
>  		page_end = PFN_UP(off + size);
>  
> -		bitmap_for_each_clear_region(chunk->populated, rs, re,
> -					     page_start, page_end) {
> +		for_each_clear_bitrange_from(rs, re, chunk->populated, page_end) {
>  			WARN_ON(chunk->immutable);
>  
>  			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
> @@ -2018,8 +2016,7 @@ static void pcpu_balance_free(bool empty_only)
>  	list_for_each_entry_safe(chunk, next, &to_free, list) {
>  		unsigned int rs, re;
>  
> -		bitmap_for_each_set_region(chunk->populated, rs, re, 0,
> -					   chunk->nr_pages) {
> +		for_each_set_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
>  			pcpu_depopulate_chunk(chunk, rs, re);
>  			spin_lock_irq(&pcpu_lock);
>  			pcpu_chunk_depopulated(chunk, rs, re);
> @@ -2089,8 +2086,7 @@ static void pcpu_balance_populated(void)
>  			continue;
>  
>  		/* @chunk can't go away while pcpu_alloc_mutex is held */
> -		bitmap_for_each_clear_region(chunk->populated, rs, re, 0,
> -					     chunk->nr_pages) {
> +		for_each_clear_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
>  			int nr = min_t(int, re - rs, nr_to_pop);
>  
>  			spin_unlock_irq(&pcpu_lock);
> -- 
> 2.30.2
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
