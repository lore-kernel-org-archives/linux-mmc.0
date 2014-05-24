From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/14] Add Qualcomm SD Card Controller support
Date: Sat, 24 May 2014 08:32:39 +0100
Message-ID: <53804B17.6080800@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>	<537EF50B.2010101@linaro.org>	<CAPDyKFpTXrURM8OzNjO-RRfCFWGct4+_M4D8COdEurUhY46GWg@mail.gmail.com>	<537F02CA.5070304@linaro.org>	<CAJAp7OgkYg12C42yMqL+CJQG3hN2KeNs7L-ZO4b9JMAb_ofYog@mail.gmail.com>	<537F7C4B.4010005@linaro.org> <CAJAp7Oj3z4_GWHXdBO5+7AVriYh0fxb0XT2UESW-DmpQ9gSGTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:44460 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaEXHco (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 24 May 2014 03:32:44 -0400
Received: by mail-we0-f176.google.com with SMTP id q59so5637347wes.21
        for <linux-mmc@vger.kernel.org>; Sat, 24 May 2014 00:32:42 -0700 (PDT)
In-Reply-To: <CAJAp7Oj3z4_GWHXdBO5+7AVriYh0fxb0XT2UESW-DmpQ9gSGTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

Thanks Bjorn,


On 24/05/14 00:26, Bjorn Andersson wrote:
> On Fri, May 23, 2014 at 9:50 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Hi Bjorn,
>>
>> Thanks for the update.
>
> Hi Srini,
>
> After pulling in Ulfs next branch again and reapplying v3 my issues
> are now gone. Not sure what I screwed up when I merged v2, this seems
> to work just fine now. Sorry for the fuzz.
>
That's fantastic news and just in time.

Hopefully we could make these patches for 3.16?

thanks,
srini

> I haven't done any extensive testing, but my CRC issues are definitely
> sorted out. I will go ahead and see if I can get external mmc working
> now as well.
>
> Regards,
> Bjorn
>
