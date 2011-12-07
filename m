From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/5 v2] MMC/core: Make sure the power is up, when detect
 the card
Date: Wed, 7 Dec 2011 02:26:31 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F116342BA@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com>
 <4EDE06C4.2060303@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:56954
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751901Ab1LGC0g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Dec 2011 21:26:36 -0500
In-Reply-To: <4EDE06C4.2060303@yahoo.es>
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
> Subject: Re: [PATCH 1/5 v2] MMC/core: Make sure the power is up, when
> detect the card
> 
> Hi Jerry,
> 
> On 12/6/2011 5:18 PM, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Before running get_cd() recall function to detect whether the card is
> > present, must make sure the power is up.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> > 	- add the CC
> >
> >  drivers/mmc/core/core.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > 5278ffb..a08e6b1 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2066,8 +2066,10 @@ void mmc_rescan(struct work_struct *work)
> >  	 */
> >  	mmc_bus_put(host);
> >
> > +	mmc_power_up(host);
> 
> If get_cd is not defined, a power-up for sure isn't necessary:
> 
> >  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
> >  		goto out;
> 
> Did you intent to leave it powered-up in case get_cd() fails?
> 
En, it is one bug, I will fix it

