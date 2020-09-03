Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42DC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D792192A
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsCcqXyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgICIK6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgICIKh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:37 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD60C061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:36 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id n12so580370vkk.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18eisnWBy1lL6GG/nsWIt3CM4+eFkMNzfIhbeVaF+oE=;
        b=vsCcqXyHQIi4uZvLQW6aFn5cqvzT9qvBykDNMNa1WGyCkka6nK4diru80ZM7v20mqH
         Uuq9xo714twU4yaCY61LkPghEVdvRGGFGvuc3T+PLiGjNyZ1ZZknrHE2f3ZhyQjT5bz8
         Uiw3RAPpxjzFRNNtBPmJtYWlqlcKMXEBQ2ustivJ2YZ6xpH93Rh2I5ZAUqi4LC9YQ8Bo
         o170Co2AAaMSjFOOVuc2IrXPieAeOugl/ugKAmwNOOUh7WBoj7mNvCfFrzpYWvoTLB55
         97BDYQd4BTpgjV00rVI8l078Ueod3U1JdPW0jxc4yBzc0vHRkDhBiRmbv1wD0j9GVXjo
         gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18eisnWBy1lL6GG/nsWIt3CM4+eFkMNzfIhbeVaF+oE=;
        b=hNTzAtLu9SCvAJnrYd0AgMeFPf+VfY+nZ6M46d2SR/u3SIGEldgv2vDR1EiQw1sI2l
         1LfmIgvJwlTSgeEb+HvyoOnx+iyQUzsySAYHng8rWqwunccA8MoRptI3JSOlisHOKMPA
         PNE58rA5veDgDaPZWuTZvEOHl4g7uJN/MhmNJeIpl0zkxBvE79EmPFIO/V3YX92IxJ/m
         P73nbu3+NnvCf8m9kMKNcfdKVdoFzMzLiAHmo5/ALmYnwyXyvGWlZcwM6XDJyttkeaL2
         14uRJM+ZrZ2ndnFn76zoBlXmkxaotFePznEH8SvanJqnzFLve486eibcqPF0+CO/Brro
         8hiA==
X-Gm-Message-State: AOAM530opTYVtRZtlI8GbK7HZDP6k256HDz9mgNESfV0U7gNSe8ittsa
        zG83Ydoc7YAc79hSZE/XEkyotXUGl3nPQyrKLwEN/lb4eKgd5g==
X-Google-Smtp-Source: ABdhPJxVLzY2dPrjfxNTc6qI18eW9TM4fEE0Kqv/rA2ePJ7kmt6dVRZpnPvcb0xBW+ENsUQ0YH9YTswRPxsonHrdNhA=
X-Received: by 2002:a05:6122:6bb:: with SMTP id r27mr433666vkq.3.1599120635229;
 Thu, 03 Sep 2020 01:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200902204847.2764-1-krzk@kernel.org>
In-Reply-To: <20200902204847.2764-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:09:58 +0200
Message-ID: <CAPDyKFpi7cCN3SaF4O6fUKwFvtqSFYLyhK_y3akjAa=a-u=H2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: davinci: Fix -Wpointer-to-int-cast on compile test
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Store in interrupt service routine always '1' in end_command, not the
> value of host->cmd to fix compile test warnings on RISC-V:
>
>   drivers/mmc/host/davinci_mmc.c:999:17: warning:
>     cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Follow up to:
> https://lore.kernel.org/linux-arm-kernel/20200902193658.20539-1-krzk@kernel.org/T/#t
>
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index fad1010fb52b..66d740ee7d45 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -996,7 +996,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
>
>         if (qstatus & MMCST0_RSPDNE) {
>                 /* End of command phase */
> -               end_command = (int) host->cmd;
> +               end_command = host->cmd ? 1 : 0;
>         }
>
>         if (end_command)
> --
> 2.17.1
>
