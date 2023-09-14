Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E38CA553C
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 12:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjINM5p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjINM5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 08:57:45 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE51FD0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 05:57:41 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d801c83325fso983704276.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696260; x=1695301060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RR3Rm3BvRcsogaZkU4Bg0Ejafb0av4o4WZ1/jDMEr44=;
        b=GT7YOe3Yag96osS+kNebu+LJLVACEAtPbg9PB4bRLk0libnh1Zg72oQEJO54houkTx
         sPj//pX0rD48MNlrcLVt6OTGmRm1HcX7+6TI8Bt8RR1VkR/tKCiDtk+WbScktLOyYcLZ
         ZujbMWe2y6w1biWg+gVOgtmN+KnFQW8JsLm9K5VEqMPEhokovfYGcV9zxw7r7p8eCr0Q
         7Suy8IRIIDPQhXt/UQirIVyVpAVr+7fHviQQ3rqGTn+PnZJgwfyN4Y7+gin1pVK8gl0H
         2FzGEB/r3dlgTVs8zGNFjbeEE1Z6TcS2M8RJMT4k05MPfEY/PecRriGWQz/6SpM21m/I
         i62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696260; x=1695301060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR3Rm3BvRcsogaZkU4Bg0Ejafb0av4o4WZ1/jDMEr44=;
        b=LEzEZ6RFU24+AGWmxMrARitmfifuu8NvktJFyRNDKdHr+5TJcrdP0uz95YXhrh8wu7
         QmnsTU+5pb4Ar979Wr4NVUbsArjbWE4h00aRxm4bfOulDY5ZjMo2e5gDClIvFykiBltx
         cJQKMYtpywgCOjnJ0yg/YDGfL5KIl1tvbBYrVypfVjNdE3EE8WRnqSqk5HnoSY6vO/bD
         siYw1lEMQYR8qdWd5qg2U+yhckYbMFA4ODQ6/RV2NXf5MgqyTGvJ2CWM1aCmbQOlC9vq
         tvXcUWjhKUhrYQmwPVRsrY440CKeeWaQLJcdg8NGvmjzkl2j1YNnkKf2TXZIcLGDuYpb
         ND+Q==
X-Gm-Message-State: AOJu0YzsKK9CS0hyROelGOfOebdSHp5b9INAy6TN/etVOxdRHecZ3ViY
        IFI/h50bUQvy4jPlyo5Vy6rxZpWAHBvvaJXlBM1Tuuu5SAOT6pARULXUhw==
X-Google-Smtp-Source: AGHT+IG8dtH15HRge6eN5RlxGnO2HTIFHcEjtnY4jBQGka7yBs1wMha24i43rdlme67glVBBEQnXGuMH2GKwzCxr1Iw=
X-Received: by 2002:a25:42ca:0:b0:d72:80bc:d3b2 with SMTP id
 p193-20020a2542ca000000b00d7280bcd3b2mr5130485yba.32.1694696260210; Thu, 14
 Sep 2023 05:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829020451.9828-1-wenchao.chen@unisoc.com> <20230829020451.9828-3-wenchao.chen@unisoc.com>
In-Reply-To: <20230829020451.9828-3-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 14:57:04 +0200
Message-ID: <CAPDyKFo67SOWS3eYgEDKGOtmZJY5UtPw7+V0BEdkF_Y8yY2i5A@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: hsq: dynamic adjustment of hsq->depth
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 29 Aug 2023 at 04:05, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Increasing hsq_depth improves random write performance.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |  5 +++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 8556cacb21a1..0984c39108ba 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -21,6 +21,31 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
>         mmc->ops->request(mmc, hsq->mrq);
>  }
>
> +static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
> +{
> +       struct mmc_host *mmc = hsq->mmc;
> +       struct mmc_request *mrq;
> +       struct hsq_slot *slot;
> +       int need_change = 0;

Rather than using a variable to keep track of this, why not just do
the below here?

mmc->hsq_depth = HSQ_NORMAL_DEPTH;

> +       int tag;
> +
> +       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> +               slot = &hsq->slot[tag];
> +               mrq = slot->mrq;
> +               if (mrq && mrq->data &&
> +                       (mrq->data->blksz * mrq->data->blocks == 4096) &&
> +                       (mrq->data->flags & MMC_DATA_WRITE))
> +                       need_change++;

And following above, then we can do the below here:
mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
break;

That should simplify and make this more efficient too, right?

> +               else
> +                       break;
> +       }
> +
> +       if (need_change > 1)
> +               mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
> +       else
> +               mmc->hsq_depth = HSQ_NORMAL_DEPTH;
> +}
> +

[...]

Kind regards
Uffe
