From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] drivercore: add new error value for deferred probe
Date: Fri, 7 Oct 2011 11:00:22 +0100
Message-ID: <20111007100022.GB19080@opensource.wolfsonmicro.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
 <1317963790-29426-2-git-send-email-manjugk@ti.com>
 <20111007064349.GD27508@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34362 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752039Ab1JGKAY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 06:00:24 -0400
Content-Disposition: inline
In-Reply-To: <20111007064349.GD27508@kroah.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Dilan Lee <dilee@nvidia.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Oct 06, 2011 at 11:43:49PM -0700, Greg KH wrote:
> On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wrote:

> > +#define EPROBE_DEFER	517	/* restart probe again after some time */

> Can we really do this?  Isn't this some user/kernel api here?

> What's wrong with just "overloading" on top of an existing error code?
> Surely one of the other 516 types could be used here, right?

There was some discussion of this in the previous patch round before the
code was changed - it does end up adding an externally visible error
code but it doesn't really make any difference, especially if we don't
propagate it externally.  We've already got some other codes in a
similar style, though I can't remember the examples that were quoted
offhand.  Adding the new code avoids confusion about exactly what the
intent of the driver is.
