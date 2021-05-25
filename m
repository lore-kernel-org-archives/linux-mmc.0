Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3BC2B9F7
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18C3613D6
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 01:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEYBBx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 21:01:53 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57075 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhEYBBx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 21:01:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3760C580B59;
        Mon, 24 May 2021 21:00:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 24 May 2021 21:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=MuuXmIqjs2b9Wql+ivIaAaXhuLI9xH3
        VV1Cqz+QjxZs=; b=LorQqEfF7U396gS162c09TdyeNqdizOd6xeH/vNcBbyROHg
        J/rvox01HTmL0jc9JsOt/vfWVXKOLiF8F36nnN7AcrG7vhRA/liF7PLsFpCsMdyr
        KpFcnt3Fmem2gak6MKB+qcVZ8Y8oJNAZKBr6c9Sb0NP0Eb4G8QjlC/NGri3iKt0J
        cU3ICrNfe+Wcv05d4d0X03U9H6im5dN45TT18GK6LVKxPobbLB0l7ooeocSw4gNu
        UVz/J/MP8zKzCRofVUGlKIyUZjrZZA3Yl7qsEdcqm1U8j0em/NfAkVEejWpf0il1
        1Cj3fEqU11N207Ux0ksiZm0rHKsYOkFgRmFh4KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MuuXmI
        qjs2b9Wql+ivIaAaXhuLI9xH3VV1Cqz+QjxZs=; b=EiWSMMf/E4LAR9llQaNh+d
        kDFyDuFh7nbbOYr+s758MyQhrnIE6KkWLflZlJYefI9GLL50m/lwWMXMgNFHZ5fq
        5Uy/ayzVKLRj35ddWMu03G75EJMJG5v4KFTXpxhrTiFEX+VexABUp4+R2Ow0MSU9
        xZJxgnHCkWNtUiCme32H1XQqeCewAL2kFmpVG/H0DllNIkeVjULFs69b0SNDj9hs
        KUNoGtNhSV29XPZaBm2wtSdeYEODX2yGaM2UxrrId81re1BIMhD3ZaHSIsJm+ho9
        9O5KWm1JEGg3Aq7GJKdbWq80BkxmF9JcD0Tg6Cp4yA3x34GwOCd7oXGsu1xmPITg
        ==
X-ME-Sender: <xms:JkysYD7VveHzst7SikTrfhAk1N1oIVYzNMMsY8nH7Few6CpOZQ-tcg>
    <xme:JkysYI6bh0zzqNdyCP36eLTrILmeD_H-9NDCWoKdNYxTG4Tvv3ZgsihUS6B4kAznp
    gBDmuy7FeQlFwxnHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdektddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:JkysYKcnx-2Fx7u0ClcsPOOGOLS-Cyi2bgrJATWsZn8IU1fQCZEo6Q>
    <xmx:JkysYEJYQ9DxTgDevycBMeAnRWYPaqZ2SeyHXihKiAedy-xmpPNdOA>
    <xmx:JkysYHKkEwOjefxvQhvIrajJM97BudoR3o8a4wha3GNoyIx9R9t5sw>
    <xmx:KEysYJwO_XcoVHP6N8odCGVRBGr2k0FiTRDxNzRrvv_rsuG5sDMHLw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AFDC7A00079; Mon, 24 May 2021 21:00:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <5c4988d5-1928-449e-8eaa-e16448f820fe@www.fastmail.com>
In-Reply-To: <20210524073308.9328-2-steven_lee@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <20210524073308.9328-2-steven_lee@aspeedtech.com>
Date:   Tue, 25 May 2021 10:30:02 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Steven Lee" <steven_lee@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     "Hongwei Zhang" <Hongweiz@ami.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v5_1/4]_ARM:_dts:_aspeed:_ast2600evb:_Add_sdhci_nod?=
 =?UTF-8?Q?e_and_gpio_regulator_for_A2_evb.?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Mon, 24 May 2021, at 17:02, Steven Lee wrote:
> AST2600 A2(or newer) EVB has gpio regulators for toggling signal voltage
> between 3.3v and 1.8v, the patch adds sdhci node and gpio regulator in the
> dts file and adds comment for describing the reference design.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
