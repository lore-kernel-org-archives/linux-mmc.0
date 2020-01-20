Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911EC33CAA
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8FA21569
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2511IgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgATL00 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:26 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37071 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATL0Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:26:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id x18so18718904vsq.4
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7UThWdp1uXaZcw1/ZLNWeY2Tk0cs8ZTeK6ZI3loXCo=;
        b=A2511IgGXqHiPBgn5UG2akcEgI8r0/gsE7QttEQt2zJGQ/ZJ6q/37/YGsbV8ixZt6m
         kVWZRlRiHQvqB7oP50NGeAPGTwG3cXn+s+4ohgPkzjNfvawBtelq+dpNspXX5ASpxqNG
         5THf1TdbFNOHbN2xTL3FNArnz5V9QFB9VhvnPp+K3aaOBLhbwmhxG3M19fhklJHxZ1Is
         Qmm3PKKsJswTxrLb4evdcwTqZfFVoJtjLiLz8YgwdfyT3A2jwOz063vIuMWFke3FAXKR
         3lHq7i9dXLNUL2FfQmHTn2PnEXnyybA3duEWiHMm0SzFTqOB5waF3AuXUHkAAf5h8H+6
         2Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7UThWdp1uXaZcw1/ZLNWeY2Tk0cs8ZTeK6ZI3loXCo=;
        b=cZuelFh9ISA1WXmyQsjTdRrKMlDEskPlFZBvcgLeII7s70Q2vwhT/aovnuJbXGHzSd
         Zuq1MHCKBtWs2CYRajtgf5Hwkckrs2RygihX+q0x4NStMg3mXznhnptRCS5S3BOliJ/l
         NxPEuZ322ZhvQp2n8MKCM2Gx0n98+N5rJYNuUns2aMbElSffirUN/kMjbLOmD5UcBoNG
         YN6tV7X8g9bImiIJoNA0A52fnRQdJURm6t+J0qPLT9O/18aEp2SZ+jwWfBIju99Ya+Oz
         Q58ut2uxgc2OLgLptuwzvZq1qmND3NoLi5FMR0Khrzu69K8PX1qaHsX7pTY0R3U/4y/n
         6Lxw==
X-Gm-Message-State: APjAAAU8N6Osc6vYRyihcJZMaKmiV30E6n5YrFjqHEZi5mIu/WUmYuHS
        fBM837k5Ag6tlo0/AcP3FjMt+rcms//ixXS4o4DKzwEE
X-Google-Smtp-Source: APXvYqwOO0D+sXYm0LOG4TFymD1hgur6SeOjdCCIbAxoYk9ljqHsljxlagx5FtOUHPVc8ACOh4k2MCThYnM6L1Ogc2Y=
X-Received: by 2002:a67:6282:: with SMTP id w124mr11972002vsb.191.1579519584474;
 Mon, 20 Jan 2020 03:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20200120094835.28050-1-yangbo.lu@nxp.com>
In-Reply-To: <20200120094835.28050-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:48 +0100
Message-ID: <CAPDyKFr48-dVjmu8x-wbC6eQwrt9U_BCOHPqjcR3+R1BR=0cNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fix serious issue clock is always disabled
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jan 2020 at 10:50, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> This patch is to fix a serious issue that clock is always disabled
> in esdhc_of_set_clock().
>
> Fixes: 1b21a701aed9 ("mmc: sdhci-of-esdhc: fix clock setting for different controller versions")
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8c06017..2950ae2 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -745,7 +745,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                 esdhc_clock_enable(host, false);
>                 esdhc_flush_async_fifo(host);
>         }
> -       esdhc_clock_enable(host, false);
> +       esdhc_clock_enable(host, true);
>  }
>
>  static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
> --
> 2.7.4
>
