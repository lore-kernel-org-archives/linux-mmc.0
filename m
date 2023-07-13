Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA3C0015E
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGMLGV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjGMLGT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:06:19 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362B2120
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-576a9507a9bso27016137b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246370; x=1691838370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rU37mFTJD2ihTlHVA/622ea5niPv5pR87SNHOeXdqbo=;
        b=zD2pOBqg0UxLMYk7lovuPhL4AZ891i7DGRJyYnEhT7/3B0HOgWzT7T10n5UCj5yACX
         QXx2wdV1FMaZMvGwqs05xaMRiJBImblR+C6Cp8rOT+MWvCmKyMPu54MQuWnP5F3BVlN+
         2woVYyF591A00TL+E45aDPxqIAwRsVfeOWxGoOGn4HkYSV+Km5oqb8lFtD2EdgDNNGMT
         7u9jwDRVc07LePELQTu9NLbkPJnDVy6JM9WJLGxiI7JVSk3ciaCnVCgzenHQCuYlmj/7
         jmY3I88pniSBSN3Ld3eC70a/7OS/VW6mBZg54lkyOF+qMb20RjK4bDpsvhjYKkIJPf2L
         T4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246370; x=1691838370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU37mFTJD2ihTlHVA/622ea5niPv5pR87SNHOeXdqbo=;
        b=cT9dhEWO7TJ3nFBSlD9QgmK5aFp7Wly/idAJWisPrOqxsEj8iPchl9XVxhyzu6TjaN
         ysmrvILsRGQNZJIA9QOFVoJlEQWJzOewi2kYkqAcG5i/bGRJjT+bBqlVYKMn6ve9pUVx
         eOjUstiXwj2d07D4/WkCbXuTN5QLvu3pG+LrWdLQYlk7LNvp34JhEt63av9l3UBQHgIy
         di0YlyfTg6rBuJq/LXUBNOCKo/OiKb/S00Cdr3t0hLjhgZtg7midnifFLqNCGVkdaO8H
         0Kdpk3FKf1meOMrGRKqL4Fat8gJFv8qMbrFw84fg0UXrE8/CJvcdCfu2/fyzK6RwyCS1
         Vt1Q==
X-Gm-Message-State: ABy/qLYzHLtUt7eIuqqyB1E+NN0GjUU2wPGVdXu/Fo9olA50xu61QIYl
        08D2fb3oh1vi61bb4qrn1ynLWWOjh0uEWEfNz7JUGA==
X-Google-Smtp-Source: APBJJlEeEyo7n9uRnp7pby4ugQLXjOATQgBLLR7fdtxhNtEtRowwGjZ2qpZCwEAf6C0TMmODlBHxXhF+SMLT3s7c5hs=
X-Received: by 2002:a81:488a:0:b0:56c:f547:e058 with SMTP id
 v132-20020a81488a000000b0056cf547e058mr5155021ywa.18.1689246370067; Thu, 13
 Jul 2023 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230627120549.2400325-1-saproj@gmail.com>
In-Reply-To: <20230627120549.2400325-1-saproj@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:34 +0200
Message-ID: <CAPDyKFr4eZQXUdjY6uAnftPAC8YGk=0zkn2a8ndWbO00cRo8zA@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: read scr register without changing byte order
To:     Sergei Antonov <saproj@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Jonas Jensen <jonas.jensen@gmail.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 27 Jun 2023 at 14:06, Sergei Antonov <saproj@gmail.com> wrote:
>
> Conversion from big-endian to native is done in a common function
> mmc_app_send_scr(). Converting in moxart_transfer_pio() is extra.
> Double conversion on a LE system returns an incorrect SCR value,
> leads to errors:
>
> mmc0: unrecognised SCR structure version 8
>
> Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 2d002c81dcf3..d0d6ffcf78d4 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -338,13 +338,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
>                                 return;
>                         }
>                         for (len = 0; len < remain && len < host->fifo_width;) {
> -                               /* SCR data must be read in big endian. */
> -                               if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
> -                                       *sgp = ioread32be(host->base +
> -                                                         REG_DATA_WINDOW);
> -                               else
> -                                       *sgp = ioread32(host->base +
> -                                                       REG_DATA_WINDOW);
> +                               *sgp = ioread32(host->base + REG_DATA_WINDOW);
>                                 sgp++;
>                                 len += 4;
>                         }
> --
> 2.37.2
>
