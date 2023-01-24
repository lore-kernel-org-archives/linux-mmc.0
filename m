Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9B8C25B4E
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 11:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjAXLHe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 06:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjAXLHb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 06:07:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FCA5D9
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 03:07:30 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 36so11037489pgp.10
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhkW1FpMKSBw2LEIkWml12Y6AIM7FamikDRt0i3hkOQ=;
        b=dn5Fz8Pc+eFnZnOhew1XCQJ2tUBOFpj2KCib49g+FwpH2PFCVZD+IYfQ1XLa8gTTnJ
         EhKMTXz3KJFnsYxH5P7f1mjz6DM1bt5q9ce4wLzCToBTWO/gydGEwcTopJ/3x9rsgZ4l
         2rrRMVFrsvo/uIEEidDUldoybOfb6moS5xlmfTQfp6UdhG4eV5mqKSeBWE5Zlb3xoDUI
         IYrpopUVip3QqSk0ha42xrBOcE/LcFqmnQ+nspZyC7MtM2bH3AExosGaJ7w3+BIM4mzx
         TuD9Sssq/RVS3rjRG5fIqcSclVkgDKKESfkt6Z8CX5PyfEJFNU6aepJcl+7CE0XJx6mY
         Wh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhkW1FpMKSBw2LEIkWml12Y6AIM7FamikDRt0i3hkOQ=;
        b=DolAe881FH4l8pU2DFryw8DOlaQtlfPypPVDu/rsJPtRsJtad2W4cRBAqTZfO8xa1s
         1nZMDm2EQO4qMTjEJj6YTjaxC4lCI/YbR3PWbelbstWwaVFWJywOVFgsX/fMD2V+NlES
         yG5VTRyMUcEQyWovbD2/TpDZqDRmBomUeP5HTXsEuS/ryEcEkzBlDwlo2vR0V/+6qAxJ
         eRmNQ1Qm6OF/Cn/YxQ8za73UNV38eiK4gcXRZx5fpIe4fZYOPPdQkjnR7/YYj7/Cht5o
         NhSWYpTbQJk3rcGKcK1xEphDEa9XOryov5YLtM19JzNR9ZVzJyXHMLf1WcdUAs/Clqn+
         Wz5A==
X-Gm-Message-State: AFqh2krgtUk+V0JCdMwiv+YYRqCT9YbHYl/7/fi0yIAP37ZxahFGGAow
        DkH2cQwYGrwKP7Uhn9U73BYnl06qdBpQV5G+O+YyTg==
X-Google-Smtp-Source: AMrXdXtOWDOmHbkDr/4rC1Lhpj2j2CSC6rKV/xVHz07rP6WvxnUEy1UeMPI4/tzJj38SUMMz9tafOXcPRTgbuxD7oek=
X-Received: by 2002:a05:6a00:2c7:b0:577:139e:1ec8 with SMTP id
 b7-20020a056a0002c700b00577139e1ec8mr3399448pft.40.1674558449616; Tue, 24 Jan
 2023 03:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20230118045749.3913296-1-chenhuiz@axis.com>
In-Reply-To: <20230118045749.3913296-1-chenhuiz@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 12:06:53 +0100
Message-ID: <CAPDyKFqUnp_rDcckBSW386webSgjAhfdONN_AKYCS-kY3XwKPg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: expose MMC_CAP_AGGRESSIVE_PM to DT
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Jan 2023 at 05:57, Hermes Zhang <chenhuiz@axis.com> wrote:
>
> This patch expose the MMC_CAP_AGGRESSIVE_PM flag to DT which
> allows the host to enable it from DT.
>
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d17eda753b7e..1d98a301515d 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -376,6 +376,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps |= MMC_CAP_HW_RESET;
>         if (device_property_read_bool(dev, "cap-sdio-irq"))
>                 host->caps |= MMC_CAP_SDIO_IRQ;
> +       if (device_property_read_bool(dev, "cap-aggressive-pm"))
> +               host->caps |= MMC_CAP_AGGRESSIVE_PM;

I think this can be debated whether this is a description of some
characteristics of the HW.

That said, please add the DT list and maintainers and resend, to let
them share their view too.

>         if (device_property_read_bool(dev, "full-pwr-cycle"))
>                 host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
>         if (device_property_read_bool(dev, "full-pwr-cycle-in-suspend"))
> --

Kind regards
Uffe
