Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BAC38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 11:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiJZL0S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiJZL0Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 07:26:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825E88DCE
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i3so14913065pfc.11
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oKMH349mZyE5O7C704UgXn1/jmb8ZYxBnb9zQ3jLyPs=;
        b=rtSKgRih/Rp6X6v7AodnB4GE3zrhjUZKkr/sSye7kQdmaEUunut1UNRKgok6sEjxV2
         pSGJs8cXlK8tJMBmv19tv2/BUsiPu1TYfgHTDZszp0njo5ID5SDosnyuO63pSIc455U4
         UJKZql1jG0WulwR1xMQ0nHuEGrZP7RomgLR4qCdi1A55R0HxylWKby/0KzlDteTlAEz8
         CoKUlXKmRpAvZ3gCZpqcv7FUUdbGYvk1Sp5nz5TAFfHlQYuMppW7uauBrpuiIzy+IPmi
         CnXK4rgY9V6eTcNYGm0eOXyHQHk8esTZk008OTNdjDvIygoGfu8BD7IeU4OJn9WL7KqZ
         Erww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKMH349mZyE5O7C704UgXn1/jmb8ZYxBnb9zQ3jLyPs=;
        b=4zecsHsjHGwAhJu2e7vsFLWjMJcJyOWXhms5YbTR3OGu0G1jG/rVP+IKopGIX0ZqI8
         xANM/HAQJItENwwYHdU1ttriww45AHidW+1gWBDiruZwBiGUIQzlzhXUh+4Zap0tRb0x
         34ElYmv0pXXKb0ojF86H2xf/U2aBZKzTILLMSPto7ydSFnsOPywcos8GGLm3bIqr65OB
         wYgUazOdYpnCQ7uempDfjnS8LUk1zu6z5NCx1YVhTIV1ERnEP6O6O+GUCoge644T+EwR
         nOxFw0yx4OGqo8V62taDl8VA2hpyuT5FFY883a43CZZ6TzDMPnvYi+JAxy26s21hyeNy
         cRLA==
X-Gm-Message-State: ACrzQf1WehZRStlUsZGozXUyaKpgxRCOKFUwbCZRfjOPW0GNQMZ06VRY
        eOjbtljKMCv32u3F/AWQDO5AvUZhbGs9DwmxF43Qug==
X-Google-Smtp-Source: AMsMyM5Nk2Bq2USu1gAlBY3AF6LKiFYfA1dqTbiUEDZdqG19uUBjs9mT8Sy+aWW0rWBsC1Vx/AubDQIFn8y3Hil/6UU=
X-Received: by 2002:a05:6a00:1823:b0:56b:f348:998f with SMTP id
 y35-20020a056a00182300b0056bf348998fmr12726452pfa.28.1666783575021; Wed, 26
 Oct 2022 04:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221024180300.2292208-1-briannorris@chromium.org>
In-Reply-To: <20221024180300.2292208-1-briannorris@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:38 +0200
Message-ID: <CAPDyKFqP8SSPCCDqcs8P_95+9jy=3UW11CTcUvvyXPAeH2v5WA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Oct 2022 at 20:03, Brian Norris <briannorris@chromium.org> wrote:
>
> REGMAP_MMIO is not user-configurable, so we can only satisfy this
> dependency by enabling some other Kconfig symbol that properly 'select's
> it.
>
> Use select like everybody else.
>
> Noticed when trying to enable this driver for compile testing.
>
> Fixes: 59592cc1f593 ("mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..fb1062a6394c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1075,9 +1075,10 @@ config MMC_SDHCI_OMAP
>
>  config MMC_SDHCI_AM654
>         tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
> -       depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
> +       depends on MMC_SDHCI_PLTFM && OF
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
> +       select REGMAP_MMIO
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's AM654 SOCs. The controller supports
> --
> 2.38.0.135.g90850a2211-goog
>
