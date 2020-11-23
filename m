Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A14AC63697
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2EA2076E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnEoXGA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgKWQHZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKWQHY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:24 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9847C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:24 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id u16so4073219vkb.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dezwpgl5737Xzk/e0pBYknPZfGBw3gKJ+L0Y5m1MpoU=;
        b=HnEoXGA+pMXs4W1m6EUGocXOahBzgdVwpPbc8r2mgZiwQ7ctuMLbkKqT/+pwHn8J9B
         XYLL2igxg6tA5Y9CeE+eAEStxA40OQ2yMyPywWn/Kafcs34rOQb6WGoA2g8p04FH5ike
         00AIeo7SShuVSNcpUXWMx3Iu6+TxXb9D4at2kvm0RGoRaipoKYWAGOkKpR1eU+TkLWl8
         kkgl1hE1yOehyzfJAP9xyj23RdgOWFxTzo+pvuzyqJ7opW0QIRFNovrUrc77kUJXkmN3
         X+uYVzKzHKeUFXWKCm3/QW6R+j7uQPqiC0wWaHPSZ5XUmzifvcnuV96u3Ck7kTyIEEc1
         2FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dezwpgl5737Xzk/e0pBYknPZfGBw3gKJ+L0Y5m1MpoU=;
        b=DMvQ6XxRaQt8lO6qMjIUtdWbTWsj1+jNzbosPTQtPKaUv7knZ9PoZ8v+g7Eb+xSmEv
         uxjHDHcm4Qf9N261AXlcGojV1suB9TcTGs8/+a0IV4mjQ/GM/KG74f3uRinWieoPhFKg
         AgdAXCdcd6ak84TyIVqYqH43uMAxBL1+Jf3yVWUbaqxckmqbU/e2u2UKt7HMJHQazRXV
         tNNmeKZjRwcezRnSOu2sfPxEXXYmJ7qnI8i3+9wkfOp28J3J3K9JBfSS1Z0JMjCsGDMa
         B/M7cg0QLAA5+1VQwKm3NbliBMQZGO/5crGuFSX0RkEdkGqK29ZXuxvyMGKbRvMyPKib
         Ypnw==
X-Gm-Message-State: AOAM5333xTrHMQgrr1cD7NNeLHcLK91yvlwRD0FwrXX2VaPgiQggrxa8
        35LzPZa3KtzGPHuigF96sqQ8z/yTAmgoqoiLmZ+ywA==
X-Google-Smtp-Source: ABdhPJxb2G+kMMNoKv/YKtDyfoSWd7H1Q8f1SLSChp2P2EkIOHNbbbMffi34DN2zwp1G+VbWVOsWbuIM1Fidc/XcOGU=
X-Received: by 2002:a1f:5e0b:: with SMTP id s11mr529474vkb.8.1606147642422;
 Mon, 23 Nov 2020 08:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20201117113750.25053-1-festevam@gmail.com>
In-Reply-To: <20201117113750.25053-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:06:44 +0100
Message-ID: <CAPDyKFoQdpDwVHWAPzrQEGoZnTFY1h6F37Z1fYboBz03ZQYOFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Convert the driver to DT-only
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Nov 2020 at 12:38, Fabio Estevam <festevam@gmail.com> wrote:
>
> Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
> by removing the unused non-DT support.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 91 +-----------------------------
>  1 file changed, 2 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index fce8fa7e6b30..16ed19f47939 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -296,22 +296,6 @@ struct pltfm_imx_data {
>         struct pm_qos_request pm_qos_req;
>  };
>
> -static const struct platform_device_id imx_esdhc_devtype[] = {
> -       {
> -               .name = "sdhci-esdhc-imx25",
> -               .driver_data = (kernel_ulong_t) &esdhc_imx25_data,
> -       }, {
> -               .name = "sdhci-esdhc-imx35",
> -               .driver_data = (kernel_ulong_t) &esdhc_imx35_data,
> -       }, {
> -               .name = "sdhci-esdhc-imx51",
> -               .driver_data = (kernel_ulong_t) &esdhc_imx51_data,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> -MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
> -
>  static const struct of_device_id imx_esdhc_dt_ids[] = {
>         { .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
>         { .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
> @@ -1531,72 +1515,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  }
>  #endif
>
> -static int sdhci_esdhc_imx_probe_nondt(struct platform_device *pdev,
> -                        struct sdhci_host *host,
> -                        struct pltfm_imx_data *imx_data)
> -{
> -       struct esdhc_platform_data *boarddata = &imx_data->boarddata;
> -       int err;
> -
> -       if (!host->mmc->parent->platform_data) {
> -               dev_err(mmc_dev(host->mmc), "no board data!\n");
> -               return -EINVAL;
> -       }
> -
> -       imx_data->boarddata = *((struct esdhc_platform_data *)
> -                               host->mmc->parent->platform_data);
> -       /* write_protect */
> -       if (boarddata->wp_type == ESDHC_WP_GPIO) {
> -               host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> -
> -               err = mmc_gpiod_request_ro(host->mmc, "wp", 0, 0);
> -               if (err) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "failed to request write-protect gpio!\n");
> -                       return err;
> -               }
> -       }
> -
> -       /* card_detect */
> -       switch (boarddata->cd_type) {
> -       case ESDHC_CD_GPIO:
> -               err = mmc_gpiod_request_cd(host->mmc, "cd", 0, false, 0);
> -               if (err) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "failed to request card-detect gpio!\n");
> -                       return err;
> -               }
> -               fallthrough;
> -
> -       case ESDHC_CD_CONTROLLER:
> -               /* we have a working card_detect back */
> -               host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> -               break;
> -
> -       case ESDHC_CD_PERMANENT:
> -               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> -               break;
> -
> -       case ESDHC_CD_NONE:
> -               break;
> -       }
> -
> -       switch (boarddata->max_bus_width) {
> -       case 8:
> -               host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
> -               break;
> -       case 4:
> -               host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> -               break;
> -       case 1:
> -       default:
> -               host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
>  static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *of_id =
> @@ -1616,8 +1534,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>
>         imx_data = sdhci_pltfm_priv(pltfm_host);
>
> -       imx_data->socdata = of_id ? of_id->data : (struct esdhc_soc_data *)
> -                                                 pdev->id_entry->driver_data;
> +       imx_data->socdata = of_id->data;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>                 cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
> @@ -1713,10 +1630,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                         goto disable_ahb_clk;
>         }
>
> -       if (of_id)
> -               err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> -       else
> -               err = sdhci_esdhc_imx_probe_nondt(pdev, host, imx_data);
> +       err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
>         if (err)
>                 goto disable_ahb_clk;
>
> @@ -1929,7 +1843,6 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>                 .of_match_table = imx_esdhc_dt_ids,
>                 .pm     = &sdhci_esdhc_pmops,
>         },
> -       .id_table       = imx_esdhc_devtype,
>         .probe          = sdhci_esdhc_imx_probe,
>         .remove         = sdhci_esdhc_imx_remove,
>  };
> --
> 2.17.1
>
