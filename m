From: Carlo Caione <carlo@endlessm.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Thu, 5 Oct 2017 10:26:59 +0200
Message-ID: <CAL9uMOHbx4+bEfaiX-NP5q_OzUqbo0O-fb4_oSPQGs0h4tOdtQ@mail.gmail.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
 <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com> <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:48526 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdJEI1A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Oct 2017 04:27:00 -0400
Received: by mail-ua0-f177.google.com with SMTP id z4so511578uaz.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Oct 2017 01:27:00 -0700 (PDT)
In-Reply-To: <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Thu, Oct 5, 2017 at 10:10 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 05/10/17 10:59, Carlo Caione wrote:
>> On Thu, Oct 5, 2017 at 9:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> + Adrian
>>
>> /cut
>>>> - With high speed SDHC cards I get a weird behavior where apparently
>>>> there is no problem but it's impossible to format the card. mkfs.ext4
>>>> gets stuck at:
>>>>
>>>> Discarding device blocks:    4096/3778299
>>
>> Just discovered that this is just reeeeeally slow, not stuck. Still
>> something is fishy about this.
>>
>> /cut
>>> Looping in Adrian, as he maintains sdhci.
>>>
>>> I guess some more useful information would also be about what commit
>>> you are running and whether this is a regression or not.
>>
>> Yeah, some more info:
>>
>> - Reproduced with the latest master on linus repo (4.14.0-rc3)
>> - No idea if this is a regression or not. This is a new hardware we
>> are trying to enable and I have never seen it working fine (I should
>> blindly try some old kernel)
>> - Windows is working fine so not an HW issue
>> - CPU is x5-Z8350
>
> Can you provide an acpidump?

DSDT https://paste.fedoraproject.org/paste/DXlkVidxM7U9LS2OpqvLGQ/raw

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
