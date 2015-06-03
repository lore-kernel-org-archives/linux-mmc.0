From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Usage of restart_handler in pwrseq_emmc
Date: Wed, 03 Jun 2015 08:03:52 -0700
Message-ID: <556F1758.4030207@roeck-us.net>
References: <1789396.sexGZzDeEb@diego> <556ED06B.9030601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <556ED06B.9030601@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?B?SGVpa28gU3TDvGI=?= =?UTF-8?B?bmVy?= <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 06/03/2015 03:01 AM, Marek Szyprowski wrote:
> Hello,
>
> On 2015-06-02 17:29, Heiko St=C3=BCbner wrote:
>> I'm confused by the pwrseq-emmc registering a restart_handler for re=
setting an
>> emmc in a panic-reboot case at priority 129 to "schedules it just be=
fore
>> system reboot".
>>
>> >From what I remember from the restart-handler discussion the actual=
l usage is
>> traversing the ordered list until one registered handler sucessfully=
 restarts
>> the system and not to have arbitary actions in there not related to =
the actual
>> restart process?
>>
>> The actual documentation in kernel/reboot.c supports this assumption=
,
>> describing register_restart_handler as "Register function to be call=
ed to
>> reset the system".
>>
>>
>> Additionally, 128 isn't even _the_ priority to reboot the system as =
described
>> above and some drivers use higher priorities per default, see in
>> drivers/power/reset arm-versatile-reboot.c; at91-reset.c; rmobile-re=
set.c and
>> some more.
>>
>>
>> So I guess this should use some other mechanism (reboot notifier) in=
stead of
>> restart_handlers?
>
> The first problem with reboot notifiers is that they are called too e=
arly - before
> device_shutdown(), what interferes with the code in mmc_bus_shutdown =
and causes
> lockup. The second problem is
> that reboot notifiers are not called from emergency_restart() path. I=
 agree that
> 129 value for priority might not be the best, maybe according to docu=
mentation,
> 255 value should be used to ensure that the handler will be called fi=
rst before
> any real restart handler.
>

There is no non-real restart handler, and the documentation does not sa=
y anything
about "called first before any real restart handler". Even with a prior=
ity of 255
you would have no guarantee that your handler is called. Restart handle=
rs are
supposed to restart the system, nothing else. Actually, you have no gua=
rantee
that the restart handler is called in the first place - not all archite=
ctures
support it (currently only arm, arm64, and mips do). Presumably mmc sup=
port is
not limited to those architectures.

> If you have any idea how to avoid restart handler and ensure proper e=
MMC card
> reboot sequence on any system reboot, I'm open for suggestions.
>

Why not execute the device-specific restart in the shutdown function ?
You could register a reboot notifier to mark that a reboot is happening=
,
and then execute the restart at the end of mmc_bus_shutdown.

Guenter
