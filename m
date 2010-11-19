From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH v2 1/1]mmc: check SDIO card wake up during suspending
Date: Fri, 19 Nov 2010 10:56:22 +0800
Message-ID: <AANLkTik0mvVmCWtGVYYsJjSimdMDgKaHTQU1Z3GHmvBf@mail.gmail.com>
References: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
	<AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com>
	<AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
	<alpine.LFD.2.00.1011181319480.6448@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45877 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0KSC4Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2010 21:56:24 -0500
Received: by iwn35 with SMTP id 35so4250210iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 18 Nov 2010 18:56:23 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1011181319480.6448@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

2010/11/19 Nicolas Pitre <nico@fluxnic.net>:
> On Thu, 18 Nov 2010, Jun Nie wrote:
>
>> >From 642b2e88fc4b6344290c88ce506fcda1bcc860a3 Mon Sep 17 00:00:00 2=
001
>> From: Jun Nie <njun@marvell.com>
>> Date: Fri, 12 Nov 2010 19:43:49 +0800
>> Subject: [PATCH] mmc: check SDIO card wake up during suspending
>>
>> It is possible that SDIO card send card interrupt to wake up
>> system just after SDIO func driver and SDIO card firmware commit
>> suspend state, while system is still in suspending process and
>> mmc interrupt is not release yet.
>>
>> Interrupt storm may happen if func driver does not notify firmware
>> to clear the wake up source. If func driver issue SDIO bus transacti=
on
>> to have firmware clear the source and driver continue to handle the
>> wake up event, system may enter suspend before all transaction done.
>> In this case, SDIO card will not enter lower power mode never. But
>> system can not be wake up for only card insert/remove/interrupt irq =
are
>> listed in wake up source in SD spec. Data/command done irq can
>> not wake up system.
>>
>> This patch check SDIO card interrupt and stop system suspend if ther=
e
>> are card interrupt after func driver suspend.
>>
>> Signed-off-by: Jun Nie <njun@marvell.com>
>
> There is a structural problem with your patch. =A0Why do you have to =
dig
> into card specific data from sdhci_suspend_host()? =A0The fact that y=
ou
> need to include mmc/card.h into sdhci.c is a sign of layering
> violation, and all host drivers would have to be similarly modified,
> leading to unmaintainable code. =A0While the race might be real, ther=
e has
> to be another way to fix it.
>
>
> Nicolas
>

Ohad,
Thank you! I will look at the framework and submit new patch later.

Nicolas
Thanks to point out layer structure issue that I did not notice.

Jun
