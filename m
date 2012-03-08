From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] sh_mmcif / PM: Use PM QoS latency constraint
Date: Thu, 8 Mar 2012 22:29:40 +0100
Message-ID: <201203082229.41042.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203080030.28965.rjw@sisk.pl> <20120308110335.GF3638@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34369 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404Ab2CHVZi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 16:25:38 -0500
In-Reply-To: <20120308110335.GF3638@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Kevin Hilman <khilman@ti.com>

On Thursday, March 08, 2012, Mark Brown wrote:
> On Thu, Mar 08, 2012 at 12:30:28AM +0100, Rafael J. Wysocki wrote:
> 
> > +	dev_pm_qos_hide_latency_limit(&pdev->dev);
> > +
> 
> Shouldn't the core be able to cope with cleaning things up by itself
> here?  It seems like it'd be easier/less error prone to do that.

Yes, I think this is a fairly reasonable expectation. :-)
