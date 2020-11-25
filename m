Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B6C56201
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCFA20872
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 22:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Cwi0ax+g";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LH4ic9yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgKYWxW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:53:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40109 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728862AbgKYWxV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 17:53:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B88F5C00BD;
        Wed, 25 Nov 2020 17:53:20 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 25 Nov 2020 17:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=rDCqF/6BWwTlGiTI6jgr+wyA4epS+Rk
        y7smBnS5oX7k=; b=Cwi0ax+gMfy1aXoVZafGL82507AbgSb3+cxI6jILb9FYs6d
        0LnPlWpQnCbnGIHJUEeNtjipXrvLb4QSjHvTw7iWupsn+eNIO6f6TMdpLsxNi8NV
        VPDo/ZLmkYIwcAEzuwWv4nmbGdG3adIv6McuBQVeCsCmUPB9WcqFwBCHfYvitbD1
        Kjs+lWR+iViXoGvQjJt+oBoa17gllsnqZg4P1xnMIrDWwZqYRAqUgYUHAiOAkFsb
        xBG1YDAvXnqhUNgKiGikHuZg+JJbkFFyOojvSnyu8kKirbZBqgOrSjzr/QKCcvHr
        WpaAX+fLvw6iKGINZW9xU/hGJhAu2V94maTcmbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rDCqF/
        6BWwTlGiTI6jgr+wyA4epS+Rky7smBnS5oX7k=; b=LH4ic9yCPOiT+CLtiR5FGG
        oFBEI7YCcxcdzEZTuuc2g6S9AGv7tPO7ddhjHie7VJb3q+9yMvHJbBVHeeB4aK2g
        MzctSTYlgsGpvvQJGYttfrnIEveZ5jQn/yHhG5OCMfJvuNTDhYj29q4Hy0yy0PEe
        JM52ecBrbeYpYM2UTerf74SklKf6BNYqi97YbbQeBwgo4DKuGFlJJk5rzIKkvgB5
        1CvTmNymmXxW6/n5hYyD8+99yUrHkGXHSIPe0dC/CqvBtVMSfKQeZZXqu0KcuBuf
        SbLgqhl1h3GYmVl7XSYE5ihd0IU+yefVRuhF5w10NWeW+amMBG56R4m0Bqpngdrg
        ==
X-ME-Sender: <xms:X-C-X3dCYLAQkzRklE-5AtPYnWjzxqm8PIlQ34JK56W6scvpqYjfdw>
    <xme:X-C-X9NSXVQ-3PnVzOHmX0dnHE4xcJwHUeRAnBAXevS39g8W0zkMSz2tI1BNj6XIn
    _F6Gtb2RgJ4uaKM-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:X-C-XwguChDjSAPpxwpyAO9qgzWWwlq44qX_tHv9QMiRkQISINzMKQ>
    <xmx:X-C-X4819J0g8oIthXbDMuMponYkU9acyNIhbtBZD2uIWZCfHODAjw>
    <xmx:X-C-XzsMMUeYU816bdmd6MjIfgUl39U9ZPKDY3ledBh2NXgLJxgmJQ>
    <xmx:YOC-X883XcAHt3lJUpzFJwdMuNjbuTUoocr8GOl9dP2YQSK8vrgaPA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 676D1E00B3; Wed, 25 Nov 2020 17:53:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <e3c4f1a8-4fa0-4e2a-be7c-763f733f0cdb@www.fastmail.com>
In-Reply-To: <CAPDyKFrC9vp5gtpFC5L1K17uN059GsJ2zF4f7-_=sFEQ5BBRpw@mail.gmail.com>
References: <20201123063004.337345-1-andrew@aj.id.au>
 <20201123063004.337345-2-andrew@aj.id.au>
 <CAPDyKFrC9vp5gtpFC5L1K17uN059GsJ2zF4f7-_=sFEQ5BBRpw@mail.gmail.com>
Date:   Thu, 26 Nov 2020 09:22:58 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Wed, 25 Nov 2020, at 00:42, Ulf Hansson wrote:
> On Mon, 23 Nov 2020 at 07:30, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The Aspeed SD/eMMC controllers feature up to two SDHCIs alongside a
> > a set of "global" configuration registers. The global configuration
> > registers house controller-specific settings that aren't exposed by the
> > SDHCI, one example being a register for phase tuning.
> >
> > The phase tuning feature is new in the AST2600 design. It's exposed as a
> > single register in the global register set and controls both the input
> > and output phase adjustment for each slot. As the settings are
> > slot-specific, the values to program are extracted from properties in
> > the SDHCI devicetree nodes.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> [...]
> 
> >
> > +static void
> > +aspeed_sdhci_of_parse_phase(struct device_node *np, const char *prop,
> > +                           struct aspeed_sdhci_phase_param *phase)
> > +{
> > +       int degrees[2] = {0};
> > +       int rc;
> > +
> > +       rc = of_property_read_variable_u32_array(np, prop, degrees, 2, 0);
> > +       phase->set = rc == 2;
> > +       if (phase->set) {
> > +               phase->in_deg = degrees[0];
> > +               phase->out_deg = degrees[1];
> > +       }
> > +}
> > +
> > +static int aspeed_sdhci_of_parse(struct platform_device *pdev,
> > +                                struct aspeed_sdhci *sdhci)
> > +{
> > +       struct device_node *np;
> > +       struct device *dev;
> > +
> > +       if (!sdhci->phase_desc)
> > +               return 0;
> > +
> > +       dev = &pdev->dev;
> > +       np = dev->of_node;
> > +
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-legacy",
> > +                                   &sdhci->phase_param[MMC_TIMING_LEGACY]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-sd-hs",
> > +                                   &sdhci->phase_param[MMC_TIMING_SD_HS]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr12",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR12]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr25",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR25]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr50",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR50]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr104",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR104]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-ddr50",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_DDR50]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-ddr52",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_DDR52]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs200",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS200]);
> > +
> > +       return 0;
> > +}
> 
> If it's not too much to ask, would you mind adding a helper function
> to the mmc core, as to let us avoid open coding? Then we should be
> able to move the sdhci-of-arasan driver to use this as well.

Yes, I can look at it and send a v4.

> 
> Perhaps the definition of the helper could look something like this:
> int mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase
> *phases) (or something along those lines)
> 
> I think the struct mmc_clk_phase could be something that is stored in
> the host specific struct, rather than in the common struct mmc_host
> (to avoid sprinkle it with unnecessary data).
> 
> Moreover, we should probably use the device_property_* APIs instead of
> the DT specific of_property_*.

Yep, thanks for the pointers.

Andrew
