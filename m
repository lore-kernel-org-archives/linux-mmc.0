Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BBC63705
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLGNiz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGNiy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 08:38:54 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BA29CB0
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 05:38:53 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id n184so22479246yba.6
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GXkP58FsgYtEtV2kltJdQIO7NbuSAa5+nIq85bqPZc=;
        b=VV1HQQXIg4IQoL/RTe8WTrB4W1JmiXDCo19eUo8d4rajcTHkrDsI5eLFjOY8ySkRmq
         5+y5sDmoGbPTBHNlac4cxxD5rVcpmGaO6FeJ1wNsxxaIMo6tLWEFhrU9KSUCSPWmaHvS
         ODgFs2lGeFgYlPY+wWNt45cF2srmGSOZ+OhJjsE0Gug/Pi8fW3FdTgY7lMz9CWq++YXV
         LenGjA8X+TV8+k3iI0BQR6Alz3VY3ItruQgLyBfTuubLtf6/tyvDW9w4pQZuPB32Dqzc
         PbCcYG6C20dUXqknwfagM9fckxA4vUqZ/ZYVEkl6lmDQWfw8U/Hjszgi/6azC7UL0ZLS
         LATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GXkP58FsgYtEtV2kltJdQIO7NbuSAa5+nIq85bqPZc=;
        b=yD0DaA1iHlAfdvLMEod1vALSq+o880rKzWGGQZpLZtJ0Fjog27fze5t/hhoPJgVokP
         FP3PtBf4NgFRYM91u6zVxY4tzeWmcLUJzqXgeZjwoUnyjhFaXA7D1lgBYmSLo/krwFn3
         AMAypnlQ3sNPM68i+0pWI/C6AKv47sOKjZZ+ipYEFhJlbcIqlGbE8YvAxF+AzZqguFyU
         IFMXxNr95Kei9kozV2JmAEWanZd88ApvkjdoBW8M6I8TiFrl+TVCOutQeNQb8d1rQeFl
         YUY6BDl2AR76So6AIbV7v1d0JebJukwpemxtywWBEJuFmzC3HhnGfn6dyPCwqO/IYwjw
         fzyQ==
X-Gm-Message-State: ANoB5pkZV7ql3CLCilfymi3cLKuPm3uAS5Sppx5E4ZZYwcOZLua0wATn
        tcvxKWl8jFRRf3qbKN7LQa1suJlUh2v7nI7fJ9B6YQ==
X-Google-Smtp-Source: AA0mqf4I6ian1m6Wk2VTDE1G5nDA4SclhjAbtbpN52dNRHMyOMowzcjMfWb+j7vOLzrlsDSmYyH8p0ZYy9K2Uidtt/g=
X-Received: by 2002:a25:1843:0:b0:6dc:b9ec:7c87 with SMTP id
 64-20020a251843000000b006dcb9ec7c87mr70316385yby.322.1670420333032; Wed, 07
 Dec 2022 05:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20221205105931.410686-1-vadym.kochan@plvision.eu> <20221205105931.410686-4-vadym.kochan@plvision.eu>
In-Reply-To: <20221205105931.410686-4-vadym.kochan@plvision.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Dec 2022 14:40:09 +0100
Message-ID: <CACRpkdaXQqrCEqu9HTMZMMWbnkQxXEmoJNtiH-HENZWeDqjqTw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 5, 2022 at 12:00 PM Vadym Kochan <vadym.kochan@plvision.eu> wrote:

> There is a limitation on AC5 SoC that mmc controller
> can't have DMA access over 2G memory,

That sounds like a pretty common problem when someone
uses a 32bit address register in their DMA controller, or
the integration engineer not connecting all address lines... :/

>  so use SDMA with a bounce buffer. Swiotlb can't help because
> on arm64 arch it reserves memblock's at the end of the memory.

OK

This:

> Additionally set mask to 34 bit since on AC5 SoC RAM starts
> at 0x2_00000000.
(...)
> +static int xenon_set_dma_mask(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_host *mmc = host->mmc;
> +       struct device *dev = mmc_dev(mmc);
> +
> +       if (priv->hw_version == XENON_AC5) {
> +               host->flags &= ~SDHCI_USE_64_BIT_DMA;
> +
> +               return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> +       }
> +
> +       return sdhci_set_dma_mask(host);
> +}
(...)
> +       .set_dma_mask           = xenon_set_dma_mask,

I don't know if is so good to assume the size and location of the
SoC RAM like you do, that looks really fragile.

Can't you check what physical RAM Linux actually think
it has and where? You partly check it with meminfo below.

> +static int xenon_ac5_probe(struct sdhci_host *host)
> +{
> +       struct sysinfo si;
> +
> +       si_meminfo(&si);
> +
> +       if ((si.totalram * si.mem_unit) > SZ_2G)

This looks like a bug since you mention that the RAM does
not start at 0x00000000 this means if the memory is
2G it will partly be at physical addresses above 2G....

> +               host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +       return 0;
> +}

Here you check how big the RAM is using meminfo (if the
bug is fixed).

But is this really a good solution? ADMA still works on the lower
2GB does it not?

What you want is a new quirk that bounces only when you
go above SZ_4G.

There *is* SDHCI_QUIRK_32BIT_DMA_ADDR have you
tried this? A 32bit DMA address is literally 4GB.
I think all you need to do is set this flag for xenon.

Yours,
Linus Walleij
