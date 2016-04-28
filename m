From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 04/23] mmc: sdhci: re-factor sdhci_start_signal_voltage()
Date: Thu, 28 Apr 2016 16:36:25 +0300
Message-ID: <572211D9.5010605@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
 <571A0E5E.4090904@intel.com>
 <CAA+hA=SygBBr+-C_r4Geodni+hj2Mg71o+ecVq_AD8vv22=UPA@mail.gmail.com>
 <5721208C.2090509@intel.com>
 <20160428030941.GA23362@shlinux2.ap.freescale.net>
 <5721B03A.5030006@intel.com>
 <20160428131451.GA27560@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6286 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbcD1NkQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2016 09:40:16 -0400
In-Reply-To: <20160428131451.GA27560@shlinux2.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On 28/04/16 16:14, Dong Aisheng wrote:
> On Thu, Apr 28, 2016 at 09:39:54AM +0300, Adrian Hunter wrote:
>> On 28/04/16 06:09, Dong Aisheng wrote:
>>> On Wed, Apr 27, 2016 at 11:26:52PM +0300, Adrian Hunter wrote:
>>>> On 24/04/2016 12:14 p.m., Dong Aisheng wrote:
>>>>> Hi Adrian,
>>>>>
>>>>> Thanks for the review first.
>>>>>
>>>>> On Fri, Apr 22, 2016 at 7:43 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>> On 15/04/16 20:29, Dong Aisheng wrote:
>>>>>>> Handle host and regulator signal voltage switch separately.
>>>>>>> Move host signal voltage switch code into a separated function
>>>>>>> sdhci_do_signal_voltage_switch() first, the following patches will
>>>>>>> remove the regulator voltage switch code and use the common
>>>>>>> mmc_regulator_set_vqmmc() instead.
>>>>>>
>>>>>> You have changed the order that things are done.
>>>>>
>>>>> Yes, the oder changes a bit that we always do controller voltage switch first.
>>>>> I suppose the order is irrelevant here since i don't recall any
>>>>> requirement from card.
>>>>>
>>>>> Actually the original order is also a bit mass.
>>>>> e.g.
>>>>> For MMC_SIGNAL_VOLTAGE_330, switch controller first, then vqmmc.
>>>>> But for MMC_SIGNAL_VOLTAGE_180, switch vqmmc first, then controller.
>>>>> It looks to us the original one also order irrelevant.
>>>>>
>>>>>> There is no way to know
>>>>>> what that will break, so let's not do that.  What about just changing
>>>>>> regulator_set_voltage() to mmc_regulator_set_vqmmc()?
>>>>>>
>>>>>
>>>>> Currently what i can think out VIO switch using are three cases: (Pls
>>>>> help add if any)
>>>>> 1) Both host IO and card IO use external vqmmc to do switch
>>>>> (e.g eMMC 1.8V DDR/HS200/HS400 mode)
>>>>>
>>>>> eMMC has no IO voltage switch protocol and requirement, so usually
>>>>> board designed
>>>>> using fixed 1.8V for eMMC and host IO.
>>>>> Event it's switchable, it should be done in the first mmc_power_up().
>>>>> Dynamical switch later may cause eMMC unable to work properly.
>>>>> (We have been confirmed about this issue by many eMMC vendors
>>>>> like Micron and Sandisk. I'm not sure if any exceptions in the community
>>>>> still doing VIO dynamical switch for eMMC, if yes, please help share
>>>>> the experience!).
>>>>>
>>>>> Event some people still do dynamical IO switch for eMMC, since eMMC
>>>>> spec has no requirement, so the order should also not care.
>>>>>
>>>>> 2) Host using controller IO switch while card using standard CMD (SD/SDIO3.0)
>>>>>
>>>>> SD/SDIO 3.0 spec defines the standard IO switch process and using it's internal
>>>>> regulator to do card IO voltage switch. It does not use external vqmmc
>>>>> regulator.
>>>>> So order irrelevant too.
>>>>>
>>>>> 3) Host using controller IO switch while card using external vqmmc
>>>>> (special SDIO3.0 or eMMC)
>>>>> I have met some special SDIO3.0 card like Broadcom WiFi which does not follow
>>>>> the spec and using external regulator for card IO voltage.
>>>>> Usually it's required to fix to 1.8v and also not order irrelevant.
>>>>>
>>>>> For eMMC, refer to case 1), it should be fixed to 1.8v at power up.
>>>>>
>>>>> So it looks all cases seems are not order required.
>>>>
>>>> I don't agree that there is any way to know that other host controllers
>>>> are not affected.  I don't want a repeat of sdhci_set_power().
>>>>
>>>
>>> Can you share some more info about sdhci_set_power() issue?
>>> I'd like to see if we are same the issue.
>>
>> Not the same issue, but the same concept.  People changing the code under
>> the impression that their way was correct, and then breaking other people's
>> drivers.  Check the git history and mailing list.
>>
>> 	http://marc.info/?l=linux-mmc&m=145880454106474&w=2
>>
> 
> Yes, now i understand your concern.
> 
>>>
>>> BTW, IMHO i don't think we should stop keep moving only afraid of potential
>>> break if it's correct way. Because .start_signal_voltage_switch() interface
>>> seems shouldn't be order dependant.
>>> If it is, then it should be fixed and handled in high layer like MMC core
>>> rather than in host driver. Right?
>>
>> The SDHCI spec. does not define how to use external regulators, so there is
>> no "correct way".
>>
> 
> The "correct way" i mean here is .start_signal_voltage_switch() shouldn't be
> order dependant, would you agree?

