Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867DFC77B73
	for <linux-mmc@archiver.kernel.org>; Fri, 26 May 2023 13:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjEZNIH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 May 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbjEZNIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 May 2023 09:08:04 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CE12A
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2023 06:08:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-561bd0d31c1so7602527b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2023 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685106481; x=1687698481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTkxXDC60IeQ41et0j1mf/hnlHv2h+jxU5lJLWJauE4=;
        b=Iway/ORLwcGm5l64I2B25Uc0402AinHSuVTm0Gks4A22eDsmelJpMmphKuLOqIYgHU
         L2hy5jKWr6RDXCOspdSkqKj2iw+Q01Ys2/Z1q8WhgMa0nZNUAwcZm2Ayu/rwSxhP8knq
         ktBuWJOW2AA1Ltvgc/MaP0YteHPFoi7SIPH7eElwSSzpOrsRo1uUba5kZKamzP9JtW1I
         ygx2rVrN1WLxw9v4S8LqLpuqf0gCNNY6i+McMvgDpWuuJPPwZ3fDZdrUMooZ7f7Dx4EP
         7d7eJIE0TeCeLqPRFhezbAUDKxUjbwmAgHkxcXIBHZwgv5ntWqb8VELIiVcuz+UugbAh
         3ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685106481; x=1687698481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTkxXDC60IeQ41et0j1mf/hnlHv2h+jxU5lJLWJauE4=;
        b=UEPpRhJK+LqhJKkWCTIZKyIQNiR1sTvRvlDV6ZMp2lXVM2XAENrH5U7bNLPPeFvT5x
         D0M9z+k+DPnmJO0m92b2O53laDfo5jq3kFXQ0TXk4qS978FezhVUGsFMuskOFVw8rC1+
         mkw8iVsOo2tOClnxRWWpLXNiulUIUQJODtjntSBeC4VP0bOt3gQiKML9rHZ+cbfYJhfx
         U4cuorBavjhPxm1U5u05viET4gAU6bCIkC6f1qhjV2eWqulDbMW7ETQFvsESQsMUxo5c
         p61SVfFq6odMHtk5/71OnRp2eakg0+kSNwBqgx2CQWFUaly0kNgdjgjR/ReIZfG0ANuV
         JwFQ==
X-Gm-Message-State: AC+VfDy5m5DX1UTA2r8WATwqJkLrfDa/SL7i/VU/xc+ps7rI3qy36I32
        VXPoOxk/WyS6m2Wdos9SiDExMEt5C+zymcZNDjwfiQ==
X-Google-Smtp-Source: ACHHUZ7LOlUF5yU88ACSGIMp+UGFzyAyiSjRtfF5ZxAkuOxawDYZT1zwuspXGl0gYmZoni+rrUmvA4iqr8z2vKZ0/pg=
X-Received: by 2002:a0d:cc54:0:b0:55a:aa57:5660 with SMTP id
 o81-20020a0dcc54000000b0055aaa575660mr1989542ywd.20.1685106481522; Fri, 26
 May 2023 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230526081100.1741293-1-a.fatoum@pengutronix.de>
In-Reply-To: <20230526081100.1741293-1-a.fatoum@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 May 2023 15:07:25 +0200
Message-ID: <CAPDyKFo4=BY0sjLRyVOXete9thV14enYXip_7h1KdsUVvzYawQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: support overriding CFLAGS without setting -DVERSION
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>, kernel@pengutronix.de,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 May 2023 at 10:11, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Build tools like OpenEmbedded set the CFLAGS environment variable to be
> in line with distro-wide decisions. Updating OpenEmbedded-core to point
> at the new mmc-utils breaks, because VERSION would then be undefined.
>
> Instead of having users workaround this by feeding in -DVERSION from
> the outside, let's just move it out of environment-overridable CFLAGS
> and into AM_CFLAGS instead.
>
> This will inconvenience users that set their own VERSION a bit: The
> Makefile sets -Werror and specifying -DVERSION twice will trigger it
> because of the duplicate definition. This can be resolved by specifying
> -UVERSION first. Given that the VERSION macro has only been there for a
> month, this is deemed acceptable.
>
> Fixes: 145c74ab6f2e ("mmc-utils: Change version string to git hash")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d8d59a4047fd..10b78ab5d7dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,8 @@
>  CC ?= gcc
>  GIT_VERSION := "$(shell git describe --abbrev=6 --always --tags)"
> -AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
> -CFLAGS ?= -g -O2 -DVERSION=\"$(GIT_VERSION)\"
> +AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
> +           -DVERSION=\"$(GIT_VERSION)\"
> +CFLAGS ?= -g -O2
>  objects = \
>         mmc.o \
>         mmc_cmds.o \
> --
> 2.39.2
>
