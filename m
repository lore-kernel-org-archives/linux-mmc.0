From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: Remove power_restore bus_ops for mmc and sd
Date: Thu, 4 Apr 2013 13:52:17 +0200
Message-ID: <CAPDyKFq--WgU4XDtsdzU2DN36G0bHN+UGG6N8Q2p0Fue9XJqvQ@mail.gmail.com>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
	<1362142035-8403-2-git-send-email-ulf.hansson@stericsson.com>
	<515D3DCC.8000505@intel.com>
	<CAPDyKFr983eazpW=ky2knujur+RND4m0nL=n1pZmUyzxVSe3uA@mail.gmail.com>
	<515D6791.4010803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:56973 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab3DDLwS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 07:52:18 -0400
Received: by mail-ve0-f173.google.com with SMTP id cy12so2565401veb.32
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 04:52:17 -0700 (PDT)
In-Reply-To: <515D6791.4010803@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>

On 4 April 2013 13:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/04/13 12:55, Ulf Hansson wrote:
>> On 4 April 2013 10:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 01/03/13 14:47, Ulf Hansson wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> The mmc_power_restore|save_host API is only used by SDIO func drivers. SDIO
>>>
>>> NAK - it is also used by eMMC hardware reset i.e. mmc_do_hw_reset()
>>
>> True for eMMC, but for SD card the bus_ops can go away. Thanks for
>> spotting this Adrian!
>>
>> Although, I see some serious problems with the mmc_do_hw_reset
>> function - it could cause eMMC data corruption.
>>
>> Issuing hw reset and doing re-initialization by using the mmc
>> bus_ops->power_restore will mean no consideration is taken to "cache
>> ctrl", "bkops" and "power off notify". I think it must.
>>
>> So the more proper way instead of calling power_restore, should be to
>> use bus_ops->suspend and bus_ops->resume callbacks from the
>> mmc_do_hw_reset function. Additionally if bus_ops->suspend is done
>> successfully, we should be able to skip the actual hw reset and just
>> do bus_ops->resume.
>>
>> Do you have any thoughts on this?
>
> Certainly the bootloader should leave the eMMC is a safe state including:
> flushing the cache or turning it off (why did it turn on?), stopping
> background operations (why did it start them?), disabling power-off
> notification CMD0? (again why it it enable it?)

Not sure what you mean here. What has a booloader to do with this?

>
> Note that according to spec. CMD0 anyway clears the cache so you have lost
> your data anyway.

What I am saying that we can try send "cache ctrl" and "power off
notify" before we send CMD0 / do hw reset. The no data shall be lost.

>
>
