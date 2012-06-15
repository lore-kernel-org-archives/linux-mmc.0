From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 13:26:58 +0200
Message-ID: <4FDB1C02.1080309@stericsson.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org> <CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com> <CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com> <CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com> <CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com> <CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com> <CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com> <4FDAE2CD.6090703@stericsson.com> <CAKLKtzc6WQnhXur-jpWHpRWguyMWsTU1o9zbn-39M8Y+ot8HrA@mail.gmail.com> <CAFEEs1nNuroEBLtO_izFrsBu0MRvW6xVoAQFfiZJfp01m-TaLQ@mail.gmail.com> <CAKLKtzcdGevM_mA-BSkOHC3DeasOoROB3H8z-1yiHqQxhFx0yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:46593 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752264Ab2FOL1i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 07:27:38 -0400
In-Reply-To: <CAKLKtzcdGevM_mA-BSkOHC3DeasOoROB3H8z-1yiHqQxhFx0yA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

Hi Saugata,

snip.

>>>>>
>>>>> The problem in sending CMD0 without power OFF notify is possibility of
>>>>> some data loss in MMC-4.5 devices.
>>>>
>>>>
>>>> I don't see the problem here. You will be sending power OFF notify when you
>>>> can. The only difference is when you "wake" the device from sleep mode.
>>>> Instead of using CMD5, which may work is some cases and in some cases not
>>>> (without restoring ios). So using CMD0 as common way of waking up from
>>>> suspend should be fine. Unless I missed something of course. :-)
>>>>
>>>
>>> CMD0 is a reset. I expect with power OFF notify enable, the eMMC
>>> device will postpone some control information update to its internal
>>> non-volatile memory (e.g. some data structures which are kept in the
>>> controller buffers and not stored in NAND). If we do a CMD0, then the
>>> eMMC device will be reset and we may lose some data. In addition to
>>> that, doing complete card initialization will increase the wakeup time
>>> (for 4.4 devices).

When doing poweroff_notify at suspend you have _always_ cut both vcc and 
vccq, according to MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which means 
you must always use CMD0 to wake up. There is no present internal cache 
in the eMMC here.

In sleep mode, you can use CMD5, but until the poweroff notify patches 
(the patch that broke suspend/resume, not this one), we have used CMD0 
to wake up. Let's go back to that solution. Then we can address you 
concern about "data loss" for sleep mode in separate patch.

>>>
>>> Till now, we have done complete card initialization during resume
>> Yes, me and Ulf think we should still do a complete initialization, at
>> least for now and in this patch.
>>
>
> In my opinion, that's incorrect on MMC-4.5 device and unoptimized for
> MMC-4.41 device.

Unoptimized for 4.41 with sleep, might be correct. But, again, let's 
look into that in a second step.

As stated for 4.5 devices with poweroff_notify, there are no issues.

>
> Let me propose a new cap, MMC_CAP2_NO_INIT_ON_RESUME and do something
> like following in mmc_resume,
>
>   	mmc_claim_host(host);
> -	if (mmc_card_is_sleep(host->card)) {
> +	if (mmc_card_is_sleep(host->card)&&
> +		(host->caps2&  MMC_CAP2_NO_INIT_ON_RESUME)) {
>   		mmc_restore_ios(host,&host->saved_ios);
>   		err = mmc_card_awake(host);
> 	} else
> 		err = mmc_init_card(host, host->ocr, host->card);
>
> I hope it's OK for Ulf, Per, Subhash, Girish, Asutosh.
>
>
>> A separate patch may deal with resume awake CMD5 and IOS save/restore.
>>
>> We may also discuss a clean up patch later on to reduce the number of
>> bus_ops. Sleep, awake, and poweroff_notify are MMC specific.
>> power_save/power_restore maps to suspend/resume. But let's not discuss
>> this now :)
>>
>> BR
>> Per


Kind regards
Ulf Hansson
