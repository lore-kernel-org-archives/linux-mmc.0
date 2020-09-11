Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A8AC433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 03:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274B5221E7
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 03:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="avFPWJr3";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+lLvNsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgIKDx1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:53:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54567 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgIKDx0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 23:53:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 729BC5C00BA;
        Thu, 10 Sep 2020 23:53:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 23:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=27Tdf84G1KGqhUUZOW9nEKHS6aZj81m
        woMOigS8sbT4=; b=avFPWJr3VFTJ+verjATzoQlx3Jf3XukjQhu1345u2edVkJZ
        +T+SJBJnmKuAiN1fBfvSFOTbaoJcoqjP94YGS3TyTgYD5TsLpr2jePhmwAN90DVm
        UrF7BbmxKxNsK8/d3K9zKpqfLWiWEjamxUOTZq/VLp96frXnDtc4wH8oXklk12Js
        1FGQEmvt5Ss0NWMRWwkXCn3yWmuHoyPzpkA2CP0vjqF6AkuplPfIbCyw7D47mlOD
        t8fTUoZY2r2XHcfm1nuuGRfXIXKZWEtm0RJZMyPVwNblo9vJcBMcLMxQoCOJfgNf
        TqVbrZypZJxE7TQb2azMXDAmHybuDPMSSs0OAtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=27Tdf8
        4G1KGqhUUZOW9nEKHS6aZj81mwoMOigS8sbT4=; b=Y+lLvNsdohw37DiOcG6SND
        olYNRMM5F3YTlpV1b8zg3F8tpXN5PqajX+whKagZUCcptd2meEusBe11e0REOacM
        fN1VV2eIEPrYWQOrAtYWq3/pO5jwf6vQF4roLFcf3L682INAvtXRZRLMYeejOkIm
        gdFNZ+LVhNqNUS7UzTJmeZE7gG70b8Ekls/TGirg5dW4J6ujgaWPvvwIWYQ1JOq1
        vq824Di7553GDNsOZ0otyub8nM4TN6LVFEEA4OZyFzGww5f0NoW8gA2KFmZq8+db
        Wve+5H8m9r5UBSRiDsa3E3u5BQwQlpNThUbs/ddeWoXwBkjiACDb0P8KBQBAZEvw
        ==
X-ME-Sender: <xms:svRaX3BRSJLRCJpxvLqgJQk6ZEYxh6sYkFp9tvmsj8ix-h-ufKYYtg>
    <xme:svRaX9hoK70b7NJ_lOEZ2jEHa5GDyG4UrekX8a7T5Kt9L0fQUmgduaoMY72gXApRK
    uMECN8YslHQqW4VWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:svRaXykMLnr4aX0CKAFmrbkRng9q5BMEjPtELyIzCxLvmlJcAd8iJQ>
    <xmx:svRaX5xvN22jUWRCXkumdSXXvggCC4LT_rlP0PSNZNmsMyp51r0WlA>
    <xmx:svRaX8Rx9LarFMuM8kDpz7kmKk0LrVXE09NQxkEuNQ4R5X3uI_mT9w>
    <xmx:s_RaX7HyLEdOE1uB_Z8Xxt7uzn9YcNoGCAVpvSGLPD6K4p1sOpm2KA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 85FBAE00A6; Thu, 10 Sep 2020 23:53:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-259-g88fbbfa-fm-20200903.003-g88fbbfa3
Mime-Version: 1.0
Message-Id: <38661d63-67ca-4dc9-942d-90a3b8cd8351@www.fastmail.com>
In-Reply-To: <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
 <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
 <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
Date:   Fri, 11 Sep 2020 13:23:01 +0930
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



On Fri, 11 Sep 2020, at 13:03, Joel Stanley wrote:
> On Fri, 11 Sep 2020 at 02:49, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> > > On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > Allow sample phase adjustment to deal with layout or tolerance issues.
> > > >
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > ---
> > > >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> > > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > > index 4f008ba3280e..641accbfcde4 100644
> > > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> 
> > > > +static void
> > > > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > > > +                          const struct aspeed_sdhci_phase_desc *phase,
> > > > +                          uint8_t value, bool enable)
> > > > +{
> > > > +       u32 reg;
> > > > +
> > > > +       spin_lock(&sdc->lock);
> > >
> > > What is the lock protecting against?
> > >
> > > We call this in the ->probe, so there should be no concurrent access going on.
> >
> > Because the register is in the "global" part of the SD/MMC controller address
> > space (it's not part of the SDHCI), and there are multiple slots that may have
> > a driver probed concurrently.
> 
> That points to having the property be part of the "global" device tree
> node.

Not really. The settings are slot-specific. The only reason it's in the global
register space is that the settings cannot be part of the SDHCI. That Aspeed
chose to pack them in the same register, and _interleaved_ at that, is
unfortunate.

As the settings are slot-specific they should be associated with each slot's
node. We should concentrate on representing the intent of the controls and
not tie the devicetree representation to the register layout that Aspeed came
up with.

>  This would simplify the code; you wouldn't need the locking
> either.

IMO this is a loss for readability, so I'm not convinced it should be changed.
The outcome is some opaque register value that is shoved in the devicetree,
and given the baffling interleaving and choices of field sizes that's not a place
I want to be.

> 
> >
> > >
> > >
> > > > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > > > +       reg &= ~phase->enable_mask;
> > > > +       if (enable) {
> > > > +               reg &= ~phase->value_mask;
> > > > +               reg |= value << __ffs(phase->value_mask);
> > > > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > > > +       }
> > > > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > > > +       spin_unlock(&sdc->lock);
> > > > +}
> > > > +
> > > >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > > >  {
> > > >         struct sdhci_pltfm_host *pltfm_host;
> > > > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > > >         return (delta / 0x100) - 1;
> > > >  }
> > > >
> > > > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > > > +                                    struct aspeed_sdhci *sdhci)
> > > > +{
> > > > +       u32 iphase, ophase;
> > > > +       struct device_node *np;
> > > > +       struct device *dev;
> > > > +       int ret;
> > > > +
> > > > +       if (!sdhci->phase)
> > > > +               return 0;
> > > > +
> > > > +       dev = &pdev->dev;
> > > > +       np = dev->of_node;
> > > > +
> > > > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > > > +       if (ret < 0) {
> > > > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > > > +                                          false);
> > >
> > > Will this clear any value that eg. u-boot writes?
> >
> > No, see the 'enable' test in aspeed_sdc_configure_phase()
> 
> OK, so this branch will never cause any change in the register? Best
> to drop it then.

So there are two parts to the phase configuration, the phase adjustment
value, and a switch to turn phase adjustment on or off. Both fields exist
for both in and out phase adjustments for both slots.

So this branch will cause the phase control to be disabled, but it won't
change the phase value that was originally programmed. If we maintain
the original semantics it shouldn't be dropped.

However, below you suggest we maintain the configuration (both
enable and value state) in the absence of the property, so the code
needs to be reworked to uphold suggestion.

> 
> >
> > >
> > > The register should be left alone if the kernel doesn't have a
> > > configuration of it's own, otherwise we may end up breaking an
> > > otherwise working system.
> >
> > Right, I can rework that.
>
