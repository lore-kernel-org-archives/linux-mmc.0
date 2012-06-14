From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Thu, 14 Jun 2012 21:37:26 +0200
Message-ID: <201206142137.26530.rjw@sisk.pl>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com> <1538938.WjgJgiBpYR@avalon>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42706 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab2FNTcI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jun 2012 15:32:08 -0400
In-Reply-To: <1538938.WjgJgiBpYR@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Thursday, June 14, 2012, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Thursday 14 June 2012 20:12:33 Magnus Damm wrote:
> > On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart wrote:
> > > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > > width. When the MMC controller gets powered off, runtime PM switches the
> > > MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> > > fails and prints an error message to the kernel log.
> > > 
> > > As configuring the bus width is pointless when the interface gets
> > > powered down, skip the operation when power is off.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > First of all, thanks for reporting this issue and coming up with a fix!
> 
> You're welcome. You can expect more of them ;-)
> 
> > Can you please explain a bit more about when this triggers? Is this
> > related to suspend-to-ram perhaps? Which hardware platform? Is
> > CONFIG_PM_RUNTIME=y set?
> 
> I've noticed the problem on the Armadillo board with CONFIG_PM_RUNTIME=y. The 
> driver spits out "timeout waiting for SD bus idle" error messages more or less 
> continuously.
> 
> > I suspect that this may be a side effect of the current PM code used
> > on the A1 SoC (which is hooked up on the armadillo board).
> > 
> > In short, the A1 SoC does not yet make use of PM domains, but AP4 and
> > the mackerel board (sh7372 based) is using PM domains.
> 
> Does this mean that runtime PM is a no-op on A1 ? That would surprise me, as 
> turning CONFIG_PM_RUNTIME off gets rid of the problem, so runtime PM is 
> somehow involved. Even if the power domain does not get turned off, can't the 
> MSTP clock be turned off ?

The problem is, most likely, that with CONFIG_PM_RUNTIME set the code in
drivers/sh/pm_runtime.c triggers and that causes default_pm_domain to be
used.

So, I don't really think we need to "fix" every driver in turn,
default_pm_domain seems to be what needs fixing.  I'm not exactly sure
how to fix it at the moment, though.

You can verify if my suspicion is correct quite easily by replacing the
(&default_pm_domain) in drivers/sh/pm_runtime.c with NULL.

Thanks,
Rafael
