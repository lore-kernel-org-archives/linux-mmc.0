Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869DEC43381
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DD964F59
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSOM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhCSOMr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:12:47 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2823C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:46 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id h25so3545592vso.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xd+o2cB05izgGbUYHaDQXSmqMhYbVE3vcae+Q3WXMyQ=;
        b=kpGO0TVYSQG0ZNsk7F8bAPPdntChgP86YButxxu2dqZ1QlkQ7+0sS6KosI4r3gTg3B
         cNHNWK4QhVVLqffq2pfkwceqqcNhi8N9wKcoTOgCLM6EO2xQDYZHnXn+4s7J6Y9em5bN
         J5ACNX2QpOkvzZjVlkjjcN8V7eCOR1ts+YfTZovNenGrHYSEmafaNsb8kBDNsUpmDjkG
         IJFaXHLaxD8A7PS0INmv8u5qoUUZrA1DBpZWkkpJk+rsRPvZaMjrxXlM1sQWJE09c5HI
         c1nDJ/Tn3WpcHJUp4uJ18xSrYw0dk1lGLzBTtGrlJv2SKu01PJNfCwTFiLqzYji6X7Kq
         frcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xd+o2cB05izgGbUYHaDQXSmqMhYbVE3vcae+Q3WXMyQ=;
        b=sQQJ5MPjn0Czyq+u0NRkBJcLUJSlAa9Z5TUZWIBK3kOTsG0Hnez0sI64fvIhWn/LfH
         Dkwv8OmBDjSdmNhAprTjCm/xeSUgBsBOWk018yoq9FP2eoAYYVRBtcs0idomIq76OnMw
         erGA0DMWQ0waIJMHBez7e9oozm5vheUbfFmnTDxpZKCayNh4VMvLp1Th/fZR9S7JnCwZ
         8RTK62ePvtBgqUBYjWMo3jv1boIBU1y+jPMcxlgK90CBHJY3psKEVx7VBlUM0XThXAvJ
         QqGY1ZIS1aS2Xj65B/7ETPgoP+Sx/FO6BAJAk/uCHCgLarC/WZIgCtR849WN+ekD1Vax
         sTlw==
X-Gm-Message-State: AOAM530C891+TK9/dw3A0TqMBGfO0WZaQ+dP+lp1CtT8m84kf3suGG0v
        mQunRCtl2ESh2U9f4s0S3e+gcdqGG3WkHrrm0xQaAA==
X-Google-Smtp-Source: ABdhPJwh0705p300VaubaGlgTs/06J1aHU2eB30nqw3thSbqZtKHL12+/YbCTi5Cwd9OFQbdyNEw5wBRs7yzhoq7taI=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr2730894vsg.34.1616163165989;
 Fri, 19 Mar 2021 07:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210313173740.GA580681@joeylaptop>
In-Reply-To: <20210313173740.GA580681@joeylaptop>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:07 +0100
Message-ID: <CAPDyKFom3UZyX+mcgte4sOedEoMAXKnsVm_8g44WqgZm30td6A@mail.gmail.com>
Subject: Re: [PATCH] memstick: Remove useless else branch
To:     Joey Pabalan <jpabalanb@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 13 Mar 2021 at 18:38, Joey Pabalan <jpabalanb@gmail.com> wrote:
>
> Remove else branch on line 334 of memstick.c, after the return of the
> previous branch. Found by checkpatch.
>
> Signed-off-by: Joey Pabalan <jpabalanb@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 12bc3f5a6cbb..bb1065990aeb 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -331,18 +331,17 @@ static int h_memstick_read_dev_id(struct memstick_dev *card,
>                                   sizeof(struct ms_id_register));
>                 *mrq = &card->current_mrq;
>                 return 0;
> -       } else {
> -               if (!(*mrq)->error) {
> -                       memcpy(&id_reg, (*mrq)->data, sizeof(id_reg));
> -                       card->id.match_flags = MEMSTICK_MATCH_ALL;
> -                       card->id.type = id_reg.type;
> -                       card->id.category = id_reg.category;
> -                       card->id.class = id_reg.class;
> -                       dev_dbg(&card->dev, "if_mode = %02x\n", id_reg.if_mode);
> -               }
> -               complete(&card->mrq_complete);
> -               return -EAGAIN;
>         }
> +       if (!(*mrq)->error) {
> +               memcpy(&id_reg, (*mrq)->data, sizeof(id_reg));
> +               card->id.match_flags = MEMSTICK_MATCH_ALL;
> +               card->id.type = id_reg.type;
> +               card->id.category = id_reg.category;
> +               card->id.class = id_reg.class;
> +               dev_dbg(&card->dev, "if_mode = %02x\n", id_reg.if_mode);
> +       }
> +       complete(&card->mrq_complete);
> +       return -EAGAIN;
>  }
>
>  static int h_memstick_set_rw_addr(struct memstick_dev *card,
> --
> 2.27.0
>
