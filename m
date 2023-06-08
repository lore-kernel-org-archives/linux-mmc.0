Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FA5C7EE45
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 14:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFHOdl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjFHOdk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 10:33:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A252729
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 07:33:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565de553de1so10283437b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686234817; x=1688826817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ro3vhsZKDowIVp2vkLdcY5Dt/KZr8q8vBrj3SRJTj7M=;
        b=Z+M7daYdqyXqdQ3T7Et0TlTHSKkE6mWGBdbR32JzVDXpes/itUbybBRAU9L4gdu4Uv
         rdfs1xX4iIy13I1BZO5aU4eb8L9ahqwOXvB9jWv8M2lh6dDRKvhc8kVmqiL8/LOFWvb6
         TGqjmq3hb6a3cY2jBAl75vPSLHRnewwR3JfJJroi0JMmeVrpSodjlzW9g7r0EZSrUuPq
         uksZLvqArVszxWgRejsrfo+WcXPU77XXFjVG/CyuDQVaW5/MtAXvswpCxVIXPZpNzyvf
         MmNut7dT8GtPQ13SJaOxX9mV2jECi6NfyNeKQ7lNe2yEPyRcsL7iHBhn4pu9RR87YN4T
         45WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234817; x=1688826817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro3vhsZKDowIVp2vkLdcY5Dt/KZr8q8vBrj3SRJTj7M=;
        b=NnmRGkRqQPqmhMbCPtTdlAp7Txnrns1FIBtf/NCEW5bohhSyeSMY/SWJuzbJqZI8yx
         YCbvmm58TQUohjRsBDzI2SZHoFtT0jjEMfgF49oPl3A+gf8khcBFI4mUwLdTH1uvo7Qn
         lU8S5sHvyOJOctxAS06zmFK8NLeCeWa0XKT0/CHQJ0vShnQtUY22/PoGZk8YRZx+12NB
         Jspzv0qmfzj5KLBmon6gGc6f07PrR2TypqSl7fRrT6eg4/HL7h5W+y4hOsVpAvxD5rsJ
         TBW9ssFVqeNALdAcVs+w3M6608yC0hPAeX70dGT4wBdDrD1x0axFARK4d1SG6AvhMkyt
         v2yQ==
X-Gm-Message-State: AC+VfDwF9MJqdn8zMxlpxSQkEMLfqjvcbtmF6IBGmGIQw6EIX/VxwfIY
        Oq8cTe68UaSMPqIIAVBpjazASN6xLwqwlLH5V/muYQ==
X-Google-Smtp-Source: ACHHUZ7FF8CsszV1cQoBza3fF1sxHIiq675h9rqQPQeKpNvvetg7y4u8iZ0ac/VhW+UI4ujH1JqV8bh7x+++KcHM4Tw=
X-Received: by 2002:a0d:df15:0:b0:561:80b2:53d8 with SMTP id
 i21-20020a0ddf15000000b0056180b253d8mr2778544ywe.20.1686234817308; Thu, 08
 Jun 2023 07:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230518082035.335112-1-haibo.chen@nxp.com> <20230518082035.335112-2-haibo.chen@nxp.com>
In-Reply-To: <20230518082035.335112-2-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 16:33:01 +0200
Message-ID: <CAPDyKFr9EZozjrhUJPU6GyCCA2Ut3jVRKEJtwav_O_ouw5GX-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: use pm_runtime_force_suspend()
 to optimize remove callback
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 May 2023 at 10:17, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Currently some code in sdhci_esdhc_imx_remove() duplicate with
> sdhci_esdhc_runtime_suspend(), so use pm_runtime_force_suspend()
> instead.

This is reasonable, but note that CONFIG_PM must always be set, as
that is needed to let pm_runtime_force_suspend() gate the clocks.

So, this boils down to whether there are cases when sdhci-esdhc-imx
can be built with CONFIG_PM unset?

Kind regards
Uffe

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 4cf42a028bb9..d7588faf52e0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1805,23 +1805,16 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int dead;
>
>         pm_runtime_get_sync(&pdev->dev);
>         dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
> -       pm_runtime_disable(&pdev->dev);
> -       pm_runtime_put_noidle(&pdev->dev);
> -
>         sdhci_remove_host(host, dead);
> -
> -       clk_disable_unprepare(imx_data->clk_per);
> -       clk_disable_unprepare(imx_data->clk_ipg);
> -       clk_disable_unprepare(imx_data->clk_ahb);
> -
> -       if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
> -               cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
> +       device_set_wakeup_capable(&pdev->dev, false);
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_put_sync(&pdev->dev);
> +       /* Ensure device disabled */
> +       pm_runtime_force_suspend(&pdev->dev);
>
>         sdhci_pltfm_free(pdev);
>
> --
> 2.34.1
>
