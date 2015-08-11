From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
Date: Tue, 11 Aug 2015 03:40:43 -0700
Message-ID: <20150811104043.GL4215@atomide.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
 <20150805104355.GE16878@atomide.com>
 <55C22524.5050304@ti.com>
 <20150806064821.GO16878@atomide.com>
 <55C4C46E.9080200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42800 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933875AbbHKKkr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Aug 2015 06:40:47 -0400
Content-Disposition: inline
In-Reply-To: <55C4C46E.9080200@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, mugunthanvnm@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [150807 07:48]:
> Hi,
> 
> On Thursday 06 August 2015 12:18 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [150805 08:03]:
> >> Hi,
> >>
> >> On Wednesday 05 August 2015 04:13 PM, Tony Lindgren wrote:
> >>> * Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
> >>>> Patch series implements voltage switching and tuning for omap_hsmmc
> >>>> driver.
> >>>>
> >>>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
> >>>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
> >>>
> >>> Your tests are missing omap3?
> >>
> >> I don't have one at my disposal :-( I'll try to find one and add omap3 tests.
> > 
> > Great :) Beagle xm is a good one to test the USB PHY stuff on
> > and also MMC. Having USB cable connected or EHCI loaded blocks the PM
> > though, so NFSroot is not very usable for testing on it.
> 
> I found a beagle xm. So I should be able to get back to this early next week.

OK great!

Thanks,

Tony
