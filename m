From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] mmc: omap_hsmmc: Fix context save and restore for
 DT
Date: Sat, 8 Jun 2013 08:02:03 -0700
Message-ID: <20130608150203.GQ3331@atomide.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214950.18581.56829.stgit@localhost>
 <20130608042553.GB20238@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59317 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751680Ab3FHPCH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Jun 2013 11:02:07 -0400
Content-Disposition: inline
In-Reply-To: <20130608042553.GB20238@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Andreas Fenkart <afenkart@gmail.com>

* Felipe Balbi <balbi@ti.com> [130607 21:32]:
> Hi,
> 
> On Fri, Jun 07, 2013 at 02:49:50PM -0700, Tony Lindgren wrote:
> > We want to get rid of the omap specific platform init code
> > callbacks as they don't play nice with device tree.
> 
> right, any plans to have similar functionality generically ? Maybe
> something like:
> 
> probe()
> {
> 	...
> 
> 	/*
> 	 * tell PM runtime layer that we can handle runtime
> 	 * power gating of this device in certain conditions.
> 	 *
> 	 * Actual power gating will be triggered depending on
> 	 * PM QoS wakeup requirements.
> 	 */
> 	pm_runtime_enable_power_gating(dev);
> 
> 	...
> }
> 
> runtime_suspend()
> {
> 	if (pm_runtime_will_power_gate(dev))
> 		save_context();
> }
> 
> runtime_resume()
> {
> 	if (pm_runtime_has_lost_power(dev))
> 		restore_context();
> }
> 
> ???

Yes some kind of generic approach is needed too, at least for some
drivers. The above API makes sense to me, sounds like you might
have a PM runtime patch coming along those lines?
 
> > Let's convert the context loss check to be based on a
> > register state detection instead.
> 
> that might not work always. Specially when you consider that default
> register values can change on every silicon release. I guess the above
> might be a bit nicer, although a lot more work :-p

These are not revision registers, here the driver configured values
are saved in PM runtime suspend, and then restored in resume.
We are already doing the same for GPIO for example. In these cases the
context loss count is not needed AFAIK.

With some hardware it is of course possible that the power cycle is so
short that the hardare is stuck in a limbo state and for those cases
keeping track of the context loss via PM runtime.

Regards,

Tony
