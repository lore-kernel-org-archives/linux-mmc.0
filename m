Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF8C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B89A60F0F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhHDKIR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhHDKIK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 06:08:10 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D0C0613D5
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 03:07:58 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id e4so695555vsr.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YS4uZAFallHLfbwvhv2xkqNIThLgrdg7qeYX+eKugZo=;
        b=i251XH69Alx9xbE7hFAMa25BxxV4LTVV1up+xr9TJuQEke1d1PYFIXB0z2wBhzxYj3
         CLnpthEdnVbdaGnC/S9NryWSaYr+pJJMu1lFQ4Vg11XAULA1SARz3s0o5uyr92VK3iwp
         O7yEVoY9WgTbzTFgWYeb+iCTk5pHOiuV9XDORQeIv8Z1unS3VcKOJHL6lzOqX0R5NpVA
         04av+fbpiQ2uKcCQhl9iJSud/FJORqvWql2YT8UfdZZoZm3zgMLWL08NhkSIEhLSUV/p
         +i07V4LkDK8j5GYZFG3OP2EkEQNxBPNSH+Pd1VwVX1uG8HU5kAfoG1VIfPn2NNiMkJAR
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YS4uZAFallHLfbwvhv2xkqNIThLgrdg7qeYX+eKugZo=;
        b=gjmu5CFx9fq+fJm1Fht5Ji3AX98o61tR0aoad47ZI8ywiZLW75B1EYHgPkajdaUcx3
         ndJrWWviX4DzF2t29CUshUv4a+tyz0OheS4PtrczvFxUUT2+I+tFvF9TK9T/1uiVPbSZ
         UqWT75n7LFztEw25LIRxagZQnQZxHCoBCG7DM0QrHkWpiM7tEyLGjCANL5F+AKgASz6b
         lgERwv6NyZeL1szYHXMWqKtzhkdv4ZFVNNNKUqOFirjejG3JVwq6Xm92/ExmjaSDopNd
         DnZdTGh0gSja77MUl9WjXGVdUFYGgJw6pNaGoS+X5GrU3AGcUlZtGkY55s+pR8QyqmO9
         pRKA==
X-Gm-Message-State: AOAM530wZPkWOTGuC2Ayoro/5dKtpq8yzs43fxzJZVfN5NGbV+dzxOX/
        1NcC95EVSm66TXucZHVOmuVTJG5W30XTeVL0Z0qc6w==
X-Google-Smtp-Source: ABdhPJzGbYTPUlcNV2yKgffmjt5Gjbrv4RybsDH3+k9p1kvwLrWKuoadWWQ1lfzeHhmzh4/fhtIpXn8YambfqRJ2Erk=
X-Received: by 2002:a67:328f:: with SMTP id y137mr16966613vsy.34.1628071677236;
 Wed, 04 Aug 2021 03:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210719021755.883182-1-yury.norov@gmail.com> <20210719021755.883182-3-yury.norov@gmail.com>
