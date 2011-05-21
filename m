From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Sat, 21 May 2011 09:50:52 +0800
Message-ID: <BANLkTikZ5heBn+1=4yqKK0+=1ykZNyubEQ@mail.gmail.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<08119C91-F5AA-4E6A-99D4-CFB253B1AE7B@marvell.com>
	<BANLkTikVM7QbRJ2Lo2Ef3T9oGAmZ4SJzMQ@mail.gmail.com>
	<201105182238.45614.arnd@arndb.de>
	<BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
	<alpine.LFD.2.00.1105191413050.14430@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48441 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1EUBuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 21:50:54 -0400
Received: by vxi39 with SMTP id 39so3049909vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 18:50:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1105191413050.14430@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>

On Fri, May 20, 2011 at 2:24 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 19 May 2011, zhangfei gao wrote:
>
>> On Wed, May 18, 2011 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> > On Tuesday 17 May 2011, zhangfei gao wrote:
>> >> >> The code handle several register difference are located at
>> >> >> arch/arm/mach-mmp/mmp2.c is for mmp2
>> >> >> arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
>> >> >> arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering ther=
e may
>> >> >> still registers changing.
>> >> >>
>> >> >> The board difference are directly put in board.c
>> >> >> For example ttc_dkb do not use wp pin, so get_ro is provided.
>> >> >
>> >> > embedding the code in these chip files stops code sharing. =A0F=
or example,
>> >> > mmp3 has same controller as mmp2.
>> >>
>> >> If register are totally same, they can share.
>> >> If there is minor difference with chip upgrading, they can put in
>> >> different file.
>> >
>> > When we talked about similar problems in drivers during the Linaro=
 Developer
>> > Summit, the broad consensus was to move code from arch/arm into in=
dividual
>> > device drivers, and I think this should be done for this driver to=
o.
>> >
>> > My recommendation here would be to have no callbacks in the platfo=
rm
>> > data at all, but instead have the code for all variants in the
>> > sdhci-pxa driver itself. You can still have a structure to describ=
e
>> > the differences using function pointers, but it's better if that i=
s
>> > part of the driver itself. In the platform data, provide a way
>> > to identify the variant of the controller (e.g. using an enum)
>> > and point to the base addresses as required.
>> >
>> > =A0 =A0 =A0 =A0Arnd
>> >
>> Hi, Arnd
>>
>> Thanks for your suggestion.
>>
>> To make sdhci-pxa easy to maintain, we still prefer put platform
>> specific difference under platform code.
>
> That's fine to split out platform differences. =A0However please put =
those
> differences, maybe in different files, but alongside the driver itsel=
f
> in drivers/mmc/host/sdhci-pxa-pxa910.c, sdhci-pxa-mmp2.c, etc. We don=
't
> want to see driver specific stuff hidden in arch/arm/mach-pxa/ or the
> like.
>
>> More and more workaround comes when more and more platform need to
>> support, making the driver bigger and bigger and not easy to maintai=
n.
>> Nobody remember what's the workaround purpose several years later.
>
> You really really should spend more time documenting those workaround=
s
> in the source directly in that case. =A0Anyone not familiar with the
> issues should be able to understand why a given workaround is there,
> whether it is today or in several years. =A0And this is why we want d=
river
> stuff go in the driver directory where more people specifically
> interested in MMC/SD are looking.

Thanks for explanation, will update accordingly.
>
>
> Nicolas
>
