From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 7 Dec 2011 02:23:59 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F116342A2@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com>
 <1323163107-32619-2-git-send-email-r66093@freescale.com>
 <4EDE06DA.7010108@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:42341
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751901Ab1LGCYB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Dec 2011 21:24:01 -0500
In-Reply-To: <4EDE06DA.7010108@yahoo.es>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>



> -----Original Message-----
> From: Hein_Tibosch [mailto:hein_tibosch@yahoo.es]
> Sent: Tuesday, December 06, 2011 8:13 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
> Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
> 
> Hi Jerry,
> 
> On 12/6/2011 5:18 PM, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > When f_init is zero, the SDHC can't work correctly. So f_min will
> > replace f_init, when f_init is zero.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> > 	- add the CC
> >
> >  drivers/mmc/core/core.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > a08e6b1..2d40c04 100644
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
> 
> Are you sure f_min can have a value of zero?
> It should have been set mmc_rescan_try_freq(), when trying a list of
> frequencies: 400000, 300000, 200000, 100000
> 
But, mmc_power_up is called not only by mmc_rescan_try_freq, so the value of f_init may be zero.

