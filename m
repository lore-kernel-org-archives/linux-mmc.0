From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: prepend 0x to hex numbers in sysfs
Date: Thu, 23 Nov 2017 19:12:06 +0100
Message-ID: <CAPDyKFoLqNyDbj6cai7h0KgszeON00s3dK_rCccQjVeZoS+_UA@mail.gmail.com>
References: <20171116113000.25044-1-bst@pengutronix.de> <CAPDyKForkLBLn059w1HJh8TCZTAim8RY3GF=ic5ot+_zEh6UzQ@mail.gmail.com>
 <CAOmT4fTZDhaFse8TFdzeaBEfs2TF9CimN0imFB6zGZdwNwWDVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:44911 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbdKWSMH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Nov 2017 13:12:07 -0500
Received: by mail-it0-f66.google.com with SMTP id b5so10929151itc.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2017 10:12:07 -0800 (PST)
In-Reply-To: <CAOmT4fTZDhaFse8TFdzeaBEfs2TF9CimN0imFB6zGZdwNwWDVQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bojan prtvar <prtvar.b@gmail.com>
Cc: Bastian Stender <bst@pengutronix.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 23 November 2017 at 15:22, bojan prtvar <prtvar.b@gmail.com> wrote:
>
>
> On Thu, Nov 23, 2017 at 2:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 16 November 2017 at 12:30, Bastian Stender <bst@pengutronix.de> wrote:
>> > The sysfs entries "pre_eol_info" and "ocr" were missing the 0x prefix
>> > to identify them as hex formatted.
>> >
>> > Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
>> > Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information
>> > through sysfs")
>> > Signed-off-by: Bastian Stender <bst@pengutronix.de>
>>
>> Bastian, would you mind splitting this into two patches. I need that
>> to be able to add correct stable tags to each of them.
>>
>> Kind regards
>> Uffe
>
>
>
> For the OCR part, maybe we should change the drivers/mmc/core/sd.c as well.

Yeah, makes sense. Please post a patch. :-)

Kind regards
Uffe
