From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable
	case
Date: Thu, 16 Sep 2010 03:20:08 +0100
Message-ID: <20100916022008.GB7939@void.printf.net>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org> <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org> <4C7F65A1.60105@samsung.com> <20100902091424.GA12456@console-pimps.org> <4C86E672.1030807@samsung.com> <20100915151142.GB21538@console-pimps.org> <20100915203855.GA6620@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52660 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab0IPCUM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Sep 2010 22:20:12 -0400
Content-Disposition: inline
In-Reply-To: <20100915203855.GA6620@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@sa>

Hi Matt,

On Wed, Sep 15, 2010 at 09:38:55PM +0100, Chris Ball wrote:
> On Wed, Sep 15, 2010 at 04:11:42PM +0100, Matt Fleming wrote:
> > Chris, are you OK to pick this up (including Jaehoon's change)? Or
> > would you prefer me to resubmit?
> 
> Thanks, that's fine, I've applied both patches to mmc-next:

This (patch 2/2) doesn't resolve symbols properly, so I've dropped it:

  Building modules, stage 2.
  MODPOST 448 modules
ERROR: "mmc_assume_removable" [drivers/mmc/host/sdhci.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

There's no EXPORT_SYMBOL(mmc_assume_removable) in core/core.c, yet it's
being referenced in host/sdhci.c.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
