From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Thu, 14 Jun 2012 22:34:01 +0200
Message-ID: <1786480.seckEUc993@avalon>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <1538938.WjgJgiBpYR@avalon> <201206142137.26530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201206142137.26530.rjw@sisk.pl>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Rafael,

On Thursday 14 June 2012 21:37:26 Rafael J. Wysocki wrote:
> On Thursday, June 14, 2012, Laurent Pinchart wrote:
> > On Thursday 14 June 2012 20:12:33 Magnus Damm wrote:
> > > On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart wrote:
> > > > The tmio_mmc_set_ios() function configures the MMC power, clock and
> > > > bus width. When the MMC controller gets powered off, runtime PM
> > > > switches the MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT
> > > > register afterwards fails and prints an error message to the kernel
> > > > log.
> > > > 
> > > > As configuring the bus width is pointless when the interface gets
> > > > powered down, skip the operation when power is off.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > First of all, thanks for reporting this issue and coming up with a fix!
> > 
> > You're welcome. You can expect more of them ;-)
> > 
> > > Can you please explain a bit more about when this triggers? Is this
> > > related to suspend-to-ram perhaps? Which hardware platform? Is
> > > CONFIG_PM_RUNTIME=y set?
> > 
> > I've noticed the problem on the Armadillo board with CONFIG_PM_RUNTIME=y.
> > The driver spits out "timeout waiting for SD bus idle" error messages
> > more or less continuously.
> > 
> > > I suspect that this may be a side effect of the current PM code used
> > > on the A1 SoC (which is hooked up on the armadillo board).
> > > 
> > > In short, the A1 SoC does not yet make use of PM domains, but AP4 and
> > > the mackerel board (sh7372 based) is using PM domains.
> > 
> > Does this mean that runtime PM is a no-op on A1 ? That would surprise me,
> > as turning CONFIG_PM_RUNTIME off gets rid of the problem, so runtime PM
> > is somehow involved. Even if the power domain does not get turned off,
> > can't the MSTP clock be turned off ?
> 
> The problem is, most likely, that with CONFIG_PM_RUNTIME set the code in
> drivers/sh/pm_runtime.c triggers and that causes default_pm_domain to be
> used.
> 
> So, I don't really think we need to "fix" every driver in turn,
> default_pm_domain seems to be what needs fixing.  I'm not exactly sure
> how to fix it at the moment, though.

But isn't there still an issue in the driver itself ? If my understanding is 
correct, calling pm_runtime_put() essentially means "I won't need to touch the 
device from now on, it can be suspended it 
needed/useful/appropriate/whatever". The runtime PM core is then free to turn 
the power domain and/or clock off synchronously or with a delay, or do 
nothing. After signaling that it won't need to touch the device, the driver 
should really avoid touching the device until the next pm_runtime_get_sync() 
call.

> You can verify if my suspicion is correct quite easily by replacing the
> (&default_pm_domain) in drivers/sh/pm_runtime.c with NULL.

-- 
Regards,

Laurent Pinchart

