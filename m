Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FFC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Oct 2022 14:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJKOlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJKOlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2022 10:41:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C1476C7
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 07:41:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so13383459pjo.4
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VPSVqJz387vGX+lndeFLaz7/WMZ4XtC2ycr+jawg9P8=;
        b=mQnj4MjlGH8JCAAKVdx0ZM4mg4T+VBUJRL1PF6iiHzJBxFr7gaFI1MpVEsVgPsuw/P
         hkjU5CuHkatbpL/GBc7u4h2oboAuZ/HnHZOgB0SsRZdd4w+s8fidpVdRbpcdLfBajMGv
         MdeQkF2mLL055Eu+mvcH58OX4RUeW0WeqJwjGUVTUufON/NUkj2HIzXDve9c2A+3iXZE
         w93AH+to+qUjIxZ7+DszdS5Imwhd24yyIZsHl7qpm66gZ7KRn/sGzg/cuYiUc9IH7zY/
         +WlPZ1rRezDZVP1y/gpY2mUALMUCzCYUd4/8JwnOQ5yBgcLfBv0Uo6qhXcp+7GKttqC3
         LR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPSVqJz387vGX+lndeFLaz7/WMZ4XtC2ycr+jawg9P8=;
        b=mX6fHAcZuaWVtPyqFNf7avMTCsZmyr8BoD6HlsyQgC9x5O1CeOyx/6ogZNKjYjH5E4
         BwxhckctffOZJ9tOftS1iMSWDx1YtwFeHOFhSmzQGS4aSQVNj4/XVcOLk/TKZTOemmtb
         yiIe32fnoeU1ca2+GxPSEVqYnpjcgKovNRWcoKpQCrgKV9kff1DeoW0CZSql3d2ZJ3NJ
         AgKtufn4JNikF2YMK4mVx95/hUmuxurFOofVMeurlT3sB1xO+6wGEOM73pnGKCE5/ULG
         ifp7gUThlUqnnoDjXcYwn5vOFpnS4sza16XhqBwTQo4EcfeO2pC6w9C4qZ5c2wXaty/d
         3tOA==
X-Gm-Message-State: ACrzQf2aGW/89A+lpCI6RuV9mJLHNSr71gP0chj4aw6sOLublJOjatJu
        +Xf9Dlq4FI6clfOESY8BnoKykfyfx8koIZ0SChNdMA==
X-Google-Smtp-Source: AMsMyM4iNccU33s454RSlugRql+oKFO3lYmpS0Trlj7q84EoU85aKPx1FToEHnR68k8DGSjMQQESeTqT3eI/n20M4f0=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr25485853ply.148.1665499292988; Tue, 11
 Oct 2022 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220927020158.1218469-1-ouyangweizhao@zeku.com>
In-Reply-To: <20220927020158.1218469-1-ouyangweizhao@zeku.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 16:40:56 +0200
Message-ID: <CAPDyKFrmg+Q-+-dgOrHFYFf0JKB08pXB-b4MEkYmzE_8zW4s3Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO card
To:     Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     John Wang <wangdayu@zeku.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Matthew Ma <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Sept 2022 at 04:04, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>
> From: Matthew Ma <mahongwei@zeku.com>
>
> SDIO tuple is only allocated for standard SDIO card, especially it
> causes memory corruption issues when the non-standard SDIO card has
> removed since the card device's reference counter does not increase for
> it at sdio_init_func(), but all SDIO card device reference counter has
> decreased at sdio_release_func().
>
> Fixes: 1a632f8cdc33 ("sdio: split up common and function CIS parsing")
> Signed-off-by: Matthew Ma <mahongwei@zeku.com>
> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Reviewed-by: John Wang <wangdayu@zeku.com>

Apologize for the delay!

Wow, that's a very old bug you fixed! However, it looks like the fixed
commit should be changed to 6f51be3d37df ("sdio: allow non-standard
SDIO cards").

I tried to apply the patch, but the patch format seems to be corrupt.
Did you use git format-patch and did run ./scripts/checkpatch.pl on
it?

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index c6268c38c69e..babf21a0adeb 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
>  {
>         struct sdio_func *func = dev_to_sdio_func(dev);
>
> -       sdio_free_func_cis(func);
> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
> +               sdio_free_func_cis(func);
>
>         kfree(func->info);
>         kfree(func->tmpbuf);
> --
> 2.25.1
>
