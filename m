Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9CC43334
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jun 2022 09:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiFBJsh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiFBJsf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2022 05:48:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62C294215
        for <linux-mmc@vger.kernel.org>; Thu,  2 Jun 2022 02:48:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so6947142lfa.6
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2022 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b855lgf2K6RWNMdrbTy9OBrZkDrExaS8QreLgdDtVNY=;
        b=J934V0sBP7B2jRhhvRfMsWF+ARZxNCY6OR9E2sMWyGUOibgGzczEaUO0Na+4aCDiNI
         SVLo8Kmxp+gjWtvXVZZZ6CbXW0iVC6TDbVRhJMO8jkqGjOzW9r7cOB62POhwADrxaWO8
         TeLmwFqw+K2Olbgpa37KvF15D7GCOY++ijcOynS4CY9PqrQeAJTpyeVCcEIWmHQSlHJ/
         Y29SdsN9iAwDU/Q+TbrZwHcpFQ0ffgZV8e1g257BaWebYmEMiEsqakQkH/6CtV7QrRDa
         ucft2WTFX6N0H7I2HKGREkZOcnRf16XhOfUxqsYFitrUmrcBNDCCo++UuQb7Gqhrj6BO
         MGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b855lgf2K6RWNMdrbTy9OBrZkDrExaS8QreLgdDtVNY=;
        b=Iiw+ui581N7sXEZXM/ePe56mBKw5DGlxXPllFDmqdOVgoI/wwlMCJ9js7h+nazAV0L
         miGomSUMFAvYCqvqR+i/Ltvym1qyiEHk7Bz4NHeOEFTtMWM+AhieH2knRkTiNF88RUSZ
         sii9OpQGEtMYDBz4HK94qLdhKLmgySVKBj4o4kxup8LIxAaJpVvaldqsE92WDfP/8Pz0
         m4H+i+r/uIizsvZiyZqeSZqc45Zc+5auG5FssQHx1wTHLURa0tIXoYRoNRSwMwMj/6LJ
         vah1WTfEfHwoI/Xv7PiaIpZV6ka6msiab58Fi3PeV+YQzoyUePuc4P7YIzsBjNlpIDD0
         gtMQ==
X-Gm-Message-State: AOAM532+fsGKidDysI50XqxM33UYBFFg/kKu6GLgpCBxNx8b1a1OkIMS
        fWKpl41Fn6fh1FIrPbmdDCx0BlnDq8BukbA+Gfasfw==
X-Google-Smtp-Source: ABdhPJzvIhjnVlgMR8NiroYOlU2q9b//vsIpURDubx6WxAEF3GHnIY+ZUlGElYuNx2D6tZCg0wjBwcUmt1jm8ds4nE4=
X-Received: by 2002:a19:ac42:0:b0:478:593c:e6fe with SMTP id
 r2-20020a19ac42000000b00478593ce6femr2904805lfc.254.1654163311389; Thu, 02
 Jun 2022 02:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653564321.git.viresh.kumar@linaro.org> <80314068d96eb53e0d9838736415b96015803844.1653564321.git.viresh.kumar@linaro.org>
In-Reply-To: <80314068d96eb53e0d9838736415b96015803844.1653564321.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Jun 2022 11:47:54 +0200
Message-ID: <CAPDyKFpB2ei325vemXcmEY6Xou7Wt+WtV8gu6nqAK9tSRAy-aQ@mail.gmail.com>
Subject: Re: [PATCH 19/31] mmc: sdhci-msm: Migrate to dev_pm_opp_set_config()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 May 2022 at 13:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
>
> Lets start using it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0ba5e4..994f3f0231f7 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2496,6 +2496,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         const struct sdhci_msm_offset *msm_offset;
>         const struct sdhci_msm_variant_info *var_info;
>         struct device_node *node = pdev->dev.of_node;
> +       struct dev_pm_opp_config opp_config = {
> +               .clk_name = "core",
> +       };
>
>         host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>         if (IS_ERR(host))
> @@ -2564,7 +2567,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (ret)
>                 goto bus_clk_disable;
>
> -       ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
> +       ret = devm_pm_opp_set_config(&pdev->dev, &opp_config);
>         if (ret)
>                 goto bus_clk_disable;
>
> --
> 2.31.1.272.g89b43f80a514
>
