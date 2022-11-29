Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A91C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiK2Myu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiK2Myq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:54:46 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27E1E719
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 62so12882188pgb.13
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ebamB0hBO/VjwPw6mTkFEnosjcg+0KhZfa7b2h9bAYU=;
        b=ez0cE8DNCEM7MmnmLmhoLcu1Fr6mVT4y6a5+eDignOdyaRWvf3V4pnkusq8UkShXkQ
         DZX7EweHxoTIgworrUUp3V83Wu0smJqvcr7HE9Jw2ERUxPC5RdNBdtIM1HPoAVudC6No
         4vrKzXiRPGjDqDwJ7EydMn2yrZjz8z/1mHypVElMqvzPV0Pj66v14TzKb9sXaJNK9B8k
         tRlGjO7nXhCxqkB/DVkgTX8qjycQglKvijgslkk+5GeDPGh55L2tVvwoy3aDZsRh6fDp
         EM+TK5a8fpyUIanXt7Yt0uuozTyObVUbtVeRUlO2efpIRdto5zREzeqP+nt/4YL21wsG
         oqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebamB0hBO/VjwPw6mTkFEnosjcg+0KhZfa7b2h9bAYU=;
        b=z4McnkBJ6dzCME94SGxzpq2AYllW4mr1OxJOURzbEjCqVh9Bllor5RIGpXlE96YbEQ
         t5IAx5zWb9q3CJpYR96DUD6D3xWlPd6/lX6oVecdvTxQbh7+Owh2BGZ49cIRzjyJ8qWy
         MbHuM1ql0zcz+5s7/87/ExZ2e/xUdz8KZqvla90GNfQmDuyxe+e+6/xab/VyU/YMj69Q
         ds37QRkT+by6uEKnhcgjPYCxUKyG7j+H7V3ohkFlK/3IfNyg3ziyRHCmOj6YZe8aKtJd
         SQyWxga3qxe4hZInuJqz9hfYhySZtwmpmFA2NTIo9Gn4fX9uNNthPD+N/BVglR0VnRbX
         B9Ug==
X-Gm-Message-State: ANoB5pkXlUknKk12OpArkfdPnmzIud0m8ddGwJycdxjyzE3nhTKv1l7v
        PX48pIqwAd7hMnLQkTtN07Lwa87sFJKjCGgw14u8YDvfvOw=
X-Google-Smtp-Source: AA0mqf75Qui9+xRewDq95sl3eNVqVZXe0i67CeO5IIpZ0BL51sFV1hK4/G8WAutQZhPUVmWBmPpysm5g2eW2t5Bj4T4=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr28698800pgm.434.1669726485354; Tue, 29
 Nov 2022 04:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20221123021221.9646-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20221123021221.9646-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:08 +0100
Message-ID: <CAPDyKFpi=K=a92Cyph8wh-B6DBZi2ZNyPX0K+Beq1hsPgMKMDQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Nov 2022 at 03:12, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./drivers/mmc/host/sunplus-mmc.c:321:2-3: Unneeded semicolon
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3238
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunplus-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index 5c36daf09bfb..db5e0dcdfa7f 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -318,7 +318,7 @@ static void spmmc_set_bus_width(struct spmmc_host *host, int width)
>                 value &= ~SPMMC_SD_DATA_WD;
>                 value &= ~SPMMC_MMC8_EN;
>                 break;
> -       };
> +       }
>         writel(value, host->base + SPMMC_SD_CONFIG0_REG);
>  }
>
> --
> 2.20.1.7.g153144c
>
