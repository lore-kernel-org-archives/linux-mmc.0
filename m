From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: DT: Allow to specify that no write
 protect signal is present
Date: Tue, 5 May 2015 12:15:13 +0200
Message-ID: <CAPDyKFrpTLZokiHCKCafh6neBmYpDtk2hLq6X57rzR8GY-bgug@mail.gmail.com>
References: <1430214020-16816-1-git-send-email-lars@metafoo.de>
	<1430214020-16816-2-git-send-email-lars@metafoo.de>
	<CAPDyKFpC9uc0n8HLiC1gWgdJOM-0DGVaNazkF3Q847r-sfXNtg@mail.gmail.com>
	<554887B0.4020407@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35711 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675AbbEEKPO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 06:15:14 -0400
Received: by qkhg7 with SMTP id g7so101998612qkh.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 03:15:14 -0700 (PDT)
In-Reply-To: <554887B0.4020407@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 5 May 2015 at 11:04, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 05/05/2015 10:36 AM, Ulf Hansson wrote:
> [...]
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
>>> b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> index 438899e..b068549 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> @@ -21,6 +21,7 @@ Optional properties:
>>>     below for the case, when a GPIO is used for the CD line
>>>   - wp-inverted: when present, polarity on the WP line is inverted. See
>>> the note
>>>     below for the case, when a GPIO is used for the WP line
>>> +- disable-wp: When set no physical WP line is present
>>
>>
>> This requires some additional explanation, I believe. I assume this
>> property is only relevant for those controllers that have internal
>> logic to handle WP!?
>
>
> Yes, currently drivers for controllers that have a built-in WP detection
> logic typically assume that if no WP GPIO is specified the built-in WP logic
> should be used. But for some of them the value returned by the internal
> detection logic will be bogus if there is no WP signal connected. So we need
> a way to specify that that there is no WP signal and the internal detection
> logic shouldn't be used either.
>
>>
>> For those that uses GPIO, this can't ever be a correct configuration.
>> Right?
>
>
> It wouldn't make much sense to use it with a GPIO based detection logic,
> since you simply don't specify the wp-gpio property if it is not present.
> One the other hand it wouldn't cause any harm to specify it in addition to
> not specifying the wp-gpios property.
>
> How about:
>
> - disable-wp: When set no physical WP line is present. This property should
> only be specified when the controller has a dedicated write-protect
> detection logic. If a GPIO is used for write-protect detection logic is used

Remove the last "is used".

> it is sufficient to not specify wp-gpios property in the absence of a WP
> line.

Looks good!

Kind regards
Uffe
