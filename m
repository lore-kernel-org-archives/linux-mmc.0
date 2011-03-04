From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Fri, 4 Mar 2011 05:52:30 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E38E6BDD@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-3-git-send-email-arindam.nath@amd.com>
 <20110304114731.GB2227@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:7392
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759550Ab1CDLwo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2011 06:52:44 -0500
In-Reply-To: <20110304114731.GB2227@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "prakity@marvell.com" <prakity@marvell.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Wolfram,


> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Friday, March 04, 2011 5:18 PM
> To: Nath, Arindam
> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; prakity@marvell.com;
> subhashj@codeaurora.org; linux-mmc@vger.kernel.org; Su, Henry; Lu,
> Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltage
> switch procedure
> 
> 
> > +	if (host->version >= SDHCI_SPEC_300)
> > +		caps[1] = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> 
> Now caps[1] can be uninitialized (didn't the compiler warn about this?)

Surprisingly, there was no compiler warning on my setup. I will take care of it.

Thanks,
Arindam

> Maybe
> 
> 	caps[1] = host->version... ? sdhci_readl() : 0
> 
> (or simply an else branch)?
> 
> Regards,
> 
>    Wolfram
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

