Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E3DC433E1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4B961981
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhCaJlb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhCaJlK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:10 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C546C061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:10 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id r12so5957195vsj.5
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlLmCetbgQB/jj+Um7Az+TREw8kej9RwKfQlp4imP+k=;
        b=VGnCFANCnDmR33gltWuvqkHDYfZ7Fjg5Bw9uGzZpEivkFM9adDAj5/mh3t7/vfVha1
         GqEnqoJIvuu3ThYE6IRzaxmC2NuL31qnC/H5Yq/xyD/V/lC0k6mnEaStbLOzoKGHmD6p
         m4DfD/HAAbtYZ+CcdDLd7hnn4H0kqdwLe91n2YfsG6TZ3uBfHnKN+WkjkKY4E/WzUK3m
         86o9R+sPLpKV20HJQ/wX2d6jsXdrej0g+84vXExh7Q3EOWyNhyrf7z3NKog20sOirpbd
         Qhk0HwKtG+CTJMTzJrzgJVOoritvKxxoF7tl4xdoJirJnpKrHDZsTEY/HC2blMnpTdIn
         4SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlLmCetbgQB/jj+Um7Az+TREw8kej9RwKfQlp4imP+k=;
        b=WFdkE4fFrpk06vJH6rovUsA5bPRlYb33WsNYY5CAT8QsvsHkylAFsVhHbqnwMzpXgB
         f1Sae14Hp4N09m8zwpSxOKSa7d8z5k9E537RUgyJNR+u9p6AaWl1EMqt2GYlQdwguE8R
         v7eOJFXifaMUKQdKhZDN+gAZy9xv6ej+lbnW0QTte0td9/ennJmRmO1Zh/ky7aXq6A5L
         a5iSg7LGmVIVzGOl4R8FBtw7CUOKhqavyFhFxB5dWGtE5la43GIxq/2EOclyNyUu4VUC
         9hkJVpD3bUvk3Yw0Pk/QtF5JjLrD23+TTCfbnw4cAjOEGoT4HqJF/HQRMDv20p31aoC5
         QjIg==
X-Gm-Message-State: AOAM531S/Js45dEF1bIJQ4zfwwDWLRxUx96DzLx26RKTzBE082rVPXYI
        Z0SjpQ96+27pCI0dXtnRuLtbCjuoZnnymWS4mYbPBc9S3Lo4lw==
X-Google-Smtp-Source: ABdhPJzC1Yt6mVZirOSE5ZCnCAA7Y/cbUZOQvkTj3vPvsLO0kYYwTsZJQo42Cqh9bRk4g9JsjbrTs9C7Uo4IQzkjKAo=
X-Received: by 2002:a67:6942:: with SMTP id e63mr915124vsc.48.1617183669460;
 Wed, 31 Mar 2021 02:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201216093146.6218-1-john.ernberg@actia.se>
In-Reply-To: <20201216093146.6218-1-john.ernberg@actia.se>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:32 +0200
Message-ID: <CAPDyKFqYb8yCM-SpzEhv5+TbfUfnfsPothXXQYb2kGtjXwgiNQ@mail.gmail.com>
Subject: Re: [PATCH][mmc-utils] rpmb: Zero-init MMC_IOC_MULTI_CMD structures
To:     John Ernberg <john.ernberg@actia.se>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Wed, 16 Dec 2020 at 10:48, John Ernberg <john.ernberg@actia.se> wrote:
>
> On our board we would occationally see what looked like a
> kernel hang while doing RPMB operations, some additional
> printk debugging revealed that in the trouble case data
> such as this was being sent to the kernel:
>
>     [  109.076981] idata[0]->ic->opcode = 0x19
>     [  109.077027] idata[0]->ic->arg = 0x0
>     [  109.080954] idata[0]->ic->write_flag = 0x1
>     [  109.084691] idata[0]->ic->is_acmd = 0x0
>     [  109.089007] idata[0]->ic->flags = 0xb5
>     [  109.092949] idata[0]->ic->blocks = 0x1
>     [  109.096865] idata[0]->ic->blksz = 0x200
>     [  109.100791] idata[0]->ic->postsleep_min_us = 0x7473696e
>     [  109.104745] idata[0]->ic->postsleep_max_us = 0x34383370
>     [  109.110167] idata[0]->ic->data_timeout_ns = 0x7265632d
>     [  109.115494] idata[0]->ic->data_ptr = 00000000e7ddd4cd
>     [  109.120832] idata[0]->rpmb = 00000000ffab5640
>     [  109.126077] idata[1]->ic->opcode = 0x12
>     [  109.130622] idata[1]->ic->arg = 0x0
>     [  109.135451] idata[1]->ic->write_flag = 0x0
>     [  109.139153] idata[1]->ic->is_acmd = 0x0
>     [  109.143437] idata[1]->ic->flags = 0xb5
>     [  109.147553] idata[1]->ic->blocks = 0x1
>     [  109.151420] idata[1]->ic->blksz = 0x200
>     [  109.155251] idata[1]->ic->postsleep_min_us = 0x652d6873
>     [  109.159166] idata[1]->ic->postsleep_max_us = 0x35353264
>     [  109.164561] idata[1]->ic->data_timeout_ns = 0x632d3931
>     [  109.169915] idata[1]->ic->data_ptr = 00000000bc641ed4
>     [  109.175152] idata[1]->rpmb = 00000000ffab5640
>
> Therefor, zero-init the MMC_IOC_MULTI_CMD structures to
> avoid the obscene sleep values.
>
> Signed-off-by: John Ernberg <john.ernberg@actia.se>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..884cdf8 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1922,7 +1922,7 @@ static int do_rpmb_op(int fd,
>
>         /* prepare arguments for MMC_IOC_MULTI_CMD ioctl */
>         mioc = (struct mmc_ioc_multi_cmd *)
> -               malloc(sizeof (struct mmc_ioc_multi_cmd) +
> +               calloc(1, sizeof (struct mmc_ioc_multi_cmd) +
>                        RPMB_MULTI_CMD_MAX_CMDS * sizeof (struct mmc_ioc_cmd));
>         if (!mioc) {
>                 return -ENOMEM;
> --
> 2.29.2
