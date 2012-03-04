From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] MMC / PM: Make it possible to use PM QoS latency constraints
Date: Sun, 4 Mar 2012 20:47:13 +0100
Message-ID: <201203042047.13702.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203040102.39253.rjw@sisk.pl> <CACRpkdb-1vh6VmK95AsFuLT-3CG-gdXO-NixPiiHm8o5AtgPCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54380 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336Ab2CDTnJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Mar 2012 14:43:09 -0500
In-Reply-To: <CACRpkdb-1vh6VmK95AsFuLT-3CG-gdXO-NixPiiHm8o5AtgPCQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>

On Sunday, March 04, 2012, Linus Walleij wrote:
> On Sun, Mar 4, 2012 at 1:02 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > A runtime suspend of an MMC controller belonging to a power domain
> > or, in a more complicated scenario, a runtime suspend of another
> > device in the same power domain, may cause power to be removed from
> > the entire domain.  In that case, the amount of time necessary to
> > runtime-resume the MMC controller is often substantially greater
> > than the time needed to enable its clock.  That may hurt performance
> > in some situations, because user data may need to wait for the
> > controller to become operational, so we should make it possible to
> > prevent that from happening.
> >
> > For this reason, introduce a new sysfs attribute for MMC hosts,
> > pm_latency_limit_ms, allowing user space to specify the upper bound
> > of the time necessary to bring the host up after it has been
> > runtime-suspended.  However, make it appear ony for the hosts whose
> > drivers declare support for PM QoS by populating the pm_qos_req
> > member of struct mmc_host before registering the host.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Overall I've already ACKed this I think, looking good...
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

I have a new version, though, (will be sent in a while), but hopefully
your ACK will still apply. :-)

Rafael
