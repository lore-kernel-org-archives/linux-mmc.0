Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74377C64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBMXuA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMXt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:49:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7619F31
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bg2so4182307pjb.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676332170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqcL+yTn1fiA5fKrsVjFnlJitfMsj/VXs0iAxxYQRNI=;
        b=DtxmCDQkSrXaIlL0SiQdAmWWjgmqZQNkj6Rk77fLGPIzyoOKxVwwbJcp6IXcMa1ElU
         w7nMHOGwIQKb764P7ryy4KeVYLS1Jd91n5WbiGstN5RmMtgbMLQSF5RY4UQNsyHx7utZ
         kKz8O4m3iFxnzoYbLsDPkJIXsjnkXApVbrfz5sXhGdbQm60Od6vXhuvLQIcikxRwProO
         Q71+RXlGrhUYawPwqtc19qTvXcnxC3hex7xE73tNeV8Drox/XDXWRjM8POXUhW1uqVGJ
         7xqYiezpf66wHJTKOZqYFkG4EzcoCXNoPlUpsRXoEjCCpcocmHoCEPFIcFDAyq4LAKLx
         Ww5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676332170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqcL+yTn1fiA5fKrsVjFnlJitfMsj/VXs0iAxxYQRNI=;
        b=kcKnDyHlX5VeBHrZtY6zNbTi1nJcOWJVVgQA5Bi6RanlYIINJIqpmEZ9JjUGo5PyHt
         a1qS8Hy3p94NCxsjx8aEi0UMmmkgrHCclaZAAuTZMMWMFeP7c5+DKdwXwqcuoe3vgusH
         OLz73JFobUyxQzN8lt8u1p/XNxKW1We+JkJVr8ikCH+N/O4PVZWk+u1KrVndpVIrfp+J
         l4ilOVqx9j94PKYJJ5nqbCKL69fbbY4QWC5tMS76s1UyvX7qVzVSSCFmUSkAzoeecyy9
         faKgyby/sAwx0RV7b9OIE6s2gfoYQPerRZV0KtLy9j5u/KONabhcX3w+cHNv7es9qzR7
         gA6Q==
X-Gm-Message-State: AO0yUKV1PcOg29AP0n/0OgY0JXMRiQZAdgaUY8WK+PahlLT1qpcnMtib
        WeasLxZiEtIWcH6ifvpd8DSVDs9fWWs16C65CE5txw==
X-Google-Smtp-Source: AK7set9AYeMFuAyjnDhgkva+nGVAezeEZfzh9tolf7qS/h/itOdqxUWwAat9xmZrkTEUirPHVw49HULoqNcrDYg0vRI=
X-Received: by 2002:a17:902:d506:b0:198:99b5:cabf with SMTP id
 b6-20020a170902d50600b0019899b5cabfmr170240plg.25.1676332170051; Mon, 13 Feb
 2023 15:49:30 -0800 (PST)
MIME-Version: 1.0
References: <1675298118-64243-1-git-send-email-shawn.lin@rock-chips.com> <1675298118-64243-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1675298118-64243-2-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:53 +0100
Message-ID: <CAPDyKFrduc0FdXg_nVZ5W9-=k7-CcqAm-xW-S=gPJhoXaEMcUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci-of-dwcmshc: Update DLL and pre-change
 delay for rockchip platform
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Feb 2023 at 01:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> For Rockchip platform, DLL bypass bit and start bit need to be set if
> DLL is not locked. And adjust pre-change delay to 0x3 for better signal
> test result.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4933867..46b1ce7 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -48,6 +48,7 @@
>  #define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL  29
>  #define DWCMSHC_EMMC_DLL_START_POINT   16
>  #define DWCMSHC_EMMC_DLL_INC           8
> +#define DWCMSHC_EMMC_DLL_BYPASS                BIT(24)
>  #define DWCMSHC_EMMC_DLL_DLYENA                BIT(27)
>  #define DLL_TXCLK_TAPNUM_DEFAULT       0x10
>  #define DLL_TXCLK_TAPNUM_90_DEGREES    0xA
> @@ -60,6 +61,7 @@
>  #define DLL_RXCLK_NO_INVERTER          1
>  #define DLL_RXCLK_INVERTER             0
>  #define DLL_CMDOUT_TAPNUM_90_DEGREES   0x8
> +#define DLL_RXCLK_ORI_GATE             BIT(31)
>  #define DLL_CMDOUT_TAPNUM_FROM_SW      BIT(24)
>  #define DLL_CMDOUT_SRC_CLK_NEG         BIT(28)
>  #define DLL_CMDOUT_EN_SRC_CLK_NEG      BIT(29)
> @@ -234,9 +236,12 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         sdhci_writel(host, extra, reg);
>
>         if (clock <= 52000000) {
> -               /* Disable DLL and reset both of sample and drive clock */
> -               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> -               sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_RXCLK);
> +               /*
> +                * Disable DLL and reset both of sample and drive clock.
> +                * The bypass bit and start bit need to be set if DLL is not locked.
> +                */
> +               sdhci_writel(host, DWCMSHC_EMMC_DLL_BYPASS | DWCMSHC_EMMC_DLL_START, DWCMSHC_EMMC_DLL_CTRL);
> +               sdhci_writel(host, DLL_RXCLK_ORI_GATE, DWCMSHC_EMMC_DLL_RXCLK);
>                 sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>                 sdhci_writel(host, 0, DECMSHC_EMMC_DLL_CMDOUT);
>                 /*
> @@ -279,7 +284,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         }
>
>         extra = 0x1 << 16 | /* tune clock stop en */
> -               0x2 << 17 | /* pre-change delay */
> +               0x3 << 17 | /* pre-change delay */
>                 0x3 << 19;  /* post-change delay */
>         sdhci_writel(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
>
> --
> 2.7.4
>
