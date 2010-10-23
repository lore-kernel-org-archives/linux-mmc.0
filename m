From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Sat, 23 Oct 2010 16:18:50 +0200
Message-ID: <1287843531.29752.10.camel@maxim-laptop>
References: <1286788315.3101.11.camel@sven>
	 <1286955116-22793-1-git-send-email-ohad@wizery.com>
	 <1287704855.12734.14.camel@maxim-laptop>
	 <AANLkTi=iC1uKyToEXrroOj+JxQ2mW97WRVEXjv+9oQEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64463 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab0JWOS7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Oct 2010 10:18:59 -0400
In-Reply-To: <AANLkTi=iC1uKyToEXrroOj+JxQ2mW97WRVEXjv+9oQEa@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, libertas-dev@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org

On Sat, 2010-10-23 at 12:09 +0200, Ohad Ben-Cohen wrote:
> Hi Maxim,
> 
> On Fri, Oct 22, 2010 at 1:47 AM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > On Wed, 2010-10-13 at 09:31 +0200, Ohad Ben-Cohen wrote:
> >> Fix SDIO suspend/resume regression introduced by
> >> 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e "mmc: fix all hangs related to
> >> mmc/sd card insert/removal during suspend/resume":
> ...
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index c94565d..515ff39 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
> >>       if (host->bus_ops && !host->bus_dead) {
> >>               if (host->bus_ops->suspend)
> >>                       err = host->bus_ops->suspend(host);
> >> +             if (err == -ENOSYS || !host->bus_ops->resume) {
> > This reintroduces the bug I fixed.
> >
> > if the CONFIG_MMC_UNSAFE_RESUME isn't set (and that is default
> > unfortunately), the host->bus_ops->resume will be NULL (see core/mmc.c
> > mmc_ops), and therefore card will be removed, that will trigger a block
> > device removal, sync, and deadlock).
> 
> Have you reproduced this or is it just a general concern ?
Only a general concern.
> 
> I'm asking this because if CONFIG_MMC_UNSAFE_RESUME isn't set, then
> mmc_pm_notify() will remove the card and detach the bus.
> 
> As a result, host->bus_ops will be unset, and host->bus_dead will be set.
> 
> In this case, mmc_suspend_host() should skip the code you are concerned about.
You are right here.
There is a very unlikely case that suspend of sd/mmc card fails (with
CONFIG_MMC_UNSAFE_RESUME set, and that will trigger the hang, but that
currently isn't possible because both mmc_sd_suspend and mmc_suspend
just return 0 unconditionally).

Btw, two above functions are identical, so some refactoring won't hurt.

So sorry for noise (and bug).

Best regards,
	Maxim Levitsky



