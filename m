Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B0C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42A620FC3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qONrOZ7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHXJvo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgHXJve (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:34 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712AEC061574
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:34 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a127so4102352vsd.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ye9+qKFbsMFveiix/CbGAMUuGY5KIVCJ33W9v6lnAlw=;
        b=qONrOZ7EHD7CCNP1anCs1Hek1QNF665bosrIamiK1TQpaGgl5O+TbeIeyLeOq4jar/
         q6yjRxk5nUEhb441yehDvnI193qNPq/tZtVgjmBSWvnWlF9oAy5rVZLKZ4rku+zQHQSx
         Xm5bSJyMOfmaK3eO7xiwZSpwa/oxVIymrNS3l1xJtFbssQ+ky62E7ADQ9/4T+kourMze
         fEkVPg0nQN5PifHhcit+PhMoCbTzl/6wG22q/Q45MW3TVFLL13m9INa1VVUz7jwKINT/
         m6OsjQlvKOsN5XHW3dnmcloW4pzLQprlZXAQUmilV4qu2zCrfTKwmU7s4SgSh9k5QvKi
         d9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ye9+qKFbsMFveiix/CbGAMUuGY5KIVCJ33W9v6lnAlw=;
        b=GK+4qAHYUe465eihj/xeYbgAmln4kuuYmXVtj1xMxvTn3+3frmWynJ9glG2HXkgwYo
         rIABnS75IUCEoAlHFtmooX4K4tx80uow2JQ6JIv6FYIG1p9zXxPqTYWxvOP/TP5IYsXI
         FTLaP1CgQG+gQwz70YK3FgdZ8cWji7v0MORvX+7iAlSLceMOL0utXzhGhvNlklVehHZz
         hPRnvXU5MtEWtGzxi8D8wT7TcjOz8X67EEujZpQZVc3HphsCcNZaZRcsCfHG0Hb4away
         H/cc2+CoYB30UhGNu3xjrxmZOYPmpnJq7Aj83snbN7NmE4HzVnS+7SrLCXkugd2PHwPE
         mf/w==
X-Gm-Message-State: AOAM530rCgQMJmJnh3gdpj0HRdWa70aExcS1dSPHu7JtmhZUR3HkLS2N
        qqMoWxQL6ZI/fvIwkcULxnmEDMjLBigN+nRgFtHLbA==
X-Google-Smtp-Source: ABdhPJwTxNcMoRKm82fr4/Q4ygmBMhtEFAtZN64L8bM1j2717tZ99in3jeEisGmqasEx/iX4HyL0WhwxxdiygxZo0ic=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr1950040vso.165.1598262693633;
 Mon, 24 Aug 2020 02:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200817115838.2981-1-wsa@kernel.org>
In-Reply-To: <20200817115838.2981-1-wsa@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:56 +0200
Message-ID: <CAPDyKFrE05SMwjGXn+DD-5XxDSKm8b-bFJHG03rqE638JYf9wg@mail.gmail.com>
Subject: Re: [PATCH] mmc: test: remove ambiguity in test description
To:     Wolfram Sang <wsa@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Aug 2020 at 13:58, Wolfram Sang <wsa@kernel.org> wrote:
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> When reading the test description, I thought a correction of the
> xfer_size was tested, which is not the case. It is tested that the
> xfer_size is correct. Use 'proper xfer_size' to remove this ambiguity.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> This may be bike-shedding and I am not offended if you think it is
> minor. However, I ended up looking at the source wondering where is what
> automatically corrected.
>
>  drivers/mmc/core/mmc_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index c21b3cb71775..152e7525ed33 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -2669,22 +2669,22 @@ static const struct mmc_test_case mmc_test_cases[] = {
>         },
>
>         {
> -               .name = "Correct xfer_size at write (start failure)",
> +               .name = "Proper xfer_size at write (start failure)",
>                 .run = mmc_test_xfersize_write,
>         },
>
>         {
> -               .name = "Correct xfer_size at read (start failure)",
> +               .name = "Proper xfer_size at read (start failure)",
>                 .run = mmc_test_xfersize_read,
>         },
>
>         {
> -               .name = "Correct xfer_size at write (midway failure)",
> +               .name = "Proper xfer_size at write (midway failure)",
>                 .run = mmc_test_multi_xfersize_write,
>         },
>
>         {
> -               .name = "Correct xfer_size at read (midway failure)",
> +               .name = "Proper xfer_size at read (midway failure)",
>                 .run = mmc_test_multi_xfersize_read,
>         },
>
> --
> 2.20.1
>
