Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADCAC4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 06:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DDF60F35
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 06:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhHDG1K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 02:27:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:43804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235303AbhHDG1K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 02:27:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="210746858"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="210746858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 23:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="466985968"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2021 23:26:55 -0700
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
 <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
 <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
 <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
 <CAJU4x8uCAQoozeAqa6icVba61uo_eP+NtOxgnLzsXh6g2HeQdA@mail.gmail.com>
 <02c26834-f16e-e1c7-9ea9-36414d1c4403@intel.com>
 <CAJU4x8u+BtU5iUna0tSws9rfUTJWfHZ21jteB5nk8e_2iMJgNg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <43448d8e-c680-62bf-7414-4620e16de524@intel.com>
Date:   Wed, 4 Aug 2021 09:27:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJU4x8u+BtU5iUna0tSws9rfUTJWfHZ21jteB5nk8e_2iMJgNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/07/21 12:26 pm, Renius Chen wrote:
> Adrian Hunter <adrian.hunter@intel.com> 於 2021年7月16日 週五 下午6:27寫道：
>>
>> On 14/07/21 5:15 am, Renius Chen wrote:
>>> Hi Adrain,
>>>
>>> What do you think of this patch?
>>> Or do you have any ideas or suggestions about the modification for
>>> Ulf's comments?
>>
>> Perhaps try to define your power management requirements in terms of
>> latencies instead of request size, and then take the issue to the
>> power management mailing list and power management maintainers for
>> suggestions.  You will probably need to point out why runtime PM doesn't
>> met your requirements.
>>
> 
> Hi Adrain,
> 
> 
> Thanks for your advice.
> 
> Our purpose is only to improve the performance of 4K reads, and we
> hope that it doesn't affect any other use cases. If we look into the
> latencies, it may affect not only 4K reads but also some other use
> cases.

I just meant that, if you present the problem to people on the power
management mailing lists,  you probably need to describe the problem at
an engineering level, instead of describing your solution at a
programming level.

> 
> Behaviors of ASPM is controlled by circuits of hardware. Drivers only
> enable or disable ASPM or set some parameters for ASPM, and are not
> able to know when the device enters or exits the L0s/L1 state. So the
> PM part of drivers may not suit this case.
> 
> This patch could be simply divided into two parts:
> 1. Monitor requests.
> 2. Set a vendor specific register of GL9763e.
> 
> The part 2 is no problems we think. And Ulf thinks that the behaviors
> of part 1 should not be implemented in sdhci-pci-gli.c. Do you have
> any suggestions on where we can implement the monitoring?
> 
> Thank you.
> 
> 
> Best regards,
> 
> Renius
> 
>>>
>>> Thank you.
>>>
>>>
>>> Best regards,
>>>
>>> Renius
>>>
>>> Renius Chen <reniuschengl@gmail.com> 於 2021年7月7日 週三 下午9:49寫道：
>>>>
>>>> Ulf Hansson <ulf.hansson@linaro.org> 於 2021年7月7日 週三 下午8:16寫道：
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> Thanks, I understand what you mean.
>>>>>>
>>>>>> I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
>>>>>> drivers/mmc/host folder, and found that in some SD/MMC host controller
>>>>>> driver codes such as alcor.c, cavium.c, ...etc, there are also
>>>>>> behaviors for monitoring the request in their driver. What's the
>>>>>> difference between theirs and ours?
>>>>>
>>>>> Those checks are there to allow the HWs to be supported properly.
>>>>>
>>>>>>
>>>>>> And if the code that monitors the requstes does not belong the driver,
>>>>>> where should I implement the code and how to add some functions only
>>>>>> for GL9763e in that place, in your opinion?
>>>>>
>>>>> Honestly, I am not sure what suits your use case best.
>>>>>
>>>>> So far we have used runtime PM with a default auto suspend timeout, in
>>>>> combination with dev PM Qos. In other words, run as fast as possible
>>>>> to complete the requests in the queue then go back to idle and enter a
>>>>> low power state. Clearly, that seems not to be sufficient for your use
>>>>> case, sorry.
>>>>>
>>>> Yes, the runtime PM, auto suspend, and PM Qos are all about the
>>>> suspend/resume behaviors of the system or related to power states such
>>>> as D0/D3 of the device. But these are totally different from the ASPM
>>>> L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
>>>> behavior on the link layer and is not handled by any codes in
>>>> drivers/mmc/core or drivers/mmc/host. We'd like to try to modify the
>>>> patch by your opinions, but we are also confused about what or where
>>>> suits our use case best. So we wonder how to start the modification
>>>> and may need some suggestions to deal with the work, sorry.
>>>>
>>>> Thank you.
>>>>
>>>>
>>>> Best regards,
>>>>
>>>> Renius
>>>>
>>>>
>>>>> Kind regards
>>>>> Uffe
>>

