Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73B9C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1D207FC
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SELbjQE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHEG36 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEG34 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:29:56 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74927C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:29:56 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id n25so8477307vsq.6
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PafBHgWX9Ed8Ls29XGCsvQo6W85zGUK4SY0StMcf7E0=;
        b=SELbjQE3Rc8NELPLzVKZILxdKMjbNPzHyd0Awr5gaQeDLxA6JLBa8CPgaUJ1T9YWxo
         DkMwT7lYT9LCU8zg6GQuOKmB0YsmPC9UjtOe235Q3uLRct550j8piRqET4CcZ8+zgcD0
         KahPFoqPQccvgsMP8M5LZ399tqk3ZUi6OVKVoHIM4ATwSHIceUIt8UZbilgsfHaRa8NH
         vKljP5BU4kePGjIbsvB3WQM0Fq2dUKB9BGJubAAaeL3HTJm3b6PTumfJ9XMtkVrt8cgP
         sCu/PvIuLa8tEv7OBDwH1tBTfKc8JoEh2Bspf3bpvcEAiAZByKAXFU7qfwWWamiwXIHf
         u4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PafBHgWX9Ed8Ls29XGCsvQo6W85zGUK4SY0StMcf7E0=;
        b=AAVhAKjElIMcvrBQ1P7DBIVqgXknoIbxQ/5ydzHv2apTxS7uqdcsBEjuzaJ9LRv2yM
         Y9YV5SU+i1ISFZwzkcWVxF4LrzJKSAx1La0HBYR/RPboRXAgaNrKsguAQ7BGSRYMnnwu
         LadlpQS7J9r0WKen4GcgZHCh4cWd5RN6Syf9MolnrEGrrr4fRsDOvFu4tPykQt7CXlDi
         l5X6592nJOqkSmpU41bBJ+XFUPC4So0ZVrnFC0NzIWvSt6+IGooqs62AizAqVUJKFgiO
         pIw36xb5DkqIwIHr/KroqxS+SQndVvUMFqhhukm0/qVJUrpVUZzU4Awmh8qnwSw+CDeq
         lwJw==
X-Gm-Message-State: AOAM531WWZWR4oJUMajTGpY5FJQemqOWryHTaxxcYssJwqm1hu+pxx+e
        WP2mmiCrBpq70PocO0l2gsL8QpThjbiRlJKoBpa4rQ==
X-Google-Smtp-Source: ABdhPJzKr8nfy+DUtqVT/z3MLTu+xXv0yuzs0sknYVoyC0Fe26DahYb4Hw/jMmaoR+FMGZfzcJq4hAnWmnogcVRnsFo=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr900047vsd.200.1596608995671;
 Tue, 04 Aug 2020 23:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200727171129.2945-1-weiyongjun1@huawei.com>
In-Reply-To: <20200727171129.2945-1-weiyongjun1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:29:19 +0200
Message-ID: <CAPDyKFpgBJ9YonJNvF-gtneSjn7furi0DD6i=SWxj-4JMQLU5Q@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: mediatek: make function msdc_cqe_disable() static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Jul 2020 at 19:11, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/mmc/host/mtk-sd.c:2269:6: warning:
>  symbol 'msdc_cqe_disable' was not declared. Should it be static?
>
> This function is not used outside of mtk-sd.c, so this commit
> marks it static.
>
> Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 734e403a142e..4e2583f69a63 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2266,7 +2266,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>         msdc_set_timeout(host, 1000000000ULL, 0);
>  }
>
> -void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> +static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
>
>
