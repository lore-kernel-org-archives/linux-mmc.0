Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5204DC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2217D23109
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 12:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbhAZM2K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404446AbhAZM2B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 07:28:01 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F1C0611BD
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 04:27:20 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a25so18175480ljn.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9v3KzGuGqK5MBcKhrYjClIynInTPzsS/HTqIFvp1/IQ=;
        b=AhNeC2fz88Ilx7fr9U//EqOYLJZuP4afzoY1D9Y/bD2x0QTfkyd4mKOivKJxKrQ0Yf
         6AvZnGWJ+8LIf9dqoKuCS6bVudx19xZbFELWI43p6MaiD6HlMHGZn9DB+SNCIrXee6Ab
         eqMtMi4JDWBe5lQUk4xFFtxSmYZP0Ucw+Ov1Fp43HytHn3j1Ibi/PCf4/YuHN3aGeLvK
         GUIFIvLGogG+pAvZxYHFZq704nBoKjv6IL+3GJnyh9QRAMF39P9lFY1Z9Cq9IZ6tDM+7
         pK9wJQJCbRKYmOj3QsDHtWvQsugGdzgQ0HViEv2CgJEv2tfA7uECayDfXOPMkVaLxfHo
         VpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9v3KzGuGqK5MBcKhrYjClIynInTPzsS/HTqIFvp1/IQ=;
        b=UQLtqFlenDvM54vPFInlIKV9OE1wbf2bBbw35h0L6QojZ4rrg/kBpig5B9A1/xV0bg
         koqBMNIvKDcPu8EBuckGw0s9znGuEvUriqfhFHqbnc3+myOrrTJI4kgCMXT+0UKXBdBx
         xYu17id6rXGy03bMYnzyy04+YWKN0EXUq8ngtMU89booueb8EbYrsEkT0dzCoSaYkSbx
         JATTFscSqywA2JVejKBzGkAH0j18XM6RWALlTXEIMu6+gvU1OyBZsXifTK27J3Ikls0m
         D5KRKbJauOHU+zWlQxLL+ZAbALqznmBeXaLSf0kIQK0482A+Tdpv8oLlosrz9glF8+UJ
         ofSg==
X-Gm-Message-State: AOAM531w8ZsKuOjjqVCYOy9voawAI8BE2eC2wDm7Dc8cJzLf9/Fopm9H
        spuU9LyMfRXjNHDYHyzXEOU88tgQpxAChSRLN3dLDQ==
X-Google-Smtp-Source: ABdhPJwQDPzt2pQJdG1h2shmSbkHRYF079XcqA/pvY3/oPEW206//2F908lHU7Mei6Id7APUc3gEXfQ+JgG0zDmUVa8=
X-Received: by 2002:a2e:854d:: with SMTP id u13mr2614130ljj.439.1611664038883;
 Tue, 26 Jan 2021 04:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20210126095230.26580-1-ulf.hansson@linaro.org>
In-Reply-To: <20210126095230.26580-1-ulf.hansson@linaro.org>
From:   Nicolas Schichan <nschichan@freebox.fr>
Date:   Tue, 26 Jan 2021 13:27:08 +0100
Message-ID: <CAHNNwZCFrZvmiVD7A3Ys9rpxfb0AytJx1CFQDYkMWUkYTDuCsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 26, 2021 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The implementation of sdhci_pltfm_suspend() is only available when
> CONFIG_PM_SLEEP is set, which triggers a linking error:
>
> "undefined symbol: sdhci_pltfm_suspend" when building sdhci-brcmstb.c.
>
> Fix this by implementing the missing stubs when CONFIG_PM_SLEEP is unset.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Nicolas Schichan <nschichan@freebox.fr>
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 6301b81cf573..9bd717ff784b 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -111,8 +111,13 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
>         return host->private;
>  }
>
> +extern const struct dev_pm_ops sdhci_pltfm_pmops;
> +#ifdef CONFIG_PM_SLEEP
>  int sdhci_pltfm_suspend(struct device *dev);
>  int sdhci_pltfm_resume(struct device *dev);
> -extern const struct dev_pm_ops sdhci_pltfm_pmops;
> +#else
> +static inline int sdhci_pltfm_suspend(struct device *dev) { return 0; }
> +static inline int sdhci_pltfm_resume(struct device *dev) { return 0; }
> +#endif
>
>  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --
> 2.25.1
>

Hello,

I have just given this patch a test and no issues here, so:

Tested-By: Nicolas Schichan <nschichan@freeebox.fr>

Regards,

--
Nicolas Schichan
