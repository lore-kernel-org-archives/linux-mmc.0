Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3368EC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30E364EF6
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSOM5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCSOMx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:12:53 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB492C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:52 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l13so3543878vst.8
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgY5oS5JD0LkQM2lwu3CpZFSfbLv5JKHmaydnspzw0o=;
        b=AcZ/yt3NT6a5h9uW4RBmru375KAR5RLpLfXaIZdquY9oh+j+fI1UjLs5QFYD1v4Ph7
         A79FdOtrG+BlAaDogNH3c4i0abZA1ME6U1SnC9ihtPacoybaXgosN+4qS5Gf0tDFEs8e
         iHHevHMPMbuFwa7j75Qv+MK65Z9uknRAbHaFj0EzuIdzdiiyNtRov33/OKQGuTwLOO7a
         NGu1+E6vAmKGxVnJzWx2Qjvo+m+qPhzT0qNFMSPCQ2qqg2GCgWGYU1QpcpwS3HaCEcLN
         lJufWog2A/G2NAMAkN4p/Jqo+MwNypI+/awYZ+x0AAwpsDc8lUbLbNIfKFOBoxmlMes0
         aUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgY5oS5JD0LkQM2lwu3CpZFSfbLv5JKHmaydnspzw0o=;
        b=KIec9Bbsb7M3liNvyw4dMNnU6TW4mjgA+P/d+dSwEent8Wi3+i8BuvVYq0Ie7bH5yj
         EryBDZJppGztVSdN0N6LCrdCXXzkioownjbem72kozsfELkWXyWIW5OD0DIJYX2MG2az
         sCmefg+fjfx/rfmgf1tI+mJXNNWYcEGpFotF0dtzpTR9U33IwKRcPbrdnublb1L/mkBN
         ZaT+wodXUuhoFDXGBCdIcdwL0HNQURCMF2g0RUVnu+Sa8qcCWAn3nkH8iC6KEzxsxwgd
         s4e6PJXrv7sCHey8qmknXo2pCJRp71gn0ZY11upkvHkL13k2sq2Is2+jYhtJCFvBMzG3
         qKOw==
X-Gm-Message-State: AOAM5310GYVqnzlfIcVn7Z/BBpHTJ/nDZiM80VzLBNTMe+is+ioSGeAZ
        G3pzeu+Aj997Wsm3jcyLIeMUUd3WKZNAiNVB1ArHWg==
X-Google-Smtp-Source: ABdhPJyAl88Wl0xWeIt1wF0bc/PwVVv1Pr3JHCbULstUBaXyKrQfMm/DoNjuTekjGpkIJUfp8rYo6HLSetMBJTImvx8=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr2864627vsd.42.1616163171932;
 Fri, 19 Mar 2021 07:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210314230824.148969-1-festevam@gmail.com> <20210314230824.148969-2-festevam@gmail.com>
In-Reply-To: <20210314230824.148969-2-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:13 +0100
Message-ID: <CAPDyKFr51RotTmPCYn0pWjR9z2Sxt-06VHojPOnjuH6yc2zMwg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: Use device_get_match_data()
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Mar 2021 at 00:09, Fabio Estevam <festevam@gmail.com> wrote:
>
> The retrieval of driver data can be a bit simplified by using
> device_get_match_data(), so switch to it.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - None
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2a1fb1cd4433..d309cc620fdc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1507,8 +1507,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>  static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =
> -                       of_match_device(imx_esdhc_dt_ids, &pdev->dev);
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct cqhci_host *cq_host;
> @@ -1524,7 +1522,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>
>         imx_data = sdhci_pltfm_priv(pltfm_host);
>
> -       imx_data->socdata = of_id->data;
> +       imx_data->socdata = device_get_match_data(&pdev->dev);
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>                 cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
> --
> 2.25.1
>
