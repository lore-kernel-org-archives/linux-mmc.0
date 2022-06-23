Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25956C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiFWNK3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiFWNK2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 09:10:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58AC2D1E7
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 06:10:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b7so23266807ljr.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/llb3O0eT3//2E6kf1t/Kj3NiwHJiPBiVEdtlH7Nbc=;
        b=Qgi1nJO4MDxswjHVyPaA2Wer/3qVIVcwLERe3R3STXQjCB5o6x+jl5zzYXAFaHgZqD
         JAlExMacG0h35hWfpJnF1+3AAXh02/nJ7cFpN72oHwyMUMfZELZS/7+2An5g6+7Xlzwn
         u79saWY052+dUjkmNSY4d/12EBc7i9htWpgfLqgDoF/XtgZhnH0Tc++ZTaXNmt/wRO2H
         SzP/QAt6eQvkUnBSy3EQvxQfdjFyOOsXPiZ8iG9flpelw5F9Iu2ACKtuOvu4PPavC/dt
         FUgbVjpp1tHzmKOvX0so9xqIOqt18h006RZPFJiYGEvuzOPYMQ1LCC1PE5OLFn5klNE/
         OiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/llb3O0eT3//2E6kf1t/Kj3NiwHJiPBiVEdtlH7Nbc=;
        b=14o96Ih7aNkwSL/Ye5mLR72g1g9uWr9AieT2OKk7DPkby2owrS09d5vt2/8fg4TCP7
         V3CPrXmHdI3YkZVaveUQoO8eXZXtHVb0H56nrTkTxspOYXuhNHI4hltEvBVmubN1qhpE
         4ch4UTfFEEFUaI0I3XUYkehemQFvvojNOGY8AM7yr+acanDwc6kzEQgk1/fkx6XZmzoy
         m3p/5NJcHkBqhRlJ0xnguGXfDJt1iSxda4R0v4xox4Ya+HMMBZsqwAHvJPAkOctGu+Nd
         VJGZk91yXQMgdbhFSXxy7xz56LkcG1Vv9GRji99LRm+/QHSfhxzLYXZlGH2oJiraGivA
         es6g==
X-Gm-Message-State: AJIora/FZnJzwk0WT1FUYqcym7tC9TqWaRrzetn45icA308NBYetKY+Q
        r8SbSDJoli1dah4gt0jFhOU9/hOg1xFf9ca8uycIfg==
X-Google-Smtp-Source: AGRyM1tBy3vNIYNmJDDkMSLWlE+3Fm72eRc+KMnPZ5iH4gem2/nPvpXT16zgU1iMz+UNh3yhoni5vMTOEvq027SDV0U=
X-Received: by 2002:a05:651c:1a1e:b0:258:f021:8020 with SMTP id
 by30-20020a05651c1a1e00b00258f0218020mr4735402ljb.273.1655989823094; Thu, 23
 Jun 2022 06:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220621065259.4079817-1-windhl@126.com>
In-Reply-To: <20220621065259.4079817-1-windhl@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 15:09:46 +0200
Message-ID: <CAPDyKFp8Ys1b5kdfWeN8EWnPY9EMzeJgrjaO9Ma_EfKMvwacoQ@mail.gmail.com>
Subject: Re: [PATCH] mmc/host/sdhci-of-esdhc: Hold a reference returned by of_find_compatible_node
To:     Liang He <windhl@126.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jun 2022 at 08:53, Liang He <windhl@126.com> wrote:
>
> In sdhci_esdhc_probe(), we should hold the reference returned by
> of_find_compatible_node() which is used to of_node_put() for keep
> refcount balance.
>
> Signed-off-by: Liang He <windhl@126.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d9dc41143bb3..9c8cd8b63578 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1418,7 +1418,7 @@ static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> -       struct device_node *np;
> +       struct device_node *np, *tp;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_esdhc *esdhc;
>         int ret;
> @@ -1463,7 +1463,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>         if (esdhc->vendor_ver > VENDOR_V_22)
>                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
>
> -       if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
> +       tp = of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc");
> +       if (tp) {
> +               of_node_put(tp);
>                 host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>         }
> --
> 2.25.1
>
