Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F1FC433E9
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F162071C
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 03:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbhAUDxn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:53:43 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52687 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388069AbhATXrj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 18:47:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D40315C0136;
        Wed, 20 Jan 2021 18:46:21 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 20 Jan 2021 18:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Osf2ELJTbWcLwWlfylNHUcxi3LV4y9b
        ORwKF8hqOZGw=; b=jOAydszf3n1jDn8jWiGmW8H/hzbrEB96l5TAiKCLXPCgFeK
        H19QuUPhFWn8fAPgcohYz4bpI5Stebdx7ad55gk25yBT4fIdE+3jfS/wn3ijhvFg
        vc9w4EUFMjnBLJJQGjs8KZMMfvuJNnlO2AdeR4bt6jYsBiRITJhrlOHX9681bV5L
        UbWWLP2VdUtNgHvjWfjehUiOX2zo98vsgGExG3RBQ2lj5DydfwLm0pwXPzLqezfr
        vGUbGIgDQuCnSfXsSXZsy+pqFykTmS88lW8IG+9oMYWf5NxzLQTTK/IvpKBXLuSj
        8xI6YKjdiS8Hvo1aGX/aFi6K8ymQxnpZEVsJHtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Osf2EL
        JTbWcLwWlfylNHUcxi3LV4y9bORwKF8hqOZGw=; b=ePZO5PHcT+F/5lxask8Z4B
        ylukggbKy+OtlTGpxvqkg0s+hwXrzrTWHUk3K4W4L9aUgVZx4MtW3XxdAT9H3cQk
        cFanGoZNGUaEe4MQzeFC5RxKq8zHSDoEclXnQQHJQlewu+tm3Dw10tfpwQoY8N17
        d4CqPKy8qGTVNkWWe2wFcT4rG8B1AxoV7HTkc0Mte2k4Q3JKB+a1B+gcYpkamzxL
        FzFIMZU+ZUFy/2Fh6SxgamPxnYJ9nt9OIZsTdxLL07vhFvr1E0Ox4V3rUlrDovVB
        QwUbVNoONeiCu5KGiDN9Qh4TPlfVMUmsEPd+4ZDlZMCYUjBdwcSh9/E4FxeDEiTQ
        ==
X-ME-Sender: <xms:zMAIYDqjI8n-vorK9RHJAlNUNZEWheGuLkH8I2qv3KUdjR5cLA7iGA>
    <xme:zMAIYNq3QLZzYVqVNgTRvGy_TFlZZ9kVOXKPT2AZXBs8ZHEM5wwUhzvaq-6Mr-NPA
    KSJWFCj7u3QJzbQ4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeduffdtvdevkeffgfetffffueevgeejleeghfffjedthedthfelgfekfefh
    feekieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:zcAIYAN8FD9QayNBy0WYXSo2ZCywtzPr83V4YgpPcsIuUPoEDOjEgQ>
    <xmx:zcAIYG7rynQYuNjz1tCZ85i69e3DU2d58HnXQUhCPjWlMcZVgDpcMA>
    <xmx:zcAIYC7WlrNW6gkz4mn3XUxLn6urpUcAZ712PgR2bmIJf8Jds92ngw>
    <xmx:zcAIYJbsD8kysw-wCz4vgVfFbZq1ra8djnrtJMWz2FXRyZoBSABx2Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4A3DA0005D; Wed, 20 Jan 2021 18:46:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-78-g36b56e88ef-fm-20210120.001-g36b56e88
Mime-Version: 1.0
Message-Id: <9f2dcef2-0b76-475c-9bb4-b029589763bf@www.fastmail.com>
In-Reply-To: <CAPDyKFqBOWLBbAxZNhN5r=qjXTG9+3tX4nT8+Gz+Xbppsxh5_g@mail.gmail.com>
References: <20210114031433.2388532-1-andrew@aj.id.au>
 <CAPDyKFqBOWLBbAxZNhN5r=qjXTG9+3tX4nT8+Gz+Xbppsxh5_g@mail.gmail.com>
Date:   Thu, 21 Jan 2021 10:16:00 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v7 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Thu, 21 Jan 2021, at 00:26, Ulf Hansson wrote:
> On Thu, 14 Jan 2021 at 04:14, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hello,
> >
> > This series implements support for the MMC core clk-phase-* devicetree bindings
> > in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
> > and is present for both the SD/MMC controller and the dedicated eMMC
> > controller.
> >
> > v7 is just a small change to the the kunit testing in response to Adrian's
> > feedback.
> >
> > I've just done a quick build test of v7 given the small change and more
> > extensive testing done with v5.
> >
> > v6 can be found here:
> >
> > https://lore.kernel.org/linux-mmc/20201218035338.1130849-1-andrew@aj.id.au/
> >
> > Please review!
> >
> > Cheers,
> >
> > Andrew
> >
> > Andrew Jeffery (6):
> >   mmc: core: Add helper for parsing clock phase properties
> >   mmc: sdhci-of-aspeed: Expose clock phase controls
> >   mmc: sdhci-of-aspeed: Add AST2600 bus clock support
> >   mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
> >   MAINTAINERS: Add entry for the ASPEED SD/MMC driver
> >   ARM: dts: rainier: Add eMMC clock phase compensation
> >
> >  MAINTAINERS                                  |   9 +
> >  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
> >  drivers/mmc/core/host.c                      |  44 ++++
> >  drivers/mmc/host/Kconfig                     |  14 +
> >  drivers/mmc/host/sdhci-of-aspeed-test.c      |  98 +++++++
> >  drivers/mmc/host/sdhci-of-aspeed.c           | 255 ++++++++++++++++++-
> >  include/linux/mmc/host.h                     |  13 +
> >  7 files changed, 423 insertions(+), 11 deletions(-)
> >  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
> >
> 
> Applied patch 1 to patch 5 applied for next (patch 6 should go via arm
> soc), thanks!

Yep. Joel, can you pick it up?

> 
> Thanks for stepping and helping with maintenance as well!

Happy to help :)

Andrew
