From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] mmc: omap_hsmmc: precedence bug in
 omap_hsmmc_context_restore()
Date: Thu, 30 Jan 2014 15:15:26 +0300
Message-ID: <20140130121526.GO4815@mwanda>
References: <20130822125613.GB2543@elgon.mountain>
 <52162444.1050908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52162444.1050908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 22, 2013 at 08:16:28PM +0530, Balaji T K wrote:
> On Thursday 22 August 2013 06:26 PM, Dan Carpenter wrote:
> >'!' has higher precedence than '&' so this doesn't work as intended
> >although since RESETDONE is 1 it would work if none of the other bits
> >are set.
> >
> Hi Dan,
> 
> Thanks for the patch, Indeed other bits are reserved.
> however ...
> 
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >---
> >Untested.
> >
> >diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> >index 1865321..7346b15 100644
> >--- a/drivers/mmc/host/omap_hsmmc.c
> >+++ b/drivers/mmc/host/omap_hsmmc.c
> >@@ -612,7 +612,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
> >  	if (host->context_loss == context_loss)
> >  		return 1;
> >
> >-	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
> >+	if (!(OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE))
> >  		return 1;
> 
> This check is unnecessary, will send a patch to remove this.

What happened with this?

regards,
dan carpenter

