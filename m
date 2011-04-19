From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 00:59:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104200030370.16641@axis700.grange>
References: <Pine.LNX.4.44L0.1104191015340.1835-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58387 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1DSW7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 18:59:35 -0400
In-Reply-To: <Pine.LNX.4.44L0.1104191015340.1835-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

Thanks to all for clarifications. Since everyone is convinced, that that 
idle function in mmc bus.c is appropriate, I restored it and managed to 
achieve my goals also without it by adjusting the platform runtime pm and 
power domain prototype support.

But I still need those "cheating" calls to

	pm_runtime_put_noidle(&pdev->dev);
and
	pm_runtime_get_noresume(&pdev->dev);

in the sh_mmcif.c driver. If I use the patch as posted at

http://article.gmane.org/gmane.linux.ports.sh.devel/10724

but without those two calls, and load and unload the driver, while a card 
is plugged in, unloading the driver doesn't power down the interface, 
because the usage_count == 1 also after the kernel has soft-ejected the 
card

mmc0: card 0001 removed

With my put_noidle() / get_noresume() hack all cases of modprobe / rmmod, 
card insert / eject work correctly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
