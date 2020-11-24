Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E5C64E7D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4B208CA
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/lVSz2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbgKXOZ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:25:58 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B49C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:57 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id t15so6883195ual.6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZpokcrYiNkFKDrqesRHIwMWb2q0UieIyDPrr1PDT0g=;
        b=A/lVSz2zLoIYzKcnGI4hqoTNYMJi/cuhqeD4LKMoLjhpWJO+dbNTjQ/d0qMCnqzsHf
         owMFf/AwDR2B20tkqBKHFZ43l44GOqE5g9B4wPxNPbQNFqXhzEKInTc5u4roDg0+6KHs
         vFzW498O6l9DEzm/+2Io3MtIuOqr+yvAUSRvAE+6aNR2IlPW5gN/0qm7i/NqjUBVppP/
         EKN80ULQvItx7w5UnO5DieYnoNefjb/4oQKu7Hm+gBUmWIrWUhY7lyJibSj5MMUTNWcT
         lw3Gkg7NOi2NTNuM/RE63+C0Z9c6J0QY5+JmX6+8dCwRLEPHd94Deha9/zAAK/h/pcwI
         DpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZpokcrYiNkFKDrqesRHIwMWb2q0UieIyDPrr1PDT0g=;
        b=LDngBSumiIIZRVqK2Li8xKeSG6/4lH4VyacPaJmHFrSJQ8OHUu0x32B5kEs+HNacgG
         koKdnzKc2MnB/0UlPD7ACaMJZLjJvu7lI61RISlT5M/FbZqXjzGQT+/59KeZtROIcr8p
         hPMe93PfaZ9CLgTmhlaikrZKuXfJBuZTLJ1utpstusaNzxej3Kfj5J38p2uQ6G/pZJeZ
         dMMcDJpUrqIBIqEbLHNCSbA8RDp6KnRMegw2tIrwpypUX7zyQ+prlnu/6Dl9mbjF9irA
         iZw8MZy6KjzGFnBwMcqF+6TxpDis/sGxaJkWazGdFOb/1+/jQ1uuzmN1RT3yeLZ9qa/T
         LxEg==
X-Gm-Message-State: AOAM531xHKr2jWI/B3d5FNPH9GEA8CWZ74LTqyH3wzAVRyTlE+7mJ0EJ
        3OHlo2c37f+HQpsNE6/UqfgEQ0xzG2n7/VgY20fm0g==
X-Google-Smtp-Source: ABdhPJwGN9h11JcGB0t0T2NXu30qTxAsYUt9sPtNoXKotqtjo05E15lzuOauqFkaV4sGeIXw/BvauQnQWMr8nw/ivP8=
X-Received: by 2002:ab0:5859:: with SMTP id p25mr5651452uac.100.1606227957134;
 Tue, 24 Nov 2020 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20201120233831.447365-1-jeremy.linton@arm.com>
In-Reply-To: <20201120233831.447365-1-jeremy.linton@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:19 +0100
Message-ID: <CAPDyKFq-pMKAJdS8qPpkR_QZ_QLW70Y7PPGxA=d_HOBRd-Su=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Update firmware interface API
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 21 Nov 2020 at 00:39, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The device_* calls were added a few years ago to abstract
> DT/ACPI/fwnode firmware interfaces. Lets convert the two
> sdhci caps fields to use the generic calls rather than the OF
> specific ones. This has the side effect of allowing
> ACPI based devices to quirk themselves when the caps field
> is broken.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..feba64fbde16 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>         if (host->v4_mode)
>                 sdhci_do_enable_v4_mode(host);
>
> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
> -                            "sdhci-caps-mask", &dt_caps_mask);
> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
> -                            "sdhci-caps", &dt_caps);
> +       device_property_read_u64_array(mmc_dev(host->mmc),
> +                                      "sdhci-caps-mask", &dt_caps_mask, 1);
> +       device_property_read_u64_array(mmc_dev(host->mmc),
> +                                      "sdhci-caps", &dt_caps, 1);
>
>         v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>         host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
> --
> 2.26.2
>
