Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C2C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 17:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiC2RfT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiC2RfS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 13:35:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374855B4;
        Tue, 29 Mar 2022 10:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CF31B81813;
        Tue, 29 Mar 2022 17:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C62C2BBE4;
        Tue, 29 Mar 2022 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648575212;
        bh=ImLZ7XYxLjoICwbUH/PGLevWhdjBi7z3FcW2zXFX7As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1V62gRYOch4F0yLlbgyUFLr6jdpkJPQwAr/s77QZ97iUxIMZ6l6lsIUwSOCItZ7X
         bHkE+vGYsAHLEgGQ653AwiJTIvABNWRGTy0xuUbNqTrdmju6ZxlItK3W3HNsnk+hpu
         nF9BoeMtE1PSIW/pdF04mpPDxrhT1hAm+FEazkyjUwjMGnqOLoOM/DaSTQBfrAPK0T
         zQ66Xfq8SujJVGdsaw5BDW3Eji87gcOodHF80jAhDs+XwLsi1DBztMVjyFGA+VB3Dg
         B0dLhBS9r+uv1DYIS0GeMxGYrwy5DBeDM2cOgPk0rtS0poi/z46W/I48qOxH2FqoKf
         QZ+RfzzJ4BSBA==
Date:   Tue, 29 Mar 2022 23:03:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yann Gautier <yann.gautier@foss.st.com>, ulf.hansson@linaro.org
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
        Grzegorz Szymaszek <gszymaszek@short.pl>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable
 DMA LLI
Message-ID: <20220329173322.GC58120@thinkpad>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
 <20220329153114.GA58120@thinkpad>
 <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 29, 2022 at 06:00:26PM +0200, Yann Gautier wrote:
> On 3/29/22 17:31, Manivannan Sadhasivam wrote:
> > On Tue, Mar 15, 2022 at 09:26:01AM +0100, Yann Gautier wrote:
> > > On 3/14/22 23:43, Linus Walleij wrote:
> > > > "On Fri, Mar 4, 2022 at 2:52 PM Yann Gautier <yann.gautier@foss.st.com> wrote:
> > > > 
> > > > > On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
> > > > > starting from revision v2 of the peripheral. But it has limitations,
> > > > > as all the buffers should be aligned on block size (except the last one).
> > > > > But this cannot be guaranteed with SDIO. We should then have a property
> > > > > to disable the support of LLI.
> > > > > 
> > > > > Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> > > > 
> > > > Actually I think this is present also on the ux500 variants. See:
> > > > commit 2253ed4b36dc876d1598c4dab5587e537ec68c34
> > > > "mmc: mmci: Support any block sizes for ux500v2 and qcom variant"
> > > > 
> > > > Spot the variant data "dma_power_of_2".
> > > > 
> > > > So whatever property you add
> > > > to the variant data (not in the device tree please) should
> > > > be added to the ux500 variants as well, it will *VERY* likely
> > > > have a problem with LLI elements not being a power of 2
> > > > as it is the ancestor of later STMicro variants.
> > > > 
> > > > It might actually be the reason for some annoying WiFi error
> > > > messages I have seen :/
> > > > 
> > > > Yours,
> > > > Linus Walleij
> > > 
> > > Hi Linus,
> > > 
> > > The STM32 variant uses an internal DMA, and the DMA functions are in its
> > > dedicated file. So I was planning to do the same as what is done in
> > > meson-gx-mmc.c: using a bounce buffer to copy from/to in case DMA
> > > constraints are not fulfilled. Not sure it can help for Ux500.
> > > 
> 
> Hi Mani,
> 
> > 
> > Irrelevant to this patch: May I know why the internal DMA cannot be represented
> > as a dmaengine driver? We started seeing these internal DMA implementations in
> > the other subsystems as well with pointers towards MMC core [1].
> 
> As for Prabhakar's answer, the IDMA here is inside our IP, and not used in
> any other IP. So I'm not sure it is really relevant to move that to another
> dmaengine driver.
> 

Okay, I think this justification makes sense. I was worried of DMA IPs that get
sandwiched into many peripherals like the one on Renesas platforms. It turned
out that each subsystem has to add internal DMA support for it :/

Ulf, your thoughts?

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> 
> Best regards,
> Yann
> 
> > 
> > [1] https://lore.kernel.org/all/CA+V-a8tfUgvzPyMe_FHuz=8mmC6dPHP7E=e+nCzOey04vCcAkg@mail.gmail.com/
> > 
> > > Ulf, before I send my new series (although it is not ready yet), would you
> > > be OK with the bounce buffer idea?
> > > 
> > > 
> > > Best regards,
> > > Yann
> 
