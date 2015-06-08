From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Usage of restart_handler in pwrseq_emmc
Date: Mon, 08 Jun 2015 08:00:01 -0700
Message-ID: <5575ADF1.3020307@roeck-us.net>
References: <1789396.sexGZzDeEb@diego> <556ED06B.9030601@samsung.com> <556F1758.4030207@roeck-us.net> <55756211.1050109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55756211.1050109@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?B?SGVpa28gU3TDvGI=?= =?UTF-8?B?bmVy?= <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 06/08/2015 02:36 AM, Marek Szyprowski wrote:
> Hello,
>
> On 2015-06-03 17:03, Guenter Roeck wrote:
>> On 06/03/2015 03:01 AM, Marek Szyprowski wrote:
>>> Hello,
>>>
>>> On 2015-06-02 17:29, Heiko St=C3=BCbner wrote:
>>>> I'm confused by the pwrseq-emmc registering a restart_handler for =
resetting an
>>>> emmc in a panic-reboot case at priority 129 to "schedules it just =
before
>>>> system reboot".
>>>>
>>>> >From what I remember from the restart-handler discussion the actu=
all usage is
>>>> traversing the ordered list until one registered handler sucessful=
ly restarts
>>>> the system and not to have arbitary actions in there not related t=
o the actual
>>>> restart process?
>>>>
>>>> The actual documentation in kernel/reboot.c supports this assumpti=
on,
>>>> describing register_restart_handler as "Register function to be ca=
lled to
>>>> reset the system".
>>>>
>>>>
>>>> Additionally, 128 isn't even _the_ priority to reboot the system a=
s described
>>>> above and some drivers use higher priorities per default, see in
>>>> drivers/power/reset arm-versatile-reboot.c; at91-reset.c; rmobile-=
reset.c and
>>>> some more.
>>>>
>>>>
>>>> So I guess this should use some other mechanism (reboot notifier) =
instead of
>>>> restart_handlers?
>>>
>>> The first problem with reboot notifiers is that they are called too=
 early - before
>>> device_shutdown(), what interferes with the code in mmc_bus_shutdow=
n and causes
>>> lockup. The second problem is
>>> that reboot notifiers are not called from emergency_restart() path.=
 I agree that
>>> 129 value for priority might not be the best, maybe according to do=
cumentation,
>>> 255 value should be used to ensure that the handler will be called =
first before
>>> any real restart handler.
>>>
>>
>> There is no non-real restart handler, and the documentation does not=
 say anything
>> about "called first before any real restart handler". Even with a pr=
iority of 255
>> you would have no guarantee that your handler is called. Restart han=
dlers are
>> supposed to restart the system, nothing else. Actually, you have no =
guarantee
>> that the restart handler is called in the first place - not all arch=
itectures
>> support it (currently only arm, arm64, and mips do). Presumably mmc =
support is
>> not limited to those architectures.
>>
>>> If you have any idea how to avoid restart handler and ensure proper=
 eMMC card
>>> reboot sequence on any system reboot, I'm open for suggestions.
>>>
>>
>> Why not execute the device-specific restart in the shutdown functi
>> You could register a reboot notifier to mark that a reboot is happen=
ing,
>> and then execute the restart at the end of mmc_bus_shutdown.
>
> Okay, this will solve one issue with reboot notifier, but there is st=
ill a problem
> with emergency_restart(). Do you think that it will be okay to add a =
call to
> restart_notifiers (for example with some higher priority) also for em=
ergency case?
> If so, I can rework my emmc pwr seq driver to use it and propose a pa=
tch for
> emergency restart code.
>
I don't think so. The restart handlers are called from machine_restart(=
),
and it is up to the architecture maintainers to decide if they want to =
use it
or not. Besides, we'd need to extend the restart handler API to permit =
this use
case.

The comment with emergency_restart() specifically states "without shutt=
ing down
any hardware", so it may be difficult to add anything there.

I would suggest to ask the power maintainers for advice; we can discuss=
 lots of
things, but ultimately they will be the ones who need to agree.

Thanks,
Guenter
