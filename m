Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCADCC43461
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B310C61464
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 07:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhEGHkB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 03:40:01 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58445 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234520AbhEGHjF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 03:39:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D34245808CD;
        Fri,  7 May 2021 03:38:05 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Fri, 07 May 2021 03:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=dQDOTzcqfOQiIceNESDpDeh6eU3HFDK
        OGe/G/Fvd6ss=; b=G0CwoqHvNi6AqWjcFA79Hiy0clV7wq2v+N4xhwwBCgQAOSH
        15qhvR1wEzXsEUv9gOGoP0ARWg+0Pgusa/R/f+i1hAq26LYr5XOXQ/zAAmU0Pgz7
        XOgEUg0gByOgeTiKyRYuMcLphcm1b6hrjzxgJvqYrlXZ9FJPu8YwPSYz7v2K8Y/v
        aIfmfxXqBsNozUZCyylXIOEkR5Rw9GgAMQh0szpbmoqZU/p4lBP4MuB0VZDzs/cE
        wSDJGS8VmXbn88kAzhMJ98uI2dqcXq4iO+ZyAlnUcVViqOxhF99pfpig7AGpbeX7
        5sNkk5yZHiV/5NPJ4IQE4Nl9nilH2cydovlw1Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dQDOTz
        cqfOQiIceNESDpDeh6eU3HFDKOGe/G/Fvd6ss=; b=eScBRXAxM+mJSzqH2fGjez
        5hfDRIafMYhgx9aIB94L0gsYXDbY9Nsxl1ABKcSFdkkOPi4eot4Aj4//BGv1TxZB
        HuLfRYJLPKi2UobdoOR6A6xawAYPhbwa2sjmoB6mCx75xMIbCE4MoSRj5ahM5f6B
        jWrB6Rz5OlV/RHlu3Svikp/Y8QmjhjEGsPMM3nTFb7bP1WTY/m84L19AHiXMqioT
        s6CF2YkVAFqDn7lcTn5yAlOAO6V5GXnD5jEHJbsZGfGqmLM76I/VUfRtg+wd1iot
        5X3OgFP26BO5CmUApZB/U1M3oH0/j5B52H5/CFYTElqR1TP20pJ6wCTokGRdFRtw
        ==
X-ME-Sender: <xms:XO6UYK6LHVKbEDBv-YocshXGJOuPe4ZpfKyU5D5gDmWNmtqb6CXN-g>
    <xme:XO6UYD7pcHK1WSfnSwwFIThFallfPLa1u4o_POD4b3mikhvwro8F4w78St58nTzAj
    6fOEPaGok6rRj_XOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeduhedttdelkeetvdefiedtleejkeevleekgedvhfdtjeehgfeftdef
    vdejjeeltdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgr
    uh
X-ME-Proxy: <xmx:XO6UYJdbKexbk8yCVKvO8lr41gDyZXItCml2Xdr0j8tc_cWU5V8IGg>
    <xmx:XO6UYHIV_VtlEfoyS5cclBKnlCnQEMLfge2lMs1ktdUOJI9tNFfdEg>
    <xmx:XO6UYOJRYmluXW-HZXIktMZnAR9kxngwoyJy6SfKHn7rVSc1IVxYsA>
    <xmx:Xe6UYJbC0Ld-red-CUnEujuNIVraR3RiJMOPHPxfaU7l4y83cXsbuA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BBCA1A00079; Fri,  7 May 2021 03:38:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <2a339218-19d7-4eea-a734-8053dd553dbb@www.fastmail.com>
In-Reply-To: <20210507062416.GD23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
 <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
 <20210507062416.GD23749@aspeedtech.com>
Date:   Fri, 07 May 2021 17:06:19 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Steven Lee" <steven_lee@aspeedtech.com>
Cc:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Hongwei Zhang" <Hongweiz@ami.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_5/5]_mmc:_sdhci-of-aspeed:_Assert/Deassert_reset?=
 =?UTF-8?Q?_signal_before_probing_eMMC?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Fri, 7 May 2021, at 15:54, Steven Lee wrote:
> The 05/07/2021 09:32, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 6 May 2021, at 19:54, Philipp Zabel wrote:
> > > Hi Steven,
> > > 
> > > On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > > > +	if (info) {
> > > > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > > > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > 
> > > Please use devm_reset_control_get_exclusive() or
> > > devm_reset_control_get_optional_exclusive().
> > > 
> > > > +			if (!IS_ERR(sdc->rst)) {
> > > 
> > > Please just return errors here instead of ignoring them.
> > > The reset_control_get_optional variants return NULL in case the
> > > device node doesn't contain a resets phandle, in case you really
> > > consider this reset to be optional even though the flag is set?
> > 
> > It feels like we should get rid of the flag and leave it to the 
> > devicetree.
> > 
> 
> Do you mean adding a flag, for instance, "mmc-reset" in the
> device tree and call of_property_read_bool() in aspeed_sdc_probe()?
> 
> > I'm still kind of surprised it's not something we want to do for the 
> > 2400 and 2500 as well.
> > 
> 
> Per discussion with the chip designer, AST2400 and AST2500 doesn't need
> this implementation since the chip design is different to AST2600.

So digging a bit more deeply on this, it looks like the reset is 
already taken care of by drivers/clk/clk-ast2600.c in the 
clk_prepare_enable() path.

clk-ast2600 handles resets when enabling the clock for most peripherals:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n276

and this is true for both the SD controller and the eMMC controller:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n94
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n88

If this weren't the case you'd specify a reset property in the SD/eMMC 
devicetree nodes for the 2600 and then use 
devm_reset_control_get_optional_exclusive() as Philipp suggested. See 
the reset binding here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/reset/reset.txt?h=v5.12

So on the surface it seems the reset handling in this patch is 
unnecessary. Have you observed an issue with the SoC that means it's 
required?

Andrew
