Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6990FC433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379DB221E9
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUXqJYCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgICILh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgICIKo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:44 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E3DC061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:44 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q124so581279vkb.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3365ghL6l++rnjNzcNJMJDS/9A8b7IBK4vQw9xWtdY=;
        b=ZUXqJYCofbaZuGOt6Jmoeo53737zVQ0l2s4cLtThhLefrDZ305hngVsyOewFoS5vz+
         qc3fKJka+rRkzxcctaDrcsEoy+2/R0xnHExSC8FhstbwsUUEoz/C+leEA6xWYclE0poI
         eDic9E/1jPGjqbD96x3W4Nk54XgBDCe1qcr6Tes40E8wQ25NXrgF7flGu9kqCucvgCVj
         7YNwP+jhZ3ZJHa3ZIZSNfY0eymPYF/6ed4wTKeqpNO+4Wcfg8mWN0EcplzBxEf8ryQcD
         M2cmRin7kPvb81vmxvxYzQeLd768WXmgfFBgdm2H6g1bWlh6CvL3OICnoEogQxzntZ5D
         gyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3365ghL6l++rnjNzcNJMJDS/9A8b7IBK4vQw9xWtdY=;
        b=Y6KY+8Zx6DXI6CUyLW1aF5MUIhxp4Xj3X7HaR6gJk6BXaLUTUzA+VydRyjObyzBOii
         klguWGttmy3z8tMxbuLABiZWbXPh5g1jzyWfWr/LSfUZrEn1UT+OIp+WzyIG5SOwOHtV
         m4ewwmUk2+4DxVeCzioLJ+HHO+3FTNZW2MTr0qJZUdjqyY22Xe6Jzgau2E27pBF/lbJn
         nVu6LdFq4WwDpDQva5wXvMOD5eIvLtkL3I8Wv5D4BXylgwIJjQezcMePdCRqWAzjG5/f
         Q3gRVvLdaq+vHG6+buexTclG+YNGWuhxVkQKoOrjIltgtbsG1SgSZO2U2O+pMgZTJX2a
         iTcg==
X-Gm-Message-State: AOAM531wHoMOtyCkpC1PaLhxrB2MW3QEbf4I/UfAizoFOd/yGU4LtqHn
        gE86f5672MJ7VFGj4JYxfeTjQRM5VpJLFdoBEa4GZA==
X-Google-Smtp-Source: ABdhPJx1P61vsP1cHQYPIhUG3f3jZTeKfXFkujPaG6RT45Rh2A4/ma6fXUMGZNn0T/qsq9HNFeAePpUYAnmp5Af5hD0=
X-Received: by 2002:a1f:e443:: with SMTP id b64mr846480vkh.17.1599120643659;
 Thu, 03 Sep 2020 01:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200902204847.2764-1-krzk@kernel.org> <20200902204847.2764-3-krzk@kernel.org>
In-Reply-To: <20200902204847.2764-3-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:05 +0200
Message-ID: <CAPDyKFoTvpvPY_vads9wL5p9zc=GGWzxqia1DF+U_SX5bsNZvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: s3cmci: Cast driver data through long
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Since driver data is a pointer, direct casting to integer causes
> warning when compile testing for 64-bit architecture:
>
>   drivers/mmc/host/s3cmci.c:1495:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>
> The actual driver data can be only 0 or 1, so cast it via long and do
> not care about any loss of value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 3fb597095079..ac94f926624d 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1492,7 +1492,7 @@ static int s3cmci_probe_dt(struct s3cmci_host *host)
>         struct mmc_host *mmc = host->mmc;
>         int ret;
>
> -       host->is2440 = (int) of_device_get_match_data(&pdev->dev);
> +       host->is2440 = (long) of_device_get_match_data(&pdev->dev);
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.17.1
>
