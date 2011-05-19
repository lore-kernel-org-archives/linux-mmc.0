From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Thu, 19 May 2011 07:34:29 -0400
Message-ID: <BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<08119C91-F5AA-4E6A-99D4-CFB253B1AE7B@marvell.com>
	<BANLkTikVM7QbRJ2Lo2Ef3T9oGAmZ4SJzMQ@mail.gmail.com>
	<201105182238.45614.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56708 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab1ESLe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 07:34:29 -0400
Received: by vxi39 with SMTP id 39so1818079vxi.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 04:34:29 -0700 (PDT)
In-Reply-To: <201105182238.45614.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>

On Wed, May 18, 2011 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 17 May 2011, zhangfei gao wrote:
>> >> The code handle several register difference are located at
>> >> arch/arm/mach-mmp/mmp2.c is for mmp2
>> >> arch/arm/mach-mmp/pxa910.c is for pxa910 serious,
>> >> arch/arm/mach-mmp/mmp3.c is for mmp3 serious, considering there m=
ay
>> >> still registers changing.
>> >>
>> >> The board difference are directly put in board.c
>> >> For example ttc_dkb do not use wp pin, so get_ro is provided.
>> >
>> > embedding the code in these chip files stops code sharing. =A0For =
example,
>> > mmp3 has same controller as mmp2.
>>
>> If register are totally same, they can share.
>> If there is minor difference with chip upgrading, they can put in
>> different file.
>
> When we talked about similar problems in drivers during the Linaro De=
veloper
> Summit, the broad consensus was to move code from arch/arm into indiv=
idual
> device drivers, and I think this should be done for this driver too.
>
> My recommendation here would be to have no callbacks in the platform
> data at all, but instead have the code for all variants in the
> sdhci-pxa driver itself. You can still have a structure to describe
> the differences using function pointers, but it's better if that is
> part of the driver itself. In the platform data, provide a way
> to identify the variant of the controller (e.g. using an enum)
> and point to the base addresses as required.
>
> =A0 =A0 =A0 =A0Arnd
>
Hi, Arnd

Thanks for your suggestion.

To make sdhci-pxa easy to maintain, we still prefer put platform
specific difference under platform code.

"Identify controller from platform data" looks to me is same as using #=
ifdef.
The method is used in our another driver before.
More and more workaround comes when more and more platform need to
support, making the driver bigger and bigger and not easy to maintain.
Nobody remember what's the workaround purpose several years later.
So the result is we have to re-write the driver again to make it simple=
 :(

Currently, the ip is shared among mmp2, pxa910, pxa168 etc, pxa910
maintainer does not care what workaround is used on pxa168.
When mmp3 wants to reuse the ip, it's easier to not care what's the
history at all.

So we still prefer keep driver as simple as possible, while specific
platform self-maintain specific workaround , which is not aware to
other platform.

Thanks
>
