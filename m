From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 06 May 2015 09:53:48 +0800
Message-ID: <5549742C.40701@linaro.org>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org> <55496227.9000904@samsung.com> <CABQgh9E5B=q-5+go2FJXUbDpveGm2xEo+1LdKbG40sxrZ7vQnA@mail.gmail.com> <55496DC8.8060208@samsung.com> <55496F78.3080700@linaro.org> <554970B6.6020309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35972 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbEFBxx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 21:53:53 -0400
Received: by pabsx10 with SMTP id sx10so211972726pab.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 18:53:53 -0700 (PDT)
In-Reply-To: <554970B6.6020309@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>



On 05/06/2015 09:39 AM, Jaehoon Chung wrote:
> Hi,
>
> On 05/06/2015 10:33 AM, zhangfei wrote:
>>
>>
>> On 05/06/2015 09:26 AM, Jaehoon Chung wrote:
>>> Hi,
>>>
>>> On 05/06/2015 10:14 AM, Zhangfei Gao wrote:
>>>> On 6 May 2015 at 08:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi, Zhangfei.
>>>>>
>>>>> If you want to check it, use the "broken-cd" and "non-removable" properties into dt-file.
>>>>> Did you use them?
>>>>
>>>> Yes.
>>>> "broken-cd" can work, but mmc_rescan keeps running.
>>>> "non-removable" does NOT work, which should be used for emmc.
>>>> Since dw_mci_get_cd only checks DW_MCI_QUIRK_BROKEN_CARD_DETECTION, so
>>>> only checks "broken-cd" but not check "non-removable"
>>>
>>> Did you use the usage like the below..
>>>
>>> dwmmc0 {
>>>      non-removable;
>>>      broken-cd;
>>> };
>>
>> non-removable and broken-cd should be used only one.
>
> Did you check the code?
> If non-removable is set, broken-cd should be discarded.
>
> I think that the below usage is not "must not".

Sorry, not understand.
Just want to use non-removable for emmc, and find it does not work.
Use broken-cd for emmc is not correct.

>
> Best Regards,
> Jaehoon Chung
>
>>
>> Documentation/devicetree/bindings/mmc/mmc.txt
>> Card detection:
>> If no property below is supplied, host native card detect is used.
>> Only one of the properties in this section should be supplied:
>>    - broken-cd: There is no card detection available; polling must be used.
>>    - cd-gpios: Specify GPIOs for card detection, see gpio binding
>>    - non-removable: non-removable slot (like eMMC); assume always present.
>>
>> work
>>   dwmmc0 {
>>       broken-cd;
>>   };
>>
>> NOT work
>>   dwmmc0 {
>>       non-removable;
>>   };
>>
>> Thanks
>>
>
