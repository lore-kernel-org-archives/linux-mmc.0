Return-Path: <SRS0=AGpe=AT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E2C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 14:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428D620720
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 14:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQcW7xbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgGHOSL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgGHOSE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jul 2020 10:18:04 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B800C08C5DC
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2020 07:18:04 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s20so17162120vsq.5
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2020 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRR2oJR1zyC/uavTh/YxuWLenLZLmhhz/A0r+ZwnaDk=;
        b=OQcW7xbioXHtmAbx/ip/Tlfp4h7QPUYO95fu9t2pWRbGgWlJdeUbVjfnhrlkb8WbDo
         DuEeB1lMqRZ90j75hQHwVuJhH1GgDEM+TvRUdOlwKpT1wkHK+PCrx4V0ZGYCHmPI+tfN
         UjLCSsrzM3cM8PCZhcfsK7i12HkvY2TIurjbLgTAttoIL23Ns9/mRuf/CWrbyebP+2kV
         qm/QnDQEOKyTcB+HUcFdeDJ/vQfWklXSC7fP+5pxnZvWonHtUicImN5rmgxwg57I3UIl
         nL7HbmxzTse5SSMZ9AoRMyqYF5kLVbJcZ0IFdjtwJa9eMX5SmLx5Qc8Ky0tFlbYpzU2X
         E2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRR2oJR1zyC/uavTh/YxuWLenLZLmhhz/A0r+ZwnaDk=;
        b=Bn63tcbHTgfmmdXuUL3Sz42ix4E32m+1ujG/syjTo0Hx8S3IPzwtVZdyPID0AThJlp
         CLQmA6km2wTBglCWV5Asq9k/5XMEVJ9z6NUoXJCjFBmeHDCoiDK0nenvrVlyRe1y6rNB
         ig3igC7S596Y1Lnb+htkIp5OlFL15WfbJIhMfgI5Aym58R3LZsV6LN2yTsiSidpp/J8/
         r+nl5eR6YHBE8em0ENh3UenKKTPdlTW0iV31F0u5wGVV/H+oosbD1qUDdVWTFKpfffuB
         3jPMjhZ95DVoPxy99yar2OgMGfI7XJcdX9sXNyC705NgGEpfJ264+yyITXL4gTQRL9kQ
         s8cw==
X-Gm-Message-State: AOAM532wZJ53ZaPwmx7VXqGcvnt4BjOLcP6ulDTnU0/fh/vLgaKefMCx
        wATiqjC+RasWbot98cIlppyW6XjVwkBvN7G9bOTHqQ==
X-Google-Smtp-Source: ABdhPJxQJp92VWdX5KqTmVPfmOl1A/gpaTfKOYLxSE9CCWw6fdiJ4zs2Ef7rqDQv+aFRiUZRPmlsdiPFBfzPND4QOJE=
X-Received: by 2002:a67:f888:: with SMTP id h8mr23246530vso.165.1594217883238;
 Wed, 08 Jul 2020 07:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-7-hch@lst.de>
In-Reply-To: <20200708122546.214579-7-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 16:17:26 +0200
Message-ID: <CAPDyKFr5+LRRGMYhWM2At=O9LQSPmFAp0YuQiwmRiV1a6Tx6=g@mail.gmail.com>
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

I can queue this via my mmc tree, but perhaps you have plans for some
additional cleanups on top? In such a case, it may be better that this
goes through Jens' tree?

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
