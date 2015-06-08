From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Usage of restart_handler in pwrseq_emmc
Date: Mon, 08 Jun 2015 11:36:17 +0200
Message-ID: <55756211.1050109@samsung.com>
References: <1789396.sexGZzDeEb@diego> <556ED06B.9030601@samsung.com>
 <556F1758.4030207@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45275 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbFHJgX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 05:36:23 -0400
In-reply-to: <556F1758.4030207@roeck-us.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 2015-06-03 17:03, Guenter Roeck wrote:
> On 06/03/2015 03:01 AM, Marek Szyprowski wrote:
>> Hello,
>>
>> On 2015-06-02 17:29, Heiko St=C3=BCbner wrote:
>>> I'm confused by the pwrseq-emmc registering a restart_handler for=20
>>> resetting an
>>> emmc in a panic-reboot case at priority 129 to "schedules it just=20
>>> before
>>> system reboot".
>>>
>>> >From what I remember from the restart-handler discussion the=20
>>> actuall usage is
>>> traversing the ordered list until one registered handler sucessfull=
y=20
>>> restarts
>>> the system and not to have arbitary actions in there not related to=
=20
>>> the actual
>>> restart process?
>>>
>>> The actual documentation in kernel/reboot.c supports this assumptio=
n,
>>> describing register_restart_handler as "Register function to be=20
>>> called to
>>> reset the system".
>>>
>>>
>>> Additionally, 128 isn't even _the_ priority to reboot the system as=
=20
>>> described
>>> above and some drivers use higher priorities per default, see in
>>> drivers/power/reset arm-versatile-reboot.c; at91-reset.c;=20
>>> rmobile-reset.c and
>>> some more.
>>>
>>>
>>> So I guess this should use some other mechanism (reboot notifier)=20
>>> instead of
>>> restart_handlers?
>>
>> The first problem with reboot notifiers is that they are called too=20
>> early - before
>> device_shutdown(), what interferes with the code in mmc_bus_shutdown=
=20
>> and causes
>> lockup. The second problem is
>> that reboot notifiers are not called from emergency_restart() path. =
I=20
>> agree that
>> 129 value for priority might not be the best, maybe according to=20
>> documentation,
>> 255 value should be used to ensure that the handler will be called=20
>> first before
>> any real restart handler.
>>
>
> There is no non-real restart handler, and the documentation does not=20
> say anything
> about "called first before any real restart handler". Even with a=20
> priority of 255
> you would have no guarantee that your handler is called. Restart=20
> handlers are
> supposed to restart the system, nothing else. Actually, you have no=20
> guarantee
> that the restart handler is called in the first place - not all=20
> architectures
> support it (currently only arm, arm64, and mips do). Presumably mmc=20
> support is
> not limited to those architectures.
>
>> If you have any idea how to avoid restart handler and ensure proper=20
>> eMMC card
>> reboot sequence on any system reboot, I'm open for suggestions.
>>
>
> Why not execute the device-specific restart in the shutdown function =
?
> You could register a reboot notifier to mark that a reboot is happeni=
ng,
> and then execute the restart at the end of mmc_bus_shutdown.

Okay, this will solve one issue with reboot notifier, but there is stil=
l=20
a problem
with emergency_restart(). Do you think that it will be okay to add a ca=
ll to
restart_notifiers (for example with some higher priority) also for=20
emergency case?
If so, I can rework my emmc pwr seq driver to use it and propose a patc=
h for
emergency restart code.

Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

