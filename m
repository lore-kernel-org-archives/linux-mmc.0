From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to include leds.h
Date: Tue, 24 Jan 2017 17:34:24 +0100
Message-ID: <87d1fcct7z.fsf@belgarion.home>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
        <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
        <87efzydusi.fsf@belgarion.home>
        <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
        <87a8aleda2.fsf@belgarion.home> <87y3y3crxl.fsf@belgarion.home>
        <CAPDyKFrxD+62MaytiYn1ROM08+wWdTXT8vcmJRs5pMDELD574g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:49919 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAXQew (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 11:34:52 -0500
In-Reply-To: <CAPDyKFrxD+62MaytiYn1ROM08+wWdTXT8vcmJRs5pMDELD574g@mail.gmail.com>
        (Ulf Hansson's message of "Tue, 24 Jan 2017 08:57:51 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 22 January 2017 at 11:25, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>
>>>> On 20 January 2017 at 09:01, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>>> So I was wondering how you made the choice of which files you add the include to
>>>>> and which you don't touch ?
>>>>
>>>> By building the pxa_defconfig, see what errors it reports and then fix them.
>>>>
>>>> Isn't pxa_defconfig building all the variants?
>>> Euh actually it should, but it's not.
>>
>> And actually thanks to a suggestion from Russell to improve my search line, I
>> came up with the command line bellow, and perhaps you could fix the others with
>> one command line and respin the patch ?
>>
>> Here it is :
>>
>> for f in $(grep -l _led arch/arm/mach-pxa/*.c | xargs grep -L linux/leds.h); do
>> sed -i '0,/^#include <linux\/[l-m].*>$/{s/\(#include <linux\/[l-m].*\)/#include
>> <linux\/leds.h>\n\1/}' $f; done
>>
>> Cheers.
>
> Robert, thanks for helping out!
>
> While running the above command-line, the following files becomes changed:
>
> arch/arm/mach-pxa/zylonite_pxa300.c
> arch/arm/mach-pxa/zylonite_pxa320.c
> arch/arm/mach-pxa/palmld.c
> arch/arm/mach-pxa/palmtc.c
> arch/arm/mach-pxa/ezx.c
> arch/arm/mach-pxa/em-x270.c
> arch/arm/mach-pxa/hx4700.c
> arch/arm/mach-pxa/magician.c
> arch/arm/mach-pxa/palmtreo.c
> arch/arm/mach-pxa/corgi_pm.c
> arch/arm/mach-pxa/spitz_pm.c
> arch/arm/mach-pxa/tosa.c
> arch/arm/mach-pxa/z2.c
Indeed.

> However, already by building pxa_defconfig, I have verified that these
> files are being build successfully without any changes needed.
Ha so for some (all ?) of them, another include is providing the leds.h,
interesting. For many of them it is either :
 - linux/power_supply.h
 - linux/gpio_charger.h
 - an mfd device (such as mfd/htc-pasic3.h)
 - etc ...

> Because of that, I am not sure I would like to make any additional
> changes as a part of this series. I think it's easier if you later on
> deal with that as clean-ups via your pxa tree instead, does that make
> sense to you as well?
Yeah as you wish, after all you're removing the leds.h and you'r patch addresses
that, it's beyond its scope to fix all pxa boards which don't include leds.h
properly.

Cheers.

-- 
Robert
