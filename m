Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B383C43381
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EF66525B
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCIJDC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhCIJCf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 04:02:35 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BDEC06175F
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 01:02:35 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a31so4270290uae.11
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 01:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTS4jcamZbNk8wX2IQOPXMrKr/myqA0Gbr1rtO1bGCw=;
        b=v0jdExRcv1ZK6Js28rL+CxBuo42P4nU38B9hxVxMw7XdXOw3cGNjORJQk5X9/tO01M
         /Pvwn/dkDn3GH+DPLAWH0MR6pdLfGaIppwoyDMbc3et5oamhZIOhBRHY89Toh/xE9JtO
         epvfEx065vhO5KwhYh7mjkB1beNS6XOKrgfHg9grblOVeRMccDZQdseYmHzqo9QNu9Rx
         E1ZS7jox0Z2a6rDADMyvI0V4NjbF7zrNBzI/2Anhe7pmyfGtPe7HO1ljGGYCMd+TNglG
         QlmxYo/MlxkPGTirClDDCsJWBvp6+xQMswBToVFqs5+th3/bazHqQhlSwoxUv0Kt/D4C
         5hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTS4jcamZbNk8wX2IQOPXMrKr/myqA0Gbr1rtO1bGCw=;
        b=ndHor0EHTBgrV9QYHEylNp0G1On3gLYcJkrt23OiARkTq9mLEZ95E69G655QntR84J
         j5nm9bindGhHGg+G3Mi7kx3jGJ4qbXMzbJbow7OacRon08AEwaJg1Voj6plB+ZnR+fGI
         d85NEj5YSSpmWIK+NAiSZUMgCbib0W5Y+mkfNBnD+3Cq4HVar1UySO46wbWk7Cx5Xg/x
         DoZznC5X8V4Qc/sKWaqVND2yzfk6F+y8s3bTeSJGldfNTIFt0YS2PDDEpNTeA/87xBvo
         VEw/hSDAzYiFYhe+JMsV1bZwzTYDj2OYGvFo8ZOdxW3gM3kI8Nde7bu7WYVXj90EFOtB
         Er5g==
X-Gm-Message-State: AOAM530d3yG6awuEG39DTIf3l3Qm8JWYtFG/73Re/pwC+Es9TWVyzrhZ
        0DwK+1pOlqMKtL2xsayTgXc2/zjG6d/IaxAErO1t2nhJaf4oJA==
X-Google-Smtp-Source: ABdhPJyU9pLHDctMoyDBwL0mk0d2cmk888NY/n8Ux/igMFANmuCDrhZwjctbhB75uGHw+rUcLoOuPvAaNiQgQrEGa40=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr15745542ual.100.1615280554230;
 Tue, 09 Mar 2021 01:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20210305090724.18832-1-p.zabel@pengutronix.de>
In-Reply-To: <20210305090724.18832-1-p.zabel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:01:57 +0100
Message-ID: <CAPDyKFrfeigvZBVvJUTXWgZCNpPORyHdfuXCbKKjZ-1xpoD-RQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: simplify optional reset handling
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Mar 2021 at 10:07, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2f4de30f650b..807f77fefc20 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3095,10 +3095,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>
>         /* find reset controller when exist */
>         pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
> -       if (IS_ERR(pdata->rstc)) {
> -               if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> -                       return ERR_PTR(-EPROBE_DEFER);
> -       }
> +       if (IS_ERR(pdata->rstc))
> +               return ERR_CAST(pdata->rstc);
>
>         if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
>                 dev_info(dev,
> @@ -3204,7 +3202,7 @@ int dw_mci_probe(struct dw_mci *host)
>                 goto err_clk_ciu;
>         }
>
> -       if (!IS_ERR(host->pdata->rstc)) {
> +       if (host->pdata->rstc) {
>                 reset_control_assert(host->pdata->rstc);
>                 usleep_range(10, 50);
>                 reset_control_deassert(host->pdata->rstc);
> @@ -3344,8 +3342,7 @@ int dw_mci_probe(struct dw_mci *host)
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
>
> -       if (!IS_ERR(host->pdata->rstc))
> -               reset_control_assert(host->pdata->rstc);
> +       reset_control_assert(host->pdata->rstc);
>
>  err_clk_ciu:
>         clk_disable_unprepare(host->ciu_clk);
> @@ -3373,8 +3370,7 @@ void dw_mci_remove(struct dw_mci *host)
>         if (host->use_dma && host->dma_ops->exit)
>                 host->dma_ops->exit(host);
>
> -       if (!IS_ERR(host->pdata->rstc))
> -               reset_control_assert(host->pdata->rstc);
> +       reset_control_assert(host->pdata->rstc);
>
>         clk_disable_unprepare(host->ciu_clk);
>         clk_disable_unprepare(host->biu_clk);
> --
> 2.29.2
>
