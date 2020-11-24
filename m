Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C52C63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677A620674
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOx0yYMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbgKXO0S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbgKXO0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:26:17 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D75C0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:16 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id r23so6877932uak.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lB2MRxBJ8srzKD3MD7oOuEMNecl+boxLNvEowDgRVEE=;
        b=wOx0yYMVkZywqxGALXE5D2GhhvTyAcByMgA5ykfDQaBzoLk0CCNEafyd//FvSOg12A
         7XXp+bE/2bVW5MgA1gWpKfHBrOaJtvVrPSaQ6/jEjnq2kub5AAfv/ZeGL7lqk2zTOnDv
         bWXei222YU5Bp9aw3lYkkUX6NVL5ADlWFqQL4vbs7aPb41dkY81QHq4mtt/Jk/fFxlLi
         UqALvEo8W/U4vgKVUCuxxrhtm0X4rpKut98jDsTTsSxkdwGMQIN+9BEO2JeACkXq7Puv
         NWEDtkUEInhLjldsoYHrQL+3WHfs0bAfi7dFjkDFKu+mYO3nYqTgrorVGoykdtQt3N8B
         WJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lB2MRxBJ8srzKD3MD7oOuEMNecl+boxLNvEowDgRVEE=;
        b=jHjqFWswJUH3h8PZLAI8iB5aVij1iwGS5aIQjEQuCQ/TWKk0Izj+VlHrePl+6LfgR+
         YUqbsvfpIO9NiI+ojcNZRZc1+qzNNnBzQtHYHjqLtyHoOIJ9lJ5Ljbsb2orC+tt2UXo9
         3q1ffzGf1loFhiNS8Wj3PZdkLyzkZDvla1mTHxMieX9qI6s4/vl/D0fVlCaDiOlFhnKr
         a5anYMIlM9lHYehClUpwoiGInKRvjUgI/wB/k/a8Xr9uSISYMzAS3/Uz6qYtm0CLpepF
         Z8ER+nI3ARL4RvWJlhvaFWxwZBAq0JcxHjbjfFcMLNAjONO0A1A87wdsDoEoT+9rta09
         NNfA==
X-Gm-Message-State: AOAM530YQMjlnwT/K1r9hd7RxLkf5bnQjluSe0hLhS/fdd7W4AtQ1AfS
        GP4Jzit1gh5v6BEQT95xdR708kdiAknrWTZsZ8VdTA==
X-Google-Smtp-Source: ABdhPJwkSTN2k2+cCb/5j1O7GOWf5tHPZQTGClF4XMfIXkqfUU6u0cxa/9ce0K6W+0fRf4/ogm/E49p7+pcsIlV/t+U=
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr2809540uan.129.1606227975568;
 Tue, 24 Nov 2020 06:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20201123203004.18792-1-festevam@gmail.com>
In-Reply-To: <20201123203004.18792-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:38 +0100
Message-ID: <CAPDyKFo71+Quyi108qAa4ZrMZK88CtykXSJDeEF=QLW9RqA7Sw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxc: Convert the driver to DT-only
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Nov 2020 at 21:32, Fabio Estevam <festevam@gmail.com> wrote:
>
> Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
> by removing the unused non-DT support.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 33 ++++-----------------------------
>  1 file changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 12ee07285980..2fe6fcdbb1b3 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -157,32 +157,16 @@ struct mxcmci_host {
>         enum mxcmci_type        devtype;
>  };
>
> -static const struct platform_device_id mxcmci_devtype[] = {
> -       {
> -               .name = "imx21-mmc",
> -               .driver_data = IMX21_MMC,
> -       }, {
> -               .name = "imx31-mmc",
> -               .driver_data = IMX31_MMC,
> -       }, {
> -               .name = "mpc512x-sdhc",
> -               .driver_data = MPC512X_MMC,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> -MODULE_DEVICE_TABLE(platform, mxcmci_devtype);
> -
>  static const struct of_device_id mxcmci_of_match[] = {
>         {
>                 .compatible = "fsl,imx21-mmc",
> -               .data = &mxcmci_devtype[IMX21_MMC],
> +               .data = (void *) IMX21_MMC,
>         }, {
>                 .compatible = "fsl,imx31-mmc",
> -               .data = &mxcmci_devtype[IMX31_MMC],
> +               .data = (void *) IMX31_MMC,
>         }, {
>                 .compatible = "fsl,mpc5121-sdhc",
> -               .data = &mxcmci_devtype[MPC512X_MMC],
> +               .data = (void *) MPC512X_MMC,
>         }, {
>                 /* sentinel */
>         }
> @@ -1001,13 +985,10 @@ static int mxcmci_probe(struct platform_device *pdev)
>         int ret = 0, irq;
>         bool dat3_card_detect = false;
>         dma_cap_mask_t mask;
> -       const struct of_device_id *of_id;
>         struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
>
>         pr_info("i.MX/MPC512x SDHC driver\n");
>
> -       of_id = of_match_device(mxcmci_of_match, &pdev->dev);
> -
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
> @@ -1044,12 +1025,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_seg_size = mmc->max_req_size;
>
> -       if (of_id) {
> -               const struct platform_device_id *id_entry = of_id->data;
> -               host->devtype = id_entry->driver_data;
> -       } else {
> -               host->devtype = pdev->id_entry->driver_data;
> -       }
> +       host->devtype = (enum mxcmci_type)of_device_get_match_data(&pdev->dev);
>
>         /* adjust max_segs after devtype detection */
>         if (!is_mpc512x_mmc(host))
> @@ -1241,7 +1217,6 @@ static SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
>  static struct platform_driver mxcmci_driver = {
>         .probe          = mxcmci_probe,
>         .remove         = mxcmci_remove,
> -       .id_table       = mxcmci_devtype,
>         .driver         = {
>                 .name           = DRIVER_NAME,
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
> --
> 2.17.1
>
