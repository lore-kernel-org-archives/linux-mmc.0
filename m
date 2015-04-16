From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Thu, 16 Apr 2015 17:19:13 +0200
Message-ID: <CAPDyKFpoyDKOF5guaQfzHpkhoU8qesNY=D_c-dKfHtZHKK51MA@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>
	<552F805B.9080003@intel.com>
	<CAPDyKFr_7giwZt76z3TnoqqJbQPBUJqRj1cepFR888FiseraGg@mail.gmail.com>
	<552FB81D.9060709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:34479 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbDPPTO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 11:19:14 -0400
Received: by qcyk17 with SMTP id k17so8062025qcy.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 08:19:13 -0700 (PDT)
In-Reply-To: <552FB81D.9060709@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

[...]

>>>> 1) Card removal/detect (hold/release?)
>>>
>>> Re-tuning will be done if needed before detect (because it is done before a
>>> request), which is necessary because detect can fail if tuning is needed.
>>>
>>> Re-tuning is done before a request. Requests aren't started if the card has
>>> been removed i.e. mmc_start_request() calls mmc_card_removed()
>>>
>>> If tuning is executed while a card is being removed, then the tuning will
>>> fail and the request will be errored out.
>>
>> So you are saying that we instead of relying on the CMD13 (for SD/MMC)
>> to check whether the card is still alive, it's fine to trigger a
>> re-tuning instead.
>
> (Oops forgot to answer this one, sorry)
>
> Yes, why not?
>
>>
>> I don't think that is an effective way to remove a card.
>
> Generally we know the card is removed from card-detect so no commands are
> sent in either case.

Not sure what you mean here.

In case when the card is "idle" and the host sees a GPIO CD irq, it
will trigger a detect work to run mmc_rescan().

In this case, it's the responsibility of mmc_rescan() to find out if
the card is being removed. It does so by invoking the
bus_ops->detect() callback, which eventually will send a CMD13 for
mmc/sd.

In this scenario, I can't see why we want to allow re-tuning to happen
in front of the CMD13 command.

>
>>
>> Moreover, I find it quite unreasonable to say the check for an alive
>> card, would fail because of that a re-tuning is needed. That would in
>> principle mean that we never should be able to hold re-tune for any
>> commands sequences.
>
> Re-tuning must work if the card is alive. CMD13 might get a CRC error if
> re-tuning is needed.

And that then applies to all commands which we hold re-tuning for. So
then we can't _ever_  hold re-tuning for any command, since we might
get CRC errors.

Kind regards
Uffe
