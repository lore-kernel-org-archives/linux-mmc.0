From: Carlo Caione <carlo@endlessm.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Thu, 5 Oct 2017 09:59:50 +0200
Message-ID: <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:54089 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdJEH7v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Oct 2017 03:59:51 -0400
Received: by mail-ua0-f176.google.com with SMTP id s41so6947262uab.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Oct 2017 00:59:51 -0700 (PDT)
In-Reply-To: <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Oct 5, 2017 at 9:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + Adrian

/cut
>> - With high speed SDHC cards I get a weird behavior where apparently
>> there is no problem but it's impossible to format the card. mkfs.ext4
>> gets stuck at:
>>
>> Discarding device blocks:    4096/3778299

Just discovered that this is just reeeeeally slow, not stuck. Still
something is fishy about this.

/cut
> Looping in Adrian, as he maintains sdhci.
>
> I guess some more useful information would also be about what commit
> you are running and whether this is a regression or not.

Yeah, some more info:

- Reproduced with the latest master on linus repo (4.14.0-rc3)
- No idea if this is a regression or not. This is a new hardware we
are trying to enable and I have never seen it working fine (I should
blindly try some old kernel)
- Windows is working fine so not an HW issue
- CPU is x5-Z8350

Thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
