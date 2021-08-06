Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C33CC4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E99760EEA
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbhHFNIL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbhHFNIL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 09:08:11 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C11C06179A
        for <linux-mmc@vger.kernel.org>; Fri,  6 Aug 2021 06:07:55 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id d20so2522358vso.8
        for <linux-mmc@vger.kernel.org>; Fri, 06 Aug 2021 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAkFgA6ayFCQ35+fxkCF9bjG6/D1dToRvqM+H1Um3y4=;
        b=d8GSk8vNGP4g1KnQ6vn8HV0XbO1MFJsevfH7fq1mX7kJ5wGKdj7J/WauQrDk9xAzw5
         JD2iLzDnjYZSzN/zcGfDrxjl221GgkHTQpb37J+kUviAiWakqW5r+peQ628Lg5ILpKJW
         v+xz4eb0Nh0cycE5VlFQZ5lWWYXvx5z3I+DZ89KVDp+xWyV00a9JeoK+yOl54KtrhCZQ
         dff7dRQ+y63TvI6Ab0PaokLc4QcDWe4EnxlvzwM6gQyZQbiWHsXlJuRU0eUsno9xW5VL
         3FDlZLBuqMjVTZZtI6+mMpGMxEL+lkZdpl8oFG814nX7MDmKwBC2+FI/7f6ZoAkQ7EKl
         WDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAkFgA6ayFCQ35+fxkCF9bjG6/D1dToRvqM+H1Um3y4=;
        b=iIwpSnKWrRBT+nXUYSjf8Z1ZypbAw6qHW61Jj4/477NUI1UNBZu/kH7QRiJ7pUVClP
         OYKATg13NXgnNRT/K44lCTzqtQhE8dG0dENdMMiNkdZtNMepccbp/BuwOJJkczSBWDtm
         wegWOuCoLH+TlWOCOkwqfl5+hFa4ewB+TxDqTUMzgrcnBQiOCdomCLx1aIJAq9DKRc4A
         2VkOuvnuO2UpzVMw5Xbpnx+Jwx5et7HfaCtbXqBuJeIumevY8rqGAPW8hN+ZUFzGg0fo
         OrvH9Ff4fW9dhNC9Tclj5fkmmo7qPTacbyBS5URWOtcKNC8UenxRTJE8cnTMukk5rUbf
         fFYw==
X-Gm-Message-State: AOAM531u028+SLiPo58xDVHw1XzAglLvvP4Rhu9f5EaSMoKEYUFQ0THa
        xxLOhmWn65VvDOJAJNPp8XaVnKLw6fMI16rfY/8qng==
X-Google-Smtp-Source: ABdhPJyjQaYrSUWr+Z6bMmgeC3I1HQ7Ic4G79Y7CFOiMvN5VcHtZ/DRWy4T083Q7Ken98y0vPa52raI9qCNdo8YZxYY=
X-Received: by 2002:a67:328f:: with SMTP id y137mr9009010vsy.34.1628255274831;
 Fri, 06 Aug 2021 06:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210728103254.171546-1-colin.king@canonical.com>
In-Reply-To: <20210728103254.171546-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 15:07:18 +0200
Message-ID: <CAPDyKFq89jK0K09HBwn8Wi5bMYh8b61TrvihPsrE=EfT50ztqQ@mail.gmail.com>
Subject: Re: [PATCH] ms_block: Fix spelling contraction "cant" -> "can't"
To:     Colin King <colin.king@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Jul 2021 at 12:32, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 4a4573fa7b0f..acf36676e388 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1105,7 +1105,7 @@ static u16 msb_get_free_block(struct msb_data *msb, int zone)
>         dbg_verbose("result of the free blocks scan: pba %d", pba);
>
>         if (pba == msb->block_count || (msb_get_zone_from_pba(pba)) != zone) {
> -               pr_err("BUG: cant get a free block");
> +               pr_err("BUG: can't get a free block");
>                 msb->read_only = true;
>                 return MS_BLOCK_INVALID;
>         }
> --
> 2.31.1
>
