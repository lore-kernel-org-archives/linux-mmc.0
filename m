Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D61FC4321A
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E6C64F59
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCSONd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCSONU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:13:20 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9FC06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:20 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id o85so2130118vko.8
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxm+/pPcm1XVG4+mY+cSz5OGxQEii57vbnoHpCbdW98=;
        b=oJ3/MhJce5u9An6ttjIoHlmAsPixMOYiHetFbmJFYfotGoZdr9fskv4V4RimusY92P
         4V1keHZZwZ2TGJ1xHxYKlHLCZqNcVw5dXVfyGKVdGy3EvaIj9RV5yuDURurnCKpki4Xg
         TcpON6cB+yzQnTUN89jR+g5p+9P9tvABzK58Lcnc8BQFxhXwiJp+WPzDlxnvvKbebVvu
         lbk06ohMWGQfZZxyjuqjUowAArE+iFx7r1AsZJWuoto6k/RxK/e0eY1nh+ykuD5GiVne
         X6zlnINyPqpUxzO2H5DTIWXUM6l0BeXRk3HuDaIe+HrjceZg6TlYWxaOlwtxua8TZeTR
         5s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxm+/pPcm1XVG4+mY+cSz5OGxQEii57vbnoHpCbdW98=;
        b=alnpHP7DoPsiJajKwya49CAXQvelhcJ6QqdyXogGhcMrc0IL+LydAs+BEKILlojc/K
         LsXUyJRTojQlYxrenwJwgvOSbDoZGYYzoMmS3i4hrB+Q8XvLlSQuwicONqZGWtyk5oUk
         ZxTLP8oEBcG2obEU186PMa7K9WLdkY8EbBZQreRW7/htJKThxqZCiNb8q7z67SJ+/tJg
         5dNTYjnGqGxQF8Js8RhvTPR3kaOwgy8uFYAS3jTIhqPnB3viMmeXRz26gIXYF66aE5f7
         IKPCVwUt5SGKg+Yr1vXYNLvTIPjMSrvNT7N8TGeAmWQNJAsXtzLR6gJW/g389qZAsRLO
         zlUg==
X-Gm-Message-State: AOAM532sfxXuOr8esqCRI/7thy6qMy1eCuqF3JN4jjO12u0TJgrdHQeu
        UAsRv3lZ7cp5vyu9YfoQmRZ5fb52aqmIMLUFTYCkdA==
X-Google-Smtp-Source: ABdhPJx2+SzVQl8imKo0EQ3B+5dXnijhV7xS6mcteSNG7VLsSVEp39ebWCZcfEIb2iQ9RP8ErpC2Xasvz+xL8WNGjiY=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr2765495vkb.7.1616163199593;
 Fri, 19 Mar 2021 07:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210319121357.255176-1-huobean@gmail.com> <20210319121357.255176-2-huobean@gmail.com>
In-Reply-To: <20210319121357.255176-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:42 +0100
Message-ID: <CAPDyKFp4Y-MS_tsNpCS9M8pqm2RoTmMG7=4MYyxZ7ZsnVKKeQw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: cavium: Use '"%s...", __func__' to print
 function name
To:     Bean Huo <huobean@gmail.com>
Cc:     rric@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 19 Mar 2021 at 13:14, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Use preferred way '"%s...", __func__' to print function name.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 4bb8f2800a2b..95a41983c6c0 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -656,8 +656,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>
>         if (!mrq->data || !mrq->data->sg || !mrq->data->sg_len ||
>             !mrq->stop || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
> -               dev_err(&mmc->card->dev,
> -                       "Error: cmv_mmc_dma_request no data\n");
> +               dev_err(&mmc->card->dev, "Error: %s no data\n", __func__);
>                 goto error;
>         }
>
> --
> 2.25.1
>