No.  There is no way to know if the regulator must be switched before or
after the host controller register is changed.

> 
>> We have to move forward *and* avoid potential breakage.
>>
> 
> If really break happens, fix platform driver, not common SDHCI.
> That's the same thing you done for sdhci_set_power().

In that case the original behaviour was kept in the common SDHCI code and
the driver had to provide its own way.

> 
>> In this case it seems me that the risk of breakage outweighs the value of
>> prettier code.
>>
> 
> Actually my main purpose is patch 6: using mmc_regulator_set_vqmmc()
> which is worth and it does improve the stability and eliminate the
> potential signal issue.
> However it's not the same way as you proposed.
> See below.
> 
>> By the way, there are ways to get rid of the ugliness - such as pushing it down
>> into individual drivers.
>>
>>>
>>>> Please instead send a patch for just using mmc_regulator_set_vqmmc()
>>>> in place of regulator_set_voltage().
>>>
>>> Just using mmc_regulator_set_vqmmc() also changes the order which
>>> is the same situation.
>>
>> How so?  It looks like a drop-in replacement to me:
>>
> 
> Sorry, i did not get that you want to change like below.
> However, it looks that it does not make too much sense to call
> mmc_regulator_set_vqmmc() for each VOLTAGE type like 3.3v/1.8v/1.2v
> which introduces ugliness because mmc_regulator_set_vqmmc()
> already handles it internally, right?
> Only because we want to keep an "ASSUMED" order as before?

Yes

> 
> Regards
> Dong Aisheng
> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 94cffa77490a..69b4d48aff87 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1757,8 +1757,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>  		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>  
>>  		if (!IS_ERR(mmc->supply.vqmmc)) {
>> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
>> -						    3600000);
>> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>  			if (ret) {
>>  				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>>  					mmc_hostname(mmc));
>> @@ -1779,8 +1778,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>  		return -EAGAIN;
>>  	case MMC_SIGNAL_VOLTAGE_180:
>>  		if (!IS_ERR(mmc->supply.vqmmc)) {
>> -			ret = regulator_set_voltage(mmc->supply.vqmmc,
>> -					1700000, 1950000);
>> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>  			if (ret) {
>>  				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>  					mmc_hostname(mmc));
>> @@ -1810,8 +1808,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>  		return -EAGAIN;
>>  	case MMC_SIGNAL_VOLTAGE_120:
>>  		if (!IS_ERR(mmc->supply.vqmmc)) {
>> -			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
>> -						    1300000);
>> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>  			if (ret) {
>>  				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>>  					mmc_hostname(mmc));
>>
>>
>>
> 

