Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C0C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiI0MSl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiI0MRy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:17:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EEE3EC1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:17:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so5318087wms.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4ogea3WbGQNROO4GDudodaBubNp8zU7tRTzmzFeN2aU=;
        b=BxOOwgm/6Ld837iwwpgNIpstKEV1EyVj2cWg2z0mhC008QSmLdSZLa11UaSDLUK7uY
         l9V5kh/sxdx7um6yUGrf7kDbEeNlFugibX2fKs7b6LfWuunuUMazDIrCiJA+szeaHIh3
         W4F/5XmrkStgyv+G/3C307l5tv67j0FSfolgPs+iSqfUnfRpJu60B8LVZz75ULDBdaDH
         iQrInFwRH0KnKqr149qQK3Vt0yiEkOV2bvI8sbxSTos46UR2aIFVsYNd6HfRJ91lZk0A
         5pkdtkFciS4zeU+gSMwzD+A1CLvwH/3ZIe8L5TKvJ8BAG+2w6cVDbI+ah1wILoFOv+1d
         +5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4ogea3WbGQNROO4GDudodaBubNp8zU7tRTzmzFeN2aU=;
        b=MWotmB8dmybRyVVoMrjFsoparz02SpTuZXTlswrSgu7afe9xAjtijvWxfgdXv3easq
         8Ikqmi+QHsHngz9Ga5pRsnW5kNOrpEfZ5bKrlbN9tRg496Fp6U6OD9YpxImfSHoPgfGF
         kzbLkA2zKq1+ba2ysDqakcx1cjLsla5+kFfkLMJ7KovHVA/1vf3pnn+HdYsHMyHRUX52
         o6/l4i4OBTJWZAeJioVRCYtyJNO9BR52B+/5sFn6pXG5hFbUtwQbyjZRf8pooFJRa+/J
         A7UOlnesS9T/Ttx4ERBUTzkP8MpsVCPfiSrh7ohixmrGEJ0ztfgC78AuJ7vi4ahp+wlx
         2CHQ==
X-Gm-Message-State: ACrzQf3n44Cd46+VPMK7iXfRS0/9o0N3/v+ClsZ6M+LGHDEEtjTd4e+3
        cvmrik53Tl5gloBasVG0+uVhiF94OGgfLZoDkrC1B7uZlUFn2Q==
X-Google-Smtp-Source: AMsMyM7mHbYck+RPBQ6Ixg32GjtTNI8+8lcZHHGwbNFHcvsLDzau4CgxByHm3tP86XCjR9yHdJzd4Wf3xIEqGSvIZeY=
X-Received: by 2002:a1c:f311:0:b0:3b5:18ca:fc5e with SMTP id
 q17-20020a1cf311000000b003b518cafc5emr2457169wmq.70.1664281069784; Tue, 27
 Sep 2022 05:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220927084317.138-1-avri.altman@wdc.com>
In-Reply-To: <20220927084317.138-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:17:13 +0200
Message-ID: <CAPDyKFpbMQOhANrKR9wkn=Z=KnjodCPpQm4AnTH47T=r8qPuQA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix a typo for ATP mid
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Mark Kanczak <Markk@us.atpinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Sept 2022 at 10:43, Avri Altman <avri.altman@wdc.com> wrote:
>
> Manufacturer id 0x44 is assign to ATP by 3c-LLC, and not to SanDisk.
> mmc-utils inherited this typo when lsmmc got merged into it.
>
> fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)
>
> Reported-by: Mark Kanczak <Markk@us.atpinc.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
>  lsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 05d59e8..55da3aa 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -237,7 +237,7 @@ struct ids_database database[] = {
>         {
>                 .type = "mmc",
>                 .id = 0x44,
> -               .manufacturer = "SanDisk",
> +               .manufacturer = "ATP",
>         },
>         {
>                 .type = "mmc",
> --
> 2.17.1
>
