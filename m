Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630CC4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F15A610CB
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhHGONN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:13:13 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:49321 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhHGONN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 7 Aug 2021 10:13:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Ghkny2kDXz64;
        Sat,  7 Aug 2021 16:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1628345574; bh=n9RHvgmwO10yV+8X1TQ8vGLq8GhTf/p7Tzeh2jxUSzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5hp8JWxEvD+QSJfDmhc0TLdpdonbMHTGAAMYpnzH/O8IavaORIg1Zpz7rkxty5UO
         nvWUbX0J7+xQFDdW8z32zbu6kMYHS87IBY6oJrEx9jHIPf9wgM4gAVcBHnG39n7Bt/
         HGPK+CkYn89939fqjZs21QjlKzkYDUG7EEzwP8xvVCxxuYHvukcV+VfCpsJDs98mIh
         jCw9/eb3RUSquX+O7YfroCVx1X49Lcw7F1lyGmchLMa0ywoCCuH7GqBLCf6Z9rcQGC
         EQXwmzrAGwEuBgI1sWd185MdOlRwLgSyJ+egBOad3RuQ7JUVYxwd5lBMZ+y/IRGGke
         gZa1T+12AhOPA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 7 Aug 2021 16:12:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v4 4/5] mmc: sdhci: move
 SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
Message-ID: <YQ6U5EeOPzCvLT8z@qmqm.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <ff3907df3aa91f83a4a0a22b63d51bfe491ed039.1627204633.git.mirq-linux@rere.qmqm.pl>
 <2cdb95f3-8943-715a-d3d7-804953e49786@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cdb95f3-8943-715a-d3d7-804953e49786@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 04, 2021 at 03:33:56PM +0300, Adrian Hunter wrote:
> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
> > Push handling of clock frequency dependence for
> > SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN quirk to the drivers that use it.
> What is the max_clk dependency for, and why push it down?

I guess this is a workaround for a hardware issue. When I wrote this,
there was only a single user. Now I don't know if the second user got
the limit by accident or just uses the flag not knowing it doesn't work
as the quirk name suggests. IOW this makes it easier to fix in drivers
if the limit is wrong or irrelevant. The dependency doesn't feel like
it belongs to the generic driver anyway.

[...]
> > @@ -318,6 +317,9 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
> >  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> >  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> >  
> > +	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
> > +		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 0993f7d0ce8e..cfa314e659bc 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1905,8 +1905,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  			/* Version 3.00 divisors must be a multiple of 2. */
> >  			if (host->max_clk <= clock) {
> >  				div = 1;
> > -				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> > -					&& host->max_clk <= 25000000)
> > +				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> >  					div = 2;
> >  			} else {
> >  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
