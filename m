Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67693C2B9F7
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ADB61370
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhEXOMq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhEXOMo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:44 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7FC061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:16 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n1so12834087vsr.10
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCQyDrPS485JCf/EEBqEIhlOY+R+jUvQFllkGWdxwlU=;
        b=rL221ZDLv+YLV6YwZRS3eQJhMyuZtgYBJ8CrSEy+N6aSE3T3ThkMn/A72sXlzWEXbB
         s1fWLTuu717xF3h23DVKY+pstdeiXlXI6rgJa3HM7nv6/VFM86FSs/coHqklivyZxNA4
         2Wy/1Ng8g7/BKFHWqPSiiVhnh22Syomle17OvQ/4n29KfSfukWYqmp/FK4vZilte2jL9
         WhQgB/sIQ+bfT/s7/yIGKbhNOCm0/mLSPh34x9FiqKVL8xH/xA8h6z9GQzFWPDX4kajB
         egQ4wTAvfNnM/dAg6LaDnHi6YxsyGwGKtAhJWvxJHNFOt9KfyQ2/V0vH/FDeaHPyr2WJ
         GMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCQyDrPS485JCf/EEBqEIhlOY+R+jUvQFllkGWdxwlU=;
        b=r6pGjnGzNc19u3ieZKg3XOKe3MBuXYspgNpP/XgmwQN2qP/lM1U5bIMT0eupL9j7A1
         ipWM6s3Cuz2evxMeieL6cbBEzJ94qjsExrxzKRans7AL4AQ55Pe0yj6+GNgi/pbfzLtm
         QUgWItQkyiPgAcL/HNm7+9/sTfjlCk1Qsb8rajxvbeAjL/szOjL6+8BHzONuD7lVa/IV
         bHzYhyU1SYHaiygyo964T/Mjfe3vvn4ZLyi9To9hEvw1Fu/cnQpzENPCJyqlmNEezgq+
         np8NRojwHF/56IO+zk8pjk5OlRAe15vFAz2hwTAMog4ZSMM8FRaYSG0nKDzg0CCjVu8o
         cjRw==
X-Gm-Message-State: AOAM532QpHLwm6PPWcD0qpBNdHav57ImducSa7qvOa6zGXyMuyGYSQMT
        KOaZoR3qnLAoz3J1adivmhInD42s7kNzwVP+Jqa21g==
X-Google-Smtp-Source: ABdhPJwMK3SFZbamqjUeewMx4pyjEYGz6E3mOkM1UlEIRFJpJxPqU+mIDBmUS5Mxf2RtuRjUN723pYQ6K6iCkHrQauA=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr21665508vsg.19.1621865475641;
 Mon, 24 May 2021 07:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210517105432.1682-1-zbestahu@gmail.com>
In-Reply-To: <20210517105432.1682-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:36 +0200
Message-ID: <CAPDyKFpyoEFt6CEwitD12sskG_YuLW=B+635_hyJ5gOLAzwYPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: remove useless data parameter from msdc_data_xfer_next()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 May 2021 at 12:54, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We do not use the 'data' in msdc_data_xfer_next().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index c4db944..4dfc246 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1347,8 +1347,7 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>         }
>  }
>
> -static void msdc_data_xfer_next(struct msdc_host *host,
> -                               struct mmc_request *mrq, struct mmc_data *data)
> +static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
>  {
>         if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
>             !mrq->sbc)
> @@ -1407,7 +1406,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 (int)data->error, data->bytes_xfered);
>                 }
>
> -               msdc_data_xfer_next(host, mrq, data);
> +               msdc_data_xfer_next(host, mrq);
>                 done = true;
>         }
>         return done;
> --
> 1.9.1
>
