Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879DEC001DC
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjGMLH3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjGMLHZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:07:25 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DD26A1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57a8080e4a7so5103097b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246443; x=1691838443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1X6eNhBTJxyZAA2cC+a9zRtrXgflOJ4PWxxjhd5jKI=;
        b=L5WMUOn2qxVhMX/WOCYk880GFyBMWzdLDyRWpQLs7jAFZT52XgtRj6bGuX34glr3nr
         rDGmCutzUqyxkuEvy13JPa0UqT0GoTZe1xOWUpDf64Jo0x0bhlsdlfTlFhFn//Kg3Z1V
         mTfQw/ItZ17rzOhmv3679QGAvKpg++hT2RZWufH+lbljGwwvrEsh87REvponNSVVcOEa
         Wpo4Oy+cQ0BSB2SHzgoPiUQiWLlJp8ANYQBWB+SSxIRpY7hb3+q5hADV+jFGjflH4tXn
         f1Ez51xA3nzGfgh0pwwGVVgXO8MbQFeQIvOjF2pSzV1mQQFAm9LdhAu1bd3GiTrt+1Ol
         RKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246443; x=1691838443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1X6eNhBTJxyZAA2cC+a9zRtrXgflOJ4PWxxjhd5jKI=;
        b=X6VAdgPJc6VGyUbi8EBsUD/PajzvN5yKfsAw6RKH1T62kPHqxbUBeBZ4nR/wtgPoAF
         gR2cBnBmn3zNnAY8CecttYCJYkep9KUa43VatllY6blWMfK5TcjXcjSfbUmR41gWAGva
         LOFpe1K88h9jHeFodSykQW4z5RMU8wus4V6dgA5QaewS0MfVkijso3ZHTaEsUIiA/VRf
         G+8ABZ/cfUGcgDU5gdS8eI6zcww5z0zk2JWf4hDpwhCLNpBc4lfBoOvsGKBkq8/3gbag
         1kUEmdCK/agCNG7XezXHY1DVtQQww2tYl+I3z/z52sskQ/HooEloqyaP+QZj0faKsEt+
         rHsQ==
X-Gm-Message-State: ABy/qLZXMxf52ieRyq/8qXLSal0j8Cc5UhBdGkhQ3ZzhSNuthmzYY5IR
        so8QPPoKp+DLCC55LMfl9v2I5l/rSn4Vcp9ukEJfsg==
X-Google-Smtp-Source: APBJJlH2P039fSEsr0FrFFqBrnQbLDD077beS/CwvVXjAT1DR8HmrZix0F4wo1Hx7dZohCkGiVdlIoKk6riWLtG39wc=
X-Received: by 2002:a0d:c2c4:0:b0:57a:8de8:f3b3 with SMTP id
 e187-20020a0dc2c4000000b0057a8de8f3b3mr1395566ywd.48.1689246443561; Thu, 13
 Jul 2023 04:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131939.22562-1-frank.li@vivo.com> <20230704131939.22562-2-frank.li@vivo.com>
In-Reply-To: <20230704131939.22562-2-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:47 +0200
Message-ID: <CAPDyKFo90Z-4gGnywfUf6QOY_QP4yLdh6y-=kMMSAYR9hhH5Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: omap_hsmmc: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jul 2023 at 15:19, Yangtao Li <frank.li@vivo.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1e0f2d7774bd..93de00a06aba 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1790,14 +1790,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 return -ENXIO;
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENXIO;
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
>
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> --
> 2.39.0
>
