Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C583C47084
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4958A61370
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhEXOCG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhEXOCD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:02:03 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE2C061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:00:34 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id z14so8257218uan.7
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhZvYF2rrfsZa6Xf7+GPLv45uKVXrZPOlQNANCKECQI=;
        b=QFwnDovX8FbineGyWDzBEnowUBB99r0szO6EctLouJ+VM2LiCGRhsvhsWGG63bQ38u
         L8737OQdQqtbmzB2DOFHbAMHFz4mbgFynB6Hr6LEPzS2NlZebCoksFMUbpIrF5cEwx7B
         T/9TaMS4c84GbC8mE2fvp1gao9RKc70VhhCRbiSPgOwHjT4x4MyLQ3y1AeJYjQvkEDI3
         hTtFD7vvnj9PNncgtHBXpOzlA5KQG9P4JKmzwSe61ZYFSHnEWhrel6yZkKW/kbqSnTbg
         QZOdLzAcRz1zB3xj9RzYvlmwEpHqCOREpVzye076+kpjJ8eDCQmKr6UsQZJa1pqzWEHI
         lPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhZvYF2rrfsZa6Xf7+GPLv45uKVXrZPOlQNANCKECQI=;
        b=jwqt6xbAK1Hzf1YnDQXWklRINmmLIOhEzXFzl6SXc5Qkt51TPmeu0If9XRCYZGloOm
         WD0+gyOYdJzrmhsE+N5bkDQ5mlOaYATC8Jnsop7TFJsGcJ632oesvLkKn1m242BkUZnC
         07WuP3IV1GAIiv5nF0QtihMEgvbLXl6A+8nWl/rz9qo1VvzXjbz/1ViBlEhR6Jq4mtP/
         IsCeBKSvZI5s9EJ3jyBKoVhwUpXwZbFDXcvkYnPe4lw9VhihFWoMtifBxJX4KbGOZmWO
         Tw+qp3LMsn0rpUkIVPCcjSL7CUjAvabg9E9XX0+0SEVRcfo+Ut3uSbwbPIR4qUA+0ARz
         Reog==
X-Gm-Message-State: AOAM530ca0DbxEExsoWXYit+91Kg/+uJg7DHFBR5Dtx3WUgFCB1MqJHT
        UciPq8sfXInAwmH2/uJTpMlMucXLCYF3E/Up5/e4Fw==
X-Google-Smtp-Source: ABdhPJyTkuNIXW/4VTeu46rTAPJNrdcFFBw/FDfMkyZ8gV3dDP2TWej1nRS1wo4Y1zZF3ITB+QVUCzn16nazwshQD3Y=
X-Received: by 2002:a9f:24b4:: with SMTP id 49mr12816796uar.100.1621864832999;
 Mon, 24 May 2021 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 15:59:56 +0200
Message-ID: <CAPDyKFrS3wdYs3AQtjZEOsLzNvxgy1n3EfxZ+a8w8J8rH8kQ-w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs-mmc: Disable the 'reg_vmmc' regulator when needed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Chris Ball <cjb@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 May 2021 at 14:36, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The 'reg_vmmc' regulator is never disabled. Neither in the error handling
> of the probe, nor in the remove function.
>
> Add a managed action to do the required clean-up before a 'regulator_put()'
> call.
>
> Fixes: 4dc5a79f1350 ("mmc: mxs-mmc: enable regulator for mmc slot")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mmc/host/mxs-mmc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 947581de7860..b043d53dd728 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -552,6 +552,13 @@ static const struct of_device_id mxs_mmc_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
>
> +static void regulator_disable_action(void *_data)
> +{
> +       struct regulator *regulator = _data;
> +
> +       regulator_disable(regulator);
> +}
> +
>  static int mxs_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
> @@ -591,6 +598,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>                                 "Failed to enable vmmc regulator: %d\n", ret);
>                         goto out_mmc_free;
>                 }
> +               ret = devm_add_action_or_reset(&pdev->dev,
> +                                       regulator_disable_action, reg_vmmc);
> +               if (ret)
> +                       goto out_mmc_free;

Even if this improves the behaviour, there is a standardized way for
how we deal with regulators for mmc.

1. Call mmc_regulator_get_supply() during probe to fetch the optional
regulator. If a regulator is found a corresponding OCR mask, in
host->ocr_avail is assigned.

2. In the ->set_ios() callback, invoke mmc_regulator_set_ocr(). This
will also set the correct voltage-level and turn on/off the regulator,
depending on the requested OCR/voltage-level.

>         }
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.30.2
>

Kind regards
Uffe
