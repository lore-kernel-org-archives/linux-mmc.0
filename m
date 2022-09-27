Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB49C6FA82
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiI0MEp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiI0MEn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:04:43 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1971D9;
        Tue, 27 Sep 2022 05:04:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84BD6580B4D;
        Tue, 27 Sep 2022 08:04:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 08:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664280270; x=1664283870; bh=X6PgjqV1In
        3ZSq9GixXUX+wp6ZWYnHlCCiRNYB8MzOo=; b=lf5crLfqQDmnHfXyRPd0RxqTsS
        1iIK1oqW2RLYJpJECb0dI8CnPPZXjJsP9fIFBJJw6GoCXv6LpqOfAheXncm8a4eE
        +3V2cMBqlF/Uq04vuq9nGHc+WjgBIQaS/IrT/G4OHmsizNz+t5jjOS5hnb1PV7I/
        xba7NdW1ag50HrLmTL5aawX/YfTG3mLag1Ca9LqaYIlixAp3qM9U/fH9dJwutsEZ
        eftnbOVPQjIT5pyn0fwEKVPuXeqrcXksQvblgeG1TjQQG7nVR3/dryBBFNfodYB5
        7Pw6q1KMF3UY/GfTNf7xrl9ORqETU1Fy0ZFLUHcdzku1cUsCCYZDuCHTr2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664280270; x=1664283870; bh=X6PgjqV1In3ZSq9GixXUX+wp6ZWY
        nHlCCiRNYB8MzOo=; b=bDSqXckW0Y32+AmR/aRSggoFs21pUIMFAL0bBrsxBc/I
        q2DUC8Yogk5bW8PgqKloeBULaZeXVSQ67uDZkhDpCwAoajHaHpasH6/i3DjloJII
        T3sbT9rokvzgRVs1Kg9UMiP8FzsBoO/5cJcna3AgJWiDjEggrnbVNyAJVBqweQFu
        S6XIuaRka8TtiGXaLwSi45zi+MyQhP0Tz4Pvl6iPUG2Ehaq8jwbfrjZMm2qL1cWB
        PFZTjEU9qVkAp6BpGLRJmXa9QJcE+1aCYqU6n25fz3Hnv9e+R7hjSrJz0xVWLOaS
        RSUDDCxp3q4tUPjT4dionUarHFCHFMeRl3c5NrMyYQ==
X-ME-Sender: <xms:zeYyY8S5ahd0QXtq6QoJfBkDmnI1-wIcUqrBfXZy5uTfEc2hDw3EEg>
    <xme:zeYyY5xM_Vtig_uSBVnjl_nqCBT3rrbRLrPCc3hX4ns7AuQO7HRd4xVQ2KpfUsWjj
    dKuwEjlkTQnPEHVO-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zeYyY50e3pxAnidlv6ow6J05cH6G_ideOK7wh8AAzqcN-73hAW5Cwg>
    <xmx:zeYyYwCDs_2gfOaVIcH6jLGueqU1KnCWJ7RXj4up8XEEgWmU11erNw>
    <xmx:zeYyY1iLZE2QFLavvsJaTrGF07tL8WwmmlI7Zgof7JkkuGNjUlJ2cg>
    <xmx:zuYyY9g1A3_VCqwS4EDE03577fjzeGafDHpLzKHagO76sn7OapU2iw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21661B60086; Tue, 27 Sep 2022 08:04:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <ad962bed-1614-4eb1-91f7-23b9cb6e0ea3@www.fastmail.com>
In-Reply-To: <20220927104138.5924-1-marex@denx.de>
References: <20220927104138.5924-1-marex@denx.de>
Date:   Tue, 27 Sep 2022 14:04:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marek Vasut" <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc:     "Yann Gautier" <yann.gautier@foss.st.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: mmc: arm,pl18x: Document interrupt-names property
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 27, 2022, at 12:41 PM, Marek Vasut wrote:
> Document interrupt-names property with "cmd_irq" interrupt name.
> This fixes dtbs_check warnings when building current Linux DTs:
>
> "
> arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dtb: mmc@58007000: 
> Unevaluated properties are not allowed ('interrupt-names' was 
> unexpected)
> "

I don't think that anything relies on the name here. Should
it just be removed from the dts files then? The name does
not follow the usual conventions with the "_irq" postfix.

     Arnd
