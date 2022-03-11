Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4172CC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349404AbiCKPrI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348744AbiCKPrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 10:47:03 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2161B1C6668
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:46:00 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so12544389ljb.6
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10XF3Sb+t0GCaPOcQ9XoyXqUIC9CjyYdWscRYcObAxw=;
        b=MqSyuOe34h+f5EWwR/oM3slrJ38qINF04yiqUGK9i44Eg7rBVyesJHW1EnFC5kq8Fz
         lk+2YfR6+b43HpQckMotOid77fcXOQCYnCzxj1VBwif0v7RCPtuA/XLZTOUL3TGLQ5aP
         rQQEfHcA3U6Ckvf/b/iG+3oXnpYqaTOumz8wAkXkJ28WbzSqpcBZIFq8ncUer5twWgks
         FOJuSVG0lF2of7EiLc6kYvyyb0pg3ayR7my6BVOGNSBBms3Z+ikWZdLDJdqgvWdJqhJe
         L4QlwgEkOq4Qz46/Q/RRjPefsiQTSwFPLy5q6vZRgKOnqEz3+Npwf2GWlZojgDZgRcgm
         baow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10XF3Sb+t0GCaPOcQ9XoyXqUIC9CjyYdWscRYcObAxw=;
        b=WpkCRmgPPkSXqfFZSWOA/P1+g2hkp2ldDxOhfIWcNvIm+jeJU6y0UHYIKXQ3dDBmxg
         jNQOvC9/fUXePALN2yeY5WYV6r0Lf1xF1B9Rs68c49h/tuLZ33WkIBTmZBYr0a1K+m4F
         BByNaxFtWM6786bEmkoRP2cUohjHNVGUasBGvVUwn+sWnqR61JXIuZGk0gV9xHAKf/0P
         5G9Ve7e6HuLwTiVyaqVdSIkMVtRkBSSXOTgP/FVMIBKrC+OO6XjwY/Pnbx7NlYM1JL46
         PeQa5t7bS1s7U2d1UVX9xpx04XT9RQx8+6WSsWUSfKnaUh2mJTI5KlqPjFikiOGemA9t
         LtdA==
X-Gm-Message-State: AOAM532KLT7o72a6dVwSgZ45ti4mfpsLHp45ImgsY6Zj4P9tfTdoXq+i
        C1jux69V8mzdJraA1bFYBNvgR3a02BUxmtk+hIZgVA==
X-Google-Smtp-Source: ABdhPJyKLXL/cjixS70H+wB5WRjtfcEBo2CKEa89VicVYZWBqrQ7uCDzqe5Ilvrer3zvBAGc4wkBHELro4zTjGulY/w=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr6543962lji.367.1647013557376; Fri, 11
 Mar 2022 07:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CAPDyKFq_TsBLjW2WxC-Fvu6qDs9MJ1=QPo9gOLRykJ5p2pJbGw@mail.gmail.com>
 <b465353f-9291-f159-ba0b-4cd9577fc676@foss.st.com>
In-Reply-To: <b465353f-9291-f159-ba0b-4cd9577fc676@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Mar 2022 16:45:21 +0100
Message-ID: <CAPDyKFqu_Y2ixbw380t5qA_rXTPLMWasqpBmaMqP0nHUOqzQhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Thu, 10 Mar 2022 at 17:00, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/8/22 11:57, Ulf Hansson wrote:
> > Hi Yann,
> >
> > On Fri, 4 Mar 2022 at 14:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> >> starting from revision v2 of the peripheral. But it has limitations,
> >> as all the buffers should be aligned on block size (except the last one).
> >> But this cannot be guaranteed with SDIO. We should then have a property
> >> to disable the support of LLI.
> >
> > Indeed, the buffer handling with SDIO is somewhat special, which also
> > has been discussed several times on LKML before. In principle, we need
> > the SDIO func drivers to respect buffer limitations that should be
> > specified by the mmc host drivers. Quite similar to what we already
> > have for block devices, like ->max_seg_size, ->max_seg, etc, that is
> > set per mmc host.
> >
> > I realize that implementing something like the above requires bigger
> > changes, which is why mmc host drivers instead validates the sglists
> > and the elements. In some cases that means returning an error code and
> > in others it could mean falling back to a non-DMA based I/O mode.
> >
> > For the stm32_sdmmc variant, it looks like the sglist validation is
> > being managed in sdmmc_idma_validate_data() already. Can it be
> > extended to cover this case too, rather than using a DT property?
> >
> > Kind regards
> > Uffe
>
> Hi Ulf,
>
> OK, I'll check what can be done for this. Patches 1 and 2 can be
> dropped, they will be reworked.

Okay.

> But patch 3 of this series could be taken, as not linked to LLI
> management. Should I push it again alone, or could you review it directly?

I have some comments/questions on it, but perhaps it makes it easier
for people to follow the discussion if it is done separately. So
please push it alone, then I will review it.

[...]

Kind regards
Uffe
