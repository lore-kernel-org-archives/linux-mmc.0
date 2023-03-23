Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2FC6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCWMNT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWMNR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA914228
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:16 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r187so401771ybr.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLAcv2qG77POi+rjBlm8PmHg6ytZD4ZLUV8QpT2wDaM=;
        b=bytt0SXWcYEL1XQ0HwoywyXKCBsz2AhEBaYUFuKdflNNfSgRIFsGr6gHSnVvAssC8t
         Nn9yweer+1RRbOdaRKqwQD5pHVnv8RraxNFPCMOACHpCRjZUiC35VpVki8+FuuVW0Ogd
         Md3Itq/aiLCtm40VBmeRJUAyQUjdtuvPCKHIv6HcPYsg2635V6A7RB6I8o7m7qFgUbRp
         7zS99h2G7znErs+GZHHR8ZotXAX2PTkOp3jjzj5QI4c5AT5tSDpZq0SkxIqEx9/UAP2B
         rQfOCwg26bR1XcjzJkOrMa4IfzXJ2STHihBui4pPpPHq1YIZrRft3qXxD7s/3k4NMlKX
         d0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLAcv2qG77POi+rjBlm8PmHg6ytZD4ZLUV8QpT2wDaM=;
        b=vvnDQUj4pMxN4uCm2cgl87z/eFiWeby4ao/7Z+/jtqf4u9rmvonbwaiMy7Z0HnT0gZ
         PX2o2Sb9t1eMJtvXf5+s7JCgFkIt+qXYPHsJD/XCe2MV+y1o+g75JnF8mP8DoEIxuPNj
         clcr+SUs3cTKyFWMROUn8B3dPx94r2K4a/ui3nVVpX1vzh439CcbAkDMrsh4a6CpkWn/
         vhW8qc2KA4jkDR33kYsFpgjO8COtH2Bhoi0lA3JTujS8+S4RC1LhQCByaByk5pDgyCPa
         pcf6E9XvijVp33JdJM3CiDs3peKtNkEgj/k14bDUDYtqlSb0tg8MyrEDOjdTOrYP0awm
         khWg==
X-Gm-Message-State: AAQBX9emV3xt1z57DgM6fAR0NXyftfywdnSPakc/KXkWN2O0m9GsspvR
        6MkmRh4465ajGgjeWUY4RU08SNPLVeGJU9ZR/nJn5w==
X-Google-Smtp-Source: AKy350bMfKNae9ZI0vTPsyNQRU09GxeoPcumQLYJeKNsqhQ5KjvfHMUAjLQBzmVS7QGv0G8NP4Kk1ScN7QBWiLN/cZI=
X-Received: by 2002:a05:6902:1705:b0:b75:8ac3:d5d8 with SMTP id
 by5-20020a056902170500b00b758ac3d5d8mr941513ybb.3.1679573595392; Thu, 23 Mar
 2023 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <858a592b-ebf4-99b4-74fc-21b4ad3382f8@gmail.com>
In-Reply-To: <858a592b-ebf4-99b4-74fc-21b4ad3382f8@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:39 +0100
Message-ID: <CAPDyKFqd7R=F-gC59UrKjXrF_CMN=Njy6zGe+jNM19V+1-QE6g@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: simplify usage of mmc_regulator_set_ocr
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 11 Mar 2023 at 23:27, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> After 087592395a96 ("mmc: core: Allow invalid regulator in
> mmc_regulator_set_ocr()") we can remove the checks here.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 2b963a81c..28e04dc4e 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -604,8 +604,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>          */
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
> -               if (!IS_ERR(mmc->supply.vmmc))
> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>
>                 if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
>                         regulator_disable(mmc->supply.vqmmc);
> @@ -615,8 +614,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 break;
>
>         case MMC_POWER_UP:
> -               if (!IS_ERR(mmc->supply.vmmc))
> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>
>                 break;
>
> --
> 2.39.2
>
