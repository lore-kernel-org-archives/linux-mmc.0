From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Wed, 20 Apr 2011 22:06:14 +0200
Message-ID: <201104202206.14240.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1104201104230.2159-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39498 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1DTUFu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 16:05:50 -0400
In-Reply-To: <Pine.LNX.4.44L0.1104201104230.2159-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

[Added linux-pm to the CC list.]

On Wednesday, April 20, 2011, Alan Stern wrote:
> On Wed, 20 Apr 2011, Guennadi Liakhovetski wrote:
...
> Ah, now I see the problem.  It looks like we did not give sufficient
> thought to the case where a device starts off (and therefore should
> finish up) in a powered-down state.  Calling pm_runtime_put_sync()
> after unbinding the device driver seems a little futile -- with no
> driver, the subsystem may not be able to power-down the device!
> 
> Rafael, how do you think we should handle this?  Get rid of the 
> pm_runtime_get_no_resume() and pm_runtime_put_sync() calls in 
> dd.c:__device_release_driver()?

I think we need pm_runtime_barrier() in there.  Otherwise we risk
removing the driver while there's a runtime PM request pending.

But we can move the pm_runtime_put_sync() before driver_sysfs_remove().

Would that help?

Rafael
