From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Convert MMC subsys drivers to dev_pm_ops
Date: Sat, 22 Aug 2009 11:24:57 +0200
Message-ID: <200908221124.57585.marek.vasut@gmail.com>
References: <200908220223.50588.marek.vasut@gmail.com> <20090822082559.GA6562@console-pimps.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59644 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZHVJZU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Aug 2009 05:25:20 -0400
In-Reply-To: <20090822082559.GA6562@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, mirq-linux@rere.qmqm.pl, linux-kernel@vger.kernel.org, manuel.lauss@gmail.com, ppisa@pikron.com, nico@cam.org, maen@marvell.com, s.hauer@pengutronix.de, tony@atomide.com, madhu.cr@ti.com, drzeus@drzeus.cx, ben-linux@fluff.org, avorontsov@ru.mvista.com, pierre@ossman.eu, sdhci-devel@lists.ossman.eu, saschasommer@freenet.de, oakad@yahoo.com, ian@mnementh.co.uk, HaraldWelte@viatech.com, JosephChan@via.com.tw, linux-mmc@vger.kernel.org

Dne So 22. srpna 2009 10:27:37 Matt Fleming napsal(a):
> (Adding linux-mmc@vger.kernel.org to the CC list)
>
> On Sat, Aug 22, 2009 at 02:23:50AM +0200, Marek Vasut wrote:
> > Hi,
> >
> > This converts most of the drivers found in drivers/mmc/host to
> > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > in some cases.
> >
> > This needs testing, so I'd be very glad if the affected maintainers
> > expressed their opinion on this.
> >
> > Cheers!
> >
> > From 66978eef1d2bd64222901f0b6c6d9c35dcca044e Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Sat, 22 Aug 2009 02:10:27 +0200
> > Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
> >
> > This converts most of the drivers found in drivers/mmc/host to
> > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > in some cases.
Hi.

it might be actually better if you fixed your platforms and submitted the 
patches independently as it seems you have better understanding of the 
hardware you maintain ;-)

Cheers!
