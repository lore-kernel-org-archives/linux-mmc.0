Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C565C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Mar 2022 20:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiCYUN6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiCYUN4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2022 16:13:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE546641
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2022 13:12:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d07ae0b1c4so93961587b3.11
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2022 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YT2o1xxdFf9OVHBJJGoL9aS2UVDgV96wgaPQnf59u3A=;
        b=iUDT/G3LEcGf/5tagjP8eFjsGsyOBph1oCwiAU9SRpn47LJA8MWoC2ZnwxrjbSPjMm
         NMgbwZLb++g0JJFq9rSNRDfuiuAAY8Rb8mEl15bFUi/1axDz0mqVDBjWIOF7rWkJktPB
         GVLthy7ZRekp5ux4Y2DFI5hfRTVn6an7IoJvpEJSJ/9e6g+VV6/TIh6v+e0YKsPg/ANl
         u9+Q/qattDvEkHp5i6SesaOU1SOYG0BE3BKYCSAklaOO+5ljSccec5A3gP/LLOHHRLHW
         2IrIx4x8ygD2EPSpIa9BNu8dVIUcFM2jbwLpeByGektKecBFHNoOwvOwoDpGWDgslNFr
         atGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YT2o1xxdFf9OVHBJJGoL9aS2UVDgV96wgaPQnf59u3A=;
        b=h5EeKTDGyXjL7ZwJkR3OCxg9M3CqdQmeFyCxod3DYrfvWn06S1rYxJZwTVCxNNTWWw
         IcTzyhbF3Ef7qHvw7SpZeQrHvjGDP4tl4niZAzKIJfhZiIVKWP19sARJrr7nfh8+cdVq
         upFiNod7hP/ZlMb4cZ8R9Xzurf0h94X4ey1GU2wH9EXfFqxNHSr7Qx6Y8WI7gh8mZJ6V
         /o9cVH0wY/QajYjSQDzbyGlAWdKPEBfc51M0cjJ1l39rYnOSO2T9s+9595zb0uYOm981
         wXNehDfq0bqaVAKz24dkApZUT0pFZk8qDzILGPOwap5v4myhElkAap+FoOvq/PZL+2yF
         ol0w==
X-Gm-Message-State: AOAM530tFhoKqcKbfsWKDu0c0GOIRwa/GOLY1nRw3/MEsZKYhVRm2iad
        IyNwrQdPo8033WWtfuE5benMTMzh7Ur0HyPOBPdPrQ==
X-Google-Smtp-Source: ABdhPJxUBffdaPMdxHWCaYq0Qr6rteF2S4TUamYdP1nuniOmrgv1lq5txO6UeJxGVYZr0OiLkvNRfbesOoqWq1bIo24=
X-Received: by 2002:a81:164a:0:b0:2e6:8e4b:7487 with SMTP id
 71-20020a81164a000000b002e68e4b7487mr12654258yww.437.1648239140546; Fri, 25
 Mar 2022 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com> <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
In-Reply-To: <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Mar 2022 21:12:09 +0100
Message-ID: <CACRpkdYMWXEX6dpT0aUrCrFd-8-U35OG9Zmpkfty=zMH=mQqbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
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

On Tue, Mar 15, 2022 at 9:26 AM Yann Gautier <yann.gautier@foss.st.com> wrote:

> The STM32 variant uses an internal DMA, and the DMA functions are in its
> dedicated file. So I was planning to do the same as what is done in
> meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
> constraints are not fulfilled. Not sure it can help for Ux500.
>
> Ulf, before I send my new series (although it is not ready yet), would
> you be OK with the bounce buffer idea?

Would it not be better if the bounce buffer is something available
for all MMCI variants and not restricted to the STM32 DMA add-on?

What I'm thinking is that this is a problem with the MMCI hardware
rather than with the DMA hardware, so the problem kind of gets
fixed in the wrong place if the bounce buffer is in the DMA add-on
code.

Maybe this is how you fixed it in later patches, I'll take a look.

Yours,
Linus Walleij
