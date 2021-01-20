Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E7C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C720705
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbhATRas (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbhATOJG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:09:06 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6EC0613D3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:26 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id n18so5619095vsa.12
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYF+Zz7wUDX6tFLm0vugTznzEeL36B9hGlq5J1Mejos=;
        b=bB6s6Snu7BEd0g7q3kNiWIUMDzZs6R2ihemuVSpA9OHoV7py5zzTe4td1pxZvg3iQO
         wAvWas1umsFvU4xr5zAGltp/VYDIu+HhKxXmeUPQgRAd9SQTXdcu/02hqNzN34jmFdi8
         aJCNHGHND1ZhUOqZN/XZguJLR1Le7SQL47N84pRUJ+uUDhITBA30LKod3lyniRsc8ghi
         y50gZvUmYm/LAgFgJzkaTx0UdX128J0STq8V7C5pIJgJuSmPyvbys9iDtc1Y7QkYSJZu
         mkZwdTYxZoDWN8KFkTG2RhYmc9M77zCkPYKv+h3EQ4oxPbDffVATGuNF/HiSHxJVelQ6
         W7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYF+Zz7wUDX6tFLm0vugTznzEeL36B9hGlq5J1Mejos=;
        b=rQ6TDvQ5HH48J7JVAv4o5BVfbzNlAgJXvz2RpIz56L/8fOD0LmNfe1ZLrhHABCVFmW
         G6Ac1ImASYcV0Dq0a4j3hNZaknqSevPtcqORV43p+XjS4KzuFHoOyD0KLVQnKXzO8V2X
         q3UqlilqVqqF862J6SdY7dMNDprQWUBJtKnmYW9E12hhbCVyf4+seNYpJQoewiqIDHe6
         d8BHjh2M3BbvunB+zo5j5sc0WEPpRcP3MLZPBa+6jwi2kHXK+VGdSyAG7iOZlOzvoiUM
         6ic3Eg4goG2nHorUnaeWJ5iwxcjD1LaVDH/yA6rOJeZbf6xpSBZvqVOFDsSoAxUdTkRg
         h7iQ==
X-Gm-Message-State: AOAM531YAhSusK2wNbrKyqs0Gcj6aZaYR4L2JBPJ9Qhj83zfHaT+xmXJ
        X+WXb43ITYf81e9UxlTSQcJiHI0R8HbNr7/2WqLxtg==
X-Google-Smtp-Source: ABdhPJzPT+5m2Uip2x9vfp7pBlxYZltKseMVwidfWwS9EYIZPJvzKkNBcaq7Pw/ew0QC+G0QrPPNK7NoCik1XvhD4+Y=
X-Received: by 2002:a67:facb:: with SMTP id g11mr6768555vsq.19.1611151705806;
 Wed, 20 Jan 2021 06:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20210119051425.305-1-zbestahu@gmail.com>
In-Reply-To: <20210119051425.305-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:07:48 +0100
Message-ID: <CAPDyKFo1fc8xHN2PjrE1s4RGsTPzL6sq6e1+aCOZBJN-6iFD3A@mail.gmail.com>
Subject: Re: [PATCH] mmc: test: remove the shutdown function
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jan 2021 at 06:14, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Since it's doing nothing for shutdown behavior. And the callback will
> be checked firstly in mmc_bus_shutdown().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 152e752..f999b48 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3267,17 +3267,12 @@ static void mmc_test_remove(struct mmc_card *card)
>         mmc_test_free_dbgfs_file(card);
>  }
>
> -static void mmc_test_shutdown(struct mmc_card *card)
> -{
> -}
> -
>  static struct mmc_driver mmc_driver = {
>         .drv            = {
>                 .name   = "mmc_test",
>         },
>         .probe          = mmc_test_probe,
>         .remove         = mmc_test_remove,
> -       .shutdown       = mmc_test_shutdown,
>  };
>
>  static int __init mmc_test_init(void)
> --
> 1.9.1
>
