Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA90C3DA6F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 11:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjHXLCA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjHXLBt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 07:01:49 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5571FCD
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 04:01:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fba83feb0so53162927b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692874862; x=1693479662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJk4IWME6WZnVOUMNwZF4Tbaz/pIeHP6xJOYCe2MNEo=;
        b=JPExiglr0NcR9gmjqfOtKhqTCoZ+GIpcZHkXoLnzHQx2rvXmKJSaEo4EVHg2uN8pnb
         iYwnoN88nlqa8HGSm95nEB6gRN481Uf5O5+zK2DItpEo9OjlqtkU159LeXKu4D8SJJQ+
         pThPN2YT5mW+1f8fzVmsmNT0pXxxJq14ocH3FaJI9JrUAFyyArP2m1KH3zrywEmqXhma
         ZFcSYQfcp51872cPlc99e6JHq5+544he0ZiLCkJGaydxKMdYwMjKxcytZTf0dYvpPfHo
         zVWXccq9pqS3ThDluKPUBVfMCjrfm0veJaLWxsWEKW5+wAFWVG5dsyNLJCAmz4BTk2cP
         1Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874862; x=1693479662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJk4IWME6WZnVOUMNwZF4Tbaz/pIeHP6xJOYCe2MNEo=;
        b=ZmBT7ZkAosne4pnGBUfszdBr/xpIyr9emfiAkDsy/vqUnNruuLCelpdRSNliZM/d0G
         y7BxNPedhbYDOCgoRjlo7gX5SJ1uChsX4Eap13m44KsA0s+qZe4CFLbxU6dfP9Xp7JXB
         SggYFjT8/Pch+k65F90jlWnig+ZT6T97HckOAw6uP1QqpZO/XjoM4YhXEBgAj2cQ1pMY
         WH+4ZnYmBko4q8ZpDmf+RdLvcaDqgNB1phBAR4a1DJBSjURVmNsXBnZ1lrx10A3d7KX3
         RVIHJDM0x10O0WpYR/PD6dFi3WuPKFZVUx9/cbSPprCEARSIf4QNc5t8lu9t8PX0/UeQ
         eeYQ==
X-Gm-Message-State: AOJu0YwIrrpoeMiVR4VBXWUcL1AzaxvycP3BFU75mzgoKd2FSQh8OhDP
        gY/W7g8PG86EYbUd43b764+zuZZSj8Sx0DmfdGqDjw==
X-Google-Smtp-Source: AGHT+IEyJLIqk0j3Ygcx2L3vmQ3TrSLWoUiGRyZ7mxxe8fj0nQlDwVH+ISzkOpH8tSg5MBrqxSWyZxzMFvnPUN8i84w=
X-Received: by 2002:a0d:d7c5:0:b0:592:264c:a88c with SMTP id
 z188-20020a0dd7c5000000b00592264ca88cmr10153718ywd.18.1692874862653; Thu, 24
 Aug 2023 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230822195929.168552-1-limings@nvidia.com>
In-Reply-To: <20230822195929.168552-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 13:00:26 +0200
Message-ID: <CAPDyKFofKO_B8h5QY0c_XGaEQQdAeXw8iv52+J+NbJghRhXPWA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] mmc : sdhci-of-dwcmshc : add error handling in dwcmshc_resume
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Aug 2023 at 21:59, Liming Sun <limings@nvidia.com> wrote:
>
> This commit adds handling in dwcmshc_resume() for different error
> cases.
>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next (I amended the patch according to Adrian's
suggestions), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 31c1892f4ecd..bc332a035032 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -630,17 +630,32 @@ static int dwcmshc_resume(struct device *dev)
>         if (!IS_ERR(priv->bus_clk)) {
>                 ret = clk_prepare_enable(priv->bus_clk);
>                 if (ret)
> -                       return ret;
> +                       goto disable_clk;
>         }
>
>         if (rk_priv) {
>                 ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>                                               rk_priv->rockchip_clks);
>                 if (ret)
> -                       return ret;
> +                       goto disable_bus_clk;
>         }
>
> -       return sdhci_resume_host(host);
> +       ret = sdhci_resume_host(host);
> +       if (ret)
> +               goto disable_rockchip_clks;
> +
> +       return 0;
> +
> +disable_rockchip_clks:
> +       if (rk_priv)
> +               clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> +                                          rk_priv->rockchip_clks);
> +disable_bus_clk:
> +       if (!IS_ERR(priv->bus_clk))
> +               clk_disable_unprepare(priv->bus_clk);
> +disable_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       return ret;
>  }
>  #endif
>
> --
> 2.30.1
>
