Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136EC61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 12:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBNMSx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNMSw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 07:18:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05EC2596F
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:18:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s20so10020937pfe.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676377130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGtzT5YWXxWjNNkuQ9gWwOTNnsMeD7tw5byiprIN4cQ=;
        b=lwoL8JOmxVzeal8ZcwYU935i9/fofLq9Am0W6fI8zNqQ94gq7zAbu8Va1ZFsC4oLIq
         AC7WBoIZv/j9l4obVOpMMlcOQxvmnv/RQ0I1dmLKLSK09ezQb79xs5gmxEjXuRkR53Hz
         v//LJWA9dsCV/N2bAMLRlAbLkyJjDcEOajJUmEIN7V22awKABDhw5LppYUBf4m24K2vF
         YlRTTtbEl3gktFEthxpYzswVFjfe755pPUV9D3cqZnR8y/JZSEauVzIQKMC6M3jTv1Bt
         fuYakdUh8z1bwAi3QW1R2fuUpF1Ny+rop6VvVq4ccPEIg+v6OzjwQxy81XxrMIklJpvv
         53Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676377130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGtzT5YWXxWjNNkuQ9gWwOTNnsMeD7tw5byiprIN4cQ=;
        b=xTjlWGNQ9CgMj7Kp01Kvk3/w2IINhjHgeM1p7BjjUcTm0D0AGFSVhZj2giqr8xrEXr
         Ywt1qLQYr6kb/KbHWDhdeGP5l5Wogx28HYv3md0mezmAal8mjffEZnEKFuoNEwYgQcIo
         xDe3jI7fAiUEeJSJ1HPVufKDJTeR6niWo+5zP33nLZHbKO0DgSJpeRftAYBtUSCMXRda
         ij+VYq/sVJoLqSKH4az4EDdOYISvBDeq7mzE8nuTEq9EGGoWcqodFjg3KTWTPyx6fdJb
         nUa4VRLah2Gvq24Vhrjb9r3tFiXRb2cjYrQXmaDN57rrfwNYdy98qsVD3+dsMeC5210r
         N2Ew==
X-Gm-Message-State: AO0yUKV+Xa8NKaJ57SgvRxMXWfKcu/POYUE73447kEEdN87c31/ibfuR
        zFTg3loysqKdXDnVflR/XmVCprhqAv4uXpmzAjl+QQ==
X-Google-Smtp-Source: AK7set+8WtbFOF8a0OL3em7goljF7W2Nln+84rBr3Y0jpvBFfiTJImlY4BKDpILrWAIOgO0OoF8iFTeSqsXX21Wgwg0=
X-Received: by 2002:a62:1784:0:b0:5a8:bdd1:6c53 with SMTP id
 126-20020a621784000000b005a8bdd16c53mr442860pfx.9.1676377130386; Tue, 14 Feb
 2023 04:18:50 -0800 (PST)
MIME-Version: 1.0
References: <f57ad0f8fdf663465bca74467c344dfa305a3199.1675305696.git.limings@nvidia.com>
In-Reply-To: <f57ad0f8fdf663465bca74467c344dfa305a3199.1675305696.git.limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:14 +0100
Message-ID: <CAPDyKFqiUqufOPaezZH4bQrxwD-7kQ6fQp4Ypf0by72Z7i4d9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: add the missing device
 table IDs for acpi
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Feb 2023 at 16:29, Liming Sun <limings@nvidia.com> wrote:
>
> This commit adds the missing MODULE_DEVICE_TABLE for acpi, or else
> it won't be loaded automatically when compiled as a kernel module.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 49338670c89f..eddaed07755a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -446,6 +446,7 @@ static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
>         },
>         {}
>  };
> +MODULE_DEVICE_TABLE(acpi, sdhci_dwcmshc_acpi_ids);
>  #endif
>
>  static int dwcmshc_probe(struct platform_device *pdev)
> --
> 2.30.1
>
