Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683BC6379F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BE22468F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ld8RtgzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQLvD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgKQLvD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:51:03 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DDC0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:51:01 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id v9so6404829uar.11
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPZaXdzLxU9pyn3jcVctcpIkUwaKDaKf29Avrgf9YS8=;
        b=ld8RtgzGdlxu7IjY/LhumFyHzpD2rpk0ZPCMr1DnMf9xiNeSkp0MXET243/U6METnH
         bpT8H0PMRyQaOGy7bQM8MCUciiiCXhuiSAtYZ4Y6pqLLayAY7hFlgCCE1Gl6/93mlGBt
         8s+dylUzhgSqBlZuot9ALTEUu3xrsyifYpvMTcIdzrL6C5C60WU7qSd6oOoUufGIDiY1
         Px9stLHcjG/DDHu8Zn6ExjVxvzZXzJytUCFmbX09B91uGZxHMYs4AxzqmuIgCOzctcr8
         vsHJcFMH8ZXd2C1MKTcL+jUzOq9oXR5m1kGaEyBnh/2RbsRBt4vITEfYXC0m9+kziiCo
         nKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPZaXdzLxU9pyn3jcVctcpIkUwaKDaKf29Avrgf9YS8=;
        b=IzHdCDKuq8nNwjr1AK1GBooQ/RQwVVOH/+qX+OMslJFfrHN2eYTG4K3QZ6wUNGBcIq
         Ns2g/VE/kX3i5fONIRYyLqwubwBbuAjL/lDC2BGldqkoKVIthRMy/5NqPuQvSqJH1tqs
         7z/Qtsuvx2a9mvxB3qhtJGZlSWgrgS7AIDZ5dlRA6NC4P4mb1nJm8/h4cpXVNLvmSQOE
         +jtVUUJKpL2GVpUYnCNto5/zQ2vGYxbP/ncr6QGsaPp9Y9g5chCHPnQAyTynow14RuGZ
         M7NVE8xkX+oNrBs1C1/3XBWfRa9KjUFFGnprAQdhWMHfMwzQvhfExxoovz1zIYLHW+sU
         BZsA==
X-Gm-Message-State: AOAM531yX5qkZEwRFfaWPCxCsveeVzaO+aEc3oPRZyVFrUziU1jOpW91
        osDu8HUTmAXCNJhbDgG9wE5fkZr3e5ptNIurjqAkkg==
X-Google-Smtp-Source: ABdhPJzUKuJPTbOyA0Ba1p7c3TlmtTuVlQvDMeGXTYXoSomYc2DkGe4Wp4Hn+nyILPbmQRgtAWE0fbRur7Q0YHdIcSQ=
X-Received: by 2002:ab0:7103:: with SMTP id x3mr10786144uan.100.1605613861159;
 Tue, 17 Nov 2020 03:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20201116132206.23518-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201116132206.23518-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:23 +0100
Message-ID: <CAPDyKFpV4jxuwqhP3tezhJex02Ou9A+NAq+P_jVELW68cKzPtg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Nov 2020 at 14:22, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> 'busy_timeout' is in msecs, not in jiffies. Use the correct factor.
>
> Fixes: 5e958e4aacf4 ("sdhci: tegra: Implement Tegra specific set_timeout callback")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since RFC:
>
> * added acks
> * fixed typo causing build failure ("MSECS" instead of "MSEC")
>
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ed12aacb1c73..41d193fa77bb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1272,7 +1272,7 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
>          * busy wait mode.
>          */
>         val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> -       if (cmd && cmd->busy_timeout >= 11 * HZ)
> +       if (cmd && cmd->busy_timeout >= 11 * MSEC_PER_SEC)
>                 val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>         else
>                 val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> --
> 2.28.0
>
