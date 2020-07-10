Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76AC433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CE3207FF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 07:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0p4lCNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGJH31 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgGJH3Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 03:29:25 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA62C08E6DC
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2020 00:29:25 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g4so1519905uaq.10
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2020 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTkYNwGzgj0pnyOd6/mQEfIDNv2BJD5cxzVN7vZlhGA=;
        b=y0p4lCNYaKfzGKjhuYKHtmPHT4iXqEDmIgWN26ISyxSxBt81oHuLSHNxKPhgM3L/nj
         cgLPf7XjGdPg1QTdRrEN1F1mm2xssHUcybsGXU4wkzDoKlHK8Ad8IQ1iKHPyEJSiAR5w
         GSxgKc54e4fGLzDhC0xe/dZTQApa03txbWo0ZpFRlW4LCc73VeVAaB2QY/87tdBJSjzO
         uvgQ9qau4PFqv/MGUE+C/Eh7jd/56qMSpqMBtwhQXgUEImjRD1RswdC5dV2LZdHVlpVJ
         F4sZRiuB915rWbtTKX/KoId0n77xzcEYdmc75oWqbZ8SoIo9cBsEDPZ9DVnmV9PV7+eU
         btAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTkYNwGzgj0pnyOd6/mQEfIDNv2BJD5cxzVN7vZlhGA=;
        b=ClFAmo7f/XHo0/gZ0MSkClAditeRr1pIoMhsV0F3l1vFgRM4mZJqXT5gmjx4biLL2T
         Z0UNel5DpbSjyKN8ZjAp+F1JC1Y463WdFYAyAB4pY+1QQFOLAIv+0Xfbc//+0en2JeeJ
         KCXbgF5f1304jg+ZSdTZpBb5sNz/9FC+kCxDZdYJIM5JmHGJWIn4I+F/zKbVz0zw+d1i
         uGYRt1uyHRYWA+E5hPULlo/9PduE+wmEKYX54FaWYai7OAxY9raKTvt1FYanEsT4pxBz
         Dn9hwu4IR6B8lhQnsb5FzJ3DcIAjgVUrwazpO9mSW35BDeZCxzOA8AIw8D/oulAz1hoh
         4hqQ==
X-Gm-Message-State: AOAM530AqLiNgL8t0OxQxCnTPf7DeOASM5SUkB6EKilGwwrL98DIvUw3
        Fpnv3RfnnD166yiiDzqxIekMrlj3TcUVdo3WnovuKQ==
X-Google-Smtp-Source: ABdhPJxHNlCLh9CShjrDdywo7NsnP0aoWUv878oapDo31qCG/k1VUc7yJ0S59pkOnASjsky1KC/KK1QIO9xbZzpbFaw=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr57659956uah.100.1594366164126;
 Fri, 10 Jul 2020 00:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-7-hch@lst.de>
In-Reply-To: <20200708122546.214579-7-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 09:28:47 +0200
Message-ID: <CAPDyKFqgHXAmc1k3BTpfUOW_iDWtyqWEcy3vRfZ3Lv3WaJwnBQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: remove the call to check_disk_change
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jul 2020 at 14:41, Christoph Hellwig <hch@lst.de> wrote:
>
> The mmc driver doesn't support event notifications, which means
> that check_disk_change is a no-op.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4791c82f8f7c78..fa313b63413547 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -312,10 +312,7 @@ static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
>
>         mutex_lock(&block_mutex);
>         if (md) {
> -               if (md->usage == 2)
> -                       check_disk_change(bdev);
>                 ret = 0;
> -
>                 if ((mode & FMODE_WRITE) && md->read_only) {
>                         mmc_blk_put(md);
>                         ret = -EROFS;
> --
> 2.26.2
>
