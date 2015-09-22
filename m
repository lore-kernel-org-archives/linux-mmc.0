From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2, 2/3] mmc: sdhci-of-esdhc: get SOC version and revision
 from GUTS_SVR
Date: Tue, 22 Sep 2015 10:35:01 -0500
Message-ID: <1442936101.19102.240.camel@freescale.com>
References: <1440667742-25424-1-git-send-email-yangbo.lu@freescale.com>
	 <1441153422.4966.105.camel@freescale.com>
	 <BY1PR0301MB119212B35DBACE0D88F274D6F2450@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0111.outbound.protection.outlook.com ([65.55.169.111]:46387
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758012AbbIVPt5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Sep 2015 11:49:57 -0400
In-Reply-To: <BY1PR0301MB119212B35DBACE0D88F274D6F2450@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 2015-09-22 at 03:56 -0500, Lu Yangbo-B47093 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 02, 2015 8:24 AM
> > To: Lu Yangbo-B47093
> > Cc: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org
> > Subject: Re: [v2, 2/3] mmc: sdhci-of-esdhc: get SOC version and revision
> > from GUTS_SVR
> > 
> > On Thu, 2015-08-27 at 17:29 +0800, Yangbo Lu wrote:
> > > @@ -24,6 +25,16 @@
> > > 
> > >  #define VENDOR_V_22  0x12
> > >  #define VENDOR_V_23  0x13
> > > +
> > > +/* Global Utility Registers */
> > > +#define GUTS_SVR             0xa4    /* System Version Register */
> > > +/* SOC version definition */
> > > +#define SVR_T4240            0x824000
> > 
> > Please do not redefine this stuff in each driver that needs to reference
> > it.
> > 
> > -Scott
> 
> [Lu Yangbo-B47093] SOC version definition like SVR_T4240 is in 
> arch/powerpc/include/asm/mpc85xx.h
> It's only for PPC and Uffe thought it's not good to introduce non generic 
> header file.
> Is there any suggestion about this? 

Either use ifdefs or move it to include/linux/fsl-svr.h.

It's not only for PPC.  Our ARM QorIQ chips also have SVR (accessible only 
through MMIO).

-Scott


