From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 7 Dec 2011 07:45:59 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1163467C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com>
 <1323163107-32619-2-git-send-email-r66093@freescale.com>
 <4EDE06DA.7010108@yahoo.es>
 <8A2FC72B45BB5A4C9F801431E06AE48F116342A2@039-SN1MPN1-005.039d.mgd.msft.net>
 <4EDEDF62.70705@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:19390 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1LGHqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 02:46:03 -0500
In-Reply-To: <4EDEDF62.70705@yahoo.es>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@stericsson.com" <ulf.hansson@stericsson.com>, Chris Ball <cjb@laptop.org>



> -----Original Message-----
> From: Hein_Tibosch [mailto:hein_tibosch@yahoo.es]
> Sent: Wednesday, December 07, 2011 11:37 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; ulf.hansson@stericsson.com; Chris Ball
> Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
> 
> Hi Jerry,
> On 12/7/2011 10:23 AM, Huang Changming-R66093 wrote:
> >
> >> -----Original Message-----
> >> From: Hein_Tibosch [mailto:hein_tibosch@yahoo.es]
> >> Sent: Tuesday, December 06, 2011 8:13 PM
> >> To: Huang Changming-R66093
> >> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
> >> Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
> >>
> >> <cut>
> >>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> >>> a08e6b1..2d40c04 100644
> >>> --- a/drivers/mmc/core/core.c
> >>> +++ b/drivers/mmc/core/core.c
> >>> @@ -1253,7 +1253,10 @@ static void mmc_power_up(struct mmc_host *host)
> >>>  	 */
> >>>  	mmc_delay(10);
> >>>
> >>> -	host->ios.clock = host->f_init;
> >>> +	if (host->f_init)
> >>> +		host->ios.clock = host->f_init;
> >>> +	else
> >>> +		host->ios.clock = host->f_min;
> >> Are you sure f_min can have a value of zero?
> >> It should have been set mmc_rescan_try_freq(), when trying a list of
> >> frequencies: 400000, 300000, 200000, 100000
> >>
> > But, mmc_power_up is called not only by mmc_rescan_try_freq, so the
> value of f_init may be zero.
> 
> Ok, I see: mmc_power_up() used to be called only after
> mmc_rescan_try_freq(), but now you want to call it earlier, because
> get_cd() *might* need it, even if get_cd is not defined...
> 
> Still I wonder whether it's good to power-up each and every card:
> 
> +	mmc_power_up(host);
>  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
>  		goto out;
> +	mmc_power_off(host);
> 
> before initialization starts. Remember earlier complaints that f_min is
> extremely low on some platforms and therefor f_init was introduced.
You can view the v3 patch I posted, only when get_cd is defined, this function is called. 
Some controller may use GPIO to detect the card preset or absent, card can be detected without power on. But the other controller has the pin to detect the card, so we need the power on to update the register.

Function mmc_power_restore_host and mmc_resume_host have called mmc_power_up, these two function are used for PM.
If the controller support get_cd and there is not card present, mmc_rescan_try_freq  can't be called, then the f_init can't be initized. If SDHC enter sleep and resume, mmc_power_up will be called by the two function I mentioned. In this case, the f_init can be zero.
So my code first check if the f_init is zero, if yes, f_min will be used. F_min is always initialized during the SDHC controller. 

