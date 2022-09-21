Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B67C32771
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 12:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiIUMwL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIUMvp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:51:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ACD8F948
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:50:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g3so9651409wrq.13
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FM+vxX44nNgO4XHdKUVMj1lO4ICRYvIZ+x9h0XyRQRs=;
        b=Z2yPnHtNc+V/Iyvkg4d8YYpVMu2xzJ10lr9AVxSvAL/nMmoqI1rnDI1ZbF31Ha+RD2
         fv+qurGPtuuaiBsLehbfJW2KLlGKQVcMYj9HCEdanohl5cNEyEsN5QqCPLcOGh9Vz+6t
         GN15I7LX4NRhEtqzwcKgTxrPCKS3XXQ80i4HxQObzx+toYm+buMgRIiHPTLBZ4KZwOdq
         ckaW+5INpVNOm/8vV43hOsnuBMQi0KcFY7t/1ypGYTnSAv/17a9qpDEcy0jYvn7MkoX9
         u5UzHYMchDEt1IMcS894377jShzS/2ycmrrDfkQq0Jd0Rn7v19JOtMvAyiW5r4+samJP
         6yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FM+vxX44nNgO4XHdKUVMj1lO4ICRYvIZ+x9h0XyRQRs=;
        b=Oj5/hv0ihBC48mwBYAnnT8OMJO+KG/U0MpAnOYqXe3wMqmAJRgSEmu6XGs2G0MC5/a
         j13gHMSxvNuFboxKS+rgtF5SDbwYC/Rhdt+IIDuqNLaqAfZcSbciO7KH0yvIddV19R6L
         /vqOZ5GYYNbYZdrHkxmNgYtCGCcHX9DNRPp4p9brdkV/XkC5r94y3Lc0RxeQF0dbKVcV
         6+CKSZc05cOeJPFOA8iQ0QTLMCZV5n5UVBeImatYUU3ArBgo528AoQJOfRd41Z1FRFei
         PvBGWDSeu0gSz6DSsITNoyhOmDECMMAxmfdBajl0lDGAMi5tJAPieqxjivIviuY1geax
         Wm6g==
X-Gm-Message-State: ACrzQf1pUM8wvUcRTCI7zHWPvXgcbJ7g7GLQXpYduaEUpVHZ7UzOZIe/
        1lRaSAMWyI+s2vXUXnR5jp81DAx4dmcCXXD6nNUwng==
X-Google-Smtp-Source: AMsMyM4MQ8ws0cGDVGmcXnoUg6zoguO4S7Kizkn1M5ddv8cj9ApHrM9CUSDN1dxelH6lvJ9TYC9GtmWkXiaQqJh/HuE=
X-Received: by 2002:adf:fa52:0:b0:228:9675:e6f3 with SMTP id
 y18-20020adffa52000000b002289675e6f3mr16516007wrr.151.1663764598805; Wed, 21
 Sep 2022 05:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com> <20220918161751.1132590-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20220918161751.1132590-1-giulio.benetti@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:49:22 +0200
Message-ID: <CAPDyKFp6d31oq7E2ZiNCF385Pg3hToHs8V+oj6x2Ftwr3C3b4g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc-utils: fix warning on uninitialized 'cnt'
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-mmc@vger.kernel.org, Avri Altman <Avri.Altman@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 18 Sept 2022 at 18:17, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> When building following warning shows up:
> ```
> In function '__bswap_32',
>     inlined from 'do_rpmb_write_block' at mmc_cmds.c:2293:27:
> /home/autobuild/autobuild/instance-15/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/bits/byteswap.h:52:10: error: 'cnt' may be used uninitialized [-Werror=maybe-uninitialized]
>    52 |   return __builtin_bswap32 (__bsx);
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> mmc_cmds.c: In function 'do_rpmb_write_block':
> mmc_cmds.c:2270:22: note: 'cnt' was declared here
> 2270 |         unsigned int cnt;
>       |                      ^~~
> cc1: all warnings being treated as errors
> ```
> This is due to function rpmb_read_counter() that doesn't set its
> argument 'unsigned int *cnt' in all return points. So let's set
> *cnt to 0 in the return point that misses to initialize it.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
> V1->V2:
> * prefix subject with 'mmc-utils:' as pointed by Avri Altman
> V2->V3:
> * add missing commit as pointed by Avri Altman
> * initialize pointer inside rpmb_read_counter() as suggested by Arnd Bergmann
> ---
>  mmc_cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..4d203ef 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2238,8 +2238,10 @@ int rpmb_read_counter(int dev_fd, unsigned int *cnt)
>         }
>
>         /* Check RPMB response */
> -       if (frame_out.result != 0)
> +       if (frame_out.result != 0) {
> +               *cnt = 0;
>                 return be16toh(frame_out.result);
> +       }
>
>         *cnt = be32toh(frame_out.write_counter);
>
> --
> 2.34.1
>
