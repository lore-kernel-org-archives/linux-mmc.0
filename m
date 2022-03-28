Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DAC433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Mar 2022 14:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiC1OHL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiC1OHK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2022 10:07:10 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0B1B7BD
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e64a6b20eeso149956417b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8CZApPDPuUnS9l1TU1XjaohxmYpHjLbbVg8Sjb9/IU=;
        b=hEnL8NnTd1X3kQVRaVF2r1Gs4O1JWM+UyhPZKFirD+nwh88IvMtueVuTNU0QbfG6gZ
         0wIXKD82+RchPkepMeaXVlPoMdtNhYBcXGyY7TRZdq9HAz3J5DPYvC1KxFPFN7Ahyc7u
         LpF1j31cRAtpS91wYjry39PdUYf/ulRs4+gsBvgaHW91RjCcdZff3zCr66BetH293y4k
         A0AZ3KoCdRPKSjDk/JSf6TN7irFlKHE8b1rv6pqI+mvNRMiUmC5vd4vzUP/BDSlsy1T0
         2OxcKQg/lWD2wGCksK073dkWhYaIQIWKiaLT3w56a6jHm4IhQJq++RozHipIavK68+hk
         uvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8CZApPDPuUnS9l1TU1XjaohxmYpHjLbbVg8Sjb9/IU=;
        b=iw6EA6ORXnv9Q74qwdtei1psH2dmce9atvgdjx66UFjOdfL7LKqrHhF1uDOSHRvpRp
         L3PptNj8H9KpC+yWMlO2Ns4pOMf4W6mapsnOa3xLN9f9UIqQeeyW/oblFDQK5FrmerAa
         LO3LDJlJeJFqhcf0VwJMajKP9MRX/a7csVH/cxRjn4+fSGJKkCiNjATkdUjQL1AbDAEC
         DZuwJLjTDsxtYh6b/sARYnAMIqgCeVQdpipAVMs+WkyJMLY4PIgQRDNsbpK0T9MgWlKo
         NFvbWvFjrDrToIroSRJVdnzEEt9LMhCTtbzGFdRzWFtO4eJ84gHOOUhhFKR9nItuWWEg
         Tjgg==
X-Gm-Message-State: AOAM533+jrjHBcZxdiMTz6FVBrF+v9VtAwu19c7am2CWbxqfifZQRJMQ
        8aVGY6EK/BcLxc6NvTPzWXg7bEigXHKtVOFcdoUM+wQs38U=
X-Google-Smtp-Source: ABdhPJwP1VmXqDvTCTUI3qjDLG6Wty/aA06/s8fpPL2mZpmlqUDdfe5p9HBHNYyTKVOSuFwAsPxr6ozjZ6hwxp1nwlA=
X-Received: by 2002:a0d:df05:0:b0:2e5:d2c2:675c with SMTP id
 i5-20020a0ddf05000000b002e5d2c2675cmr25340860ywe.495.1648476329398; Mon, 28
 Mar 2022 07:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220317111944.116148-1-yann.gautier@foss.st.com> <20220317111944.116148-2-yann.gautier@foss.st.com>
In-Reply-To: <20220317111944.116148-2-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 16:04:52 +0200
Message-ID: <CAPDyKFpHUWodb_j8pF-tGV9JRMBEEAgsS7gouJ0rQLsJuxkTdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: stm32: correctly check all elements of sg list
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Mar 2022 at 12:19, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Use sg and not data->sg when checking sg list elements. Else only the
> first element alignment is checked.
> The last element should be checked the same way, for_each_sg already set
> sg to sg_next(sg).
>
> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

This one, applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 9c13f2c31365..4566d7fc9055 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -62,8 +62,8 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>          * excepted the last element which has no constraint on idmasize
>          */
>         for_each_sg(data->sg, sg, data->sg_len - 1, i) {
> -               if (!IS_ALIGNED(data->sg->offset, sizeof(u32)) ||
> -                   !IS_ALIGNED(data->sg->length, SDMMC_IDMA_BURST)) {
> +               if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
> +                   !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
>                         dev_err(mmc_dev(host->mmc),
>                                 "unaligned scatterlist: ofst:%x length:%d\n",
>                                 data->sg->offset, data->sg->length);
> @@ -71,7 +71,7 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
>                 }
>         }
>
> -       if (!IS_ALIGNED(data->sg->offset, sizeof(u32))) {
> +       if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
>                 dev_err(mmc_dev(host->mmc),
>                         "unaligned last scatterlist: ofst:%x length:%d\n",
>                         data->sg->offset, data->sg->length);
> --
> 2.25.1
>
