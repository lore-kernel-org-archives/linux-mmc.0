From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 2 Apr 2015 10:43:30 +0200
Message-ID: <CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
	<551BDAEA.20405@intel.com>
	<551C0A4C.9020602@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35973 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbbDBInb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2015 04:43:31 -0400
Received: by qgeb100 with SMTP id b100so23361751qge.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2015 01:43:30 -0700 (PDT)
In-Reply-To: <551C0A4C.9020602@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>

[...]
>>>>    - ability to hold off re-tuning if the card is busy
>>>
>>>
>>> What do you mean by "card is busy"?
>>
>>
>> I guess, more accurately, any time the card is in a state that is
>> incapable
>> of supporting re-tuning. For example:
>>         - DAT0 busy
>
>
> This state is not specific to re-tuning. An SDIO device can keep DAT0 busy
> at which the host controller can not start another request.

Not entirely true. Some commands are allowed during this period, for
example CMD13 (which doesn't exist for SDIO)

Anyway, I get the point. Thanks!

>
>>         - between dependent commands like erase start, end, etc
>>         - card is asleep
>> Also SDIO cards can have a custom sleep state where tuning won't work.
>
>
> Our SDIO wifi device has such a state and it can only come out of it upon
> CMD52 write or CMD14 (ExitSleep).

So how will the mmc core know about these states? I guess we will
require SDIO func drivers to deal with enable/disable or hold/release
of re-tuning then?

I don't like this, but if there is no other way... Also, we must be
very careful on which API we exports for SDIO func drivers to use. The
can easily be misinterpreted.

[...]

Kind regards
Uffe
