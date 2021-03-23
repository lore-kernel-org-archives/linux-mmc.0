Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A0C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 10:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E98A619BA
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 10:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCWKxp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 06:53:45 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59967 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhCWKxY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 06:53:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0C9C6128C;
        Tue, 23 Mar 2021 06:53:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Mar 2021 06:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=b
        F2ZJHjpCDRG6YL3M/WZ6toZgNvLcne9zlEm4BRKu9A=; b=lvOEsqWbAy8n1Xy2H
        VqMsi68JRSgxuGbIDo/g6xeWUbVk16kkfo+t2ULSuxhZwuDPkcfqZFGL63nDK277
        qKnXH7+tQZBxXM/Nr/N5ggsXubpomnJWUkzEZ4DPd3jWivqt8byjYmNCNmDB+D1F
        mCODzyKwLwLlNlTwd0sXMzYxDdku0kB08O4Kd0+A1esOXHLIQYI3HO5TQNtepmMX
        AKiE/KOMHta+B+SrN8qKUpEuhlBZrHs5NHeIehdzWll0/EEpp2bkgf4GO9+c1G/5
        NvKyyd3vI1JfwRuWzKr6eDTasDNmkBIaiSRCIL9MuIUqGj5k178dfYW59JQ7RLtK
        23sDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=bF2ZJHjpCDRG6YL3M/WZ6toZgNvLcne9zlEm4BRKu
        9A=; b=idGy1fPIBLYn4KgfEcLGM5JIuSr6lyS75Qhkf2oLmzMA7JEBopzIfKcGa
        5cn09xy0Ie2J1cM2QA4K4agK+nxUMx68VSmiahgEl46ALMMkapbEDLKVqcjsygP/
        wuVhMOSuWBWEBZ5jSlx5fDEjFbUmn6cVcCqcTFzLiGS7bIMHTGxfd9eR9QSs6nhs
        8vxUc1a9DxOyG6hz1STt6yhpnf5VC2QIgDz9mIblLRSXl/+RiKMH8h5J8DCCB3/8
        NDDMWG6BsgCpjuQgPhATiDcxds7mBw69j3j2O5GoUgG+Eq3mjW+0/78Xgu8arYZq
        JEuWBCSDlcOKMow61E9y59NwmDCnQ==
X-ME-Sender: <xms:o8hZYLg4M-vw2Z2Filb6x0CfDh6_JbfkFpLsX6MIrO4PP302RM6evg>
    <xme:o8hZYH_32WtpdRUEzdL56QayGoSvtNLWGzrJeZnXO0sYVfEEI-X998kLNmSK0X0w7
    ONGbtGNyl5R33j0ddE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegiedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:o8hZYH9wY6wTBfNiVo752vSTWMmpxyRw4dIwdqsH73ZkCvi46DECKg>
    <xmx:o8hZYADtJ1YiWdSq-b6OlUh6FvJmJoEn3UNv04Hb3IJWvcziYVvUmg>
    <xmx:o8hZYHzy7BgBfns_p8ViHRO9LF9XsiM7qnWAzTewcFioHDhYQahBjw>
    <xmx:o8hZYAyib5j-JKVf6gt4eSJBMzqy0nXR-xpvkIuU4_RTvXeTVzf74A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 292531080054;
        Tue, 23 Mar 2021 06:53:23 -0400 (EDT)
Date:   Tue, 23 Mar 2021 11:53:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Help with eMMC inline encryption
Message-ID: <20210323105320.ximbrvy6biwfvsue@gilmour>
References: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
 <YFJLipl1CzTJ/B7/@sol.localdomain>
 <20210322155318.yg4u634a7fxg2yiq@gilmour>
 <YFjNvGAu8M/+ERCo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFjNvGAu8M/+ERCo@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Eric,

On Mon, Mar 22, 2021 at 10:02:52AM -0700, Eric Biggers wrote:
> On Mon, Mar 22, 2021 at 04:53:18PM +0100, Maxime Ripard wrote:
> >=20
> > Indeed, I somehow missed that you were setting the DUN in
> > cqhci_crypto_prep_task_desc, and I'm guessing that's where my issue
> > lies: it doesn't look like there's any field to set the DUN in the
> > controller, which doesn't make much sense to me.
> >=20
> > The documentation is pretty short, but it looks like it might be
> > inferred from the MMC commands arguments (the Access Mode bit in the MMC
> > controller, page 517). Would that make sense?
> >=20
>=20
> If your hardware has no way to specify a starting DUN (or starting IV) fo=
r each
> request, then presumably it automatically chooses IVs based on the locati=
on of
> the data on-disk.
>=20
> This way of IV generation is problematic for several reasons, and it does=
n't
> match the UFS and eMMC standards.  So blk-crypto and fscrypt don't suppor=
t this
> type of hardware.

Too bad then :)

Thanks for your help

Maxime
