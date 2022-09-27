Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF8C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiI0MO0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiI0MOS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:14:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66560AFAD1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id iv17so6393174wmb.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VNMJ8dAUFpnWH5my97l4aBgOKeowx7PWc9A+8a4PR10=;
        b=Opaisrf0YyM9ixDUEygxXwqhLUcxRIYHwPrAdD1EsngI+gSnI/P5zTxmU4bHQwEbZ8
         mLS0ZeKunZyelGY7r82jc+c5L3r/JpLt8UQpXsMKRmpz5Pz2xtF+J8jjul5+9LnuS92y
         9cO+ajXsttOxz6Qyg3KHTsGYzFnpF84e9Jgo3zX63DixeXqh8pwgY67PmOvHafSrJixr
         D+mGcn1nE1vTyE4IQ0J8ipqVDJDMOsusEDI+X83E2+//Hnt8lp5exKgzO+Fwqki9Obev
         NMj8LPhCmysizM4Y+L3j8Zh1R462w6ohWMR5FQU626vJckfUGFcOznxcydQY/ogLDdnF
         akAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VNMJ8dAUFpnWH5my97l4aBgOKeowx7PWc9A+8a4PR10=;
        b=dzDxZ7m4z8CN/5UFWl916pXdNIul6x11E7tbCJhXYpnohKiJWyg241zQKKwE9KjK+b
         W4cGgQbDxyKHAT39as3LGB08okI9PblCJZrBmFIHl0+7KWBiZJMZuruE7j+/PriPQ96x
         2noYHPgYjIW5eyhWr06uf4LTSqnJ287kDogvt5MUC/bT/wq2jtMhIjEBnOVHXmyv1oRj
         eR8J3PGJqvHqk0Q6heU24GbHTSPSwi8j93U7CQog2zuJiJ6WXCCp7QD8T+eRa8qqZIZc
         MwzQ1g2y1iNtWO4bSAYcapYTZEBz3wH5hCMQVxCZh4h4GzrRnamwWlK4B+ndVwt99MUg
         A5Jg==
X-Gm-Message-State: ACrzQf3s8EGjATl03MpHN4vhkbzCRiIiXYWNqt031qeZuZb/dCgK/rI7
        L5UDDDEdzh8uRSHDkJwQqxLI9V4vemK97+zuUW6+sg==
X-Google-Smtp-Source: AMsMyM5xwt8GtZ5GqRGo+ZWthPbEfmJgCcSjohJZ+6LcAxXTNx9DpuzY2FpP0asC0lryGBBctHMQcUWoC+0O6+WUrgk=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr2366068wmq.17.1664280855969; Tue, 27
 Sep 2022 05:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <53fc6ffa5d1c428fefeae7d313cf4a669c3a1e98.1663873255.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:39 +0200
Message-ID: <CAPDyKFrLvXhnEgx5JjvnUnrTWsAid-2Wvgj3ypEU5AetkT+6JQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cjb@laptop.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 22 Sept 2022 at 21:06, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A dma_free_coherent() call is missing in the error handling path of the
> probe, as already done in the remove function.
>
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
>   * Add and use the (ugly named) 'fail5_and_a_half' label   [Dan Carpenter <dan.carpenter@oracle.com>]
>
> v1: https://lore.kernel.org/all/bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 163ac9df8cca..9b5c503e3a3f 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -846,7 +846,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->clk_sdmmc)) {
>                 dev_err(&pdev->dev, "Error getting clock\n");
>                 ret = PTR_ERR(priv->clk_sdmmc);
> -               goto fail5;
> +               goto fail5_and_a_half;
>         }
>
>         ret = clk_prepare_enable(priv->clk_sdmmc);
> @@ -863,6 +863,9 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         return 0;
>  fail6:
>         clk_put(priv->clk_sdmmc);
> +fail5_and_a_half:
> +       dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>         free_irq(dma_irq, priv);
>  fail4:
> --
> 2.34.1
>
