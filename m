From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 10:52:01 -0800
Message-ID: <20160211185201.GX19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
 <20160211150806.GS19432@atomide.com>
 <20160211155255.GA1953@sirena.org.uk>
 <20160211173620.GU19432@atomide.com>
 <20160211183640.GB1953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33755 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcBKSwG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2016 13:52:06 -0500
Content-Disposition: inline
In-Reply-To: <20160211183640.GB1953@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Wolfram Sang <wsa@the-dreams.de>

* Mark Brown <broonie@kernel.org> [160211 10:38]:
> On Thu, Feb 11, 2016 at 09:36:20AM -0800, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [160211 07:54]:
> 
> > > This does sound like there's been a change in the interface compared to
> > > what users are actually doing - is this an actual problem or is it just
> > > a divergence from docs?
> 
> > It's an actual problem at least on omaps as the omap_device code
> > is very picky about the hardware state.
> 
> > Depending how the PM runtime is implemented, it may be a problem
> > for some other cases too.
> 
> Or people just aren't testing mainline that well (if this is broken in
> v4.5 that suggests nobody noticed in -next) - do you know when this
> broke?  It really seems like we may need to spin round on how this is
> deployed.

I noticed it only with v4.5-rc1 and bisected it to commit 5de85b9d57ab
("PM / runtime: Re-init runtime PM states at probe error and driver
unbind") as it broke my PM tests for n900. For Linux next probably
was also broken for before that for some time.

Unfortunately based on the regressions I'm chasing every merge window
I'm suspecting that very few people are actually testing PM runtime
with mainline Linux kernel. Or they don't have the PM runtime fully
implemented in the mainline kernel for their devices. This is at
least for the SoC PM use case.

Ulf is working on a generic PM runtime test driver :) I'm hoping we
can then use that for basic regression testing on in an arch
independent way.

Regards,

Tony

