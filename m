From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 17:04:32 +0530
Message-ID: <CAKLKtzcMk+H-ZeLs6nOP8B8PnCtK+A0emU_tZtGGacnYueg0dQ@mail.gmail.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com>
	<CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com>
	<CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com>
	<CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com>
	<CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com>
	<CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com>
	<4FDAE2CD.6090703@stericsson.com>
	<CAKLKtzc6WQnhXur-jpWHpRWguyMWsTU1o9zbn-39M8Y+ot8HrA@mail.gmail.com>
	<CAFEEs1nNuroEBLtO_izFrsBu0MRvW6xVoAQFfiZJfp01m-TaLQ@mail.gmail.com>
	<CAKLKtzcdGevM_mA-BSkOHC3DeasOoROB3H8z-1yiHqQxhFx0yA@mail.gmail.com>
	<4FDB1C02.1080309@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41963 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2FOLee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 07:34:34 -0400
Received: by gglu4 with SMTP id u4so2191499ggl.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jun 2012 04:34:33 -0700 (PDT)
In-Reply-To: <4FDB1C02.1080309@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

On 15 June 2012 16:56, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> Hi Saugata,
>
> snip.
>
>
>>>>>>
>>>>>> The problem in sending CMD0 without power OFF notify is possibil=
ity of
>>>>>> some data loss in MMC-4.5 devices.
>>>>>
>>>>>
>>>>>
>>>>> I don't see the problem here. You will be sending power OFF notif=
y when
>>>>> you
>>>>> can. The only difference is when you "wake" the device from sleep=
 mode.
>>>>> Instead of using CMD5, which may work is some cases and in some c=
ases
>>>>> not
>>>>> (without restoring ios). So using CMD0 as common way of waking up=
 from
>>>>> suspend should be fine. Unless I missed something of course. :-)
>>>>>
>>>>
>>>> CMD0 is a reset. I expect with power OFF notify enable, the eMMC
>>>> device will postpone some control information update to its intern=
al
>>>> non-volatile memory (e.g. some data structures which are kept in t=
he
>>>> controller buffers and not stored in NAND). If we do a CMD0, then =
the
>>>> eMMC device will be reset and we may lose some data. In addition t=
o
>>>> that, doing complete card initialization will increase the wakeup =
time
>>>> (for 4.4 devices).
>
>
> When doing poweroff_notify at suspend you have _always_ cut both vcc =
and
> vccq, according to MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which mean=
s you
> must always use CMD0 to wake up. There is no present internal cache i=
n the
> eMMC here.
>
> In sleep mode, you can use CMD5, but until the poweroff notify patche=
s (the
> patch that broke suspend/resume, not this one), we have used CMD0 to =
wake
> up. Let's go back to that solution. Then we can address you concern a=
bout
> "data loss" for sleep mode in separate patch.
>

Yes, you will get back to the same code flow with the introduction of
the MMC_CAP2_NO_INIT_ON_RESUME. If some host drivers are capable of
executing the CMD5 resume then they enable this cap and go on the
optimized path. The rest go on CMD0 path.

>
>>>>
>>>> Till now, we have done complete card initialization during resume
>>>
>>> Yes, me and Ulf think we should still do a complete initialization,=
 at
>>> least for now and in this patch.
>>>
>>
>> In my opinion, that's incorrect on MMC-4.5 device and unoptimized fo=
r
>> MMC-4.41 device.
>
>
> Unoptimized for 4.41 with sleep, might be correct. But, again, let's =
look
> into that in a second step.
>
> As stated for 4.5 devices with poweroff_notify, there are no issues.
>
>>
>> Let me propose a new cap, MMC_CAP2_NO_INIT_ON_RESUME and do somethin=
g
>> like following in mmc_resume,
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
>> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_NO_INIT_ON_R=
ESUME)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_restore_ios(host,&host->saved_ios=
);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
>> =A0 =A0 =A0 =A0} else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->ocr=
, host->card);
>>
>> I hope it's OK for Ulf, Per, Subhash, Girish, Asutosh.
>>
>>
>>> A separate patch may deal with resume awake CMD5 and IOS save/resto=
re.
>>>
>>> We may also discuss a clean up patch later on to reduce the number =
of
>>> bus_ops. Sleep, awake, and poweroff_notify are MMC specific.
>>> power_save/power_restore maps to suspend/resume. But let's not disc=
uss
>>> this now :)
>>>
>>> BR
>>> Per
>
>
>
> Kind regards
> Ulf Hansson
