From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] DWMMC controller for next
Date: Thu, 24 Nov 2016 21:30:40 +0900
Message-ID: <a24581b1-55d7-fe07-77a6-37f5c64e0c75@samsung.com>
References: <63a0b568-cd9e-d038-b7eb-08b7868f96f2@samsung.com>
 <CAPDyKFo+W12sV-U8r44ySerWHi2tAwEEnGNMd97iUN8NLV4duA@mail.gmail.com>
 <CGME20161123114758epcas5p25465d2ecaf5f7332003aa0eab61cac31@epcas5p2.samsung.com>
 <CAPDyKFokGM+-6hjGpgJRJOVwANX43gEww4p17LCxvD=e0Qbj=g@mail.gmail.com>
 <ed2ab8e4-6209-49d4-8ef3-76db0a0342bf@samsung.com>
 <a6358997-0e19-05b6-e488-3a17bdac5952@samsung.com>
 <ca995842-9e10-a5c5-27b9-dd24750e36a1@samsung.com>
 <CAPDyKFqUjLqYT5nS7hsAULK6iDtvcv8a1Cqao_VCtTXm5X82cA@mail.gmail.com>
 <19761c56-36a6-3a05-1299-d30a163c1968@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37876 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938751AbcKXMan (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 07:30:43 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH5033KGC31JC60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Nov 2016 21:30:40 +0900 (KST)
In-reply-to: <19761c56-36a6-3a05-1299-d30a163c1968@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11/24/2016 08:50 PM, Jaehoon Chung wrote:
> On 11/24/2016 08:43 PM, Ulf Hansson wrote:
>> On 24 November 2016 at 12:17, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 11/23/2016 09:31 PM, Jaehoon Chung wrote:
>>>> On 11/23/2016 08:50 PM, Jaehoon Chung wrote:
>>>>> On 11/23/2016 08:47 PM, Ulf Hansson wrote:
>>>>>> On 22 November 2016 at 17:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>>> On 22 November 2016 at 10:59, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>>>>> Dear Ulf,
>>>>>>>>
>>>>>>>> Could you pull these patches on your next branch?
>>>>>>>> If there is a problem, let me know, plz.
>>>>>>>>
>>>>>>>> The following changes since commit e2081b37d910c5e6c6925d9b4d0a7a6283f84ec5:
>>>>>>>>
>>>>>>>>   Merge branch 'fixes' into next (2016-11-21 11:09:18 +0100)
>>>>>>>>
>>>>>>>> are available in the git repository at:
>>>>>>>>
>>>>>>>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>>>>>>>
>>>>>>>> for you to fetch changes up to e25fd245b557482a8e0f7ab87841085f30706f3a:
>>>>>>>>
>>>>>>>>   Documentation: synopsys-dw-mshc: remove the unused properties (2016-11-22 10:34:05 +0900)
>>>>>>>>
>>>>>>>> ----------------------------------------------------------------
>>>>>>>> Colin Ian King (1):
>>>>>>>>       mmc: dw_mmc: fix spelling mistake in dev_dbg message
>>>>>>>>
>>>>>>>> Jaehoon Chung (9):
>>>>>>>>       mmc: dw_mmc: display the real register value on debugfs
>>>>>>>>       mmc: dw_mmc: fix the debug message for checking card's present
>>>>>>>>       mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
>>>>>>>>       mmc: dw_mmc: use the hold register when send stop command
>>>>>>>>       mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
>>>>>>>>       mmc: dw_mmc: use the cookie's enum values for post/pre_req()
>>>>>>>>       mmc: dw_mmc: remove the unnecessary mmc_data structure
>>>>>>>>       mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
>>>>>>>>       Documentation: synopsys-dw-mshc: remove the unused properties
>>>>>>>>
>>>>>>>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  8 ++------
>>>>>>>>  drivers/mmc/host/dw_mmc.c                                  | 92 ++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
>>>>>>>>  include/linux/mmc/dw_mmc.h                                 |  6 ++++++
>>>>>>>>  3 files changed, 52 insertions(+), 54 deletions(-)
>>>>>>>>
>>>>>>>> Best Regards,
>>>>>>>> Jaehoon Chung
>>>>>>>
>>>>>>> Dear Jaehoon, thanks for the pull request. I have add queued it all up
>>>>>>> for my next branch!
>>>>>>>
>>>>>>>
>>>>>>> Kind regards
>>>>>>> Uffe
>>>>>>
>>>>>> Jaehoon,
>>>>>>
>>>>>> It seems like some of these patches breaks Exynos 5250-arndale. Can
>>>>>> you please have a look and see what you think?
>>>>>> https://kernelci.org/boot/all/job/ulfh/kernel/v4.9-rc5-78-g52eb5d4531e4/
>>>>>
>>>>> I will check and reply. Thanks for noticing.
>>>
>>> Ulf,
>>>
>>> It's strange..My patches didn't have any dependency...
>>> There is no any log for dwmmc..and even it doesn't initialize dwmmc controller.
>>>
>>> Did you think that this failure is my patches problem? What is your thinking?
>>
>> Well, I don't know but indeed it seems a bit odd. Maybe there are some
>> interdependency that changes the behaviour for something outside
>> dw_mmc, which triggers the problems!?
>>
>> It could of course also be completely unrelated.
>>
>> I do have the Arndale board available. I will try it out within a
>> couple of days, to see if I can find something.
> 
> If there is effect..it seems that only below patch for clock..
> 
> commit 38332b0fd6c06fcecc64bc238bbb7cf80ed6bc7b
> Author: Jaehoon Chung <jh80.chung@samsung.com>
> Date:   Thu Nov 17 16:40:35 2016 +0900
> 
>     mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
> 
>     If there is no property "clock-freq-min-max", mmc->f_min should be set
>     to 400K by default. But Some SoC can be used 100K.
>     When 100K is used, MMC core will try to check from 400K to 100K.
> 
> otherwise timing?
> 
> I wonder when the below patches is applied, what happen..
> 
> https://patchwork.kernel.org/patch/9445233/
> https://patchwork.kernel.org/patch/9445209/
> https://patchwork.kernel.org/patch/9445211/
> 
> I will also check this continuously..to find before PR for next.

Dear Ulf,

It seems that related to the below patch.

https://lkml.org/lkml/2016/9/15/170


commit 212ca7c839abbec1d5ef4f29206b66b42192db22
Refs: v4.9-rc1-29-g212ca7c
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Thu Oct 27 15:50:18 2016 +0530
Commit:     Lee Jones <lee.jones@linaro.org>
CommitDate: Mon Nov 21 13:00:28 2016 +0000


Applied on v4.9-rc1..but i don't know why occurred this error.
Could you rebase your branch on v4.9-rc5 again?

Best Regards,
Jaehoon Chung

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> [...]
>>
>> Kind regards
>> Uffe
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

