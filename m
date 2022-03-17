Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FBC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 10:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiCQKCG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiCQKCF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 06:02:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FCFD6C8
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:00:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h11so6538006ljb.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QhShUoe84DPn/qSDuJss4yxswaSum21NgfxRVJizeNM=;
        b=JaGzOhhUBuH/BXOUzMz78R/tXpFW9PtxKjjthc7yAtoRV6cTPvWodM23mwl4m2cLfp
         H1RGlDUWy2wa6JsIy60+qH5vCdemKBd2v0gUqAOPGoUbBDFr2pSFr3wgSR0o6N7mRYzO
         wqRnXRK0iyG7WAANNYpOotSjtLLrnpazC+7XUP4/c+n+VArSv8HHCpDqk/CdTCIdtvlc
         Whhnb9w3pm0GpqFL4VQLkt++CeRY50VzPSRwyn6+NfTW5Q3/YwGhr2VhWXGPecyL+sAY
         hQ3BkMs88cXhYCv3eLILGmoc5xS9UP96DNEiRvnSgeBYP3ot7ItwtkAcBoYP5gTjlXVE
         csCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhShUoe84DPn/qSDuJss4yxswaSum21NgfxRVJizeNM=;
        b=5DBof+GNnf8wAZKjpucslqNm+HagjcYxK3iYAk3TJZVcx28tkP8h2LbB33ZHQrJRjh
         TIDJS1cUT8Tqz1ZHj/yAT5/rE1EnsmV+pUevi8ExJPUA/bTCpCsczaG2+iLijurE9trm
         YOOW7OQNd50fwp+8pMzY/aVc5Rk5xtM/2yb5VM8NJh2A+w4GynokcOdKDP6aV2tKBoWf
         ++eq/p73kFmM6qRlnXBu8f3PPkKvnBmnOYR+FznnfaOdCfdNar4IosG+TQjojx3KGtJF
         w5+WlRlOdtpXC8Ai8uQpi5dfsWEElWNvPL2gJ1Pwg5wnOk+qyxdB1h16X4jEG+a2Osiq
         S7xw==
X-Gm-Message-State: AOAM532KQxHYHYM8FewdYRptZBe3poLU7oNgA5dpujRo8Cj8v5F5LeDV
        O9JUMLOU+rgcluqguqSRQT8Cfl/HCXfs78hbib6Jqg==
X-Google-Smtp-Source: ABdhPJzGP/6VJ+sfVftD7foeJ61GzofJGTWadnmk9/XhbBJ6gkiCtzjkDLFBkPAu3NbN9QU6HJH517gTjYEZt7di0FI=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id
 e9-20020a2e5009000000b00247d7383e90mr2393121ljb.229.1647511247546; Thu, 17
 Mar 2022 03:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
In-Reply-To: <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 11:00:10 +0100
Message-ID: <CAPDyKFqgQZFH3LT1Z+G9N0MVfhFwoiUr9N2sKFaejTWcH+dNXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Mar 2022 at 09:26, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/14/22 23:43, Linus Walleij wrote:
> > "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> >
> >> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> >> starting from revision v2 of the peripheral. But it has limitations,
> >> as all the buffers should be aligned on block size (except the last one).
> >> But this cannot be guaranteed with SDIO. We should then have a property
> >> to disable the support of LLI.
> >>
> >> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >
> > Actually I think this is present also on the ux500 variants. See:
> > commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
> > "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
> >
> > Spot the variant data "dma_power_of_2".
> >
> > So whatever property you add
> > to the variant data (not in the device tree please) should
> > be added to the ux500 variants as well, it will *VERY* likely
> > have a problem with LLI elements not being a power of 2
> > as it is the ancestor of later STMicro variants.
> >
> > It might actually be the reason for some annoying WiFi error
> > messages I have seen :/
> >
> > Yours,
> > Linus Walleij
>
> Hi Linus,
>
> The STM32 variant uses an internal DMA, and the DMA functions are in its
> dedicated file. So I was planning to do the same as what is done in
> meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
> constraints are not fulfilled. Not sure it can help for Ux500.

We already have a bounce buffer in mmci_pio_read(), but we need one in
mmc_pio_write() too, which hasn't been implemented yet.

>
> Ulf, before I send my new series (although it is not ready yet), would
> you be OK with the bounce buffer idea?

Yes, that works for me.

On the other hand, it would be even better if we could specify the
buffer limitations per mmc host instance, so upper layers (SDIO func
drivers) could conform to these - and use better buffers, to achieve a
better performance.

>
>
> Best regards,
> Yann

Kind regards
Uffe
