From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 5 Jan 2018 11:45:00 +0100
Message-ID: <CACRpkdY6whY4Xrt5ijhyNCDVR8LgXyi7krkeUoSMhtsBjUJZYg@mail.gmail.com>
References: <20180104201045.31139-1-linus.walleij@linaro.org>
 <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
 <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com> <OF76C564BA.6811E770-ONC125820C.00365A44-C125820C.00373E96@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:42038 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeAEKpB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 05:45:01 -0500
Received: by mail-io0-f193.google.com with SMTP id x67so5353422ioi.9
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2018 02:45:01 -0800 (PST)
In-Reply-To: <OF76C564BA.6811E770-ONC125820C.00365A44-C125820C.00373E96@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Jan 5, 2018 at 11:03 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:
>> Hey it doesn't segfault! :D
>
> Okay, so I guess it was a successfully test :D.
>
>> OK I clearly need to find a system with sdhci on it, so I dug up a laptop
>> with SDHCI to experiment on. Now trying to figure out a bit about
>> x86_64 development...
>
> Oh, sounds like fun. I'm looking forward to read from you.
>
>> > Suprisingly there is a mmcblk0rpmb partition now. I don't know what that is
>> > and if this was there before, but normally it has nothing to do
>> > with our system. On our other systems it is not present.
>
>> It is a feature of the eMMC card, and the feature list is retrieved with
>> special commands from the card. Usually eMMCs that have boot partitions
>> also have an RPMB partition.
>
> Thanks for that information, I assume it comes with a newer kernel because with
> our old 3.7.2 kernel there was nothing like that.

Actually the patch works (!) with my laptop!

It also has only SDMA as it turns out.

I'm working on trying to figure out the problem....

Yours,
Linus Walleij
