Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82137C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 03:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58359613E4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 03:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhEGDn5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 23:43:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53945 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231299AbhEGDn5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 23:43:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8B99B580EFD;
        Thu,  6 May 2021 23:42:57 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 06 May 2021 23:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=arDYubqdnTaycuMeD6vidROrSycff0E
        9LYTfLWtgEeY=; b=vUdHaypfY4c34YnKjC3s38glKfC2kan4S8Y3Sn2ZirS1OSy
        67ziv2lw5DGr/TW8IAGecuPLAlX9tOIQtl3s3Y/upj9zNy1qjTSRftWlfDcWUr2l
        6H3MscnI12kj5PlEQsSMgENVHXbu3boVDCnKd7eKPTYJCkH76xm01m/hjq/Rl/Hz
        CA6y5K8u1QTTuQ6xA+K4gwNfWb43+8wnzGyCvCP+WGha64jgB8JTgcjQKf8J0gr6
        aoXLoXMbeKxTMfr6DSrPx4JqemG9lsNqYTM8S+5SfjqWoBH50F8vTlomf2x3vEY8
        4LLf+R6k4sfxenxOBhKmOI1UxqPhyJ4Wtx7P6tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=arDYub
        qdnTaycuMeD6vidROrSycff0E9LYTfLWtgEeY=; b=Jotf7hi/FDyVXe12rk8yAh
        5AUFEwU+zBRtM+RZLmWbwnSk9Le2M5M9BQY8QGiRM2xOkA+xXH4oH26u1xvEfxGs
        zoGUsGiy9cvSrwQ2gn6eOtfSYgJXOWGhw1WCAwKriP1Bdq3BMmD//kUAFjT87gBW
        Vil9ksLVPjWW7M1Vl6QbDc33TBGiiUTOYraBcZDXKkNHzBno9xUBb6j9CR+hWRcp
        TzEEwhjUchKw3lFMY8A3RFeYg9RSQQ+yA2c1YekYYDBPteCuZW9EnAaTI0kYU8Ik
        BkAahLwTb6OBB3j0crZr4VC50BKjm7PhN5GPNsmFU4GaZ2zs5tg3xWs6OBZeC4zg
        ==
X-ME-Sender: <xms:PreUYGgNO7y0p9W5vCAQQSpSKJXYWf-HQbShd30VlYApiAEEQ5p5-Q>
    <xme:PreUYHBBBgcUrABYSQHbK0XsS4dTLfay8CLxia1jx82oEhBdS-0R3_8jnvjzg86m1
    twi_DUwQLcIc3_OPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:PreUYOHUFAcApAtcZPRcXj_H3W80jYyLiSDGBXiBH6HNJvJnhwAubw>
    <xmx:PreUYPQ1cF1XoVMS8jSHQt2F7Y6rdUYmm3Zz0Wpg8gkQY4UZwrj_lw>
    <xmx:PreUYDz1cyqTTSguYYuwokVuf-DXWUYaatpj-RPp3XjZAb1cwf-xJQ>
    <xmx:QbeUYLgVbW01lRE-6Dmy5lqaMFTZ0sG6a8vvB6y3CNIdFmW4BOMpIA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22FE4A0007A; Thu,  6 May 2021 23:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <d581f7b9-dd08-4690-ba3e-f38662dcb587@www.fastmail.com>
In-Reply-To: <20210507033021.GB23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-3-steven_lee@aspeedtech.com>
 <8611c4a7-8c65-4d7d-90d5-37c80faa3142@www.fastmail.com>
 <20210507033021.GB23749@aspeedtech.com>
Date:   Fri, 07 May 2021 13:12:33 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Steven Lee" <steven_lee@aspeedtech.com>
Cc:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        "Hongwei Zhang" <Hongweiz@ami.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/5]_ARM:_dts:_aspeed:_ast2600evb:_Add_comment_f?=
 =?UTF-8?Q?or_gpio_regulator_of_sdhci?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Fri, 7 May 2021, at 13:00, Steven Lee wrote:
> The 05/07/2021 09:40, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 6 May 2021, at 19:33, Steven Lee wrote:
> > > Add the description for describing the AST2600-A2 EVB reference design of
> > > GPIO regulators.
> > > 
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> > > b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > index 2772796e215e..1ae0facc3d5f 100644
> > > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > @@ -104,6 +104,21 @@
> > >  	status = "okay";
> > >  };
> > >  
> > > +/*
> > > + * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
> > > + * toggled by GPIO pins.
> > > + * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
> > > + * power load switch that providing 3.3v to sdhci0 vdd, GPIOV1 is connected to
> > > + * a 1.8v and a 3.3v power load switch that providing signal voltage to
> > > + * sdhci0 bus.
> > > + * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
> > > + * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
> > > + * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
> > > + * sdhci0 signal voltage becomes 1.8v.
> > > + * AST2600-A2 EVB also support toggling signal voltage for sdhci1.
> > > + * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
> > > + * as power-switch-gpio.
> > > + */
> > 
> > Okay, I think the comment is in the right place, but I feel this patch 
> > should also add the regulator nodes and hook them up to the SDHCIs.
> > 
> > Given Rob isn't super keen on a second example in the binding document 
> > I think you can just cut the example out and paste it in here.
> > 
> 
> Hi Andrew,
> 
> Since AST2600-A0 and AST2600-A1 don't have regulators, do you mean cut
> the example from dt-binding and paste it to aspeed-ast2600-evb.dts but
> comment out the example?

If the board design varies with the silicon revision we should probably 
have devicetrees that are appropriate for each, so an 
aspeed-ast2600-evb-a2.dts

#include "aspeed-ast2600-evb.dts" at the top and go from there.

Cheers,

Andrew
