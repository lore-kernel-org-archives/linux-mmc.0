From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] driver core: detach device's pm_domain after
 devres_release_all
Date: Tue, 29 Aug 2017 11:03:27 +0200
Message-ID: <20170829090327.GC25315@kroah.com>
References: <1502786217-212887-1-git-send-email-shawn.lin@rock-chips.com>
 <1502786217-212887-2-git-send-email-shawn.lin@rock-chips.com>
 <20170829064231.GE12198@kroah.com>
 <ebd40b1d-c4a2-7e39-2841-88e60edddafe@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdH2JDV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 05:03:21 -0400
Content-Disposition: inline
In-Reply-To: <ebd40b1d-c4a2-7e39-2841-88e60edddafe@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 29, 2017 at 04:08:52PM +0800, Shawn Lin wrote:
> Hi Greg,
> 
> On 2017/8/29 14:42, Greg Kroah-Hartman wrote:
> > On Tue, Aug 15, 2017 at 04:36:56PM +0800, Shawn Lin wrote:
> > > Move dev_pm_domain_detach after devres_release_all to avoid
> > > accessing device's registers with genpd been powered off.
> > 
> > So, what is this going to break that is working already today?  :)
> 
> Thanks for your comment!
> 
> The background of this patch is that:
> (1) Some SoCs, including Rockchips' SoCs, couldn't support
> accessing controllers' registers w/o clk and power domain enabled.
> (2) Many common drivers use devm_request_irq to request irq for either
> shared irq or non-shared irq.
> (3) So we rely on devres_release_all to free irq automatically.
> 
> So the actually race condition is:
> (1) Driver A probe failed or calling remove
> (2) power domain is detached right now
> (3) A irq triggerd cocurrently just before calling devm_irq_release..
> (4) Driver A's ISR read its register .. panic..

If a probe failed, the ISR should never be called, right?  So that
should not be an issue here.

> The issue is exposed by enabing CONFIG_DEBUG_SHIRQ. Thus devres_free_irq
> will try to call the ISR as it says: "It's a shared IRQ -- the driver
> ought to be prepared for an IRQ event to happen even now it's being
> freed". So it calls the driver's ISR w/o power domain enabled, which
> hangup the system... This is theoretically help folks to make the code
> robust enough to deal with shared case.
> 
> But, for no matter whether the irq is shared or non-shared, the race
> condition is there. So we possible have two choices that
> (1) Either using request_irq and free_irq directly
> (2) Or moving dev_pm_domain_detach after devres_release_all which
> makes sure we free the irq before powering off power domain.
> 
> However doesn't choice(1) imply that devm_request_irq shouldn't
> exist? :) So I try to fix it like what this patch does.

Ok, this makes a lot more sense, please put this kind of information in
the patch changelog when you resend it.

thanks,

greg k-h
