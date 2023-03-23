Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC64C6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCWMOE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCWMNq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760923C7D
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5456249756bso95623627b3.5
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxdfkNfg9Cqx5PYmumxkm8NMkeCxgHCaWOIO7seRGFc=;
        b=Oc5CC7lkTCcR+4UrY3yOys4sw49dgOCf2d5z51X3K0DuBDgj3jifHLKiXt0FJw3gPj
         pbghvApM4AgjcaL91jsik0stF+kvYUY19NsBmiaefZ1B/NbhWme7+70jgOmxsiCLzfMV
         XKKphWjjwAAuMYbLFQFxLbcAH3g3Mn1gfTD+JZItMNK/RRfOe2t+lOrynVrDbZG6YcxH
         QPFulzsnm/qEpU0MAW9sdNl6RCqTZ/+nYK8QJ0tXfJA5z8VkRTrftoG9A6V9UrBM5npy
         19EwLyDH6UJIFbJDW7W3Ci7pyqwZppyfUZD3IMkRHqsC5XyubAvqYDXowWrsKu2xp6qE
         MA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxdfkNfg9Cqx5PYmumxkm8NMkeCxgHCaWOIO7seRGFc=;
        b=OvZClcr6O1t04ynuy0Mc/yaVnGiDPPcjAbj6GXxHVkrkwZh6ocOsUSpwhSumrwmZpt
         t/KtKHKx83YBvOEdVYPE0NqWHegrRbrKKmaKX0jO9d0dAqhdWKR2knKq9FmHEX+4tf/c
         8VyUw0JrLq+1DW4PQs5GwGPevsZzPZEQOQWaPNqghVbxzQtWocN8Ucy3e2wlraFSwQkN
         ELVcT8/Hbs0U/WvDhiPWN44o1IQrabAjfoyRhym5jJnOIC6AphihFsk8wXwQk4cQNOrl
         PzL3RPrn+Y35Nnz9/6zOQR9cd9Iqw7JZ5qozMS2Ii+GDdb86fmGbZZJWyAXuOBbxbgnU
         0oOw==
X-Gm-Message-State: AAQBX9fZC0Su02SfTbU0hy3ITrS83POCZi3f+K8U71GyEg1Pupdx1B1E
        WYn/y4r+ZiZs7poy2qlo47Wn2A6WiMba+yczDfo7Rw==
X-Google-Smtp-Source: AKy350Y1gToqF8IQePPQcs6V/flQM1zYWsO0bWIIjsJI3krL5ltJnWiQ2EPXtgKJDKpk0TDLCWLLljtGESt2ExHdzgg=
X-Received: by 2002:a81:b388:0:b0:541:7237:6e6b with SMTP id
 r130-20020a81b388000000b0054172376e6bmr1609332ywh.0.1679573618392; Thu, 23
 Mar 2023 05:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230315055355.66733-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315055355.66733-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:02 +0100
Message-ID: <CAPDyKFqeQf-eiBjY_Wi58ZLAGH=L0Dec=OA+UFZZ5RYVAzRdGA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: usdhi6rol0: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jesper.nilsson@axis.com, lars.persson@axis.com,
        linux-arm-kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 06:54, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 99515be6e5e5..2f59917b105e 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1790,8 +1790,7 @@ static int usdhi6_probe(struct platform_device *pdev)
>
>         host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->base = devm_ioremap_resource(dev, res);
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto e_free_mmc;
> --
> 2.20.1.7.g153144c
>
