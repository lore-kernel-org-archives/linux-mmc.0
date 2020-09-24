Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374F0C4727D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D7B21D24
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmvdLcHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIXMuh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgIXMuc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:32 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E5C0613D3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:32 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id c25so868953vkm.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FV+W9qCfwLlahXA9uVHzI8exYIRdq3lpUWqEdGTM0BM=;
        b=RmvdLcHq3Gllm1JRWrmjcRNf0L0d40Et/6As1CJqJuYzhqBbH+eSiCK0x/k6s2O5By
         S8BfPjvtzN38uDOIUNsS1dCKTloVtvMQdxZocRFYbS9C+gGoLZf6aETjK6gdL+lau1TP
         bECl2GY2P9ovBmDxvbZdYNGLsgyvs3IbY9Xyoo7pG6aGervos3ES889uLnEb7SjQdqB8
         c04oQSB+PnAtVssLohRqVsNTxxpZEXMlYEYZPaIQawRcqWXpoMMCB+Ij+QaUvFXaWX+9
         EkwQURLaFTPtw3uOe88PQxDRiEQbFWGdtkez6eYqA5ZmRd2ICq0f8B5PwzMC/2IfXMJV
         3HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FV+W9qCfwLlahXA9uVHzI8exYIRdq3lpUWqEdGTM0BM=;
        b=egj2htVTZkmMebeO3Dzyg0mhw8mUTMSE+Fa4e0rpaczIbs3zH5o/pOnY4+zVkxo+68
         vr717r4epKi1ucrzjOrAfPLDv42+KT7mkWMFQ2JqD+yz+4al8kKxQr7MAFLzzw7M/dZW
         JhnZ4qqFzuPTLUmy41X9y1vfCgfT4whafnM4vI0dmfzunSbkO+F1/NAEi3kYrDk2YQXa
         GYGXgUtUjIPeE/8X4x7BxMa59/TxOLvUwkuIiVug/1yWhBh++KNPOd75XsrNHZeUZQ8T
         Sk4RfmfSrDAL00cN/Uw469/AUHOB4uZeLu8Fh5tN07q3Q8bq4e/H327q84pjkdZy6maL
         k45g==
X-Gm-Message-State: AOAM533Q0y/9Cz6QCHbUSGgKjSKiRmF6BHoAzmbZ5KTD6MG9O7MLjCt5
        bmeQQsT13a89Ll6MxzhdZ9JNdUVllRcoQ5ZPsPAy/w==
X-Google-Smtp-Source: ABdhPJy1E77lXHw7zxYl3yAzOBYjjsrq0taGD22v7OOK8eJ5f2Oi5l3FQezUUXPcsOCVonCdRcIouLG27uOu052PqAQ=
X-Received: by 2002:a1f:1f46:: with SMTP id f67mr3562226vkf.6.1600951831604;
 Thu, 24 Sep 2020 05:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200923153739.30327-1-krzk@kernel.org> <20200923153739.30327-2-krzk@kernel.org>
In-Reply-To: <20200923153739.30327-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:51 +0200
Message-ID: <CAPDyKFqFrpMotaiLwj=Q1cUqVc1S-Oeqhq3kt6QqyW=A0T1Y9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: fix indentation mistakes
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Sep 2020 at 17:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix inconsistent indenting, reported by Smatch:
>
>   drivers/mmc/host/sdhci-esdhc-imx.c:1380 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
>   drivers/mmc/host/sdhci-sprd.c:390 sdhci_sprd_request_done() warn: inconsistent indenting
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  drivers/mmc/host/sdhci-sprd.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 62b3d4767916..fce8fa7e6b30 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1377,7 +1377,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>                          * response, block the tuning procedure or the first command
>                          * after the whole tuning procedure always can't get any response.
>                          */
> -                        tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
> +                       tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
>                         writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>                 } else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>                         /*
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 1efaf602c206..58109c5b53e2 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -387,7 +387,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>         if (mmc_hsq_finalize_request(host->mmc, mrq))
>                 return;
>
> -        mmc_request_done(host->mmc, mrq);
> +       mmc_request_done(host->mmc, mrq);
>  }
>
>  static struct sdhci_ops sdhci_sprd_ops = {
> @@ -433,7 +433,7 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  }
>
>  static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
> -                                     struct mmc_request *mrq)
> +                                    struct mmc_request *mrq)
>  {
>         sdhci_sprd_check_auto_cmd23(mmc, mrq);
>
> --
> 2.17.1
>
