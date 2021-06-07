Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F286C4743E
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 01:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3886461421
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 01:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFGBBu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:01:50 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43905 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhFGBBu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jun 2021 21:01:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A40458076C;
        Sun,  6 Jun 2021 20:59:59 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Sun, 06 Jun 2021 20:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=T0W141wRe6b71/Xg2Xn4ohInHEOkVFt
        9X3xu0i/suIE=; b=RWt2oykHHeI3if1e49E8EZdj++lPJnMr5wKlaVb+eFGqQ/a
        mBXK2X2O/7BdzaD69+RJ/5ler+UMo1A/KRLtotNJ62wKgv/i2aL+EVYM0M6yMknS
        J+Lo5Zeq09soHYUjf9qD9suI9TR5G2ZwqioLj7LY3c0Q/0ACXfWG/GdKwIQ9NLEv
        8qZZD33W04zzwxp+vPj1l+BRZHGxO6cbzrMzE0f8MC7juDlyftxOLAY8HKodr8ZJ
        dxZ/hKns9JzaFdSdQ25rlj+HgH0Kb1CMx1R2E2JrBw86r0ribe9VVJzk7OfYGt0E
        ks6myNv2BrnIwIgEXhTbqHg0zt/Hk5JSEYKtX1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=T0W141
        wRe6b71/Xg2Xn4ohInHEOkVFt9X3xu0i/suIE=; b=URHRROFeAnIoBkMxIR8RBV
        oL61SDRhqVuqW/IWKin4K6GPgp402gOTcCVco5CYYXQaYPWM16PMIucy+bku1PRB
        c6jHJ/6PSVJ6tFIJaF/tvBeZXnECH1stI5wLcpd+jueTPruqZ1fDGOERGlXIc/ws
        lKzFtTmdAGrHLLdLS31a6ugXpL8dMU33xO/PzOmusNBBnE82hbn7U39qRe9U6DcE
        rs/ii4cEp2eSEhPfg0cDL0mZqJpQ/0OU/MZzUk82Cy2qyeuE70bLCeBRLXCgwmdY
        Ggi4kWfEWwHU0YjWYp07O7e/fcXYRByVMhv/wp2hQePQml5FRiOvwO+u53csHCHQ
        ==
X-ME-Sender: <xms:jW-9YBwR-q3V4EK7STbPOH9wT3p70NZCeAv8Deq25z5HcwioIxtvKQ>
    <xme:jW-9YBSNnhQ4ObgNYMkZhHkC1_egOmrWDE9AfPZWkboIphW2KWQNaIrCZaxRERa-O
    6YjLZwfF_tGSCPyuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepkeekteekuddvffeigeetkeegudduffejfffguedvveffvdekheeivdet
    hefftefhnecuffhomhgrihhnpehlkhhmlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:jW-9YLVhEphlM38b9mECgcIsLbV-XLYFkZ4EU21IQOb4pTiGQNKgvQ>
    <xmx:jW-9YDikW5FSPcrjlIqsFepDzNF6ZusNr7XT-iQX5qWqQ-zHPmAgfA>
    <xmx:jW-9YDAAc2l9A-soi9K94ycDHH-7JSAj3QkoLlFMvfXfyp1H1OFEvA>
    <xmx:jm-9YAKYnP8L3NEJ_NfFwjZ66dMlzcBi892-1OVvXx7MZOdOKVBxxg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 738A2AC0062; Sun,  6 Jun 2021 20:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <987dca0b-1164-42d0-91d9-39e45896a47f@www.fastmail.com>
In-Reply-To: <e95c5263-d50f-4316-bb93-e14449559b1b@www.fastmail.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
 <20210525094815.GA8757@aspeedtech.com>
 <CACPK8XfdYAcx=RX07hf1ar8A7th8G8390exvKbgh92X=ov8u2A@mail.gmail.com>
 <e95c5263-d50f-4316-bb93-e14449559b1b@www.fastmail.com>
Date:   Mon, 07 Jun 2021 10:29:36 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Steven Lee" <steven_lee@aspeedtech.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "Hongwei Zhang" <Hongweiz@ami.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v5_0/4]_mmc:_sdhci-of-aspeed:_Support_toggling_SD_b?=
 =?UTF-8?Q?us_signal?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Wed, 26 May 2021, at 08:29, Andrew Jeffery wrote:
> 
> 
> On Tue, 25 May 2021, at 22:26, Joel Stanley wrote:
> > On Tue, 25 May 2021 at 09:48, Steven Lee <steven_lee@aspeedtech.com> wrote:
> > >
> > > The 05/25/2021 15:55, Joel Stanley wrote:
> > > > When I was testing on my A2 EVB I saw this:
> > > >
> > > > [    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > > > clamping to tap 15
> > > > [    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > > > clamping to tap 15
> > > >
> > > > Do you know what is happening there?
> > > >
> > >
> > > Per MMC spec, eMMC bus speed is set as legacy mode(0~26MHz) at startup of
> > > eMMC initializtion flow. Clock phase calculation is triggered in set_clock()
> > > and it calculates taps based on phase_deg(<9>, <225>) in the dts file and the
> > > current speed(1562500Hz), which causes the warning message you mentioned.
> > > As the phase_deg in the dts file should be calculated with 100MHz.
> > >
> > > https://lkml.org/lkml/2021/5/24/95
> > >
> > > But after some initialization flow, eMMC bus speed will be set to
> > > correct speed(100MHz).
> > > Clock phase calculation will be triggered again to get correct taps.
> > 
> > Thanks for the explanation. I added another debug print and I can see
> > it doing what you describe:
> > 
> > [    1.465904] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> > [    1.480598] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 9 tap 15
> > [    1.490316] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> > [    1.505077] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 45 tap 15
> > [    1.515059] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> > [    1.524886] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> > [    1.534904] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> > [    1.544713] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> > 
> > We should change the "out of range" message to be dev_dbg, as it is
> > expected on a normal boot.
> 
> I would think the issue is rather that we shouldn't be applying a phase 
> correction for a bus speed that isn't what the correction was specified 
> for.
> 
> Let me look at this a bit further.

Okay, looks like the issue is that setting the card timing and the bus frequency are not atomic in the sense that the bus clock enable is toggled in between the two, and the MMC core calls through the driver's set_clock() callback when toggling the bus clock state. This means the driver observes a transient state where the card timing is not aligned with the bus frequency, and so we have garbage inputs to the phase correction calculation.

Ideally there'd be a better solution than just switching to dev_dbg(), but I'm not sure what it would look like.

Andrew
