Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34DEB64DC
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Jul 2023 11:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGQLTg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Jul 2023 07:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQLTd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jul 2023 07:19:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E910D5
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 04:19:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so62759211fa.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20221208.gappssmtp.com; s=20221208; t=1689592765; x=1692184765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP+nVMJjM1Cb7BnxGt2NHvMg7jOq0WlJMksYF5HiLBg=;
        b=rj025K+C5Z8BE5/YeGBiuH67TsN9ZX0VWnpkXMlbJGWRFWA7fsAqeVxzWp5qVWkG+o
         pKLE3QgGPjIIIKbq/4imgPdiBukFyVUQM2WSRBis10DSvld98y0jzXBs52dQnS2gMqW4
         e3pZ9giZgOD88+JCfXi5xAj1PqUhQgFez1ju7pNvDSOI8sMLcyUq4wOVJ2xrlTnl9z8y
         I1jWJf4EvHo/9Db6L5/jo5ja0RdPD5pPOy1f72RDjAzA6Moe343BLlVGakPJ6DswXJ86
         Ht/bh+bom0M98bkyd9g8LGtyLsmvJSot8J3P8KsSDyB6dIuJijn0GfiCJDjGOA/VL7F0
         l88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592765; x=1692184765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP+nVMJjM1Cb7BnxGt2NHvMg7jOq0WlJMksYF5HiLBg=;
        b=g0RWMJs525MhE/fV7q2smFIIEC7GCod7VI+p3Gp/kujfr5ypTOh0eM70Ig02nJByqH
         xVcCxOKUv7rfohINaCb2B62oBquAD5uRKInISVpDkht7PwsGfSCNcksvDFTuLqWy2f4G
         sJlAPjll9f51Sb6MCvTySG1UZAsTwq+kGExfzLzodNWQoaJNaEaw8ZJYqWHQRnsl7KyB
         SpuEpXNSgC0KIQ6B7hBOEqC3nbURMHctbYpJZxara0+m6vqYWkNEs/gdFFwNmb87xk3r
         FOnNPEzhxu3EdcGFUKkqyN0rTyOCMLEwkvnhnuaJO6ZYxpLoYFP6hOA2RHlysPjvdKD1
         HJag==
X-Gm-Message-State: ABy/qLb3ZHDBgWVibR0sVLXjRfWuDT65jTx2wuxoGuQuNqi4VLDhuelT
        CwR6q9sDudNXX/UiLsxwGcp3Fj4VrA1jsCp2QbfkxA==
X-Google-Smtp-Source: APBJJlH4R5Xe/E1R4Dc/dga5xiLgfWGkDb3SuDMXjnAI7QZGce5yHzVql6xy4ermoZmvw25KyymPvezpYrkHnpuFqgc=
X-Received: by 2002:a2e:3603:0:b0:2b6:d536:1bba with SMTP id
 d3-20020a2e3603000000b002b6d5361bbamr8490425lja.18.1689592765299; Mon, 17 Jul
 2023 04:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230713080807.69999-1-frank.li@vivo.com> <20230713080807.69999-49-frank.li@vivo.com>
In-Reply-To: <20230713080807.69999-49-frank.li@vivo.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Mon, 17 Jul 2023 13:18:39 +0200
Message-ID: <CALJHbkA1HCubm5b31CQmHtX-UC29LfgoafyzwxpHFydttdOe+g@mail.gmail.com>
Subject: Re: [PATCH 49/58] mmc: sdhci-esdhc-mcf: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yangtao,

thanks,

Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>


On Thu, Jul 13, 2023 at 10:10=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wro=
te:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-=
esdhc-mcf.c
> index 05926bf5ecf9..a07f8333cd6b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -489,7 +489,7 @@ static int sdhci_esdhc_mcf_probe(struct platform_devi=
ce *pdev)
>         return err;
>  }
>
> -static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
> +static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -502,8 +502,6 @@ static int sdhci_esdhc_mcf_remove(struct platform_dev=
ice *pdev)
>         clk_disable_unprepare(mcf_data->clk_per);
>
>         sdhci_pltfm_free(pdev);
> -
> -       return 0;
>  }
>
>  static struct platform_driver sdhci_esdhc_mcf_driver =3D {
> @@ -512,7 +510,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver =
=3D {
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .probe =3D sdhci_esdhc_mcf_probe,
> -       .remove =3D sdhci_esdhc_mcf_remove,
> +       .remove_new =3D sdhci_esdhc_mcf_remove,
>  };
>
>  module_platform_driver(sdhci_esdhc_mcf_driver);
> --
> 2.39.0
>


--=20
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
