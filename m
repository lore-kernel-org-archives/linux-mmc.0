From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] mmc: add functions to enable/disable aggressive
 clock gating
Date: Wed, 17 Aug 2011 15:19:14 +0300
Message-ID: <20110817121914.GW16790@intel.com>
References: <e13e177c732ee8ad2d6fe389c9bac21877f60c59.1313400777.git.mika.westerberg@linux.intel.com>
 <CACRpkdZ5oCmRupNn9HjZj534zXJQWD8OpycpMxG4Jhgsvk=kEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6689 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1HQMSl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Aug 2011 08:18:41 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZ5oCmRupNn9HjZj534zXJQWD8OpycpMxG4Jhgsvk=kEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org

On Wed, Aug 17, 2011 at 09:51:31AM +0200, Linus Walleij wrote:
> 
> I would suggest that in all patches using these functions, try
> to replace:
> 
> mmc_host_clk_disable() -> mmc_host_clk_ungate()
> mmc_host_clk_enable() -> mmc_host_clk_gate()
> 

Wow, that is indeed *much* cleaner way of doing this!

One thing is that if I call these from those ios functions,
mmc_host_clk_ungate() will always try to restore the clock
even if there is really no need. Do you see this as a problem?

> Please tell us if this works!

Certainly. I'll try this overnight and see whether it works.

> I understand that the names can be a bit confusing by but
> I think you can convince yourself that what this will do is
> simply increase the refcount host->clk_requests so the
> clock is not gated across these sections.
> 
> If you think the names of the functions are confusing then
> you may rename them, say like this:
> 
> mmc_host_clk_ungate() -> mmc_host_clk_hold()
> mmc_host_clk_gate() -> mmc_host_clk_release()
> 
> Which would make the usecases more clear, I'd be happy
> to ACK a patch for this.

I agree, I'll cook a patch for that also.

Thanks for the comments.
