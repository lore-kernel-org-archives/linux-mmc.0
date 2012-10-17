From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Support all MMC capabilities when booting
 from Device Tree
Date: Wed, 17 Oct 2012 20:53:00 +0200
Message-ID: <CAPDyKFq6YfpjCs-3Wh=RPGc-4ukUinuhVWaZ0=+WCLsc0JBWbQ@mail.gmail.com>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
	<201210151420.29930.arnd@arndb.de>
	<20121015160740.GC7662@gmail.com>
	<201210171338.01011.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52530 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757623Ab2JQSxC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 14:53:02 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6562953wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Oct 2012 11:53:01 -0700 (PDT)
In-Reply-To: <201210171338.01011.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>

On 17 October 2012 15:38, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 October 2012, Lee Jones wrote:
>> > and so on. What are you actually missing in the properties that
>> > are already there?
>>
>> MMC_CAP_ERASE
>
> This one seems to be set unconditionally on some controllers but
> not on others. Why would it need to be configurable?
>
>> MMC_CAP_UHS_SDR12
>> MMC_CAP_UHS_SDR25
>> MMC_CAP_UHS_DDR50
>
> Could this be derived from max-frequency?

No, this is likely depending on what the hw controller supports. Not
connected to the freq.
UHS also means 1.8 V I/O voltage.

>
>> MMC_CAP_1_8V_DDR
>
> Right, I suppose we need this. Should we have a minimum and maximum
> voltage added to the common properties for this?
>
>> MMC_CAP2_DETECT_ON_ERR
>> MMC_CAP2_NO_SLEEP_CMD
>
> I don't see these ones being set anywhere, but they were both
> added by Ulf. Maybe he can comment on if or why they are needed
> in devicetree, rather than being set by the driver unconditionally
> or for specific versions of the host controller.

>From ux500 perspective there are patches not been up-streamed yet
which are using these host caps, for whatever it is worth for you to
know and consider.

Actually, I think quite a few of the host caps in mmc could be debated
whether those should exist at all.
Some are directly mapped to what the host controller hw support, some
are purely what the host driver (sw) support, but then there are
others kind of "mmc/sd/sdio software support configuration" which are
kind of strange host caps to me. For example MMC_CAP2_DETECT_ON_ERR
which I invented. :-). I think it especially these "software support
configuration" caps that might be causing this dt issues.

Would be very interesting to hear if someone is sharing my thoughts
around the host caps. Or if I am totally wrong here.

Kind regards
Ulf Hansson
