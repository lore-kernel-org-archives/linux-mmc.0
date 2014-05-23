From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v2 00/14] Add Qualcomm SD Card Controller support
Date: Fri, 23 May 2014 16:26:09 -0700
Message-ID: <CAJAp7Oj3z4_GWHXdBO5+7AVriYh0fxb0XT2UESW-DmpQ9gSGTQ@mail.gmail.com>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
	<537EF50B.2010101@linaro.org>
	<CAPDyKFpTXrURM8OzNjO-RRfCFWGct4+_M4D8COdEurUhY46GWg@mail.gmail.com>
	<537F02CA.5070304@linaro.org>
	<CAJAp7OgkYg12C42yMqL+CJQG3hN2KeNs7L-ZO4b9JMAb_ofYog@mail.gmail.com>
	<537F7C4B.4010005@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50914 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaEWX0L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 19:26:11 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so6330720oac.11
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 16:26:09 -0700 (PDT)
In-Reply-To: <537F7C4B.4010005@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Fri, May 23, 2014 at 9:50 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Hi Bjorn,
>
> Thanks for the update.

Hi Srini,

After pulling in Ulfs next branch again and reapplying v3 my issues
are now gone. Not sure what I screwed up when I merged v2, this seems
to work just fine now. Sorry for the fuzz.

I haven't done any extensive testing, but my CRC issues are definitely
sorted out. I will go ahead and see if I can get external mmc working
now as well.

Regards,
Bjorn
