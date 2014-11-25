From: Alexandru Stan <amstan@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for vqmmc
Date: Tue, 25 Nov 2014 13:11:43 -0800
Message-ID: <CAHNYxRwT8YeR-AUa-BVPraufLWZtEaeLdNjGBs77CfkMWVCNqg@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com> <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
 <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
 <5464152E.7040209@rock-chips.com> <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
 <CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>
 <CAD=FV=UJT5zBkcj2a03Y_RWxad9+Pu83G_z79Xzzn74V=eRqww@mail.gmail.com>
 <CAPDyKFqt4rrwi940KAPyPONpjixK1730QmHEsN27V97jyHH+Qw@mail.gmail.com>
 <5473EB8B.3000803@rock-chips.com> <CAD=FV=U9Hh-OR2aGh6Q9YAwnP8AuAbQtogD=7wQxgg9XvoWTMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43649 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbaKYVMI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 16:12:08 -0500
Received: by mail-oi0-f49.google.com with SMTP id i138so1040901oig.8
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 13:12:07 -0800 (PST)
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com. [209.85.214.182])
        by mx.google.com with ESMTPSA id x3sm940558obg.7.2014.11.25.13.12.06
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 13:12:06 -0800 (PST)
Received: by mail-ob0-f182.google.com with SMTP id m8so1144828obr.41
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 13:12:06 -0800 (PST)
In-Reply-To: <CAD=FV=U9Hh-OR2aGh6Q9YAwnP8AuAbQtogD=7wQxgg9XvoWTMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Addy <addy.ke@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, open list:ARM

>From what I understand... High speed SD cards have 1.8V regulators
inside them(sourced by vmmc (what we power the SD card with)). So in
terms of the SD card IO pins they will either use exactly vmmc or
1.8V. It doesn't make sense for vqmmc (the voltage we use to power the
AP block connected to the SD cards) to be anything but exactly equal
to vmmc or 1.8V. If vqmmc differs from vmmc(or 1.8V, depending on
mode) by more than a little (~100-200mV), both up or down, you start
getting leaks into the input protection diodes of the pins(either the
AP or the SD card) which is a pretty BAD thing (you're essentially
powering the sd card through the IO pins, or the SD card is powering
the IO block on the AP).

Alexandru Stan (amstan)

On Mon, Nov 24, 2014 at 9:36 PM, Doug Anderson <dianders@chromium.org> wrote:
> Addy,
>
> On Mon, Nov 24, 2014 at 6:38 PM, Addy <addy.ke@rock-chips.com> wrote:
>>> In worst case scenario, VDD = 3.6V and VIO = 2.7V. That gives as the
>>> factor of 0.75, thus we are inside spec but without margins.
>>
>> * From eMMC4.5 spec:
>>   1. (VDDF)vcc: Supply voltage for flash memory,  which is  2.7v -- 3.3v
>>   2. (VDD)vccq: Supply voltage for memory controller, which is  1.7v --
>> 1.95v  and 2,7v -- 3.6v
>>
>> * And from RK3288 datasheet:
>>   Digtial GPIO Power(SDMMC0_VDD --> vccq) is 3.0v -- 3.6v and 1.62v - 1.98v
>>
>> So I think:
>> 3.3v:  (2.7v < vccq < 3.6v)   &&  (3.0v < vccq < 3.6v)  ==> (3.0v < vccq <
>> 3.6v)
>> 1.8v:  (1.7v < vccq < 1.95v)  && (1.62v < vccq < 1.98v) ==> (1.7v < vccq <
>> 1.95v)
>>
>> and (2.7v < vcc < 3.3v)
>>
>> * And according to our hardware engineer:
>>   All of supply voltage must have +/- 10% cushion.
>>
>> * And we have found in some worse card that there is 200mv voltage collapse
>> when these card is insert.
>>
>> So I think the best resolution is that vcc and vccq is configurable int dt
>> table.
>
> Ah, interesting.  ...so what we really need to be able to do is to say
> that the regulator we for vqmmc have supports the ranges 3.0V - 3.3V
> and 1.7V - 1.95V but not anything in between 1.95V ad 3.0V.  I have no
> idea how to express that in the regulator framework.
>
> Technically you could take the IO Voltage Domains code (responsible
> for choosing the 1.8V range or the 3.3V range) and have it communicate
> the requirements to the regulator framework if you could figure out
> how to communicate them.
>
>
> ...of course if you implemented my suggestion of keeping vqmmc as the
> highest voltage <= vmmc then maybe the whole point is moot and we
> don't have to figure it out.  Just make sure that vmmc never goes
> below 3.0V.
>
>
> -Doug
