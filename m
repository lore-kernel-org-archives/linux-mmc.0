Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987AAC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhLUNDa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbhLUND3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:29 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA10C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:29 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 207so21263157ljf.10
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3G/BObKbKRIOe1mMzk7sCK8sxyQHVHo40L2JB+EWsAY=;
        b=czHS4kyyDyP20l0ewMvyj7YQnV76B0bch+ifwRYOwFFH+D9RrbHcJRnYeyfJ1JK/1q
         1kvZUABK7/gF69M1nreEGgeibF4k/xOCrhFJBNZQyIjPoZc025SQ3N3q3keu2QodgjTJ
         9/c5iQaxtt9wL2Y0ettvMx8epmUbtlcxKIqbWiY14LcHsba1/kvooGmrRqkBTia7ktTu
         TLujjCn4fW+eIX1LVNCiS3zIhXhQfuOIMg+F481Wt+BkT3G1Aw8RU8jyXn+pXFEARea5
         Nj223ib9MDvjpoHq/y7l327QVGlNPvNZuo5xQArtarsdv2iYgIBXJw2QQOZTN+tgLjQU
         sLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3G/BObKbKRIOe1mMzk7sCK8sxyQHVHo40L2JB+EWsAY=;
        b=eulxMmUCPy5JdbuObBvQVOIABzTBxNh6U3E3IXnfOvYEMO35TfyBhHVU8G6zGkzBmq
         hYT4VGGk+aiJvR1846PKSNfxfB0OMNKdLgEM/5En5rTg6pJZCCd0DlWWspTXOJPobY2p
         0Lh4Le92/G41uxdO1RUbqdQ8SNfYrwbRG+1S7wqPUr8egp8WXmHLjQ+idwDDzfDn07/Y
         tn89g40NSetG462JMn53akKMKoLWlVPdcTve3q4stm550ZNx7J6NuA9CSB3TUwPAK6LU
         K7o0v9sQkU6rw6rjY6Bg6lEbgaLuNnqJkdfEk0VP9D2/IsMoDOuNrJIQQZoV7Qt0s2nd
         PhlA==
X-Gm-Message-State: AOAM533V9k8o1hVaVVJX5hQJATKPf085jQSx8XZCPpG2eoHIIwjONBwY
        Bps/61+bUzWvQ5LTkBhmunhBH+ouiKjG4T1S9WhQHsRtBRM=
X-Google-Smtp-Source: ABdhPJwvQP9tqrxLGsc3TuojfLjegR0SCKRBNpS9rqz0smQOxq9ihVHc7XNdA3hS4OBlM91URcuqQ2eoH27g9wEdTeQ=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr2648216ljf.300.1640091807738;
 Tue, 21 Dec 2021 05:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
 <20211215141727.4901-4-yann.gautier@foss.st.com> <05ab7b52-190e-048f-3803-7bed51e2b09c@denx.de>
 <67c6d0be-078b-0726-698d-096c5e77b4ab@foss.st.com>
In-Reply-To: <67c6d0be-078b-0726-698d-096c5e77b4ab@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:51 +0100
Message-ID: <CAPDyKFpGoa1QbGgjjaH_pDpqSLky+urE76AuA+vhGnmrb9pggQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmc: mmci: stm32: clear DLYB_CR after sending tuning command
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Dec 2021 at 10:49, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 12/16/21 10:13 AM, Marek Vasut wrote:
> > On 12/15/21 15:17, Yann Gautier wrote:
> >> During test campaign, and especially after several unbind/bind sequences,
> >> it has been seen that the SD-card on SDMMC1 thread could freeze.
> >> The freeze always appear on a CMD23 following a CMD19.
> >> Checking SDMMC internal registers shows that the tuning command (CMD19)
> >> has failed.
> >> The freeze is then due to the delay block involved in the tuning
> >> sequence.
> >> To correct this, clear the delay block register DLYB_CR register after
> >> the tuning commands.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >> ---
> >>   drivers/mmc/host/mmci_stm32_sdmmc.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> index fdaa11f92fe6..a75d3dd34d18 100644
> >> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> >> @@ -441,6 +441,8 @@ static int sdmmc_dlyb_phase_tuning(struct
> >> mmci_host *host, u32 opcode)
> >>           return -EINVAL;
> >>       }
> >> +    writel_relaxed(0, dlyb->base + DLYB_CR);
> >> +
> >>       phase = end_of_len - max_len / 2;
> >>       sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);
> >
> > Shouldn't this have a Fixes: tag and be CC stable ?
> > This seems like a bugfix, no ?
>
> Hi Marek,
>
> You're right, I should have added:
> Fixes: 1103f807a3b9 ("mmc: mmci_sdmmc: Add execute tuning with delay block")
>
> Ulf, could you manage that, or should I push a new version?

Patch applied for fixes and by adding a stable tag too, thanks!

Kind regards
Uffe
