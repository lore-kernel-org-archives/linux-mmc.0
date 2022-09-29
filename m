Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiI2MmG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2MmF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 08:42:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131A15E452
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 05:42:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e68so1353549pfe.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SwmTmZM4cNqpS1jNdiXo9u+cxg65tRQ/3yvkU0CfYPE=;
        b=ZOYDj1n4QUXianLwU4/ysFeg33aNMmR5ebPyRpKQ5YcZfU3W07+B2J8Vnafxrcjz8/
         jTyMGvoJzXQhgziPk7y1CgO/h058aO1EXsZ13F+QVBueuPjL+DLYmokPy3M08vDOTjrd
         0fRw9k8IBIUswHZ18DYfkPVi/lbEAXot7wqkIds65OzVMurZ9eayxUbRMqd9ZFYBB2Gu
         wIdi8BFZLN5yTtjHXvvfzn0GZBNZjml0DC3kEHjnQT+o95MyYP15S5j7w+i++JBS3UWH
         NjUozmSjXL9HsePwqWc2jzyP1LJbiFQmveJfyHzB5kUvItQKtg+6rqok60sr8uuvDxJr
         qCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SwmTmZM4cNqpS1jNdiXo9u+cxg65tRQ/3yvkU0CfYPE=;
        b=NjG54GKEg/ExuiYKy2vERoQzU67AfRAOmjy+jVDZSg/k9j8cCiKX3CISD5r+KOZfCM
         gGG4OH8DMabeM2zqI+K7UMjP44aLOtq82VuXfov6Cn1P+j6llHgc08YNCsfx8OnbxDO+
         rqnVYwobtCseG9oNnRZBm/F8p/7ulX7aHwX/gjaqFyH+dq+E+4T5LdOS9cEJ5iOoZIUa
         x37gGeEq20uJkHyetOlcG4VjzCLK9xVbHAQmQG8zwBejphr+nYxWjIFg914gU2Gmqfur
         jl9UihIJm0CJUUI+f4hIXFRKR+yGRROB9oNGTOHgvIrlglfW+bf2KYo7BD+Aec6+mLFy
         +Rig==
X-Gm-Message-State: ACrzQf18vXx/mjnAZXk/VniJQIjoeugbuYXLvmzlQlTgpDS5B7Woyqup
        VrM2NwhkSe3lweUH3o0c2AcLDy11Q3UJy3WZSRRZYg==
X-Google-Smtp-Source: AMsMyM5ZUb/2lWBCbsRRgg01oLCxyggEUP2L940cOJ4h0BKo9I4kzuXh3iyLffRgpIqyDbOXNi5nXm5cDl5aVMj2UYE=
X-Received: by 2002:a05:6a00:24c2:b0:52e:7181:a8a0 with SMTP id
 d2-20020a056a0024c200b0052e7181a8a0mr3331978pfv.57.1664455322742; Thu, 29 Sep
 2022 05:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <21f604139a9a4675b9ed49292839dcfb@horizon.ai> <dd8d212c48944cb4ba3b58af2efe3723@horizon.ai>
In-Reply-To: <dd8d212c48944cb4ba3b58af2efe3723@horizon.ai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 14:41:26 +0200
Message-ID: <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
Subject: Re: [PATCH RFC stable 4.14 1/1] mmc: core: fix hung task caused by
 race condition on context_info
To:     "dinggao.pan" <dinggao.pan@horizon.ai>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ming.yu" <ming.yu@horizon.ai>,
        "yunqian.wang" <yunqian.wang@horizon.ai>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 5 Sept 2022 at 08:22, dinggao.pan <dinggao.pan@horizon.ai> wrote:
>
> Hi,
> After applying rt patches to our 4.14 kernel and enabling preempt-rt, we =
met a hung task during boot caused by race condition on context_info stored=
 in struct mmc_host.
> From our investigation, context_info should not be changed by threads tha=
t have not claimed the host, hence the following fix.
>
> Any comments are much appreciated.
> Dinggao Pan

Hi Dinggao,

Apologize for the delay.

The 4.14 kernel is too old for me to be able to comment. In
particular, the mmc block layer moved to blk-mq in v4.16, which means
the path you are investigating doesn't exist any more, sorry.

Kind regards
Uffe

>
> From: "Dinggao Pan" <mailto:dinggao.pan@horizon.ai>
>
> =E3=80=80=E3=80=80A race condition happens under following circumstances:
>     (mmc_thread1)               |              (mmc_thread2)
>     mmc_issue_rq(req1)          |
>       > qcnt++ for req1         |
>         host handling req1      |
>     mmc_queue_thread(req=3Dnull)  |
>       > enter queue thread      |
>         again, fetches blk req  |
>         (return null), sets     |
>         is_waiting_last_req 1   |  mmc_request_fn(req1) -> set is_new_req=
 1
>                                 |                   and wake_up wait_queu=
e
>     mmc_issue_rq(req2)          |   > mmc_thread2 tries to claim host
>       > **qcnt++ for req2**     |
>       mmc_finalize_req(req2)    |
>         > should wait for req1  |
>           done but req2 return  |
>           MMC_BLK_NEW_REQ       |
>           due to is_new_req     |
>           already set to 1      |
>                                 |
>                                 |
>     req1 done                   |
>       > qcnt-- for req1         |
>     mmc_issue_rq(req3)          |
>       > qcnt++ for req3         |
> req2 is not handled but qcnt is already added(noted by **),
> thus mmc_thread1 will never release host, causing mmc_threads
> except thread1 to hung. Fix race by moving wake_up to the front of
> context_info update.
>
> Reviewed By: Yunqian Wang <mailto:yunqian.wang@horizon.ai>
> Signed-off-by: Dinggao Pan <mailto:dinggao.pan@horizon.ai>
> Signed-off-by: Ming Yu <mailto:ming.yu@horizon.ai>
> ---
> drivers/mmc/core/queue.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 0a4e77a5b..58318c102 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -107,6 +107,11 @@ static void mmc_request_fn(struct request_queue *q)
>                return;
>       }
>
> +      if (mq->asleep) {
> +               wake_up_process(mq->thread);
> +               return;
> +      }
> +
>       cntx =3D &mq->card->host->context_info;
>
>       if (cntx->is_waiting_last_req) {
> @@ -114,8 +119,6 @@ static void mmc_request_fn(struct request_queue *q)
>                wake_up_interruptible(&cntx->wait);
>       }
>
> -       if (mq->asleep)
> -                wake_up_process(mq->thread);
> }
>
> static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
> --
> 2.36.1
