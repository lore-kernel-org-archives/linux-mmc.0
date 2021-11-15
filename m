Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8482C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D0C6321B
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKOO6V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhKOO6N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 09:58:13 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99592C061210
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:15 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t11so36135513ljh.6
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jv1FyWTvSFkzwe84PcyLvxqk+TijWQ0y/lQ95MsalS0=;
        b=Y2ZKW5eoHPejk/E4W+Dv2yfW6xLpij7VRiG1ySppwCyrAI2FVYpN3vsgxuBAOkDmIp
         bOStS5l28Cu1HKcIrbMLDF7Su7nDdWx0xy9t4r8uZPTitG6ltDL7Nugvwrm98+UG1ves
         68WU71+H4qZVO5Tt06aXDCJCzNzkSNRiTT9+LWRAxMRnvfMkqY2xeRwEch9uN0VetYVX
         ivU+8OCM8U4Fpl3v/Ne8HhGkLiH9PqKRS9xEOW37qCOaXlFiMAfGM6aLNRmeIOOwiqij
         Ne+TcmbUgJAbHLwtwA9/AG2XpaEtOKOnjXbBw+Xoaxnb5y+MoWM3VEUpUzBqdQuggBLA
         T+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jv1FyWTvSFkzwe84PcyLvxqk+TijWQ0y/lQ95MsalS0=;
        b=Yos0vDyjZHNA5dH+RUtlUssGHidoLHwTpaC+4ej/gcOEMEc8f0ppkoZCIOmabHpcIu
         kx3lfM8f2ZMzoyHR8ozkUOds9f2CyUBzRA6eWudq3rc/Irqim+l2h1KCuUQfzJIETDJ7
         elAQDXh0Y3xswTvltVwMqpkCa6r7AxzqOSJF//eL5nnLEPS+3rQeCeCEOGqOr5sxs3nh
         yLVBigBjN22fafqPl/TPjNBOGWmVriIoZ2WMEDzBCgVgFY3sXydStKXRj5P9dlR/JenS
         OxP9SkuKtAwmqKNP3LDbSsSj40eZoRE1ovgUundm7zCLWgzsEkRISlUEVj+UOZxLKkqI
         wZqQ==
X-Gm-Message-State: AOAM531jY4pS4zRO+W/gxdUOJdtgkqwEojiE3MdKNK75ttUMPRuWMW/i
        nypaDiDa7lVsaxftA+Z26vyTLTqBYl3mmC/DcnWpPA==
X-Google-Smtp-Source: ABdhPJyHIzpMiaso6l0huu6M4lqAHLE3ome+kf4mCfPUMvzUxRjUViPtO3zCxXU55aH1QVFk46jf1C7iFf0eHuwng4Q=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr39072444ljn.463.1636988113817;
 Mon, 15 Nov 2021 06:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20211115082345.802238-1-adrian.hunter@intel.com>
In-Reply-To: <20211115082345.802238-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:37 +0100
Message-ID: <CAPDyKFrADwgb_xeVDmdPETcFnbqRqvKKav_Gr+oGf-4E3Tfj6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Nov 2021 at 09:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> The block layer forces a minimum segment size of PAGE_SIZE, so a segment
> can be too big for the ADMA table, if PAGE_SIZE >= 64KiB. Fix by writing
> multiple descriptors, noting that the ADMA table is sized for 4KiB chunks
> anyway, so it will be big enough.
>
> Reported-and-tested-by: Bough Chen <haibo.chen@nxp.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Should we perhaps tag this for stable and/or queue it as a fix for v5.16?

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci.c | 21 ++++++++++++++++++---
>  drivers/mmc/host/sdhci.h |  4 +++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 269c86569402..07c6da1f2f0f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -771,7 +771,19 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
>                         len -= offset;
>                 }
>
> -               BUG_ON(len > 65536);
> +               /*
> +                * The block layer forces a minimum segment size of PAGE_SIZE,
> +                * so 'len' can be too big here if PAGE_SIZE >= 64KiB. Write
> +                * multiple descriptors, noting that the ADMA table is sized
> +                * for 4KiB chunks anyway, so it will be big enough.
> +                */
> +               while (len > host->max_adma) {
> +                       int n = 32 * 1024; /* 32KiB*/
> +
> +                       __sdhci_adma_write_desc(host, &desc, addr, n, ADMA2_TRAN_VALID);
> +                       addr += n;
> +                       len -= n;
> +               }
>
>                 /* tran, valid */
>                 if (len)
> @@ -3968,6 +3980,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>          * descriptor for each segment, plus 1 for a nop end descriptor.
>          */
>         host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
> +       host->max_adma = 65536;
>
>         host->max_timeout_count = 0xE;
>
> @@ -4633,10 +4646,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>          * be larger than 64 KiB though.
>          */
>         if (host->flags & SDHCI_USE_ADMA) {
> -               if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
> +               if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
> +                       host->max_adma = 65532; /* 32-bit alignment */
>                         mmc->max_seg_size = 65535;
> -               else
> +               } else {
>                         mmc->max_seg_size = 65536;
> +               }
>         } else {
>                 mmc->max_seg_size = mmc->max_req_size;
>         }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index bb883553d3b4..d7929d725730 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -340,7 +340,8 @@ struct sdhci_adma2_64_desc {
>
>  /*
>   * Maximum segments assuming a 512KiB maximum requisition size and a minimum
> - * 4KiB page size.
> + * 4KiB page size. Note this also allows enough for multiple descriptors in
> + * case of PAGE_SIZE >= 64KiB.
>   */
>  #define SDHCI_MAX_SEGS         128
>
> @@ -543,6 +544,7 @@ struct sdhci_host {
>         unsigned int blocks;    /* remaining PIO blocks */
>
>         int sg_count;           /* Mapped sg entries */
> +       int max_adma;           /* Max. length in ADMA descriptor */
>
>         void *adma_table;       /* ADMA descriptor table */
>         void *align_buffer;     /* Bounce buffer */
> --
> 2.25.1
>
