Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D1C433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C63222B3A
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 00:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAKAD1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:03:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36779 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbhAKAD0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jan 2021 19:03:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A5AB5C0066;
        Sun, 10 Jan 2021 19:02:39 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 10 Jan 2021 19:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=YHDGpMsoVWO7Mu0PPN8KuDaFtz6Yykc
        CQ780RW5/qxw=; b=ZaAILfvy5ecridk++cJ0nJ4K/Oni0M8gbBt8H5IDOnlfeNj
        Mo8nq31+IJ6ROeQTNBMDqquGNuY+ixPvPF/EfCRvnYbi+StHMb5u4owS1IbLcwaJ
        fGuGk6UTarTg8YOaqBC7OK8njZueBAATPZn/Gyy/IkKAKR6i1BztxNwh4uaR0kVm
        3k+cccwP4SAMBs/Y8qD11DGqN7BN7OJVic/ai9BRuSvucrBpykivqaZOFos9k7pK
        zX2TylMK/eIBVoJ34tdtJMQiUgeyMXIMTuXUX6mZs5bV1y1r699ghSY3Xqw8VaqL
        vOFflD7nbINSIZWHwpJZotyTrA3elFBJrzie/XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YHDGpM
        soVWO7Mu0PPN8KuDaFtz6YykcCQ780RW5/qxw=; b=pF4fPa/UWkHXKr5pNhdG9q
        vBaanS0z8zTNwimmVCAM2By+ADYxx9v48FWNh7Fr/Rtgbug5jGsRqdaiRUWH7/jB
        6I52/g8iDiUMS1yihvqSerhNlGvHsYF4+exRfoAAr7d09yjJ6WlDaFBEZ7Y0XSS6
        xflDyUncnOYvA2k20kdwUKXVKPKO5+11/cNiRTI+59gTAfYM96auf0uLGmplIQxH
        eTXKvAOMrB1bn1Xdn6Tg/DcHjiZughf2N5wi5bKhv0OogEjnboCcOSpyyZxYcOBn
        55vSjGv+SzYB4a+48+TSXdPuZKRmcAqFGZkx1piqJGMpHhwp6VsUQ45bYfDREAmQ
        ==
X-ME-Sender: <xms:nJX7X0-vTH81zuNKvqIMJPtxcq9IN0WMIHhgscQ3qY7G-WaKCAzv1w>
    <xme:nJX7X8u68X-9gWWX2O_IguwwioHT99hLFYB0D1zxpIJBU3qXRR7pRfTl4IvBPreiv
    TY_f-eVW-AEjLdqgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:nZX7X6BCQ9yklg5W8vmuA_Eq76fAZ8EZcbkMVa3AwaIzKtEkWHn5rg>
    <xmx:nZX7X0eK4qbgMcgJz9T8-pH0nH1bPGM0A5lXwDgkgxnFSjxnDBmYhQ>
    <xmx:nZX7X5NuaN6KlHOkhyqIsFOYmhrTo4B9dzRlXBkZFmDCgsDLGrqIyA>
    <xmx:n5X7X8eNOxauqVlg4v-yio38sT6_ingLbCRm6UHN9NpRF0-O5_nNSw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D610CE00BF; Sun, 10 Jan 2021 19:02:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-45-g4839256-fm-20210104.001-g48392560
Mime-Version: 1.0
Message-Id: <6f341a22-f5ce-4c38-9f42-358124468821@www.fastmail.com>
In-Reply-To: <ff588027-0fbb-100e-05a9-4a804662d838@intel.com>
References: <20201218035338.1130849-1-andrew@aj.id.au>
 <20201218035338.1130849-5-andrew@aj.id.au>
 <ff588027-0fbb-100e-05a9-4a804662d838@intel.com>
Date:   Mon, 11 Jan 2021 10:32:15 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v6_4/6]_mmc:_sdhci-of-aspeed:_Add_KUnit_tests_for_p?=
 =?UTF-8?Q?hase_calculations?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Wed, 6 Jan 2021, at 00:17, Adrian Hunter wrote:
> On 18/12/20 5:53 am, Andrew Jeffery wrote:
> > Converting degrees of phase to logic delays is irritating to test on
> > hardware, so lets exercise the function using KUnit.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/host/Kconfig                |  14 ++++
> >  drivers/mmc/host/Makefile               |   1 +
> >  drivers/mmc/host/sdhci-of-aspeed-test.c | 100 ++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 596f32637315..d6f00d1d6251 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -168,6 +168,20 @@ config MMC_SDHCI_OF_ASPEED
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_OF_ASPEED_TEST
> > +	bool "Tests for the ASPEED SDHCI driver"
> > +	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
> > +	help
> > +	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
> > +	  option only if you will boot the kernel for the purpose of running
> > +	  unit tests (e.g. under UML or qemu).
> > +
> > +	  The KUnit tests generally exercise parts of the driver that do not
> > +	  directly touch the hardware, for example, the phase correction
> > +	  calculations.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_OF_AT91
> >  	tristate "SDHCI OF support for the Atmel SDMMC controller"
> >  	depends on MMC_SDHCI_PLTFM
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 451c25fc2c69..3ee59d5802cf 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> > +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)	+= sdhci-of-aspeed-test.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > new file mode 100644
> > index 000000000000..fb79b278fb81
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* Copyright (C) 2020 IBM Corp. */
> > +
> > +#include <kunit/test.h>
> > +
> > +#include "sdhci-of-aspeed.c"
> 
> I am not sure including like that is advisable.

Yeah I wasn't convinced by it either, but I was just running the tests under 
qemu and they did what I expected.

> Did you consider instead
> doing it the other way around i.e. adding an include to the bottom of
> sdhci-of-aspeed.c?

No, I didn't. I'll switch to this approach.

Thanks!

Andrew
