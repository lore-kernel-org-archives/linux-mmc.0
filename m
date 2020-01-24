Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3CC35242
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107DA206D4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJsoSEak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgAXLjN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:39:13 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44679 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403916AbgAXL0L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 06:26:11 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so421063vkc.11
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2020 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4zxNmALyQaeSNVgycZmI7UdCPyGJp4Jq4VQMZS6LoA=;
        b=AJsoSEakroKigcs2LGpzFMwCgIQRExPi/mj4WfXkL5sxCiUUKPgLWLeoUD/zI6wuJD
         nDnv5X/UovIDv0oVVPK/bOV/r9T3ChUKkgYIYC9t4UWuxU5RAzCwaz4yls51fzKxjmS4
         baFvn3RZy1U2BYpwOJBFp0lGTKupCoduCSPuHuVqFe6Zvmvs5v8TAxcMIrCENfbv0gPO
         T3jUlKF1FWyXmL/HeSFUU3+vCbS1MQg8KiHGmR+XrrP1oi7SRNC4e6IrzGzEjUY/bSrA
         L8VNNE6vFC1uwo1MYUx997nvmvUQ9J0bM4UZHWPs6E80bkD0AYOSbSd0L/O9g8UGfZY6
         bpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4zxNmALyQaeSNVgycZmI7UdCPyGJp4Jq4VQMZS6LoA=;
        b=Kqkfpu88WnrAgk+H2GoQTcdfaVpeqyEimBoZlYPsrcrOdrhxHQWTtjL/1UNW6w6xEm
         /+MiNsVosFXrf//vgPSpByCQr+jT/QT8vVfMFQCpndmsNydzyTCBpL6f8qbZ7qn26tHI
         BZCDfQSfYxIJmzBcOQ3j7Nq/DpSLG48mnEzp+AFuKEyZxsg3uz2tDZl3M8ynEmDotrwa
         cTn7q0JUXurqg2wDqKowbW3o6DbftduYMPqe2sjRaTl5CIsVqrLF8aJA3k7DNcwF0QL3
         Vi1gP4FYGMUdMcd5QBz+Br35VL41dlq43PFeWzDl07J2kk5XdAsSs4qF9sVgqAmPOmZZ
         E5Rg==
X-Gm-Message-State: APjAAAWZ7nMJldW4sXZ2juIsBcqL9I9lPr/jjLEf9+NbVDHaNFNvzJFd
        0eEVeh1k6rEOrcVdBgs/EWfLvzVDPQZSfT8FliCVcQ==
X-Google-Smtp-Source: APXvYqxfMDotHNYK2A3nSMosS8PRPs0S744rAnj3lTNvJsxAJkHtSPIC5Tx4zdR5V1TGJtFLt8LfVJgC5UtN0wPcvlg=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr1592935vkd.101.1579865170740;
 Fri, 24 Jan 2020 03:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20200121105858.13325-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200121105858.13325-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:34 +0100
Message-ID: <CAPDyKFosM5+ffP-qC+Z6k-mMzu9oVDVxNskNb5hFepgAyg8vVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: remove unneeded 'inline' marker
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jan 2020 at 11:59, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 'static inline' in .c files does not make much sense because
> functions may or may not be inlined irrespective of the 'inline'
> marker. It is just a hint.
>
> This function is quite small, so very likely to be inlined by the
> compiler's optimization (-O2 or -Os), but it is up to the compiler
> after all.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index ae0ec27dd7cc..5827d3751b81 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -158,7 +158,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>         return 0;
>  }
>
> -static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> +static void *sdhci_cdns_priv(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
> --
> 2.17.1
>
