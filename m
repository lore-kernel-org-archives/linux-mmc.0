From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] MMC fixes for v.4.12 rc3 - take 2/2
Date: Fri, 2 Jun 2017 12:13:18 +0200
Message-ID: <bbdcdf34-4c05-b37a-5e7d-02d8a12d072d@linaro.org>
References: <CAPDyKFofp6qdgcqha6uNWJz4ApEc2y5dEkEo51LQyq-U3onpgQ@mail.gmail.com>
 <CAOesGMj=jG9RHy1WdNFy18kaCY8GjF2-srypigP1wuWzPzw5qQ@mail.gmail.com>
 <CAPDyKFr8xHRsztpMHjodpQZXH4bNMfVh_ZZvYDLpWS0Rc0JBMQ@mail.gmail.com>
 <20170529102236.GB2192@mai> <20170602000522.GH13314@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36439 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFBKNW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jun 2017 06:13:22 -0400
Received: by mail-wm0-f54.google.com with SMTP id 7so19960592wmo.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jun 2017 03:13:21 -0700 (PDT)
In-Reply-To: <20170602000522.GH13314@localhost>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>

On 02/06/2017 02:05, Olof Johansson wrote:

[ ... ]

>> For the story, this mmc/sdio is for the WiFi and this one was working for some
>> version of the bootloader which initialized the clock and set the enable line
>> for the chip. That is bad because the WiFi is working as a side effect from the
>> boot loader.
>>
>> In order to properly make support for the WiFi in the kernel, we need to sort
>> out this by:
>>
>>  - Reset the mmc
>>  - Implement the clock at the pmic level
>>  - Add the mfd clock cell
>>  - Add the DT definition
> 
> Ok, that's all fine but it's not really what we would call a fix. Hardware
> bringup and enabling of major drivers is usually done through the release
> cycle and merged in the merge window, not as "fixes" after it's closed.

Yes, I second you on that. That is the reason why I was not really
convinced about this series for -rc.

> It's not causing problems in this case, but if it happens often it runs
> the risk of causing a mess due to conflicting contributions from different
> subsystem maintainers (i.e. in particular the DT contents updates),
> and in general circumvents the development model we're keeping where
> things are tested in -next before merge, etc.
> 
> Anyway, water under the bridge but it's stuff to think about for next time
> around.

Copy that. Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

