Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B0C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 21:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiC2VSt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiC2VSs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 17:18:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428721D4C03
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2022 14:17:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e203so24911577ybc.12
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2022 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NmdHbhnl/vRItSEWqZfS578eYz0Ln76M7w3+17SBng=;
        b=nnNp2K9C0PhtBCZ9DlF+5HkNtJtSFxGCTe+rj/yzMLI7t8hiUYwTIqIX7DjUb2Ej+l
         YZJn4iEApNAcehGis3mzjUOYIlnzVRouSbGMm6iXFNxUZ+KoTMHAVElD+A4wwZmCd/B0
         eEEbLLsLZFZEcsXXT0Lo5ktPGfgsMiW2ylL9g+GOabkqDWyMZ1h1SM1Pf4lmXgs/D+7I
         gXS3N7nI5IDy0LRBZ4AehTCJ1hAF298ax1wzj0Ii9zBxM8U3GjQ0lFRhOsj8guh34ZnJ
         wCCDM9vUrfgM5TSoshOYj3qBD4m2Ny8MZNGXo+h+RQmlgcxRSkD4XP6KR3exbwSYnVXH
         m04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NmdHbhnl/vRItSEWqZfS578eYz0Ln76M7w3+17SBng=;
        b=mqIVla2g6pfx55Nz9zAmVY9XZoMo4yiKJfC1ir25YE/Uz/Fthylbc5hORr/Jc2KEGl
         n5tZOFymdPfWxDbukqJBh3jhg27w4rbJHoZNpW2oRVhxJyttqjs0SOzKybrBTwlAlVtd
         r7AuuGJGf8wtK+BszIiWrlOAAxcO8V1Bofh7gV+psCvRMZnPvFcpg1ahNvMhxJ3tFEJw
         ehBvy+fwmaX09Jm4lRIHeFLF9p6PXy2KBbgmNxNDeoUyrhTwaWvTZ3tgG53VsI/PI4oN
         cK213uJ9yfoqTzLd6VOorH5PsnAzLLyqr+2zhqE3s3jL681fzfcJkn1rCdSWim3awVY6
         ntJw==
X-Gm-Message-State: AOAM531X4QmDlDOPVW94zs1ItqUzX8TbgXP0INAhQN5G0BQkutG1C4en
        Jr+U2RtXLeIBc0Vd/WypZ84sH+SBbnHoTe5ObPXodQ==
X-Google-Smtp-Source: ABdhPJykJ5Ut7PIceBwZraoLzJOYrOlgWf2VUP56VuJtpRcHz881r39za7FgGIqkZzFEF9YvREaj+sXPJsynCiusvbw=
X-Received: by 2002:a25:2497:0:b0:633:c1d0:e7bb with SMTP id
 k145-20020a252497000000b00633c1d0e7bbmr30780376ybk.291.1648588623439; Tue, 29
 Mar 2022 14:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com> <20220329153114.GA58120@thinkpad>
 <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com> <20220329173322.GC58120@thinkpad>
In-Reply-To: <20220329173322.GC58120@thinkpad>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 23:16:51 +0200
Message-ID: <CACRpkdaiOhMGzuWPwoRLZ05HyM8BO_-cZt4TiAqAYQvDaJA-mA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>, ulf.hansson@linaro.org,
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
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 29, 2022 at 7:33 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> [Yann]
> > As for Prabhakar's answer, the IDMA here is inside our IP, and not used in
> > any other IP. So I'm not sure it is really relevant to move that to another
> > dmaengine driver.
>
> Okay, I think this justification makes sense. I was worried of DMA IPs that get
> sandwiched into many peripherals like the one on Renesas platforms. It turned
> out that each subsystem has to add internal DMA support for it :/

That is a justified worry.

Qualcomm has "BAM DMA" (I think it is called?) which is added to each IP
that needs DMA. drivers/mmc/host/mmci_qcom_dml.c
It's for older Qualcomm platforms but I *think* it is actually not just used
for the MMCI, just noone ever got around to adding it to any other
peripheral? Srini do you know?

Yours,
Linus Walleij
