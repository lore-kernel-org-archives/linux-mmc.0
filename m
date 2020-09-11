Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F530C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5FF2078B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="i+cYvdGV";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLnperrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKCth (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:49:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50725 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKCtg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 22:49:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 890CD5C00C8;
        Thu, 10 Sep 2020 22:49:34 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 22:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=c6HSkrtTKfINlw/HGLRz2lhc2rwOVfP
        uL1hDI8lDt7U=; b=i+cYvdGVG53shXCRHyD1vQ8u1ujCCPr5eY1kK7EQYToNz+J
        AA9iBTCjQz+NRmJURYnog1U27xaGfY3NyipTOWPe2454RBFuTael3OkUln5t2n9I
        6GSgpEx7J8fOlw0CC6J6PqvoJiJErY6Q8svxxXXDCLvP5cqys5GyzbPBBxcPkb42
        QIhSrKOq5elMO1uVA8Yv/TuSd14KDteBE8gQsdyXb+aRBgO3UVWhQuYu6+BEwe5y
        ISgH6nLndpMJDKMk0GEPF+bwOhBjh4//6K4VOqUrf82+wdF9xyCoxXYR8LmCjTe1
        dNk+6iqUckagvBRY1CF9V3kZCiP2+uQ84TNt0HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=c6HSkr
        tTKfINlw/HGLRz2lhc2rwOVfPuL1hDI8lDt7U=; b=CLnperrNN8K6K/UlWaRxxw
        VyLslnaNvGyFPVwFj9hB5enyU460ugTNHZhsJG5MPFsEu29OcutNFOgYMsKUVRmQ
        1TufmHI6LDHRjLxB+tQpX9YxbmZldRec3SWUI/Jg8H7Bd3NWDFDPoXDVK/GIcB4f
        mIJeTIeZKtzYdhOG+dYPFcsfMMpUhP0Gq5ZVdG2DG4oaAPaUKW1tjvmo7VruzRa8
        e56JJSXrTTZ9HHC+3h1cqXY433GAb2U2chU9uT2Y/fJuvaUEGb0H8a9oCjkm3509
        EMFPM2oHFkdWZqp2nNXE3c7AWW7sxO1cFLqeSQTiFePe9JAcNPfyFLebK7LYWy9Q
        ==
X-ME-Sender: <xms:veVaX9i2zJKbL-rsGu6wDuS392e7ONVJEaK5sVFtYYYdKwcWtdN4JA>
    <xme:veVaXyAGhpTGhQ2LG_SClz1Fy5TnETvSioVKunfDXC7bq8OXVHryBlN9SqgTjYBj1
    JlezshzqbJg9wzTIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:veVaX9GzcQP1jyPm9v2lMWIhHGnJ6RJrPVxgHTBXuoSO7BfzfcX9yQ>
    <xmx:veVaXyTChuYUP85dyIaMFhOkBTkUXsBI1h6k_CGJPVGOfxMCJz-how>
    <xmx:veVaX6zFQKd-fxpsOWmn0iEQIvyywA6N99rnM0vjzMDroCM46OmXxg>
    <xmx:vuVaXxmCtWS5yUGdCGGfZw9qVzjbq3uDcSJ0rSrnzyF0zpIiT-cICQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3088E00A6; Thu, 10 Sep 2020 22:49:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-259-g88fbbfa-fm-20200903.003-g88fbbfa3
Mime-Version: 1.0
Message-Id: <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
In-Reply-To: <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
Date:   Fri, 11 Sep 2020 12:19:12 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_mmc:_sdhci-of-aspeed:_Expose_data_sample_phase?=
 =?UTF-8?Q?_delay_tuning?=
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Allow sample phase adjustment to deal with layout or tolerance issues.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> >  1 file changed, 132 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > index 4f008ba3280e..641accbfcde4 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -16,9 +16,18 @@
> >
> >  #include "sdhci-pltfm.h"
> >
> > -#define ASPEED_SDC_INFO                0x00
> > -#define   ASPEED_SDC_S1MMC8    BIT(25)
> > -#define   ASPEED_SDC_S0MMC8    BIT(24)
> > +#define ASPEED_SDC_INFO                        0x00
> > +#define   ASPEED_SDC_S1_MMC8           BIT(25)
> > +#define   ASPEED_SDC_S0_MMC8           BIT(24)
> > +#define ASPEED_SDC_PHASE               0xf4
> > +#define   ASPEED_SDC_S1_PHASE_IN       GENMASK(25, 21)
> > +#define   ASPEED_SDC_S0_PHASE_IN       GENMASK(20, 16)
> > +#define   ASPEED_SDC_S1_PHASE_OUT      GENMASK(15, 11)
> > +#define   ASPEED_SDC_S1_PHASE_IN_EN    BIT(10)
> > +#define   ASPEED_SDC_S1_PHASE_OUT_EN   GENMASK(9, 8)
> > +#define   ASPEED_SDC_S0_PHASE_OUT      GENMASK(7, 3)
> > +#define   ASPEED_SDC_S0_PHASE_IN_EN    BIT(2)
> > +#define   ASPEED_SDC_S0_PHASE_OUT_EN   GENMASK(1, 0)
> >
> >  struct aspeed_sdc {
> >         struct clk *clk;
> > @@ -28,9 +37,21 @@ struct aspeed_sdc {
> >         void __iomem *regs;
> >  };
> >
> > +struct aspeed_sdhci_phase_desc {
> > +       u32 value_mask;
> > +       u32 enable_mask;
> > +       u8 enable_value;
> > +};
> > +
> > +struct aspeed_sdhci_phase {
> > +       struct aspeed_sdhci_phase_desc in;
> > +       struct aspeed_sdhci_phase_desc out;
> > +};
> > +
> >  struct aspeed_sdhci {
> >         struct aspeed_sdc *parent;
> >         u32 width_mask;
> > +       const struct aspeed_sdhci_phase *phase;
> >  };
> >
> >  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> > @@ -50,6 +71,25 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> >         spin_unlock(&sdc->lock);
> >  }
> >
> > +static void
> > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > +                          const struct aspeed_sdhci_phase_desc *phase,
> > +                          uint8_t value, bool enable)
> > +{
> > +       u32 reg;
> > +
> > +       spin_lock(&sdc->lock);
> 
> What is the lock protecting against?
> 
> We call this in the ->probe, so there should be no concurrent access going on.

Because the register is in the "global" part of the SD/MMC controller address 
space (it's not part of the SDHCI), and there are multiple slots that may have 
a driver probed concurrently.

> 
> 
> > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > +       reg &= ~phase->enable_mask;
> > +       if (enable) {
> > +               reg &= ~phase->value_mask;
> > +               reg |= value << __ffs(phase->value_mask);
> > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > +       }
> > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > +       spin_unlock(&sdc->lock);
> > +}
> > +
> >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >  {
> >         struct sdhci_pltfm_host *pltfm_host;
> > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> >         return (delta / 0x100) - 1;
> >  }
> >
> > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > +                                    struct aspeed_sdhci *sdhci)
> > +{
> > +       u32 iphase, ophase;
> > +       struct device_node *np;
> > +       struct device *dev;
> > +       int ret;
> > +
> > +       if (!sdhci->phase)
> > +               return 0;
> > +
> > +       dev = &pdev->dev;
> > +       np = dev->of_node;
> > +
> > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > +       if (ret < 0) {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > +                                          false);
> 
> Will this clear any value that eg. u-boot writes?

No, see the 'enable' test in aspeed_sdc_configure_phase()

> 
> The register should be left alone if the kernel doesn't have a
> configuration of it's own, otherwise we may end up breaking an
> otherwise working system.

Right, I can rework that.

> 
> > +               dev_dbg(dev, "Input phase configuration disabled");
> > +       } else if (iphase >= (1 << 5)) {
> > +               dev_err(dev,
> > +                       "Input phase value exceeds field range (5 bits): %u",
> > +                       iphase);
> > +               return -ERANGE;
> > +       } else {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in,
> > +                                          iphase, true);
> > +               dev_info(dev, "Input phase relationship: %u", iphase);
> 
> Make theis _dbg, on a normal boot we don't need this chatter in the logs.
> 
> The same comments apply for the output.

