Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68029C4741F
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDF7206DB
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ws10/iKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgKEM7o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgKEM7n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:43 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049BC0613CF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:42 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id f7so693687vsh.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cf6Reenkulcvx1M++5Ft3F89n+TgucGRfAJUzamClvg=;
        b=ws10/iKJk8CyhNwGYsbllaueWggHLsmbWy/ERx4LGC0DAmcxw0jWh5ojrVT+bMKqZ0
         2t3zBnI+FOp4xyiV3Suo3dlXpWLz6bWG7dDiRmoN27iynEgt3w0KGhzyQ3SocRgnsJxC
         s+8zZOJ6WHouDntrP2XqjDagS1cHFcCoRSf86TVyQ7Qv5o3+98iPzshUfMjM+pR0ebU1
         d4ETkZS7VEYG65XgYW7I2yWAROGPP0iReuBeGSa/UgF4leKJ7LhZwIZvMILhOmosnMwq
         ISxh5HWnBGxNQzIoCtrWCt3CmmEr7SKu5+DV8gaquYvhstk2bk3jXu8vBgQwCwv+rexs
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cf6Reenkulcvx1M++5Ft3F89n+TgucGRfAJUzamClvg=;
        b=Q3H4RpdmFpf2eJtJyvY5f77lX4kBkkebtt+K+gVLrMkfamZel+Lih3QSvoVQOv3eOU
         6n+ezXxE36feY6WQCwgxATiUJoEmcqXn0uNMpeyB3mHUL/rRG7lqk28BMrWqh/KFNVF3
         LfOxGSaeU5715/E4TD3SBHdWl7RFll+h6A1EJFs0p0lj/tkfeRA6SGyNTsw/bbUdU5k5
         92SzX1fuDtmNzxTFi+By4IUp3kkzqQI8MKDz1L+fOm3XlCaEfYKuSmWA4B1Hv5H1Tcjo
         LR73x59253sZ6OyIAIFmwvloiDJoP3MGqSWaOAlh1qZSChOpdC7NN95CqvuPpexPaU6J
         zk9Q==
X-Gm-Message-State: AOAM5308w7nkWiYVnMMt/ENtEUt1swN8j68IL+FCJk5Jbz4nLkSmBzWr
        NMvwVIV1zUsdevBAnoLFSR5KDdbhOuPmAgy+Y/D9Yg==
X-Google-Smtp-Source: ABdhPJyALjYk4dc+ZE9nrx+tFiQQuxVnGKZVVOwn967qwn5WyQmkB9fFCK6Gknms9k31ZhzVwlUZP9EveWxT15FLCmA=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr1011201vsp.34.1604581182187;
 Thu, 05 Nov 2020 04:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20201031142756.2140029-1-trix@redhat.com>
In-Reply-To: <20201031142756.2140029-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:06 +0100
Message-ID: <CAPDyKFpgUAoXSptorC-WqRFUHvuuM6=xUSQwBAXwVSMXPn1PzQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: tifm: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Alex Dubov <oakad@yahoo.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 31 Oct 2020 at 15:28, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/tifm_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index 786e46798da2..57145374f6ac 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -528,7 +528,7 @@ static int tifm_ms_set_param(struct memstick_host *msh,
>                 } else
>                         return -EINVAL;
>                 break;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 2.18.1
>
