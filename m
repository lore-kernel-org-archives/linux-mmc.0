From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Fri, 13 Jan 2012 11:26:30 +0800
Message-ID: <20120113032628.GA7564@ladygaga>
References: <1323399230-29118-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692B2@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:28160
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901Ab2AMD0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2012 22:26:44 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F116692B2@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi,

On Fri, Jan 13, 2012 at 02:24:46AM +0000, Huang Changming-R66093 wrote:
> Hi, Chris,
> Could you have any comment about this patch?
> Can it go into 3.3 or 3.4?
> 
> > -----Original Message-----
> > From: Huang Changming-R66093
> > Sent: Friday, December 09, 2011 10:54 AM
> > To: linux-mmc@vger.kernel.org
> > Cc: Huang Changming-R66093; Chris Ball
> > Subject: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
> > 
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > 
> > When f_init is zero, the SDHC can't work correctly. So f_min will replace
> > f_init, when f_init is zero.

What about setting f_init before your call to mmc_power_up?

> > 
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> > 	- add the CC
> > changes for v3:
> > 	- enalbe the controller clock in platform, instead of core
> > 
> >  drivers/mmc/core/core.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index a08e6b1..2d40c04 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1253,7 +1253,10 @@ static void mmc_power_up(struct mmc_host *host)
> >  	 */
> >  	mmc_delay(10);
> > 
> > -	host->ios.clock = host->f_init;
> > +	if (host->f_init)
> > +		host->ios.clock = host->f_init;
> > +	else
> > +		host->ios.clock = host->f_min;
> > 
> >  	host->ios.power_mode = MMC_POWER_ON;
> >  	mmc_set_ios(host);
> > --
> > 1.7.5.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

