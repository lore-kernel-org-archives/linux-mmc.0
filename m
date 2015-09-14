From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for
 all other voltages
Date: Mon, 14 Sep 2015 12:34:32 +0200
Message-ID: <CAPDyKFrpDPaCLNEdwP7vYM4CJfxyz-zwC8+9AJMcUG+O=GCBOA@mail.gmail.com>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
	<20150902150442.118d3305@xhacker>
	<55E6B129.1030002@linaro.org>
	<20150902162627.682cdedf@xhacker>
	<55E6E0FD.7000806@linaro.org>
	<CAPDyKFqOGsKXTCOG89Kq=F6VsDpyfnpwo+jNb+6otgPUFE_bzw@mail.gmail.com>
	<55F6969D.7090004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37434 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbbINKed (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 06:34:33 -0400
Received: by wicfx3 with SMTP id fx3so126538116wic.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 03:34:32 -0700 (PDT)
In-Reply-To: <55F6969D.7090004@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14 September 2015 at 11:42, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
>
>
> On Monday 14 September 2015 03:00 PM, Ulf Hansson wrote:
>>
>> [...]
>>
>>>>>>
>>>>>> Could this be implemented by regulator API? From patch set 3/3, the
>>>>>> pxa1928
>>>>>> voltage_switch hook is to operate the IO pad registers, this seems not
>>>>>> belong
>>>>>> to the SDHC IP core.
>>>>>>
>>>>>
>>>>> Not quite sure whether regulator would be right fit for this.
>>>>
>>>>
>>>>
>>>>   From the patche[3/3], this can be achieved by abstracting the IO PAD
>>>> as
>>>> regulators
>>>> then, we may not need to touch the core sdhci.c. But I'm not sure
>>>> whether
>>>> this
>>>> is the good solution or not.
>>>
>>>
>>>
>>> Exactly...
>>>
>>>> sdhci Maintainers and experts may have better
>>>> suggestions.
>>>>
>>>
>>> Thats is the reason I stamped it as a RFC :)
>>>
>>
>> [...]
>>
>>  From an mmc core perspective it would be preferred if you implement
>> this as a regulator (vqmmc).
>>
>> Especially since we will soon have an API for how to set the I/O
>> voltages - and the intelligence within that API is not something we
>> would like to implement for each and every host driver.
>> https://lkml.org/lkml/2015/8/31/367
>>
>
>
> I would still consider this as a regulator specific and may not address
> the IO configuration within the SoC which are module specific.
> The API regulator_set_voltage_triplet() will not have intelligence to
> differentiate whether the call is coming from MMC or somewhere else.
>
> Note that, the IO pad voltage configuration which I am referring to is
> MMC specific and applicable only when pad is configured in MMC mode. So
> technically it is not simply common pad voltage configuration.
>
>
> And I am still not sure regulator framework would be right fit for
> this. Pinctrl would have been right fit, but...since I saw f_sdh30
> driver is already doing this, which is easy fit; so adopted the same.

Pinctrl would work as well, or perhaps a combination of both pinctrl
and a regulator.

What I don't like is the solution you have suggested in patch3.

Kind regards
Uffe
