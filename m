From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Fri, 13 Jan 2012 03:39:53 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1166942B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323399230-29118-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692B2@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113032628.GA7564@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:24220
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab2AMDj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 22:39:58 -0500
In-Reply-To: <20120113032628.GA7564@ladygaga>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>



> -----Original Message-----
> From: Aaron Lu [mailto:aaron.lu@amd.com]
> Sent: Friday, January 13, 2012 11:27 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Chris Ball
> Subject: Re: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
> 
> Hi,
> 
> On Fri, Jan 13, 2012 at 02:24:46AM +0000, Huang Changming-R66093 wrote:
> > Hi, Chris,
> > Could you have any comment about this patch?
> > Can it go into 3.3 or 3.4?
> >
> > > -----Original Message-----
> > > From: Huang Changming-R66093
> > > Sent: Friday, December 09, 2011 10:54 AM
> > > To: linux-mmc@vger.kernel.org
> > > Cc: Huang Changming-R66093; Chris Ball
> > > Subject: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
> > >
> > > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > >
> > > When f_init is zero, the SDHC can't work correctly. So f_min will
> > > replace f_init, when f_init is zero.
> 
> What about setting f_init before your call to mmc_power_up?
f_init is initialized only by mmc_rescan_try_freq, and mmc_power_up will use it.
But mmc_power_up will called not only by mmc_rescan_try_freq, but also by other functions.
You will see it in my previous email about it.

