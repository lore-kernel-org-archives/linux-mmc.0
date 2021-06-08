Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E3C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F260A6124B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhFHNTh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:19:37 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:46051 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhFHNTg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:19:36 -0400
Received: by mail-vs1-f54.google.com with SMTP id y207so2458636vsy.12
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpplA6Fv6gqlJrx9MVYvEyu2+9CFUA8ToNoqtQ6jasU=;
        b=BqADVqx8y2DVKVgA/xCjrxtyM1Gs9RV94SNPy6k6Z6UIptajWLKsGkado94kCpoNY6
         tGI9iwXsES8zIi3UE3g3cqAVjINyeGe8po7XYpDacIuW8klOrLTkm6yZEIlHXZ9Ab/gE
         +nX6twnvnOmYijaacsQr8Gh0HSpXSg1VchjFqaGZRBcNyM49iTryDJYueVRp3TRLRqnP
         OMjyfWB140rqHQ0uboFJenTp94AMWRnkJGVOqSoAWHLMSBVKBfMu1QCUCrqW+mkNZKpS
         BG6fp3ddbfcDMtRlHJDxZQIcdNCN9ezf2ioff3lGaHUHzJE5mNlu3rv2tMZWjbTN9wg0
         wvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpplA6Fv6gqlJrx9MVYvEyu2+9CFUA8ToNoqtQ6jasU=;
        b=lk6OlN3fnCM/wwhEHfhHA4qp46KHpYaEgSngGSk5xpTkPhUfx+CC6IdDpfnc4ycStx
         7SfBu+vTECi0syQE3Rl4KlTZT4x8y2Fbi7jTio4w4oHbFc1yl2b9muKDyurkJgQrtSIR
         39zpMARIS+9f0h6O0RUJPW+nUE+VpCa++GKOkC8gcHijvMIaIrbfsJjIapZkkqhyeJfH
         6BiUlJhxWJVwCc2cOgWOysYkvGwp7jrrUEqQsWEIDsZ4igX+3frTFJtyJmRs24k9x/sA
         FZ2aWaAj9/VZyrG0bI5VpY/COH1jrCoFShFCPC4e614L/4iH+KmR+LO1euMehkGKCWv7
         n5qg==
X-Gm-Message-State: AOAM531yVjxAQMPdC18Ox1Lw7eHRngC1OKms04UaPBhKFUsCWBFbXqVU
        ZbJAIhTdYa1YNcadoUIjXkOAEeWXz09I6ysIWV7Dfw==
X-Google-Smtp-Source: ABdhPJzHJ705v7RhZgZU+bX7G/bAuqLvXnhZQ2HnR0DYK1oZvzl21Z9kN28AdoaRPIfsaOaTl0R4C+T1JV/PYZl0W58=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr11664363vsp.48.1623158203612;
 Tue, 08 Jun 2021 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:05 +0200
Message-ID: <CAPDyKFq6Aaw9kqr3NAdM1oZvXyNkcoUAQT03EUdKv56LRxHNhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Jun 2021 at 11:54, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The is_imx6q_usdhc() function is unused:
>
>   drivers/mmc/host/sdhci-esdhc-imx.c:343:19: warning: unused function 'is_imx6q_usdhc'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f47c4bbfa283 ("mmc: sdhci-esdhc-imx: create struct esdhc_soc_data")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index fba4a963d12e..7336ae749137 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -324,11 +324,6 @@ static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
>         return data->socdata == &esdhc_imx53_data;
>  }
>
> -static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
> -{
> -       return data->socdata == &usdhc_imx6q_data;
> -}
> -
>  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
>  {
>         return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> --
> 2.27.0
>
