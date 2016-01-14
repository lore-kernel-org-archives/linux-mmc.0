From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 08:49:51 -0800
Message-ID: <20160114164950.GN12777@atomide.com>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
 <569796EE.7030506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55337 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbcANQtz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Jan 2016 11:49:55 -0500
Content-Disposition: inline
In-Reply-To: <569796EE.7030506@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, pali.rohar@gmail.com, pavel@ucw.cz, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, nsekhar@ti.com

* Kishon Vijay Abraham I <kishon@ti.com> [160114 04:39]:
> On Thursday 14 January 2016 05:37 PM, Sebastian Reichel wrote:
> > 
> > Is there a good reason against adding "depends on REGULATOR_PBIAS"
> > to MMC_OMAP_HS? I guess it's required for most systems and the regulator
> > driver is just 250 loc. I am aware, that this will disable the
> > hsmmc driver for 'make oldconfig', but I guess that will be noticed
> > in a similar way your warning is noticed.
> 
> hmm.. only MMC1 requires PBIAS so I'm not sure if it's okay to add depends on
> REGULATOR_PBIAS for the HSMMC driver as such. And as you said it'll also
> disable the hsmmc driver if oldconfig is used. But do we get a warning?

Adding depends there is a bit wrong, many designs are not using MMC1
but use eMMC on the other controllers instead. I think the runtime
warning is best we can do here to keep things modular.

Regards,

Tony
