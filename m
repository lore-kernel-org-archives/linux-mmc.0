From: Nishanth Menon <nm@TI.COM>
Subject: Re: [PATCH] mmc: omap_hsmmc: use for OMAP5 as well
Date: Mon, 8 Jul 2013 14:58:28 -0500
Message-ID: <20130708195828.GA28218@kahuna>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <51CDB260.8080108@ti.com>
 <20130707201309.GA5429@localhost>
 <20130708074606.GD16635@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33977 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab3GHT6e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jul 2013 15:58:34 -0400
Content-Disposition: inline
In-Reply-To: <20130708074606.GD16635@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@TI.COM>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Balaji T K <balajitk@TI.COM>, a-bindra@TI.COM, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org

On 10:46-20130708, Felipe Balbi wrote:
> On Sun, Jul 07, 2013 at 05:13:10PM -0300, Ezequiel Garcia wrote:
> > Hi guys,
> > 
> > On Fri, Jun 28, 2013 at 09:27:20PM +0530, Balaji T K wrote:
> > > On Friday 28 June 2013 06:04 PM, a-bindra@ti.com wrote:
> > > > From: Amarinder Bindra <a-bindra@ti.com>
> > > >
> > > > OMAP's hs_mmc driver is also used for OMAP5 MMC controller operation.
> > > > Considering that the device tree entries are already there for this,
> > > > allow the driver to be built when only OMAP5 is enabled.
> > > > This allows MMC root filesystems to be available in "OMAP5 only"
> > > > configurations.
> > > >
> > > > Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> > > > Acked-by: Felipe Balbi <balbi@ti.com>
> > > > Acked-by: Nishanth Menon <nm@ti.com>
> > > 
> > > Looks good to me,
> > > Acked-by: Balaji T K <balajitk@ti.com>
> > > 
> > 
> > I came across this same issue while trying MMC patches on AM3xx,
> > which is nor OMAP3 neither OMAP4.
> > 
> > Now, looking at the driver I don't see any OMAP-specific bits
> > (welcome to the multiplatform world ;-) so I think we can just
> > remove the 'depends' line. Something like this:
> 
> frankly speaking, this driver should be deleted and all users should be
> moved to sdhci. OMAP's HSMMC controller is compatible with SDHCI except
> for a couple quirks which can be easily worked around.
Do we take that as a NAK to this specific patch?

I am not complaining about the future migration to a solution that is
much more generic and scalable, but having fixes for current problems
should'nt be ignored IMHO.

How about a depends on CONFIG_ARCH_OMAP2PLUS instead? will that solve
our pains with all OMAP2+ usin this?
-- 
Regards,
Nishanth Menon
