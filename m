Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC55EEAA55
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbjINOsV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjINOsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 10:48:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7571FD6
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7225259f52so1103707276.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702893; x=1695307693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EKF0T0zAUhQoZRitQ2MLePZaTopAwYUl0Una5eIOS4I=;
        b=EMPbKkRrJ4xunoX/wE0AXcdOEm3dMXDg/oMYKeqPY0z6/tpHU9hycYH7EAJHz8kyqB
         m2VVAwee2+H3RvNn3B1s4tctVPLtf/lKSPEbDv08EyM5t4Wm57LRy9cSvjqAqh7aK5Jk
         gGikHU0/0DVbLVPaoo9AgbMx9CZbR+CMzI9CjvU0yVi3PHVynwvzCJUajG1HDswH70Ju
         8Dk3Lwst5aoDMcm/3TC39fZjJGa9aMRdpIyZsc8a5Vvstu4GL4eIu09jbtVViOLNUTTq
         xTdNc9LoKNQLiV4aQbimey+rH8KFuRtTBmxRfQlu2LKZae1WfLBplgNuQrQexLIMSaKm
         CTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702893; x=1695307693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKF0T0zAUhQoZRitQ2MLePZaTopAwYUl0Una5eIOS4I=;
        b=wpUbPyoy+gS7eyYczEMi+/yiLBgLEdyFjAD4NruVLA2uFh9VP3v9mDjLPpBvb3lGZv
         3dejm8FJkr6STY4GYOgOYKOG3POnzJqSZw95CjqI2ZAN804+Ed2xQtPWFTOVJwwY8RQ9
         h4oIdrk/f94y39M77YFF7QC4hxXThO4zhRdfUX2Ud7ZHZeCA8kPOiLqDnkPckPBZUKtX
         3CcIxc55fhPzCX2TKkmSSw4O5qJpW7PRnQelsqb6XCcpp/5FOEHIi9YRNrpLTPriAcew
         lCg3YKNdtl41QcgbCCRjBwfVoxa2vCCEMsKaxX+mAhOJvknR9Gn8QdQJNr0m6S707aFH
         5qdg==
X-Gm-Message-State: AOJu0Yyh2JhzeXobssCjMe7CRGOMUBKPrr+ldmRnC6WcyYZfbqd7r+r5
        nZJlbYaIf5+pBRksx4nU8lvMT4SgZPaBzzpeAo2THA==
X-Google-Smtp-Source: AGHT+IGSlFamOIT/G3C3WlIsE63iqRpU58Q+hPmZ2BJoB5zJjrYZqaVHHpnVGsRIKAGvS1YS3rjcS1gyRMTtYMrVB7g=
X-Received: by 2002:a25:109:0:b0:d07:5b87:ec56 with SMTP id
 9-20020a250109000000b00d075b87ec56mr5330060ybb.14.1694702893555; Thu, 14 Sep
 2023 07:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
In-Reply-To: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:37 +0200
Message-ID: <CAPDyKFq60V2OLe8K9RkuEZCUQHVwoDZCOtOt6w3nDw1P-reEWg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 Sept 2023 at 11:54, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Return an error code if sdhci_sprd_get_best_clk_sample() fails.
> Currently, it returns success.
>
> Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> This is from static analysis and has not been tested.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 649ae075e229..6b84ba27e6ab 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
>         best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
>         if (best_clk_sample < 0) {
>                 dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> +               err = best_clk_sample;
>                 goto out;
>         }
>
> --
> 2.39.2
>
