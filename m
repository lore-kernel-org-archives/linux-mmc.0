Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F47BC6FA8F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 10:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjHXKhn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjHXKhM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 06:37:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D019A2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:37:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-590685a3be5so48315997b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692873428; x=1693478228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+t+6Jj4c8OD+E4DqAHyvyhb2KIFsqFvRqrnhgqjYgc=;
        b=nTeAP+kMD6HeAXh5/js1gdtYeek/dko2c5WLeifxOkkPBAiSejtAnTIWSOYZD/XbfT
         LmAkcHegepMUKPFJwkYfYpxbgLdTGpgN4O0uVmUVzCsyxx0lu0lklX5nWtxo1/p+z3kp
         bdUq6BdTTEEKaLhu+dT21WnEciKIqNKN7OoRbVIRLUMDOpc1OhY4ZfZxQhbjyGNwjilE
         p/ktvjCYlMiIPjCVTg4a3DeTa9KHzQY3QkZnAOkg/HLhP5wWOGbSD43b6ajo1+MryYN3
         dzz3cLMF5VmbUpqz+nqmyhkzNb36NjJHxVshkpf7J0zEmwLwKy8YOxlvBkmso/sNZS32
         1MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873428; x=1693478228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+t+6Jj4c8OD+E4DqAHyvyhb2KIFsqFvRqrnhgqjYgc=;
        b=DgDT1uNoTsorACGTIpw+NcA42akyTmMYPmWGVUL9IS3NuGhPd+pOApIp97bR4xHRRe
         IWfa3gvC0yXkEww1iqDQBAe9cg+ZgUYpgxoLmIWLy7iBUU5wSOSJJAaQjcfXmtgjKPbC
         SuMgH7O7+VukDaTM8c+jF7zGL0iNZDwSV+Ddc0QU2dGsmB/0IuCQUrGk32dcYp1GP7YF
         1UYsXoxCbbrnZbcM4OZuNB6voD3ihaUHc7uVYmb7JvRAo/tIS7LJ/3jnm4/sdF2VRohG
         BUoR90/1T2Cfx84X295OMOpKdCgVGowd2M69XTHLX4H4iLN0xrnrCGOYeST+c2fGWbJo
         IlGg==
X-Gm-Message-State: AOJu0Yxn33YEXDVeDJ9Jtrbb4Q7nulAO7yUUIsXQEjFBEEA0SVON2ovb
        vJvsTFmYBJgpcc/IOwVf/tAsdD70Xmw5hn+VS/ggcajP3tyO3CTwoBsk4Q==
X-Google-Smtp-Source: AGHT+IGgT1fs4cb+csCKFpIcm/YjFDyRo/O88UP51BgIw2jkGgaEUESazYPERGYE/mOk11GEYXLJuz94B+/M7DEvjBI=
X-Received: by 2002:a05:690c:3693:b0:592:8909:10f0 with SMTP id
 fu19-20020a05690c369300b00592890910f0mr710256ywb.28.1692873428556; Thu, 24
 Aug 2023 03:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061734.27479-1-wenchao.chen@unisoc.com> <20230823061734.27479-3-wenchao.chen@unisoc.com>
In-Reply-To: <20230823061734.27479-3-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:36:32 +0200
Message-ID: <CAPDyKFriZ_uu-WACjqXK5um1bYJSDaHsghOMGwwPJXM8pYCoGw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: hsq: dynamic adjustment of hsq->depth
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Aug 2023 at 08:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Increasing hsq_depth improves random write performance.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/mmc_hsq.c | 26 ++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |  2 ++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 8556cacb21a1..8682a3d16a76 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -21,6 +21,30 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
>         mmc->ops->request(mmc, hsq->mrq);
>  }
>
> +static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
> +{
> +       struct mmc_host *mmc = hsq->mmc;
> +       struct mmc_request *mrq;
> +       struct hsq_slot *slot;
> +       int need_change = 0;
> +       int tag;
> +
> +       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> +               slot = &hsq->slot[tag];
> +               mrq = slot->mrq;
> +               if (mrq && mrq->data && (mrq->data->blocks == HSQ_DATA_IS_4K)

This assumes mrq->data->blksz is 512 (which at least for now is always
the case), but perhaps better to compute the request size instead?
Hence:

"mrq->data->blksz * mrq->data->blocks == 4096"

> +                               && (mrq->data->flags & MMC_DATA_WRITE))
> +                       need_change++;
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
>  static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>  {
>         struct mmc_host *mmc = hsq->mmc;
> @@ -42,6 +66,8 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>                 return;
>         }
>
> +       mmc_hsq_modify_threshold(hsq);
> +
>         slot = &hsq->slot[hsq->next_tag];
>         hsq->mrq = slot->mrq;
>         hsq->qcnt--;
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index aa5c4543b55f..fc031e38f1e0 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -10,6 +10,8 @@
>   * flight to avoid a long latency.
>   */
>  #define HSQ_NORMAL_DEPTH       2
> +#define HSQ_PERFORMANCE_DEPTH  5
> +#define HSQ_DATA_IS_4K 8

Perhaps re-phrase the comment a few lines above to explain why/when
'5' can be good too.

>
>  struct hsq_slot {
>         struct mmc_request *mrq;

Kind regards
Uffe
