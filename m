From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
Date: Thu, 9 Feb 2012 02:12:14 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
 <m21uq52wk8.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:18153 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756511Ab2BICMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Feb 2012 21:12:19 -0500
In-Reply-To: <m21uq52wk8.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, February 08, 2012 11:07 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Jain Priyanka-
> B32167
> Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on p1010rdb
> 
> Hi,
> 
> On Wed, Feb 08 2012, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > SD card read was failing (data crc error)on some cards at
> > maximum possible frequency on P1010(CCB frequency set to 400MHz).
> > Some clock deviations are also observed at this frequency.
> > Hence reduced the mmc clock freq.
> >
> > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> > Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> 
> Thanks, just one comment below:
> 
> > ---
> > changes for v2:
> > 	- change the property to compatible for quirks
> > changes for v3:
> > 	- fix one compile error
> > changes for v4:
> > 	- use hooks to suspend/resume the special platform
> > changes for v5:
> > 	- add the Acked-by
> > changes for v6:
> > 	- move the workaround codes to special platform from header file
> > changes for v7:
> > 	- don't use quirks to check the platform support
> >
> >  drivers/mmc/host/sdhci-of-esdhc.c |   19 ++++++++++++++++++-
> >  1 files changed, 18 insertions(+), 1 deletions(-)
> >  drivers/mmc/host/sdhci-of-esdhc.c |   24 ++++++++++++++++++++++--
> >  1 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 2ef52f4..acac541 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -1,7 +1,7 @@
> >  /*
> >   * Freescale eSDHC controller driver.
> >   *
> > - * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
> > + * Copyright (c) 2007, 2010, 2012 Freescale Semiconductor, Inc.
> >   * Copyright (c) 2009 MontaVista Software, Inc.
> >   *
> >   * Authors: Xiaobo Xie <X.Xie@freescale.com>
> > @@ -14,6 +14,7 @@
> >   */
> >
> >  #include <linux/io.h>
> > +#include <linux/of.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/mmc/host.h>
> > @@ -114,6 +115,25 @@ static unsigned int esdhc_of_get_min_clock(struct
> sdhci_host *host)
> >  	return pltfm_host->clock / 256 / 16;
> >  }
> >
> > +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int
> clock)
> > +{
> > +	/* Workaround to reduce the clock frequency for p1010 esdhc */
> > +	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
> > +		if (clock == 0) {
> > +			host->clock = clock;
> > +			return;
> > +		}
> 
> Is this if (clock == 0) necessary?  You'll be calling esdhc_set_clock()
> immediately afterwards, and it performs the same test.

Yes, I perform this test two times.
The first time, I test the original value (as the parameter from set_clock)
The second time, I test it again, that is because the clock value has been changed or reduced,
I think it is necessary to test it again. 

Thanks
Jerry Huang

