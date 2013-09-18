From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: get rid of ti,non-removable
Date: Wed, 18 Sep 2013 11:58:19 -0700
Message-ID: <20130918185818.GC9994@atomide.com>
References: <cover.1379066249.git.nsekhar@ti.com>
 <20130913153732.GO7189@atomide.com>
 <5236F8BC.1000305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40850 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751807Ab3IRS6Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Sep 2013 14:58:25 -0400
Content-Disposition: inline
In-Reply-To: <5236F8BC.1000305@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Benoit Cousson <bcousson@baylibre.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Device Tree Mailing List <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>

* Sekhar Nori <nsekhar@ti.com> [130916 05:33]:
> On Friday 13 September 2013 09:07 PM, Tony Lindgren wrote:
> > * Sekhar Nori <nsekhar@ti.com> [130913 03:18]:
> >> Get rid of TI specific binding ti,non-removable in favour of the
> >> generic binding present for the same purpose.
> > 
> > Looks like there's a different handling in the MMC driver
> > for no_regulator_off_init that's needed for eMMC. That needs to
> > be sorted out and tested first.
> 
> Okay. I couldn't really get the eMMC on my board to detect, but
> apparently Koen has been able to get it to work. I am not really deep
> into details of HSMMC driver so will check with Balaji on what needs to
> be done here.

I think the issue is that until we have a SCM driver module setting
up the PBIAS register as a regulator, eMMC cards won't work without
ti,non-removable.
 
> >> This patch set does not support the old binding anymore. So, yes,
> >> it does introduce an ABI breakage. IMHO, it is not really worth
> >> supporting both bindings ATM since DT-usage in OMAP is still very
> >> nascent and almost always DTB and uImage are upgraded together.
> > 
> > The old bindings must be supported. It's not like we can just drop
> > them. We should just keep the old binding and parse it the same way
> > as the generic binding. That's a minimal amount of code.
> 
> Yes, its minimal amount of code but its code that will very likely never
> get exercised in future because of the reasons I mentioned above. I fear
> in time we will accumulate a lot of unused code this way.

Hey it's an ABI :)
 
> Anyway, since you don't feel its okay to remove the old binding, I will
> go ahead and mark the old binding as deprecated. But perhaps we can
> come-up with some time frame within which users of old .dtb can upgrade
> their .dtb or consider never upgrading to a newer kernel? This sounds
> eerily similar to feature-removal-schedule.txt and yeah I am aware of
> what happened to that. But I still put it here since this problem of DTB
> compatibility is not going to go away.

But before doing that, we first must fix the issue for still
needing ti,non-removable.
 
> One thing that might help is a kernel configuration that does not
> support deprecated bindings so users of old dtbs can actually see what
> deprecated bindings they are using. This way they can probably plan for
> a dtb upgrade better. So in driver you would do something like:
> 
> 	if (of_support_deprecated_bindings() &&
> 	    of_find_property(np, "ti,non-removable", NULL)) {
> 		.. do something ..
> 	}
> 
> of_support_deprecated_bindings() would return based on a config option.

Hmm yeah maybe that should be discussed separately on the
device tree mailing list.

Regards,

Tony
