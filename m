Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3CC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BA661406
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbhI2Mj6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Sep 2021 08:39:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:21285 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343735AbhI2Mj6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Sep 2021 08:39:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285944712"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="285944712"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 05:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="707248480"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2021 05:38:13 -0700
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
To:     Bean Huo <huobean@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917172727.26834-1-huobean@gmail.com>
 <20210917172727.26834-3-huobean@gmail.com>
 <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
 <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
 <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
 <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
 <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
 <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
 <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
 <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
 <32b753ff-6702-fa51-2df2-32ff1d955a23@intel.com>
 <296607ef57f3fb632107997f4edca99a5722beab.camel@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b7fd4a22-65f6-d1c4-675c-5930452a1fea@intel.com>
Date:   Wed, 29 Sep 2021 15:38:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <296607ef57f3fb632107997f4edca99a5722beab.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/09/2021 13:49, Bean Huo wrote:
> Hi Adrian,
> 
> On Tue, 2021-09-28 at 13:18 +0300, Adrian Hunter wrote:
>> On 25/09/2021 00:33, Bean Huo wrote:
>>> On Fri, 2021-09-24 at 16:26 +0300, Adrian Hunter wrote:
>>>> On 24/09/21 4:08 pm, Bean Huo wrote:
>>>>> On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
>>>>>>>>>          sdhci_writeb(host, count,
>>>>>>>>> SDHCI_TIMEOUT_CONTROL);
>>>>>>>>> }
>>>>>>>>> The driver has detected that the hardware timer cannot
>>>>>>>>> meet
>>>>>>>>> the
>>>>>>>>> timeout
>>>>>>>>> requirements of the device, but we still use the
>>>>>>>>> hardware
>>>>>>>>> timer,
>>>>>>>>> which will
>>>>>>>>> allow potential timeout issuea . Rather than allowing a
>>>>>>>>> potential
>>>>>>>>> problem to exist, why can’t software timing be used to
>>>>>>>>> avoid
>>>>>>>>> this
>>>>>>>>> problem?
>>>>>>>> Timeouts aren't that accurate.  The maximum is assumed
>>>>>>>> still
>>>>>>>> to
>>>>>>>> work.
>>>>>>>> mmc->max_busy_timeout is used to tell the core what the
>>>>>>>> maximum
>>>>>>>> is.
>>>>>>> mmc->max_busy_timeout is still a representation of Host HW
>>>>>>> timer
>>>>>>> maximum timeout count, isn't it? 
>>>>>>
>>>>>> Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it
>>>>>> would be
>>>>>>
>>>>>> set to zero to indicate no maximum.
>>>>>
>>>>> yes, this is the purpose of the patch, for the host controller
>>>>> without
>>>>> quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count
>>>>> required by
>>>>> device is beyond the HW timer max count, we choose SW timer to
>>>>> avoid the HW timer timeout IRQ.
>>>>>
>>>>> I don't know if I get it correctly.
>>>>
>>>> Why can't drivers that want the behaviour just set the quirk?
>>>>
>>>> Drivers that do not work with the quirk, do not have to set it.
>>>
>>> Adrian,
>>>
>>> We cannot add this quirk to every host driver.
>>
>> I was suggesting only the ones for which it works.
>>
>>>  This is the difference
>>> on the device side.
>>
>> It is the host controller that has the problem, not the device.
>> Hence the quirk.
>>
>>> In addition, I don't know what the maximum hardware
>>> timer budget for each host is.
>>
>> mmc->max_busy_timeout is calculated by sdhci.c, or the driver can
>> override the maximum count via ->get_max_timeout_count() or the
>> driver
>> can override mmc->max_busy_timeout.
>>
>> With the quirk, sdhci.c will usually set mmc->max_busy_timeout to
>> zero.
>> That allows timeouts greater than the hardware can support, and then,
>> with the quirk, the driver will switch to a software timeout when
>> needed.
>>
> 
> 
> According to your above statement, do you mean that the eMMC host
> controller does not support the scenario where the data transmission
> timeout value required by the eMMC device is greater than the capacity
> of the eMMC host hardware data transmission timer? Unless the eMMC host
> vendor accepts their eMMC host accepts the use of SW timers in this
> case (adding quirks)?

Yes

>> However, that won't work for every host controller, because some do
>> not
>> provide a completion interrupt after the timeout, even if the timeout
>> interrupt is disabled.  
> 
> Do you mean that if we disable the hardware timer/timeout interrupt and
> use the software timer, the eMMC host controller will not trigger a
> completion interrupt?

Yes.  On some hardware, if the timeout interrupt is disabled, and the
operation takes longer than the hardware timeout value, then there is
no completion interrupt.  It is as if the timeout "happens" even if the
interrupt is disabled.

> Even before the SW timer expires, the data
> transfer between the host and the eMMC device is complete? Is this what
> you mean?

I'm not 100% sure about what happens if the operation completes
before the hardware timeout value, but I think it gets a completion
interrupt same as normal.

> 
> 
>> That means they should set mmc->max_busy_timeout
>> to the hardware value.  Hence the quirk is needed to tell the
>> difference.
>>
> 
> This means this quirk is for eMMC host can privode the completion
> interrupt in case HW timer is disabled?  

Yes

>>> Even if you use the same SOC, the
>>> maximum time budget on different platforms may be different.
>>
>> The mmc core calculates timeouts based on the relevant standards and
>> values provided by the device itself.
> 
> 
> Yes, but the eMMC standard does not define the maximum timeout value.
> Different eMMC will have different timeout values.
> 
>>
>>> Assume that the maximum timeout time supported by the hardware
>>> timer is
>>> 100 milliseconds
>>
>> I realise it is an example, but 100 milliseconds is a bit low. Legacy
>> host controllers have always had to deal with standard SD card and
>> MMC card timeouts.  SD card write timeout of 500 milliseconds for
>> instance.
> 
> 
> Yes, this is just an example. I have several platforms, they are TI,
> NXP, Intel and Qcom. The timeout time of the hardware timer is
> different, the greatest one is 1.3s, some are less than 500ms.
> 
>>
>>> but the maximum data transmission time required by
>>> the device is 150 milliseconds. In most cases, data transfer will
>>> not
>>> take so long. 150 is the maximum time under extreme conditions.
>>> This
>>> means that the device just needs to complete a data transfer within
>>>> 100ms and keep the data line busy. If we still use the HW timer,
>>>> it
>>> will trigger a DATA LINE timeout interrupt.
>>>
>>> This patch does not affect scenarios where the hardware timer meets
>>> the
>>> max data transmission time requirements of the device. It will
>>> still
>>> use the hardware timer. Only when the device changes, will it
>>> switch to
>>> using the SW timer.
>>
>> Which is what the quirk does.  So I am very confused why the quirk is
>> no goo
> 
> Because I don't know what the maximum volume of the real hardware timer
> of each host controller is.> And different hosts have different timer
> capacities.
> Meanwhile, the eMMC devices have different data
> transmission timeout between the different density/series as well.
> 
> Would you please confirm your three points above? If they are true, I
> agree we cannot disable hardware timers and use SW tiner on some
> platforms.

Yes, I expect the quirk will do what you need.  Have you tried it?
