From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 1/3]Add erase timeout calculation routine for sdhci
 host
Date: Thu, 11 Nov 2010 18:01:23 +0800
Message-ID: <5D8008F58939784290FAB48F549751982EF72ADA59@shsmsx502.ccr.corp.intel.com>
References: <20101111090519.GB18170@intel.com>
 <20101111093341.GA3131@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10923 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351Ab0KKKBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 05:01:31 -0500
In-Reply-To: <20101111093341.GA3131@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi wolfram
> 
> Just a formal thing I noticed on a glimpse...
> 
You mean can directly set the TIMEOUT CONTROL register to be the maximum value?
And any comment about patch2 and patch3?

> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 154cbf8..79fcca2 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -879,6 +879,48 @@ static void sdhci_finish_data(struct sdhci_host *host)
> >  		tasklet_schedule(&host->finish_tasklet);
> >  }
> >
> > +static void sdhci_set_erasetimeout(struct sdhci_host *host,
> > +		unsigned int erase_timeout)
> > +{
> > +	u64 current_timeout;
> > +	int count = 0xe;
> 
> I'd suggest a define with a speaking name instead of all the hardcoded 0xe.
Ok, will fix it in the next version submission.
Thanks
