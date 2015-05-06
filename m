From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Wed, 06 May 2015 14:30:22 +0800
Message-ID: <5549B4FE.6080007@linaro.org>
References: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org> <55496227.9000904@samsung.com> <CABQgh9E5B=q-5+go2FJXUbDpveGm2xEo+1LdKbG40sxrZ7vQnA@mail.gmail.com> <55496DC8.8060208@samsung.com> <55496F78.3080700@linaro.org> <554970B6.6020309@samsung.com> <5549796A.5090703@linaro.org> <554996BB.70800@samsung.com> <5549A70C.5070404@linaro.org> <5549B0EE.4000202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33685 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbEFGa3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 02:30:29 -0400
Received: by pdbnk13 with SMTP id nk13so549937pdb.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 23:30:29 -0700 (PDT)
In-Reply-To: <5549B0EE.4000202@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>



On 05/06/2015 02:13 PM, Jaehoon Chung wrote:

>>>>>>>>> If you want to check it, use the "broken-cd" and "non-removable" properties into dt-file.
>>>>>>>>> Did you use them?
>>>>>>>>
>>>>>>>> Yes.
>>>>>>>> "broken-cd" can work, but mmc_rescan keeps running.
>>>>>>>> "non-removable" does NOT work, which should be used for emmc.
>>>>>>>> Since dw_mci_get_cd only checks DW_MCI_QUIRK_BROKEN_CARD_DETECTION, so
>>>>>>>> only checks "broken-cd" but not check "non-removable"
>>>>>>>
>>>>>>> Did you use the usage like the below..
>>>>>>>
>>>>>>> dwmmc0 {
>>>>>>>        non-removable;
>>>>>>>        broken-cd;
>>>>>>> };
>>>>>>
>>>>>> non-removable and broken-cd should be used only one.
>>>>>
>>>>> Did you check the code?
>>>>> If non-removable is set, broken-cd should be discarded.
>>>>>
>>>>> I think that the below usage is not "must not".
>>>>
>>>> I understand you meaning, you suggest
>>>>>>> dwmmc0 {
>>>>>>>        non-removable;
>>>>>>>        broken-cd;
>>>>>>> };
>>>>
>>>> drivers/mmc/host/dw_mmc.c checks broken-cd, while mmc_of_parse checks non-removable.
>>>> Yes, it works.
>>>>
>>>> But is it a workaround? and a little tricky.
>>>> It costs me some time to find why non-removable does not work, someone else may meet the same issue.
>>>> It does not align with Documentation/devicetree/bindings/mmc/mmc.txt, which is the guideline to write dts.
>>>> And see drivers/mmc/host/sdhci.c: sdhci_do_get_cd, it also checks both.
>>>
>>> "non-removable" is assumed that card is not removed.
>>> it's not also correct detect scheme. Then it's also able to say the broken card detection scheme.
>>> (if CDETECT register can't use.)
>>>
>>> BROKEN_CARD_DETECTION quirk means that it has unreliable card detection.
>>> When dw-mmc host controller has unreliable card detection scheme, it could be set.
>>> Is this tricky? i don't think so.
>>>
>>> Though non-removable doesn't set, it has to work fine, isn't?
>> If non-removable is not set, broken-cd has to be set.
>> Or set both, but usually we may not consider this at first.
>>
>> When we first want to enable emmc, we naturally use non-removable, according to Documentation/devicetree/bindings/mmc/mmc.txt
>
> Why do you use naturally non-removable? eMMC can be removed at some SoC. (It's assumption.)
> Is it common approach that consider how eMMC can be detected at host controller?
The emmc chip we use is folded on board and can not be removed.
non-removable will make mmc_rescan only executing once, while broken 
will make mmc_rescan polling.

>
>> Only one of the properties in this section should be supplied:
>>    - broken-cd: There is no card detection available; polling must be used.
>>    - cd-gpios: Specify GPIOs for card detection, see gpio binding
>>    - non-removable: non-removable slot (like eMMC); assume always present.
>>
>> But unfortunately we find it does not work and took half day to debug, happen to find broken-cd can work, though mmc_rescan is keeps running for a while, and we treat it as workaround.
>>
>> After some time, another person find broken-cd does not make sense, and debug again about non-removable, and took another half day.
>>
>> It really happens here :(
>
> Sorry for not saving your time.
> Hmm..To prevent your case, it seems better that apply your patch. :)
>
> Will apply at my dw-mmc tree.

Thanks Jaehoon.