In-Reply-To: <20210719021755.883182-3-yury.norov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 12:07:21 +0200
Message-ID: <CAPDyKFrdR15QFLEqvzJui63MtvWrda_OuFoVsW0WmRax1EWR6w@mail.gmail.com>
Subject: Re: [PATCH 2/4] bitmap: unify find_bit operations
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-mmc <linux-mmc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Jul 2021 at 04:18, Yury Norov <yury.norov@gmail.com> wrote:
>
> bitmap_for_each_{set,clear}_region() are similar to for_each_bit()
> macros in include/linux/find.h, but interface and implementation
> of them are different.
>
> This patch adds for_each_bitrange() macros and drops unused
> bitmap_*_region() API in sake of unification.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe

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
>          * is at least SH_MOBILE_SDHI_MIN_TAP_ROW probes long then use the
>          * center index as the tap, otherwise bail out.
>          */
> -       bitmap_for_each_set_region(bitmap, rs, re, 0, taps_size) {
> +       for_each_set_bitrange(rs, re, bitmap, taps_size) {
>                 if (re - rs > tap_cnt) {
>                         tap_end = re;
>                         tap_start = rs;
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
> - *                                             Iterate over all clear regions
> - *  bitmap_for_each_set_region(map, rs, re, start, end)
> - *                                             Iterate over all set regions
>   *  bitmap_shift_right(dst, src, n, nbits)      *dst = *src >> n
>   *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
>   *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
> @@ -459,41 +453,6 @@ static inline void bitmap_replace(unsigned long *dst,
>                 __bitmap_replace(dst, old, new, mask, nbits);
>  }
>
> -static inline void bitmap_next_clear_region(unsigned long *bitmap,
> -                                           unsigned int *rs, unsigned int *re,
> -                                           unsigned int end)
> -{
> -       *rs = find_next_zero_bit(bitmap, end, *rs);
> -       *re = find_next_bit(bitmap, end, *rs + 1);
> -}
> -
> -static inline void bitmap_next_set_region(unsigned long *bitmap,
> -                                         unsigned int *rs, unsigned int *re,
> -                                         unsigned int end)
> -{
> -       *rs = find_next_bit(bitmap, end, *rs);
> -       *re = find_next_zero_bit(bitmap, end, *rs + 1);
> -}
> -
> -/*
> - * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
> - * @rs and @re should be integer variables and will be set to start and end
> - * index of the current clear or set region.
> - */
> -#define bitmap_for_each_clear_region(bitmap, rs, re, start, end)            \
> -       for ((rs) = (start),                                                 \
> -            bitmap_next_clear_region((bitmap), &(rs), &(re), (end));        \
> -            (rs) < (re);                                                    \
> -            (rs) = (re) + 1,                                                \
> -            bitmap_next_clear_region((bitmap), &(rs), &(re), (end)))
> -
> -#define bitmap_for_each_set_region(bitmap, rs, re, start, end)              \
> -       for ((rs) = (start),                                                 \
> -            bitmap_next_set_region((bitmap), &(rs), &(re), (end));          \
> -            (rs) < (re);                                                    \
> -            (rs) = (re) + 1,                                                \
> -            bitmap_next_set_region((bitmap), &(rs), &(re), (end)))
> -
>  /**
>   * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
>   * @n: u64 value
> diff --git a/include/linux/find.h b/include/linux/find.h
> index ae9ed52b52b8..5bb6db213bcb 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -301,6 +301,62 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>              (bit) < (size);                                    \
>              (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>
> +/**
> + * for_each_set_bitrange - iterate over all set bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first set bit)
> + * @e: bit offset of end of current bitrange (first unset bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_set_bitrange(b, e, addr, size)                        \
> +       for ((b) = find_next_bit((addr), (size), 0),            \
> +            (e) = find_next_zero_bit((addr), (size), (b) + 1); \
> +            (b) < (size);                                      \
> +            (b) = find_next_bit((addr), (size), (e) + 1),      \
> +            (e) = find_next_zero_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_set_bitrange_from - iterate over set bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first set bit); must be initialized
> + * @e: bit offset of end of current bitrange (first unset bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_set_bitrange_from(b, e, addr, size)           \
> +       for ((b) = find_next_bit((addr), (size), (b)),          \
> +            (e) = find_next_zero_bit((addr), (size), (b) + 1); \
> +            (b) < (size);                                      \
> +            (b) = find_next_bit((addr), (size), (e) + 1),      \
> +            (e) = find_next_zero_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_clear_bitrange - iterate over all unset bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first unset bit)
> + * @e: bit offset of end of current bitrange (first set bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_clear_bitrange(b, e, addr, size)              \
> +       for ((b) = find_next_zero_bit((addr), (size), 0),       \
> +            (e) = find_next_bit((addr), (size), (b) + 1);      \
> +            (b) < (size);                                      \
> +            (b) = find_next_zero_bit((addr), (size), (e) + 1), \
> +            (e) = find_next_bit((addr), (size), (b) + 1))
> +
> +/**
> + * for_each_clear_bitrange_from - iterate over unset bit ranges [b; e)
> + * @b: bit offset of start of current bitrange (first unset bit); must be initialized
> + * @e: bit offset of end of current bitrange (first set bit)
> + * @addr: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_clear_bitrange_from(b, e, addr, size)         \
> +       for ((b) = find_next_zero_bit((addr), (size), (b)),     \
> +            (e) = find_next_bit((addr), (size), (b) + 1);      \
> +            (b) < (size);                                      \
> +            (b) = find_next_zero_bit((addr), (size), (e) + 1), \
> +            (e) = find_next_bit((addr), (size), (b) + 1))
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
>         struct pcpu_block_md *block = chunk->md_blocks + index;
>         unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
> -       unsigned int rs, re, start;     /* region start, region end */
> +       unsigned int start, end;        /* region start, region end */
>
>         /* promote scan_hint to contig_hint */
>         if (block->scan_hint) {
> @@ -796,9 +796,8 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
>         block->right_free = 0;
>
>         /* iterate over free areas and update the contig hints */
> -       bitmap_for_each_clear_region(alloc_map, rs, re, start,
> -                                    PCPU_BITMAP_BLOCK_BITS)
> -               pcpu_block_update(block, rs, re);
> +       for_each_clear_bitrange_from(start, end, alloc_map, PCPU_BITMAP_BLOCK_BITS)
> +               pcpu_block_update(block, start, end);
>  }
>
>  /**
> @@ -1856,13 +1855,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>
>         /* populate if not all pages are already there */
>         if (!is_atomic) {
> -               unsigned int page_start, page_end, rs, re;
> +               unsigned int page_end, rs, re;
>
> -               page_start = PFN_DOWN(off);
> +               rs = PFN_DOWN(off);
>                 page_end = PFN_UP(off + size);
>
> -               bitmap_for_each_clear_region(chunk->populated, rs, re,
> -                                            page_start, page_end) {
> +               for_each_clear_bitrange_from(rs, re, chunk->populated, page_end) {
>                         WARN_ON(chunk->immutable);
>
>                         ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
> @@ -2018,8 +2016,7 @@ static void pcpu_balance_free(bool empty_only)
>         list_for_each_entry_safe(chunk, next, &to_free, list) {
>                 unsigned int rs, re;
>
> -               bitmap_for_each_set_region(chunk->populated, rs, re, 0,
> -                                          chunk->nr_pages) {
> +               for_each_set_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
>                         pcpu_depopulate_chunk(chunk, rs, re);
>                         spin_lock_irq(&pcpu_lock);
>                         pcpu_chunk_depopulated(chunk, rs, re);
> @@ -2089,8 +2086,7 @@ static void pcpu_balance_populated(void)
>                         continue;
>
>                 /* @chunk can't go away while pcpu_alloc_mutex is held */
> -               bitmap_for_each_clear_region(chunk->populated, rs, re, 0,
> -                                            chunk->nr_pages) {
> +               for_each_clear_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
>                         int nr = min_t(int, re - rs, nr_to_pop);
>
>                         spin_unlock_irq(&pcpu_lock);
> --
> 2.30.2
>
