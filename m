Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,FSL_HELO_FAKE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA501C6377C
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F5361411
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGUU1t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:27:49 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37566 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhGUU1q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 16:27:46 -0400
Received: by mail-io1-f44.google.com with SMTP id r18so3954831iot.4;
        Wed, 21 Jul 2021 14:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7heAi6SLnU26NM0WzqQ+MseadYPmrRZaOm1kRLvtmk=;
        b=hF2TrfaMVaxTs2SJZrCBHDc3HtmS/clWu9GfKp7Aa/jxQqj7KRqiDeveAUlRY+Yl9c
         ppco9UMJsf/IEgUFnOAh5M6IQALNd5AQfbxE/AGVhWzLIEg20V2KbVxe2s2TMoVdWZF+
         9LWQjHJxnE9rMZ9z6utu99hMWazKhj2jL3Ph1j11KBY1kyqBUrwROlCJ+odPGXA+wWJQ
         luG4OpbS1lbppQvcaYV0J9wssUWh7gtQenQRGztHDM3Pv5J3JWM0T94sigUMydLfPQa9
         2x1QNBPybQq4mimHAJH9aS9t5O01Huvuy18TiHbkxJn3BwIIY+hNsngcpV0cl6O8eD+q
         6u8w==
X-Gm-Message-State: AOAM533zUO3293QCm1wErcn3oSpnJ0FmSLxCdxMM0V/zA3L2Ks39ndek
        trpg3hhsAL6W/pQZZ1hksho=
X-Google-Smtp-Source: ABdhPJzcyDiP+EZD0ff1DA+BbajK/V110cX7YnJzs6CDyhedpltAd+hOS3MwoMTMMcSKOVSVE0VsaA==
X-Received: by 2002:a05:6638:1608:: with SMTP id x8mr12026410jas.115.1626901701770;
        Wed, 21 Jul 2021 14:08:21 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id l11sm15495000ios.8.2021.07.21.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:59 -0700 (PDT)
Date:   Wed, 21 Jul 2021 21:07:08 +0000
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
Subject: Re: [PATCH 1/4] mm/percpu: micro-optimize pcpu_is_populated()
Message-ID: <YPiMUF/sYpjPSADv@google.com>
References: <20210719021755.883182-1-yury.norov@gmail.com>
 <20210719021755.883182-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719021755.883182-2-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

On Sun, Jul 18, 2021 at 07:17:52PM -0700, Yury Norov wrote:
> bitmap_next_clear_region() calls find_next_zero_bit() and find_next_bit()
> sequentially to find a range of clear bits. In case of pcpu_is_populated()
> there's a chance to return earlier if bitmap has all bits set.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  mm/percpu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7f2e0151c4e2..25461571dcc5 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1071,17 +1071,18 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
>  static bool pcpu_is_populated(struct pcpu_chunk *chunk, int bit_off, int bits,
>  			      int *next_off)
>  {
> -	unsigned int page_start, page_end, rs, re;
> +	unsigned int start, end;
>  
> -	page_start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
> -	page_end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
> +	start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
> +	end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
>  
> -	rs = page_start;
> -	bitmap_next_clear_region(chunk->populated, &rs, &re, page_end);
> -	if (rs >= page_end)
> +	start = find_next_zero_bit(chunk->populated, end, start);
> +	if (start >= end)
>  		return true;
>  
> -	*next_off = re * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
> +	end = find_next_bit(chunk->populated, end, start + 1);
> +
> +	*next_off = end * PAGE_SIZE / PCPU_MIN_ALLOC_SIZE;
>  	return false;
>  }
>  
> -- 
> 2.30.2
> 

Sorry for the delay.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
