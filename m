From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Wed, 14 Jan 2015 13:59:34 +0100
Message-ID: <CAPDyKFrtByPeRvU-pSc62JjthRXQJyPkTR+PcNOSDeTPXwFEoA@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>
	<54B51C55.9060500@intel.com>
	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>
	<54B52D53.8080106@intel.com>
	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>
	<54B53592.9070303@broadcom.com>
	<CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>
	<54B54187.7080008@broadcom.com>
	<CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>
	<54B63D94.2050602@intel.com>
	<CAPDyKFosO9D6sQagk1nPRZ5aTMDhYu2P7Y5jzFUdA8gAcTNJog@mail.gmail.com>
	<54B66015.1010507@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:61280 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbbANM7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jan 2015 07:59:35 -0500
Received: by mail-qg0-f48.google.com with SMTP id j5so6746126qga.7
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2015 04:59:34 -0800 (PST)
In-Reply-To: <54B66015.1010507@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend van Spriel <arend@broadcom.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

[...]

>>
>> The value from the register is also just randomly selected, only
>> difference is that it's the HW that has randomly set it.
>
> Presumably the value is chosen based on the maximum rate of temperature
> change and the corresponding effect that has on the signal.
>
>>
>> Even if the above commit was merged, I don't think it was the correct
>> way of dealing with re-tuning.
>>
>> First of all, re-tuning this is a mmc protocol specific thing should
>> be managed from the mmc core, like the approach you have taken in your
>> $subject patchset. Second I question whether the timer is useful at
>> all.
>
> The SD Host Controller Specification does not document another way to do
> mode 1 re-tuning. The timer is it. Otherwise re-tuning is never done.
>
> In the patches I sent, the driver must call mmc_retune_needed() to set
> host->need_retune = 1 otherwise mmc_retune() does nothing.
>
> I would like to extend the model to include transparently re-tuning and
> re-trying when there is a CRC error, but that is a separate issue, not
> documented in the spec but recommended by others.
>

That perfect and in line from what I heard as recommendations from
memory vendors as well.

Now, can we stop arguing about the timer and try without it?

If we do see a need for a more frequent re-tuning to happen, due to
that we get lots of CRC errors to recover from, then I think we should
look into using runtime PM instead of the timer. And that's because I
want to minimize the impact on performance.

Kind regards
Uffe
