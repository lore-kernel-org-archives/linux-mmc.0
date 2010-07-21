From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
 define
Date: Wed, 21 Jul 2010 12:03:40 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E38B7ED@dbde02.ent.ti.com>
References: <1279607878-2405-1-git-send-email-s-ghorai@ti.com>
 <4C454B99.7090705@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E3107D8@dbde02.ent.ti.com>
 <4C4559E5.7090004@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E310805@dbde02.ent.ti.com>
 <4C4560EB.8070702@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E31084E@dbde02.ent.ti.com>
 <4C4568C6.9050705@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E310B10@dbde02.ent.ti.com>
 <4C4690A3.5030503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4C4690A3.5030503@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

Adrian,

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Wednesday, July 21, 2010 11:46 AM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Shilimkar,
> Santosh; Chikkature Rajashekar, Madhusudhan; Andrew Morton
> Subject: Re: [PATCH] omap: hsmmc funtionality breaks when CONFIG_PM not
> define
> 
> >>> [Ghorai] thanks and need input again,
> >>> we have two tables -
> >>> 1. static const struct mmc_host_ops omap_hsmmc_ops = {
> >>> }
> >>> --> This is without CONFIG_PM, assumed.
> >> No it is independent of CONFIG_PM
> >>
> >> With CONFIG_PM
> >> 	- the driver will restore registers if the host controller
> >> 	has been powered off / on by PRCM
> >> 	- suspend / resume can be used
> >>
> >>> 2. static const struct mmc_host_ops omap_hsmmc_ps_ops = {
> >>> }
> >>> -> this with CONFIG_PM, assumed.
> >> No it is independent of CONFIG_PM
> >>
> >> Without CONFIG_PM
> >> 	- card will be put to sleep after 1 second
> >> 	- card will be powered off after another 8 seconds
> >>
> >>> a. And you feel we should remove #1
> >> Nothing should need to be removed.
> >>
> >>> b. use omap_hsmmc_ps_ops default.
> >> With power_saving it is yes.
> > [Ghorai] Is it that power_saving (true or false) is independent of
> CONFIG_PM?
> 
> Yes, power_saving (true or false) *is* independent of CONFIG_PM.
> 
[Ghorai] Thanks and would you please reply for query from Kishore and now query from my side too?
Is there any use case or a valid scenario when to use omap_hsmmc_ps_ops or omap_hsmmc_ops ? I meant using power_saving option and without power_saving option.

Ideally I feel having omap_hsmmc_ps_ops as default with or without CONFIG_PM would be better as it internally has a state handling.

Regards,
Ghorai

