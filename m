Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB99C77B7E
	for <linux-mmc@archiver.kernel.org>; Tue,  2 May 2023 14:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjEBOcn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 May 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEBOcm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2023 10:32:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD095
        for <linux-mmc@vger.kernel.org>; Tue,  2 May 2023 07:32:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9d881ad689so5841484276.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 May 2023 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683037960; x=1685629960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0++0+/Ug+3JSWLaIqYWRl4j9BK08vqn/6MzYdH3xVU=;
        b=lq5bCU7hkAiaR1vzgXDVSiZj3Xf23I0UFt7KFomYM+XQ7+/5ES1SK9t+BJ/546wpXg
         kcXHiRzUr3f38IUFmcCGEEwdpkGfGMg3R/g3081ynaq0wG88n1LLAQmTDe6wBQnoSMYb
         wMmc48OdYEYj0JJSwIb8oIvotyDBJfRuNCR4RYnZO0vscKYwx/Mv85mne+/wnHyhTqwt
         N2YwWhfXSWziagxEOqGANQm7e5QzOUnCBnzFvvUXIta09rOeC6C2oQmmZRVCn3Yoeccj
         HECaotp6W3M2v6H++wb8mVNdHt/31VT6VuQPBO8lrK82BDTzVKdLAOix7qtYgiKEg1LZ
         Bycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037960; x=1685629960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0++0+/Ug+3JSWLaIqYWRl4j9BK08vqn/6MzYdH3xVU=;
        b=YptfhPjAj2JL6Xql20mhHss7VOD1kCJBhJk1xzluUePPh5G8xVzl8Tooqe7LWWcv8n
         yUbur8+5Hto7fqF8icaYRm26B90jIOH2EeYyns3UlK0qBxdoC6zBB5mR3H0hqNoR69CX
         T/NVstguGUSeSxNITgktxfVad+ukRCIKBC9AOFSAGSoDGrYotKhdr8M+yKsClHM3FIlD
         lPgEAyjUxCRMDQ0nerFVowkNzyfACuMS3Y0/eCN0KHP/9DtrIsysJ/vGkjtYlBEmbER7
         W4ezrVanB0oty+W9RJE481ZRbkBb3j6jxY5H46N6fwa80xC/U+F7ASexc4pMlfJEJpAs
         1Jeg==
X-Gm-Message-State: AC+VfDz3lhOukdhktFvCsK5D3xVIsidDhZLHGpaBE+W/WA53REHGM+BH
        DhUguH7RFuVQE2bq1FbbFhzTwzu4yW4o0OOE2tP7rA==
X-Google-Smtp-Source: ACHHUZ7tjnkLLgQaXdBvE5eFMPW6xkR6z/FwUQkv+DxYwSsyPxdEOseu2rsUDojNZvfE/SQmivtt+QYdkCmuFVE9TNk=
X-Received: by 2002:a25:c1c2:0:b0:b9e:8a15:753b with SMTP id
 r185-20020a25c1c2000000b00b9e8a15753bmr1235964ybf.16.1683037960504; Tue, 02
 May 2023 07:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 May 2023 16:32:04 +0200
Message-ID: <CAPDyKFqWD+w82N5AB0CJ867nPvg4tdHWuKDx=784qSXY4K6tNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Brad Larson <blarson@amd.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Apr 2023 at 15:41, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If devm_reset_control_get_optional_exclusive() fails, some resources still
> need to be released. So branch to the error handling path instead of
> returning directly.
>
> Fixes: aad53d4ee756 ("mmc: sdhci-cadence: Support mmc hardware reset")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-cadence.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index b24aa27da50c..d2f625054689 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -540,9 +540,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>
>         if (host->mmc->caps & MMC_CAP_HW_RESET) {
>                 priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> -               if (IS_ERR(priv->rst_hw))
> -                       return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> -                                            "reset controller error\n");
> +               if (IS_ERR(priv->rst_hw)) {
> +                       ret = dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +                                           "reset controller error\n");
> +                       goto free;
> +               }
>                 if (priv->rst_hw)
>                         host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>         }
> --
> 2.34.1
>
