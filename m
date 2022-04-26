Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E1C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351309AbiDZN7S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiDZN6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 09:58:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3915F58B
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y2so14176873ybi.7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBWTMy19BCU8GJLOpBmlkiJHgnhETyOqG4xsK78wLxQ=;
        b=y0qlk5Wop1rWL3gXkgBl5O9PjeYqAiQ1ig5/DeQlJRMziLwwYQx+LkfhDm+OGi+g9j
         7oliRUhScsahDl34Eu1Fa2j59Y8ajc/Vhlir2Y7/aPAFoB67qyf+oqHDK1XZ2UVaQNlw
         sr0RkEERg55+T9vK0IZlgRpc6eSXLnVnM291eRkpVjMG3Z0VLQR9eTKNxCaKdALs5NFO
         hBhWH+3ZRcXKKK1sultcqu8lbZ7aCzaRdi1IzAjb3TqCebP5VSiWhG6+vmvI6J4przib
         ASXHvVFfO5rMIdh1GlBR0Q1uYleb+NKjAVVfkERYhkI039Egka5l45WNe6gJpXbgkXQt
         rCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBWTMy19BCU8GJLOpBmlkiJHgnhETyOqG4xsK78wLxQ=;
        b=M0z13QhOyAn5HMXocdb2XFQoID+h5K02tibY6w07JnoDyPBCOTcgto2abirN7mwPWf
         5SJdu82sGklOpnNT5oX/OyfzW9wwnSHWZmJRsqeYrI50sQuxgSBPOXgnsT6FC6ZQrAeR
         /AxAHjqd1HTelNSRd+rkJr6jAWy0vwyBH2EhTcRIS9p4SKfROz/KASB66Z4vn8JKgKpG
         oOHnf9oXSem0NNUzSDRbzNggUy7rJwpdAhkwOjqR2uE1rANR4Tahs95IqcKbs3hsJ2+N
         2Hkw2M0DIiguC0rq5giOqsJryYBq0LZeJ0JIHRi1NaFeJqpgyVRMOXkyR+bZhCmA4BSl
         2Ibg==
X-Gm-Message-State: AOAM533BXAAqariRH4k3dTU2QBBRtwKp1XWgfWTPR+kF4huAOVBhZlAT
        0OdStRKMAFpKFzvoVXDQETjLR+CkW6l3CNlYVCAz0A==
X-Google-Smtp-Source: ABdhPJw92iLZ8A8h//KsmSd7zk7HfXV1sN9OJS8uxSz8+RRspq25GOq/lPymHBG1FtpLpzP8LuhhvxTuI+IgUuTf+0M=
X-Received: by 2002:a05:6902:8c:b0:631:ef56:6694 with SMTP id
 h12-20020a056902008c00b00631ef566694mr20679552ybs.194.1650981344539; Tue, 26
 Apr 2022 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-3-huobean@gmail.com>
In-Reply-To: <20220423221623.1074556-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:55:08 +0200
Message-ID: <CAPDyKFrksB_kgrnmcay+ub0nDfmPVZfw-zJihop5N8_6qUqrug@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Allows to override the timeout value
 for ioctl() path
To:     Bean Huo <huobean@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 24 Apr 2022 at 00:16, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Occasionally, user-land applications initiate longer timeout values for certain commands
> through ioctl() system call. But so far we are still using a fixed timeout of 10 seconds
> in mmc_poll_for_busy() on the ioctl() path, even if a custom timeout is specified in the
> userspace application. This patch allows custom timeout values to override this default
> timeout values on the ioctl path.
>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Linus, I interpreted your earlier reply as a reviewed-by tag, so I
have added that. Please tell me, if you want me to drop it.

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b35e7a95798b..6cb701aa1abc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -609,11 +609,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>
>         if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
>                 /*
> -                * Ensure RPMB/R1B command has completed by polling CMD13
> -                * "Send Status".
> +                * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
> +                * allow to override the default timeout value if a custom timeout is specified.
>                  */
> -               err = mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, false,
> -                                       MMC_BUSY_IO);
> +               err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
> +                                       false, MMC_BUSY_IO);
>         }
>
>         return err;
> --
> 2.34.1
>
