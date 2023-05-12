Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021FC77B7F
	for <linux-mmc@archiver.kernel.org>; Fri, 12 May 2023 07:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjELHgV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 May 2023 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjELHgU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 May 2023 03:36:20 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1118C
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 00:36:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a2691637bso142016327b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876978; x=1686468978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tncq8rfyUORTEsPTT3s+fxb4TbHZLX39y7YOezqrzs0=;
        b=fL3tkpkY3e7x9wRiZaKP69lP/XH/CkvQXuknKF1weIZyaprC1jdHBaFpHdwBdJvDre
         jGLDvxXIFbizwtpTftLiNpX69nau/Q1K4PrCyTc17PG6qclSaKeBwaPKzHk4ySkBuZTO
         48sDt977LNwmmWi3wyorLUvr0h1CR6i4yGdqZycwiu/57CpKnbuiFsjmRWrljd4dOyFE
         xbCJocOc2aAATilkd2Akea7ZsEhQ4Ilav0HkAOI8pw34riGDwk6KEa9C22ygZmRbRZoz
         aQ7/LX6WazuUhXRw3ufkfLePclrQbEQtwMckpwCc/8t0fyQC5Nu2RoP3TNWKWuehchyM
         w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876978; x=1686468978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tncq8rfyUORTEsPTT3s+fxb4TbHZLX39y7YOezqrzs0=;
        b=kqC2wxqtHV60G9i1XlAp+EgCWKsc7D9UWUjkFR7DEJ/TAE0QSHR32gtEqUt7iqigAq
         CSdSHIrC6B+Y8G+HZlRhLh8eV3lvKY3Go4hE0PR3r0U0q/zc+RyIybb+Pwg5k/FBJAqa
         L89mHiwqhnsJzA+LQ/uVQuHzCVxTOI/f4Bxl0x5udmTw5Q4qUNmeanr0u0FqxLzPIIQT
         GJM+xx2Slue23lpiaLO7fwfSmwCa64m3OZSqTeP0d8cdM83qNtJ0RHBK0LzPj68FqfHZ
         IdoIZ53euzu2CoT44UE8XHUtE37wPyLwqW1o3fWtEF/JE3Egh3KvxjfM1MEGSv6S5nVw
         6Yjw==
X-Gm-Message-State: AC+VfDzQZAjet2fmTf3fUlol5LSfy95XDvtC+e0xeSYyJvRJP03g/9ql
        uFjlq5OCQkocGVeN+dg9OmRW2aFo0OkNHYAI5qLQKA==
X-Google-Smtp-Source: ACHHUZ59nmfYULt99BcAd1fsiRehSxiNwq4WR0XL7rzfga36xwxlT8G2hlKjI4WZ7FjamYLHleaRunmdnysnlp+tB1A=
X-Received: by 2002:a81:c24c:0:b0:55a:6e23:1a82 with SMTP id
 t12-20020a81c24c000000b0055a6e231a82mr22237820ywg.52.1683876978444; Fri, 12
 May 2023 00:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 May 2023 09:35:42 +0200
Message-ID: <CAPDyKFrD5HihGzH17HHd9NP5SoH73prmsuK1NCHg-a62dbH_fA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add runtime PM operations
 for BlueField-3
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 May 2023 at 21:03, Liming Sun <limings@nvidia.com> wrote:
>
> This commit implements the runtime PM operations for BlueField-3 SoC
> to disable eMMC card clock when idle.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76 ++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..19ce058fc5f0 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>
> @@ -542,8 +543,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         }
>
>  #ifdef CONFIG_ACPI
> -       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata) {
>                 sdhci_enable_v4_mode(host);
> +               pm_runtime_enable(dev);

Why make this ACPI specific? Wouldn't other platforms benefit from
this change too?

[...]

Kind regards
Uffe
