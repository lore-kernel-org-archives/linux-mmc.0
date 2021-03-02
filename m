Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E5C433DB
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B62D61606
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhCCBp6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349582AbhCBKke (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:40:34 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDBC061224
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:41 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id v123so6150759vsv.9
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCb17pJqYLYOaPlH3RafC0Z7t2deRH5mcAjGJbewryc=;
        b=qqeRzipCVUOWpEdfEdKar8PHGPfM1QIM1ZgyCxk1PnH7MQgJQ8C76Lsrrl3IzglLIU
         B9bKtKJK+5OFt7868weyALgwInxoemwx+fneJUyYJ6cXGefqw9w97DCu2k4irL7W4wOa
         KD2Tx2f1moChCfPiDGUSwYm64EItEL15YDot8KU/wiEWHluz7+b/EByswO71Pas0ANaH
         Q9eTwD4y0RbcrgszHFgDZQOLbtC6R8tvUIVDeNNAmNgiCLiQUzUvwrErKA7Ud6x4w94/
         5mYCMj4Pxs0dc9b1PsRSI9LtOKU2yB36qL5oIFs7kSGZnJCCDHhu8PobnTbRn8MKoZpH
         tWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCb17pJqYLYOaPlH3RafC0Z7t2deRH5mcAjGJbewryc=;
        b=n7OQTQx4XIz4AkgM8Z7LOvvO8IlTKrsh6od6SYtj8UD2epsAuUprexrk1A6eYcTTpu
         5Vrzls+T9kUliEI7u8IWTsjrH1zTh4Ci1duMMZ9LW9mPMtB9Br/EHOjWv6QkoAEqrteS
         ohRCEgryzh/1CJlKDCqftdhmhI/PCRqW2arhL2F+C2knwWRNEv0z0KvBADZitrVctU0V
         UWJq6PMUvLnYTblZHRF/GH+wcfo4fr6L4ca2mbLHStkjfP+E0AZC9BN6nlBlQGmTtDqL
         /DRuCDmric8E4vG2t0Y4j1fvkFyS/7XaDecMb5bCiuLAg9CN/HDWFdzSM8nmeGgxK9PU
         yOLQ==
X-Gm-Message-State: AOAM533rQRB8bfgZK/SVF7aUj51LaCZYlt7/dsCGr4IUWGjNJxPBW/3M
        a1GN9V4WDPCb8bmehZHq1ahovvSGPSVctBTFFHjAAQ==
X-Google-Smtp-Source: ABdhPJyt7fGxKlN7AIitumSlgOzSjEEq6tP8RwG5BaWlh5w0HakijpiesHmhGiDz5MYNmAvWSbs58gyE0CHMa4a5K+U=
X-Received: by 2002:a67:8c6:: with SMTP id 189mr1540600vsi.55.1614681580546;
 Tue, 02 Mar 2021 02:39:40 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1@epcas1p3.samsung.com>
 <20210222083156.19158-1-sh043.lee@samsung.com>
In-Reply-To: <20210222083156.19158-1-sh043.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:04 +0100
Message-ID: <CAPDyKFqtB3WLD5A+5SesyOArbbVaZROdeu23FwFDy667h0M6eQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: set read only with permanent write protect
To:     Seunghui Lee <sh043.lee@samsung.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        Chanwoo Lee <cw9316.lee@samsung.com>, sh8267.baek@samsung.com,
        wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Feb 2021 at 09:15, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> Some of SD cards sets permanent write protection
> due to lifespan or internal problem.
> Host can find out it's protected permanantly during initialization.
> Once set read only during initialization,
> it could prevent unnecessary write operation in it.
>
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6fa51a6ed058..2c48d6504101 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -135,6 +135,9 @@ static int mmc_decode_csd(struct mmc_card *card)
>                         csd->erase_size = UNSTUFF_BITS(resp, 39, 7) + 1;
>                         csd->erase_size <<= csd->write_blkbits - 9;
>                 }
> +
> +               if (UNSTUFF_BITS(resp, 13, 1))
> +                       mmc_card_set_readonly(card);
>                 break;
>         case 1:
>                 /*
> @@ -169,6 +172,9 @@ static int mmc_decode_csd(struct mmc_card *card)
>                 csd->write_blkbits = 9;
>                 csd->write_partial = 0;
>                 csd->erase_size = 1;
> +
> +               if (UNSTUFF_BITS(resp, 13, 1))
> +                       mmc_card_set_readonly(card);
>                 break;
>         default:
>                 pr_err("%s: unrecognised CSD structure version %d\n",
> --
> 2.29.0
>
