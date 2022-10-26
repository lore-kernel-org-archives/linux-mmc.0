Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24239C38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 11:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiJZL0U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiJZL0T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 07:26:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAC8B2EE
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so14455186pgc.9
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIiOLjtnf2qbxkuXcBFpYSERKNLiy0vN0TgZPAlpRjI=;
        b=y3AltkaH/WeQVuWZdTks3oMsOwOdaRAp3Vup5pEkIZGuzLowz3YlhxeQatzvFZMk9l
         pqIp9SGTHos8srmXNwjuc6XF+dUF9/H/OSaQPF9I8cxjaLJV/2H1nCvKiMU2J8JjYN3Z
         oqXoxpFlS+gXDJPTkkGgyPiLRfPIb7v2zGs/YmfiIUvcZZfm6EGratCTW1HbWjEK1xlk
         TbgmxRAhbbDMaOyWx4nQkB1tauFJuvIYKaS4ukMwtfQKoJ0+Gpsj/CnrmF+jzpljUrT4
         mBycOO7IgpVKJB3tMrXXRtc4ZHByPxU1DCD8plMI2qxrvEJjlyBMTLlxxSBiqcdpAv2u
         Ws/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIiOLjtnf2qbxkuXcBFpYSERKNLiy0vN0TgZPAlpRjI=;
        b=JLxVHfhGRMqRnHKtMsxCunyKkTwd1XcvWfIQMLz4aFy6TOXaVf1HhFYv1urKHYv3W8
         L0RLB8a/rpVxy1UNqDKDN9cyAufkNW/Te+jUqyAYDpAV4LJYLZIJZGWhj7u+6GnZ219x
         XwjGsYqKwCY/F5JGo5LyqT66KPrlt28k1jEEjih0omTED/RDPZS2gkBvc8EULYWWjPKu
         5O+asgop8A65DnfB5pO3LetPaIc8jUvalaNVpDVT2kjNfBXxwyK/4+eqATjtAH0hPmRk
         N/22uMskd28J5bQasDbjjHDZlFX4wcZLVPmyU3so0W1mLjOusWw9gGHMLBO+cYaQ3uo6
         mkLQ==
X-Gm-Message-State: ACrzQf2xFpTer8UTCkqFXLq7K2D7s/32G594D/Z32PQ6iNZ4fL9aZfmv
        +oLdNi74OsaaTLOjLRZu1OU+p8p7rVf/4uFybrTBfFdK0Ns=
X-Google-Smtp-Source: AMsMyM7KVNwJRn9XUHGfIaLNGJ3yt+K/RIDMpM6kVr83jtTNXXXw7fsFhVW5kigCfMN9KGs+iC0vAFLKjLRxr8LPspA=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr37998315pgl.434.1666783578179; Wed, 26
 Oct 2022 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221024181759.2355583-1-briannorris@chromium.org>
In-Reply-To: <20221024181759.2355583-1-briannorris@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:41 +0200
Message-ID: <CAPDyKFoWoUFOL1Q5tiP07PMCbn8U6sY+FRdo03c8FZCQh_R2Dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
To:     Brian Norris <briannorris@chromium.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Oct 2022 at 20:18, Brian Norris <briannorris@chromium.org> wrote:
>
> This driver is pretty simple, and it can be useful to build it (for
> validation purposes) without BMIPS or ARCH_BRCMSTB.
>
> It technically depends on CONFIG_OF to do anything useful at runtime,
> but it still works out OK for compile-testing using the !OF stubs.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..453fba8d2d9d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1040,10 +1040,10 @@ config MMC_SDHCI_MICROCHIP_PIC32
>
>  config MMC_SDHCI_BRCMSTB
>         tristate "Broadcom SDIO/SD/MMC support"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_CQHCI
> -       default y
> +       default ARCH_BRCMSTB || BMIPS_GENERIC
>         help
>           This selects support for the SDIO/SD/MMC Host Controller on
>           Broadcom STB SoCs.
> --
> 2.38.0.135.g90850a2211-goog
>
