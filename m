From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Wed, 7 Oct 2015 08:52:06 -0700
Message-ID: <20151007155206.GX23801@atomide.com>
References: <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56521 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbbJGPwK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Oct 2015 11:52:10 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Ulf Hansson <ulf.hansson@linaro.org> [151007 06:46]:
> On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
> >> > Good idea, how about something like the following? AFAIK that's the
> >> > only .config option needed as MFD_SYSCON is selected by Kconfig
> >> > already.
> 
> Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
> selected when omap_hsmmc is being used?
> 
> It seems like that should also be a patch for the rc, right!?

Well selecting CONFIG_REGULATOR is still optional and force selecting
drivers usually leads into randconfig build issues sooner or later.
And we'd like to make everything into loadable modules eventually.

We could print a warning during MMC1 probe if REGULATOR_PBIAS
is not selected and attempt to continue probing?

Regards,

Tony
