Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47271C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179C4218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRnVYBKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLROCK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:02:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35496 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLROCK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id x123so1447267vsc.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH4aIq7Jaykh3QOsuADriJ4yT0d4LtE+YvUrQccjYaI=;
        b=sRnVYBKK2r5JofW2URszX0KMUVpMDnItr37/jrqF/RSIrMziEgKU/7Kzw16JWctqzi
         Y0SjYdEa3F3n32pwKzuesXs7HENFMQxAosZENiCSwkW8H0FMKYCEyG+5DlZFhMQbjSzM
         ZVVcO/xYbsT8JKaShOPJz4Cy4S8sLPivDhcSjaJB1HQikiZx8ccGrfDzeuZ9WDZuJf16
         808sFvJp5MUfkQCJXYpW/wSs0RiDhAgvJB+uSfdwEq4PmwIBQAhdUSVh8bz42xwAdAwa
         FS1ELxvjZjseV5tnwlkJBTuk0DZDwRmVqZaNpMNIuVy6hI9k73UW0sbqdsHyD6HZ3Gi2
         gwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH4aIq7Jaykh3QOsuADriJ4yT0d4LtE+YvUrQccjYaI=;
        b=q4X2RRqRSrqYliowmhbIafsMU0yHOPkQQDpiLgeFlWNeRK+9j4hafwMkO32XAsbjCH
         cwbdK4BycXxwTWS+5Kf7Ncl+UrBrjdOPXBfQdxSSH3+1CJAq1B+IgnyVkaQmCDeoTvRw
         ONzdT2td++r7MJ6GEv7UVkvz6Da7vpPUte3bc8sLs908fN5xPw8OHOZiKJjDle9G7s8e
         TDT3BTakUAMsylCsJ356k2RjqPFMfUPuMMIerPGXssTZYNv/QbFXjenqup78gtEJ8bAJ
         lBv4rqJAW1vJWsqCGxJoElfc189VYXXAtsj6dpxl/HM8W+YHneiymYYeGvk0UAOsUBCQ
         UM2w==
X-Gm-Message-State: APjAAAW+6OcfJ1elUAya5iPhmxZP6DJwuosGdTz6C1HHwViqFLyI3I1k
        YK1G+Q3KRvw0i6myLmN5gBYyNUunMC2b4LDSY89/7pso
X-Google-Smtp-Source: APXvYqxxlIlPm3y7R1Cte5vgr1BDrkFQTJ0yqQLl2SLT1QNp7IfjFGpso/xJAh+mLlnwyuoXUk1YobOL+Df3y5gZ26w=
X-Received: by 2002:a67:f499:: with SMTP id o25mr1432467vsn.165.1576677729315;
 Wed, 18 Dec 2019 06:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20191217095349.14592-1-adrian.hunter@intel.com> <20191217095349.14592-2-adrian.hunter@intel.com>
In-Reply-To: <20191217095349.14592-2-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:33 +0100
Message-ID: <CAPDyKFo=1kWajo71WMDTvMqGi-w6jmVjb5pGy-x-vB3rWKLewg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: Add a quirk for broken command queuing
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Dec 2019 at 10:54, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Command queuing has been reported broken on some systems based on Intel
> GLK. A separate patch disables command queuing in some cases.
>
> This patch adds a quirk for broken command queuing, which enables users
> with problems to disable command queuing using sdhci module parameters for
> quirks.
>
> Fixes: 8ee82bda230f ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2e5dba..f4540f9892ce 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3769,6 +3769,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>                        mmc_hostname(mmc), host->version);
>         }
>
> +       if (host->quirks & SDHCI_QUIRK_BROKEN_CQE)
> +               mmc->caps2 &= ~MMC_CAP2_CQE;
> +
>         if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>                 host->flags |= SDHCI_USE_SDMA;
>         else if (!(host->caps & SDHCI_CAN_DO_SDMA))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0eaef5f..fe83ece6965b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -409,6 +409,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_BROKEN_CARD_DETECTION              (1<<15)
>  /* Controller reports inverted write-protect state */
>  #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT             (1<<16)
> +/* Controller has unusable command queue engine */
> +#define SDHCI_QUIRK_BROKEN_CQE                         (1<<17)
>  /* Controller does not like fast PIO transfers */
>  #define SDHCI_QUIRK_PIO_NEEDS_DELAY                    (1<<18)
>  /* Controller does not have a LED */
> --
> 2.17.1
>
