Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30203C64E7C
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E537720674
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRRwGoRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbgKXO0W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388969AbgKXO0V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:26:21 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21EC0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:20 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id t15so6883579ual.6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6kP5uAmhVMOzDxA6JRa0F12t1u+ZcnAagQa2SKiwLA=;
        b=hRRwGoRElSR2T9ojKPNq6hH87KWAabEVIok8dYnucsnQBbb8tpOF1wGTz6sOdto7eq
         1nsXjkoSgBGwRCYPa4lZup1Cm3gOsSRzukH59LLcmjF1qReOty3Q4HQki8Z4BFndm3z9
         gF3HdHzFom+zLJq+NERYeE8hqrLblVnyd/Z7Iz7B6gFOFypbROnwFi8uUO6FaxvWvsPC
         u75y6ok6hJI70LncHTiuJgGS7QsBPDLetnPesTzwZbgcIhuvRZ5UZlX9IgTU4oYAGHy1
         aiOAo/TXzFg7GWXwcRsFlFVXx2+5HuiNYTrDm+OnsAuWlZFVaKcBFTkYpkcnLsVaVvIF
         r8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6kP5uAmhVMOzDxA6JRa0F12t1u+ZcnAagQa2SKiwLA=;
        b=soP1AFTil6I1VBTiaRX5ByYDi1RZqyIi9c/djamlbKAIpN4LKO/5WZ/CFQuF2rB/t9
         NMA/vQX1LJQXJCzVkW+8Cx24eR/zuTAvzfZGnrqCImQAsBUR8jyK3zRGAwlf/p2FIjGn
         qPlMeNWpzL/YwcMeoccFktf+k0a+4uPh5KLqHviLP5SbH+1S2wmJMgIP72mYCWMUj0A1
         Tyh8OZN99MOUh1cqT4JrrlS6E0qZfyyTIPa+OmBLcA6I5+hp0iklbnN1OcFfPGREQ0Zf
         JOmOjRFImHVeXKUq+RYzhIzHMzQXvkeI45xIq0gQ1OY3DrcNrozDWNN3RdE6ALJl7ZdH
         QG8Q==
X-Gm-Message-State: AOAM5335QX2U4vZRUjs2zPqimrbc+NITm9hCQJIryloogGjflRqvBat+
        wz0RUWFPvKb0i3pwG3AtgfR8Eg/QW4JwaJmG4OliPONIQKo1rA==
X-Google-Smtp-Source: ABdhPJyaXPzNR2z6DXfGmcxv9H7D3lmtRqJBFg9MIduENmWy7gIduw3rNtllzyQbi8ilAuKcw3s8UvlNRShdqKjfAgA=
X-Received: by 2002:ab0:5859:: with SMTP id p25mr5654647uac.100.1606227980214;
 Tue, 24 Nov 2020 06:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20201123191956.10542-1-festevam@gmail.com>
In-Reply-To: <20201123191956.10542-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:42 +0100
Message-ID: <CAPDyKFrBKJyWApnOHzeHnQ3RFuuYm-44iOR3MwY5Xe-j9tboSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs: Remove the unused .id_table
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Nov 2020 at 20:26, Fabio Estevam <festevam@gmail.com> wrote:
>
> The mxs-mmc driver is only used by DT platforms and the .id_table
> is unused.
>
> Get rid of it to simplify the code.
>
> While at it, use of_device_get_match_data() to retrieve the driver
> data.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 75007f61df97..56bbc6cd9c84 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -545,19 +545,6 @@ static const struct mmc_host_ops mxs_mmc_ops = {
>         .enable_sdio_irq = mxs_mmc_enable_sdio_irq,
>  };
>
> -static const struct platform_device_id mxs_ssp_ids[] = {
> -       {
> -               .name = "imx23-mmc",
> -               .driver_data = IMX23_SSP,
> -       }, {
> -               .name = "imx28-mmc",
> -               .driver_data = IMX28_SSP,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> -MODULE_DEVICE_TABLE(platform, mxs_ssp_ids);
> -
>  static const struct of_device_id mxs_mmc_dt_ids[] = {
>         { .compatible = "fsl,imx23-mmc", .data = (void *) IMX23_SSP, },
>         { .compatible = "fsl,imx28-mmc", .data = (void *) IMX28_SSP, },
> @@ -567,8 +554,6 @@ MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
>
>  static int mxs_mmc_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =
> -                       of_match_device(mxs_mmc_dt_ids, &pdev->dev);
>         struct device_node *np = pdev->dev.of_node;
>         struct mxs_mmc_host *host;
>         struct mmc_host *mmc;
> @@ -593,7 +578,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>                 goto out_mmc_free;
>         }
>
> -       ssp->devid = (enum mxs_ssp_id) of_id->data;
> +       ssp->devid = (enum mxs_ssp_id)of_device_get_match_data(&pdev->dev);
>
>         host->mmc = mmc;
>         host->sdio_irq_en = 0;
> @@ -723,7 +708,6 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
>  static struct platform_driver mxs_mmc_driver = {
>         .probe          = mxs_mmc_probe,
>         .remove         = mxs_mmc_remove,
> -       .id_table       = mxs_ssp_ids,
>         .driver         = {
>                 .name   = DRIVER_NAME,
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> --
> 2.17.1
>
