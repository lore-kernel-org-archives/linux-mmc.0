From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Thu, 14 Jun 2012 23:48:44 +0200
Message-ID: <201206142348.44804.rjw@sisk.pl>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <201206142137.26530.rjw@sisk.pl> <1786480.seckEUc993@avalon>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42861 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab2FNVn2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jun 2012 17:43:28 -0400
In-Reply-To: <1786480.seckEUc993@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Thursday, June 14, 2012, Laurent Pinchart wrote:
> Hi Rafael,
> 
> On Thursday 14 June 2012 21:37:26 Rafael J. Wysocki wrote:
> > On Thursday, June 14, 2012, Laurent Pinchart wrote:
> > > On Thursday 14 June 2012 20:12:33 Magnus Damm wrote:
> > > > On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart wrote:
> > > > > The tmio_mmc_set_ios() function configures the MMC power, clock and
> > > > > bus width. When the MMC controller gets powered off, runtime PM
> > > > > switches the MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT
> > > > > register afterwards fails and prints an error message to the kernel
> > > > > log.
> > > > > 
> > > > > As configuring the bus width is pointless when the interface gets
> > > > > powered down, skip the operation when power is off.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > First of all, thanks for reporting this issue and coming up with a fix!
> > > 
> > > You're welcome. You can expect more of them ;-)
> > > 
> > > > Can you please explain a bit more about when this triggers? Is this
> > > > related to suspend-to-ram perhaps? Which hardware platform? Is
> > > > CONFIG_PM_RUNTIME=y set?
> > > 
> > > I've noticed the problem on the Armadillo board with CONFIG_PM_RUNTIME=y.
> > > The driver spits out "timeout waiting for SD bus idle" error messages
> > > more or less continuously.
> > > 
> > > > I suspect that this may be a side effect of the current PM code used
> > > > on the A1 SoC (which is hooked up on the armadillo board).
> > > > 
> > > > In short, the A1 SoC does not yet make use of PM domains, but AP4 and
> > > > the mackerel board (sh7372 based) is using PM domains.
> > > 
> > > Does this mean that runtime PM is a no-op on A1 ? That would surprise me,
> > > as turning CONFIG_PM_RUNTIME off gets rid of the problem, so runtime PM
> > > is somehow involved. Even if the power domain does not get turned off,
> > > can't the MSTP clock be turned off ?
> > 
> > The problem is, most likely, that with CONFIG_PM_RUNTIME set the code in
> > drivers/sh/pm_runtime.c triggers and that causes default_pm_domain to be
> > used.
> > 
> > So, I don't really think we need to "fix" every driver in turn,
> > default_pm_domain seems to be what needs fixing.  I'm not exactly sure
> > how to fix it at the moment, though.
> 
> But isn't there still an issue in the driver itself ? If my understanding is 
> correct, calling pm_runtime_put() essentially means "I won't need to touch the 
> device from now on, it can be suspended it 
> needed/useful/appropriate/whatever". The runtime PM core is then free to turn 
> the power domain and/or clock off synchronously or with a delay, or do 
> nothing. After signaling that it won't need to touch the device, the driver 
> should really avoid touching the device until the next pm_runtime_get_sync() 
> call.

That's correct, the hardware shouldn't be touched after runtime suspend.

Thanks,
Rafael
