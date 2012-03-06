From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] tmio_mmc / PM: Use PM QoS requests, v2
Date: Tue, 6 Mar 2012 22:07:38 +0100
Message-ID: <201203062207.38583.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042056.20707.rjw@sisk.pl> <Pine.LNX.4.64.1203061038050.9300@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58519 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031094Ab2CFVDc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Mar 2012 16:03:32 -0500
In-Reply-To: <Pine.LNX.4.64.1203061038050.9300@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Tuesday, March 06, 2012, Guennadi Liakhovetski wrote:
> On Sun, 4 Mar 2012, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make tmio_mmc populate the pm_qos member of struct mmc_host, to
> > let the core know that it should create the pm_latency_limit_ms
> > host attribute for it, and set the default value of that attribute
> > to 100 ms.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/mmc/host/tmio_mmc_pio.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > Index: linux/drivers/mmc/host/tmio_mmc_pio.c
> > ===================================================================
> > --- linux.orig/drivers/mmc/host/tmio_mmc_pio.c
> > +++ linux/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -918,6 +918,12 @@ int __devinit tmio_mmc_host_probe(struct
> >  	if (ret < 0)
> >  		goto pm_disable;
> >  
> > +	mmc->pm_qos = kzalloc(sizeof(*mmc->pm_qos), GFP_KERNEL);
> 
> Why don't you just add pm_qos to struct tmio_mmc_host?

Because the core has to see it.

> > +	if (mmc->pm_qos)
> > +		mmc->pm_qos->val = 100;
> 
> 100ms... that seems way too long for me, wouldn't that allow the 
> runtime-pm to power down and up the domain on each request?...

That should be 100 us, sorry for the confusion.

Thanks,
Rafael
