From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCHv4 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 13 Jul 2011 21:04:14 +0530
Message-ID: <CANfBPZ-M+yrZv2r3sGYFRC4vRmD5AZ1b4FfyFYENmqH+FDgCcg@mail.gmail.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<1309538376-23260-3-git-send-email-balajitk@ti.com>
	<8739ig8wby.fsf@ti.com>
	<5D8008F58939784290FAB48F5497519846C4113396@shsmsx502.ccr.corp.intel.com>
	<87sjqaql91.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43247 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601Ab1GMPeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Jul 2011 11:34:16 -0400
In-Reply-To: <87sjqaql91.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Balaji T K <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "kishore.kadiyala@ti.com" <kishore.kadiyala@ti.com>

On Wed, Jul 13, 2011 at 8:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Dong, Chuanxiao" <chuanxiao.dong@intel.com> writes:
>
> [...]
>
>>>
>>> Basially, the question is: can the driver be reworked such that a s=
ystem
>>> suspend does not need to runtime resume the device? =A0For most dev=
ices,
>>> we kind of expect that if the device is runtime suspended, a system
>>> suspend will have nothing extra to do, but this driver runtime resu=
mes
>>> the device during system suspend in order to do "stuff", which I
>>> admitedly don't fully undestand.
>>>
>>> Ideally, the "stuff" needed for runtime suspend and system suspend =
could
>>> be made to be common such that a system suspend of a runtime suspen=
ded
>>> device would be a noop.
>>>
>>> Is this possible?
>>>
>>> Kevin
>>
>> During system suspended patch, a callback named .prepare will be fir=
st
>> done before .suspend is called, and .complete callback will be calle=
d
>> after .resume is called. These two callbacks are in pair. If driver
>> can implement the .prepare and hold the usage count in this callback=
,
>> then runtime pm suspend/resume will not happen during device
>> suspending. So there will be no need to add pm_runtime_get* and
>> pm_runtime_put* in .suspend/.resume.
>
> That doesn't avoid the problem, since the device is still runtime
> resumed and then re-suspended during system suspend.
>
> My basic question is this: why does this device need to be runtime
> resumed during system suspend? =A0Why can't it just stay runtime
> suspended?
>

=46rom my understanding, the runtime suspend is usually implemented to =
not
lose the card 'context', i.e. transactions can continue after a
runtime suspend /
resume cycle.

=46or system suspend, the MMC core sends a sleep command (which, in its=
elf,
is a transaction) to the card to go to sleep state, and for all
practical purposes,
the card is treated as 'removed'. When the system resumes, the card is =
rescanned
and re-initialized.

Hence, for system suspend, the MMC controller needs to be enabled to ac=
tually
send the command which puts the card to sleep (and hence the resume).

Best regards,
Venkat.