Yes, I actually meant to do this before I sent the patches but clearly forgot :)

> 
> > +       }
> > +
> > +       ret = of_property_read_u32(np, "aspeed,output-phase", &ophase);
> > +       if (ret < 0) {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out, 0,
> > +                                          false);
> > +               dev_dbg(dev, "Output phase configuration disabled");
> > +       } else if (ophase >= (1 << 5)) {
> > +               dev_err(dev,
> > +                       "Output phase value exceeds field range (5 bits): %u",
> > +                       iphase);
> > +               return -ERANGE;
> 
> This will cause the driver to fail to probe. I think skipping setting
> of the phase is a better option.

Well, maybe? If the phase is specified but invalid then chances are you'll hit 
system instability by continuing to probe the driver. I think it's better to 
fail in an obvious way, it's not as if it's incidentally incorrect.

> 
> 
> > +       } else {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out,
> > +                                          ophase, true);
> > +               dev_info(dev, "Output phase relationship: %u", ophase);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int aspeed_sdhci_probe(struct platform_device *pdev)
> >  {
> > +       const struct aspeed_sdhci_phase *phase;
> >         struct sdhci_pltfm_host *pltfm_host;
> >         struct aspeed_sdhci *dev;
> >         struct sdhci_host *host;
> > @@ -181,7 +271,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >
> >         dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> > -       dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> > +       dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
> > +       phase = of_device_get_match_data(&pdev->dev);
> > +       if (phase)
> > +               dev->phase = &phase[slot];
> >
> >         sdhci_get_of_property(pdev);
> >
> > @@ -195,6 +288,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >                 goto err_pltfm_free;
> >         }
> >
> > +       ret = aspeed_sdhci_configure_of(pdev, dev);
> > +       if (ret)
> > +               goto err_sdhci_add;
> > +
> >         ret = mmc_of_parse(host->mmc);
> >         if (ret)
> >                 goto err_sdhci_add;
> > @@ -230,10 +327,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct aspeed_sdhci_phase ast2600_sdhci_phase[] = {
> > +       /* SDHCI/Slot 0 */
> > +       [0] = {
> > +               .in = {
> > +                       .value_mask = ASPEED_SDC_S0_PHASE_IN,
> > +                       .enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
> > +                       .enable_value = 1,
> > +               },
> > +               .out = {
> > +                       .value_mask = ASPEED_SDC_S0_PHASE_OUT,
> > +                       .enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
> > +                       .enable_value = 3,
> > +               },
> > +       },
> > +       /* SDHCI/Slot 1 */
> > +       [1] = {
> > +               .in = {
> > +                       .value_mask = ASPEED_SDC_S1_PHASE_IN,
> > +                       .enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
> > +                       .enable_value = 1,
> > +               },
> > +               .out = {
> > +                       .value_mask = ASPEED_SDC_S1_PHASE_OUT,
> > +                       .enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,
> 
> Is there any value in splitting the input and output phase values
> up? (instead of taking the property from the device tree and putting
> it in the hardware).

One register contains both settings for both slots. We can't just blast the 
full register value for one of the slots into it. Further, the fields for the 
slots are interleaved, so it's not like we can just associate the top or bottom 
16 bits with a particular slot.

Cheers,

Andrew
