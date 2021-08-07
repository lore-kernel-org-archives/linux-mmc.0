Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7858FC4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537BA61078
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHGOIl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:08:41 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:50665 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhHGOIl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 7 Aug 2021 10:08:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Ghkhk51Mwz64;
        Sat,  7 Aug 2021 16:08:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1628345302; bh=UJWADItsCZvOOHDfxmRe0b1fjopiUgDTm+JjB8F5HJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp2nhN8NpuDYP4uteGkUuSpkP4vv+N4DhpiyL9637M/qD3bidIMbOBrAkA7yxaIx/
         bSkzz2EjtDKdnZD2m9yIBZxcDzss8R7Ic2K7vSGkM/0PrBVq8XM9nTFc6iYimaI9s7
         xwarzmPzgg5tFxPWaKXjgy/EPBsoBdIzNj0gRkawIKdLLG08VazzREG9XVO3fUnE0I
         tN5/dRxGGiduVO71NdMgaXbokbhbvzROp9q6eCbg1FbIZpefAudK/yGwHy/9HvOc2H
         7m98id/5kRlSmemIwUiqEL2cTtP/j/RFy9+nMfUMiHd7LTazgJ1gVMSpZwY4UH+Dni
         ihxzxnCDdLv/g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 7 Aug 2021 16:08:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v4 3/5] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
Message-ID: <YQ6T1d4VElzQclsX@qmqm.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <b343556a93c2741b502723f63af189283235bc9a.1627204633.git.mirq-linux@rere.qmqm.pl>
 <8c03b995-f449-8f12-a4cf-8fc4978f05c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c03b995-f449-8f12-a4cf-8fc4978f05c7@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 04, 2021 at 02:06:55PM +0300, Adrian Hunter wrote:
> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
> > Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.
> > This fixes real_div value that was calculated as 1 (meaning no division)
> > instead of 2 with the quirk enabled.
> > 
> > Cc: stable@kernel.vger.org
> > Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> 
> Notwithstanding comment below:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
[...]
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1903,9 +1903,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  
> >  		if (!host->clk_mul || switch_base_clk) {
> >  			/* Version 3.00 divisors must be a multiple of 2. */
> > -			if (host->max_clk <= clock)
> > +			if (host->max_clk <= clock) {
> >  				div = 1;
> > -			else {
> > +				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> > +					&& host->max_clk <= 25000000)
> 
> It is preferred to line break after '&&' and line up e.g.
> 
> 				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN) &&
> 				    host->max_clk <= 25000000)

This was just old code moved, but fixed for next version.

> 
> 
> > +					div = 2;
> > +			} else {
> >  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
> >  				     div += 2) {
> >  					if ((host->max_clk / div) <= clock)
> > @@ -1914,9 +1917,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  			}
> >  			real_div = div;
> >  			div >>= 1;
> > -			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> > -				&& !div && host->max_clk <= 25000000)
> > -				div = 1;
> >  		}
> >  	} else {
> >  		/* Version 2.00 divisors must be a power of 2. */
> > 
> 
