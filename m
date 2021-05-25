Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB94C4707F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 23:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F0E6142E
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEYXBm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 19:01:42 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48719 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhEYXBi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 19:01:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08757580F64;
        Tue, 25 May 2021 19:00:04 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 25 May 2021 19:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=k2E6Xl2OGkKHi1Co9wKE/zYBcsaaJtP
        CLHu3XoEVoQ0=; b=r+Ba5JSfHnYEVlp/TkUTUnYG03Qko6M6XZGkGlDC6YcunKf
        BHWlxaBLNmYkqWyR36EMS+hW/z3uQfM439RN4++ABiAzQDLFOAAiWudJRqpxMH6J
        lkEwppBtDbcXRzKaTCSFVxcQh8EB+kzSbOJ2EqdmCyy4PLXeT5N1CbAxRADLCIde
        er8+tAw/sdHdbJnOxoeSjdGuVqB8/VU4vGiVg8uN51zalxvra21PM5iF5CVK4Qbw
        IodHaj4AY2mY+DCsicOEWt/mTq9vWpYx+gnghHgrDkNIRoT31CkeOSs8nBTL3Rl7
        pirZlfhAYnHp+cF+29zgtjTMAb9aRshlz5O90xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=k2E6Xl
        2OGkKHi1Co9wKE/zYBcsaaJtPCLHu3XoEVoQ0=; b=j/tvEBgcYT6NruAOEo3pmY
        NFb2EXKVliDobySmbPRtNYOyV1iIUzK1TKy4x/RWO85Ehi7yeLPyWjPT/4LqJ5kM
        tT75MNO8RJ+xkmG+WE+sT9aS42wi9qbN7S8B0X6+bEQy7+MabqEKyiwiDbcARWBS
        zU3jptQswjST6QeAGjqNYjREgPUmk8A+o5cQbIF/NyYA9eVxmV3V3XNmKNko3mWh
        lOsBOW5wpb0TdeO7+BUvROO+GKlOUgUqI3+UhDkpp0w1cux/ESh4hDeaXWzUjNwo
        t0iLJ1dmo+WjC7Tub1KqwQrTSMOQHH+fAV5IPXOiUTjvbbg7wmsV3YJE/hQAGSKw
        ==
X-ME-Sender: <xms:coGtYGCUw_IwHteOiD36wp6XozWVtIrqrZEQR6pmnzy2hZWcm0s56g>
    <xme:coGtYAiJCmUqHCyBkbEi-cGrKurmv-_JD49TRsgimGYLHezCwQ6Q8tluCrAoXDN1H
    tiQCitaXuXEu-iTeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepkeekteekuddvffeigeetkeegudduffejfffguedvveffvdekheeivdet
    hefftefhnecuffhomhgrihhnpehlkhhmlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:coGtYJngWbcMwKlahILBMLZx3vkNJjDejNejGHrMeWeEqwvPh7m-9w>
    <xmx:coGtYEyD_dC7VoMgHak49JjdCvUWccHAklJzntTLHG7mlGK5DGQ41g>
    <xmx:coGtYLTzOu7698bAdzm07BYsxnElSqI1BLC96NBw9gLMSRUbnR4TMA>
    <xmx:dIGtYDYUKATlHWFKXDhHESTfJoCiGjHfn1sIw-EOM3IEM8KuwvywoQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 159C4A00079; Tue, 25 May 2021 19:00:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <e95c5263-d50f-4316-bb93-e14449559b1b@www.fastmail.com>
In-Reply-To: <CACPK8XfdYAcx=RX07hf1ar8A7th8G8390exvKbgh92X=ov8u2A@mail.gmail.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
 <20210525094815.GA8757@aspeedtech.com>
 <CACPK8XfdYAcx=RX07hf1ar8A7th8G8390exvKbgh92X=ov8u2A@mail.gmail.com>
Date:   Wed, 26 May 2021 08:29:41 +0930
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



On Tue, 25 May 2021, at 22:26, Joel Stanley wrote:
> On Tue, 25 May 2021 at 09:48, Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > The 05/25/2021 15:55, Joel Stanley wrote:
> > > When I was testing on my A2 EVB I saw this:
> > >
> > > [    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > > clamping to tap 15
> > > [    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > > clamping to tap 15
> > >
> > > Do you know what is happening there?
> > >
> >
> > Per MMC spec, eMMC bus speed is set as legacy mode(0~26MHz) at startup of
> > eMMC initializtion flow. Clock phase calculation is triggered in set_clock()
> > and it calculates taps based on phase_deg(<9>, <225>) in the dts file and the
> > current speed(1562500Hz), which causes the warning message you mentioned.
> > As the phase_deg in the dts file should be calculated with 100MHz.
> >
> > https://lkml.org/lkml/2021/5/24/95
> >
> > But after some initialization flow, eMMC bus speed will be set to
> > correct speed(100MHz).
> > Clock phase calculation will be triggered again to get correct taps.
> 
> Thanks for the explanation. I added another debug print and I can see
> it doing what you describe:
> 
> [    1.465904] sdhci-aspeed 1e750100.sdhci: Requested out of range
> phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> clamping to tap 15
> [    1.480598] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 9 tap 15
> [    1.490316] sdhci-aspeed 1e750100.sdhci: Requested out of range
> phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> clamping to tap 15
> [    1.505077] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 45 tap 15
> [    1.515059] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> [    1.524886] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> [    1.534904] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
> [    1.544713] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
> 
> We should change the "out of range" message to be dev_dbg, as it is
> expected on a normal boot.

I would think the issue is rather that we shouldn't be applying a phase 
correction for a bus speed that isn't what the correction was specified 
for.

Let me look at this a bit further.

Andrew
