Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78962C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5872D2075F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1iYdjiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgEOHKL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 03:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEOHKJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 03:10:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC8C05BD09
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:10:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id l25so636596vso.6
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myGyyZuzORGXEjWjyinqgW2ioJBRbKGcje8Lfk9tAJ4=;
        b=V1iYdjiOBUzaZsw9VykUGi6O3id6OkuKqKwhHbS7Ia6GpcTJZHMx8pkdASMjcCODmr
         x9qzM6Z+XeTcaiCtNUzNOE69Z3Ai4uwnSXHD6paK4pJBja1MfDlyIuoLErPxTJ2dQNzZ
         BEIwKsUoRXtLfiEgDgOGgUY/C27XjDKycTr+wTsOJqgq8l/RLGEdHcnuJUHZ8Kwl2mK6
         N/7PBniq8Gi/d7/Q1bL6mTsSZXL8S7npqAYqFix4H11vG0hS192A4jQdzPHL0GKVhlph
         XOipgyMJVJ6zfeC4hIG578pr6Po4V9J8UNz3CJxyc+LHJANsVlqF3hJ4UkygWYmIN5yp
         0+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myGyyZuzORGXEjWjyinqgW2ioJBRbKGcje8Lfk9tAJ4=;
        b=ExSu7CRMbhTvyiaJPUAxbV+o0wmZTosITl/lM7mmuTr4BS3Q5Hwkj9mcyMHBLqkS6I
         kdIaaEvpKQWzaENr5JM7gFh/vMRi8NzwBQBuJbh0y8cJQnPUNSSAA6eiLfo9nG7wHQoX
         JIOjCRlwflFM1nt/lhfrltxBIMFZTXjuI3UsP2g68E2ubkLHQJxRtdYalh5Mwja/M8BL
         gt17emgtAREZN7C7ktQL3m4SkyDmEifZe6ZIN2U7MwSXznidZGhXtOXD6DI4yYLmVb//
         KVWeSuj2F5nvFc3r21GX56kHRX5NiFEBBdhETXbrFd/SfnGQ6PAeNfR2h60i9vOHDczz
         W13w==
X-Gm-Message-State: AOAM530MygTPXHiOxmWgAztJrqkvXaJozGapsbeLQ+dNw/dW8bMt/irY
        zIxab9o0mCeZvn6WhXxe759Qo5zHUm6sHHoVO0RgRQ==
X-Google-Smtp-Source: ABdhPJwWT9hZyFsNUs1oXPi53/yyClKjwQlDhz3XUttz3eZZvyWLoaaa83hLU9+m5NTVHoY6N8fZU3lwC03rOLFfkFQ=
X-Received: by 2002:a05:6102:5d6:: with SMTP id v22mr99713vsf.191.1589526608698;
 Fri, 15 May 2020 00:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200513182602.3636a551@xhacker.debian>
In-Reply-To: <20200513182602.3636a551@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:31 +0200
Message-ID: <CAPDyKFr90VZof91VBzLU6JWsna43c++QxL9Z3WREVC7NZTQ=QQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: implement specific set_uhs_signaling
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 May 2020 at 12:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> We need a different set_uhs_signaling implementation for
> MMC_TIMING_MMC_HS and MMC_TIMING_MMC_HS400.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 31 ++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a5137845a1c7..a9ed0e006e06 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -16,6 +16,9 @@
>
>  #include "sdhci-pltfm.h"
>
> +/* DWCMSHC specific Mode Select value */
> +#define DWCMSHC_CTRL_HS400             0x7
> +
>  #define BOUNDARY_OK(addr, len) \
>         ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>
> @@ -46,10 +49,36 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>         sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
> +static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
> +                                     unsigned int timing)
> +{
> +       u16 ctrl_2;
> +
> +       ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +       /* Select Bus Speed Mode for host */
> +       ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +       if ((timing == MMC_TIMING_MMC_HS200) ||
> +           (timing == MMC_TIMING_UHS_SDR104))
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +       else if (timing == MMC_TIMING_UHS_SDR12)
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> +       else if ((timing == MMC_TIMING_UHS_SDR25) ||
> +                (timing == MMC_TIMING_MMC_HS))
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +       else if (timing == MMC_TIMING_UHS_SDR50)
> +               ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> +       else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +                (timing == MMC_TIMING_MMC_DDR52))
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +       else if (timing == MMC_TIMING_MMC_HS400)
> +               ctrl_2 |= DWCMSHC_CTRL_HS400;
> +       sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
>         .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
>         .reset                  = sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
> --
> 2.26.2
>
