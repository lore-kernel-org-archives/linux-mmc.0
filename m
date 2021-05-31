Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B3C47082
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7807161279
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEaKSr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 May 2021 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhEaKSq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2021 06:18:46 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CFC061574
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:06 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f15so5749901vsq.12
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZlOBlSZYULypfw5/ewHC+v8ch9iaJNGfsO0EtuWzfM=;
        b=Y2yUwc3uTGu50MTnx/PW29KqfUP+uFZqZkHW9KemUvYqqNi5Iw8OiWOr+KH4x64vJ2
         UkI4ZBbwfQMZfqHGYU1Z6RQnVO0VOnUX5Tjn2GxF6SWF9Hll3vxzQS/3esWCcC21HqMU
         bSodJRHUZKMVsnQdSnCRYoVxbyr1gnVumiyUBqQZat6cOkWUch0nFsldRlk7vVYst2n8
         NoodRFcQ4CSva7Be76FzJkwqSLevyGU/GsQGcpV6REi4yXeyQMQR0iFMXsyCQEEjZLG/
         CaRXWiwmnK9ZtXHMoaTrBqcdepmPRBbfH3fxhOKjtmwCuAgm/Al9d8XSXKJy2EE6hHk2
         hXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZlOBlSZYULypfw5/ewHC+v8ch9iaJNGfsO0EtuWzfM=;
        b=d+IhSewaxTzyOldOtOF04dX6nNDGTJEYbFiYJG8cB7NnP/XdhHrQxeffJxZPk9pCAX
         DIn4eTI4bhlQb6jkRPg4TJJjpr4qxksPHaExrbZbm3uw02b+MOW9uwo1xVn0Lq8o4iOn
         M5CUl6SZrTVRQP+miPjZnCM8z735jrcNJCgeNr7rRff8+UFxflopXLLVUkWkqTfrwCEV
         4II0rbVra4tSvFnD2FzIxaMSl8DLv9fHEp44ygoNrkYuroBoWzmDzTmcogPAoNQogejr
         xyDJ3Xh/vHIJPK6Qd0YPwkT0xu7vcgRplGVjZcCeu/avQyYc7m/Xph8wyca431tonFjc
         xUHw==
X-Gm-Message-State: AOAM531406LfzaJqLqd4xycs/tNJeu+iDzG6yQlTGf5Hg3p0/5roKFYM
        Z7uNdZp2hiS9gv6mi2SdMGoJMNj7/Z0rwYVoSjJdxC/gSfxcCA==
X-Google-Smtp-Source: ABdhPJzgNUwfNc7KV7nrd1Dztm0iM1syumDQ3ZnEjB9Q60g7bqz7yWKku4XH8O/WDamv0wx+bkqorLwQFKUfEmeuMLU=
X-Received: by 2002:a67:e915:: with SMTP id c21mr2200575vso.19.1622456225517;
 Mon, 31 May 2021 03:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 12:16:29 +0200
Message-ID: <CAPDyKFp1ziD7w9xp789XtTvhURKTuDUyCZSzMJ5As7Y8Pq0SNQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: mmc_spi: Drop duplicate 'mmc_spi' in the
 debug messages
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 May 2021 at 13:21, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> dev_dbg() in any case prints the device and driver name, no need
> to repeat this in (some) messages. Drop duplicates for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 9776a03a10f5..65c65bb5737f 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -504,7 +504,7 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>                 /* else:  R1 (most commands) */
>         }
>
> -       dev_dbg(&host->spi->dev, "  mmc_spi: CMD%d, resp %s\n",
> +       dev_dbg(&host->spi->dev, "  CMD%d, resp %s\n",
>                 cmd->opcode, maptype(cmd));
>
>         /* send command, leaving chipselect active */
> @@ -928,8 +928,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 while (length) {
>                         t->len = min(length, blk_size);
>
> -                       dev_dbg(&host->spi->dev,
> -                               "    mmc_spi: %s block, %d bytes\n",
> +                       dev_dbg(&host->spi->dev, "    %s block, %d bytes\n",
>                                 (direction == DMA_TO_DEVICE) ? "write" : "read",
>                                 t->len);
>
> @@ -974,7 +973,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>                 int             tmp;
>                 const unsigned  statlen = sizeof(scratch->status);
>
> -               dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
> +               dev_dbg(&spi->dev, "    STOP_TRAN\n");
>
>                 /* Tweak the per-block message we set up earlier by morphing
>                  * it to hold single buffer with the token followed by some
> @@ -1175,7 +1174,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 canpower = host->pdata && host->pdata->setpower;
>
> -               dev_dbg(&host->spi->dev, "mmc_spi: power %s (%d)%s\n",
> +               dev_dbg(&host->spi->dev, "power %s (%d)%s\n",
>                                 mmc_powerstring(ios->power_mode),
>                                 ios->vdd,
>                                 canpower ? ", can switch" : "");
> @@ -1248,8 +1247,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 host->spi->max_speed_hz = ios->clock;
>                 status = spi_setup(host->spi);
> -               dev_dbg(&host->spi->dev,
> -                       "mmc_spi:  clock to %d Hz, %d\n",
> +               dev_dbg(&host->spi->dev, "  clock to %d Hz, %d\n",
>                         host->spi->max_speed_hz, status);
>         }
>  }
> --
> 2.30.2
>
