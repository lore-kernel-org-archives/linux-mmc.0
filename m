Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03EC433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 07:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2A0619CA
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 07:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhCaG7s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhCaG7X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 02:59:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB3C061574;
        Tue, 30 Mar 2021 23:59:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so8868295pgj.10;
        Tue, 30 Mar 2021 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJOBofPObDNYMGsBSlhGej7Cpe8ovuQ3/ENLYS3IMVQ=;
        b=MTHH0ApwlbyIykIs64IpY5gSDyGQts/pyHYUmrlhRKLt3YIP35F36aeqR6Zc0PONd/
         huPaVqNR2lkG6Eopm8qlahqemxdn0crCmMjmAQejTQIcqKudX8KWMcIjwZJq2+K6Yl62
         XptbiXh7LQMScWgepLmKWplHHu4JLsScfmexXfFFipp948HHEWACTPRYX2jNYPSnkl2j
         nLthNM9Dd7NVSSh9b01Y/2VlbeflcjHJs5AaC+ibRA4xSMz1GG46lH9OEgMWNBPb8+TV
         kzOg8zGe8p9IuDycQX/4NKtlnyXx5veHCCfxuifA9u48b2l+bWqMypDLkaP6Bqu+8asZ
         5lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJOBofPObDNYMGsBSlhGej7Cpe8ovuQ3/ENLYS3IMVQ=;
        b=VF+P3dScT9XVA84rNnvgxgb4ep0pzo+DUm9rJQO2lK2Kb8CPuM1dweVpJAJMiZl5zq
         2BmXBrmYcydFtZ98LLiJYrFwXLLZHxt1uR6nirNxu07OGzVnoS4SCsGdK5PmMHinIUNI
         FN8dql/Ms0emJcrmvMwm/pqOQTBKOlUIHp2Fhcw66ab/5uxYKsQwGSTkMORPWt+oSPM/
         ECPps2pI/6iytRwdF20YP8FfZlaoXPzqmZQI2COrEH3/tOyKHgNvmdY4DqpHjRMl9Rb2
         jOizVUboP6GsCXyCCvEB9qNyV9QGAzqFX3i+C6iB5Cr+KVd7XDw2qhFUAYw+Yail86+h
         DfGQ==
X-Gm-Message-State: AOAM530cWGGOhoKQZfdWJpwxee7BvP5CVxoPXPymTB69iLbzppMFZdjb
        Ru96K1VFi/YLCMH0RWfXvm06wVjwLkXWG8czEMs=
X-Google-Smtp-Source: ABdhPJx0/mRvSYPq3REz2mXyxcPF6tbk9kRbQksLbTIpgbKUzsHjVll09iDn811ekJYlT5uB4STSeVkjXl7Xb2AvKm8=
X-Received: by 2002:a63:cc:: with SMTP id 195mr1878785pga.282.1617173962706;
 Tue, 30 Mar 2021 23:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@gmail.com>
Date:   Wed, 31 Mar 2021 14:59:11 +0800
Message-ID: <CAMj5BkjT7nBst4pa+Z6WKtfxhOYPLr3wcSU2ONoOqscu5uqCHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 30, 2021 at 2:46 PM Hao Fang <fanghao11@huawei.com> wrote:
>
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks for the fix.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

> ---
>  drivers/mmc/host/dw_mmc-k3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 29d2494..0311a37 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>   */
>
>  #include <linux/bitops.h>
> --
> 2.8.1
>
