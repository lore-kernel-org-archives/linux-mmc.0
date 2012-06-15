From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 14:07:22 +0200
Message-ID: <4FDB257A.8060305@stericsson.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org> <CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com> <CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com> <CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com> <CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com> <CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com> <CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com> <4FDAE2CD.6090703@stericsson.com> <CAKLKtzc6WQnhXur-jpWHpRWguyMWsTU1o9zbn-39M8Y+ot8HrA@mail.gmail.com> <CAFEEs1nNuroEBLtO_izFrsBu0MRvW6xVoAQFfiZJfp01m-TaLQ@mail.gmail.com> <CAKLKtzcdGevM_mA-BSkOHC3DeasOoROB3H8z-1yiHqQxhFx0yA@mail.gmail.com> <4FDB1C02.1080309@stericsson.com> <CAKLKtzcMk+H-ZeLs6nOP8B8PnCtK+
 A0emU_tZtGGacnYueg0dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:56004 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755499Ab2FOMHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 08:07:45 -0400
In-Reply-To: <CAKLKtzcMk+H-ZeLs6nOP8B8PnCtK+A0emU_tZtGGacnYueg0dQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

On 06/15/2012 01:34 PM, Saugata Das wrote:
> On 15 June 2012 16:56, Ulf Hansson<ulf.hansson@stericsson.com>  wrote:
>> Hi Saugata,
>>
>> snip.
>>
>>
>>>>>>>
>>>>>>> The problem in sending CMD0 without power OFF notify is possibility of
>>>>>>> some data loss in MMC-4.5 devices.
>>>>>>
>>>>>>
>>>>>>
>>>>>> I don't see the problem here. You will be sending power OFF notify when
>>>>>> you
>>>>>> can. The only difference is when you "wake" the device from sleep mode.
>>>>>> Instead of using CMD5, which may work is some cases and in some cases
>>>>>> not
>>>>>> (without restoring ios). So using CMD0 as common way of waking up from
>>>>>> suspend should be fine. Unless I missed something of course. :-)
>>>>>>
>>>>>
>>>>> CMD0 is a reset. I expect with power OFF notify enable, the eMMC
>>>>> device will postpone some control information update to its internal
>>>>> non-volatile memory (e.g. some data structures which are kept in the
>>>>> controller buffers and not stored in NAND). If we do a CMD0, then the
>>>>> eMMC device will be reset and we may lose some data. In addition to
>>>>> that, doing complete card initialization will increase the wakeup time
>>>>> (for 4.4 devices).
>>
>>
>> When doing poweroff_notify at suspend you have _always_ cut both vcc and
>> vccq, according to MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which means you
>> must always use CMD0 to wake up. There is no present internal cache in the
>> eMMC here.
>>
>> In sleep mode, you can use CMD5, but until the poweroff notify patches (the
>> patch that broke suspend/resume, not this one), we have used CMD0 to wake
>> up. Let's go back to that solution. Then we can address you concern about
>> "data loss" for sleep mode in separate patch.
>>
>
> Yes, you will get back to the same code flow with the introduction of
> the MMC_CAP2_NO_INIT_ON_RESUME. If some host drivers are capable of
> executing the CMD5 resume then they enable this cap and go on the
> optimized path. The rest go on CMD0 path.

Please do that as a separate patch so we can get this merged asap. 
Moreover, I think we should try to prevent from adding another cap for this.

There are another option for a host driver tell whether CMD0 shall be 
used or not, by using the regulator supplies. See a patch by Guennadi 
Liakhovetski in: http://article.gmane.org/gmane.linux.kernel.mmc/14635, 
still being discussed though.

The MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, can likely soon be removed 
as well, when above patch is accepted and host driver is starting to use 
the new API.

Kind regards
Ulf Hansson
