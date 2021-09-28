Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D0C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7333F61131
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbhI1KVO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:21:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:43064 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239952AbhI1KVO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Sep 2021 06:21:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224315857"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="224315857"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 03:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="553933229"
Received: from ahunter-desktop.fi.intel.com (HELO [10.42.0.236]) ([10.237.72.84])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2021 03:19:27 -0700
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <32b753ff-6702-fa51-2df2-32ff1d955a23@intel.com>
Date:   Tue, 28 Sep 2021 13:18:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/09/2021 00:33, Bean Huo wrote:
> On Fri, 2021-09-24 at 16:26 +0300, Adrian Hunter wrote:
>> On 24/09/21 4:08 pm, Bean Huo wrote:
>>> On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
>>>>>>>          sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>>>>>>> }
>>>>>>> The driver has detected that the hardware timer cannot meet
>>>>>>> the
>>>>>>> timeout
>>>>>>> requirements of the device, but we still use the hardware
>>>>>>> timer,
>>>>>>> which will
>>>>>>> allow potential timeout issuea . Rather than allowing a
>>>>>>> potential
>>>>>>> problem to exist, why can’t software timing be used to
>>>>>>> avoid
>>>>>>> this
>>>>>>> problem?
>>>>>> Timeouts aren't that accurate.  The maximum is assumed still
>>>>>> to
>>>>>> work.
>>>>>> mmc->max_busy_timeout is used to tell the core what the
>>>>>> maximum
>>>>>> is.
>>>>> mmc->max_busy_timeout is still a representation of Host HW
>>>>> timer
>>>>> maximum timeout count, isn't it? 
>>>>
>>>> Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it would be
>>>>
>>>> set to zero to indicate no maximum.
>>>
>>> yes, this is the purpose of the patch, for the host controller
>>> without
>>> quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count
>>> required by
>>> device is beyond the HW timer max count, we choose SW timer to
>>> avoid the HW timer timeout IRQ.
>>>
>>> I don't know if I get it correctly.
>>
>> Why can't drivers that want the behaviour just set the quirk?
>>
>> Drivers that do not work with the quirk, do not have to set it.
> 
> 
> Adrian,
> 
> We cannot add this quirk to every host driver.

I was suggesting only the ones for which it works.

>  This is the difference
> on the device side.

It is the host controller that has the problem, not the device.
Hence the quirk.

> In addition, I don't know what the maximum hardware
> timer budget for each host is.

mmc->max_busy_timeout is calculated by sdhci.c, or the driver can
override the maximum count via ->get_max_timeout_count() or the driver
can override mmc->max_busy_timeout.

With the quirk, sdhci.c will usually set mmc->max_busy_timeout to zero.
That allows timeouts greater than the hardware can support, and then,
with the quirk, the driver will switch to a software timeout when needed.

However, that won't work for every host controller, because some do not
provide a completion interrupt after the timeout, even if the timeout
interrupt is disabled.  That means they should set mmc->max_busy_timeout
to the hardware value.  Hence the quirk is needed to tell the difference.

> Even if you use the same SOC, the
> maximum time budget on different platforms may be different.

The mmc core calculates timeouts based on the relevant standards and
values provided by the device itself.

> Assume that the maximum timeout time supported by the hardware timer is
> 100 milliseconds

I realise it is an example, but 100 milliseconds is a bit low. Legacy
host controllers have always had to deal with standard SD card and
MMC card timeouts.  SD card write timeout of 500 milliseconds for instance.

> but the maximum data transmission time required by
> the device is 150 milliseconds. In most cases, data transfer will not
> take so long. 150 is the maximum time under extreme conditions. This
> means that the device just needs to complete a data transfer within
>> 100ms and keep the data line busy. If we still use the HW timer, it
> will trigger a DATA LINE timeout interrupt.
> 
> This patch does not affect scenarios where the hardware timer meets the
> max data transmission time requirements of the device. It will still
> use the hardware timer. Only when the device changes, will it switch to
> using the SW timer.

Which is what the quirk does.  So I am very confused why the quirk is
no good?
