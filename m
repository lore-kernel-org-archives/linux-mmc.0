Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9403EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jan 2022 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380034AbiAaQHx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349615AbiAaQHv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 11:07:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD0C061744
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:07:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o12so27790114lfg.12
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qc5uFheXk0XaZTfYuE1nZxBYJ9/v+WsFBLbPDZbz7PY=;
        b=U/vrkJJUjzjB48elBk2hfP4kNGT8ELSVcRs0TQlT2Jo+OJ8OFgrw0UblWt2i8Ma9zV
         Kkf3ftSRxkBUe1/9hQUhl3BuvhKY+NU7000oD1Ec0EEOV3sniK1FX+8q/Lu21M/CgJOL
         NTM+uOyd/aKmEvHoTYfy6kCrYlZciBRl6HZVPsEX9jodm4OWL5eHwH8++W8L64sOAqOf
         9j/6u7ytlc8Gi5RBsp758nPJc/AeM8v1RfPnwQ78KljKz+BouG9lNddOhwchnxBbgq16
         QSILW/VPSHzkhk5VWvS4Xtrk9SG0G0fcos926IQ7d1196tE4czaOlUvXSqoxzitXvnv4
         tnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qc5uFheXk0XaZTfYuE1nZxBYJ9/v+WsFBLbPDZbz7PY=;
        b=AGXWsSqvvlrGuBbrxkVcKzGS+zhRhITNFaMozag1DK8RAexsBtXDAAaBVqWoXm2G2K
         l6CsBTIDgbLy6Un8Qu7w3k995yMDVscUTtTk+u38dLSfafhdHXH1ZInmGSQGSLpiMJ1d
         oq8WrsELobvWBBfpeGwuTg1XK/SWu+bO4yvq7oAaeoMJwU52cWrEBwHrAPvpSu1WTdND
         RKGNVOYCvQJM3SvUFlsniRDRIs4SgRAlPxWXS206wNNXeBDjF0qGIkT2lrnVYE+UUxdG
         UvIVUjRuwrsrDgrR8Pczr5ER6AYSdkf8wUzUtuNKOVdr7rQEZlO60GtIq0cWuxpJiz9j
         p0XA==
X-Gm-Message-State: AOAM5333RsQe7puBMWmp/IcwOj0tJoD5jViWYYITk0t5PVXdi7lWgR+w
        ozvsVD3E4Z/0Fh+dX5o5cXBrLxM6cnqjlnniVkFhQQ==
X-Google-Smtp-Source: ABdhPJw/LzqcIwGx3pWlTx8PycHS7Obn8n9Ru3sYnGrV+l2mRnMI+4mOkzlAV/1B8+vSTp8P1jiek1IavKASEg5IwQU=
X-Received: by 2002:ac2:4c08:: with SMTP id t8mr15582685lfq.358.1643645267227;
 Mon, 31 Jan 2022 08:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20220123183925.1052919-1-yury.norov@gmail.com> <20220123183925.1052919-31-yury.norov@gmail.com>
In-Reply-To: <20220123183925.1052919-31-yury.norov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 17:07:10 +0100
Message-ID: <CAPDyKFoJ=1nTYh6rNUQV2X68qE+jJX3OEindnTN_2_J54UVqkA@mail.gmail.com>
Subject: Re: [PATCH 30/54] drivers/memstick: replace bitmap_weight with
 bitmap_weight_eq where appropriate
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <david.laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 23 Jan 2022 at 19:41, Yury Norov <yury.norov@gmail.com> wrote:
>
> msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
> weight of bitmap with a given number. We can do it more efficiently with
> bitmap_weight_eq because conditional bitmap_weight may stop traversing the
> bitmap earlier, as soon as condition is met.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/memstick/core/ms_block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 0cda6c6baefc..5cdd987e78f7 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -155,8 +155,8 @@ static int msb_validate_used_block_bitmap(struct msb_data *msb)
>         for (i = 0; i < msb->zone_count; i++)
>                 total_free_blocks += msb->free_block_count[i];
>
> -       if (msb->block_count - bitmap_weight(msb->used_blocks_bitmap,
> -                                       msb->block_count) == total_free_blocks)
> +       if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
> +                               msb->block_count - total_free_blocks))
>                 return 0;
>
>         pr_err("BUG: free block counts don't match the bitmap");
> --
> 2.30.2
>
