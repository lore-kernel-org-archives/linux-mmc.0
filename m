From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Usage of restart_handler in pwrseq_emmc
Date: Wed, 03 Jun 2015 12:01:15 +0200
Message-ID: <556ED06B.9030601@samsung.com>
References: <1789396.sexGZzDeEb@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54937 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbFCKBS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jun 2015 06:01:18 -0400
In-reply-to: <1789396.sexGZzDeEb@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 2015-06-02 17:29, Heiko St=C3=BCbner wrote:
> I'm confused by the pwrseq-emmc registering a restart_handler for res=
etting an
> emmc in a panic-reboot case at priority 129 to "schedules it just bef=
ore
> system reboot".
>
> >From what I remember from the restart-handler discussion the actuall=
 usage is
> traversing the ordered list until one registered handler sucessfully =
restarts
> the system and not to have arbitary actions in there not related to t=
he actual
> restart process?
>
> The actual documentation in kernel/reboot.c supports this assumption,
> describing register_restart_handler as "Register function to be calle=
d to
> reset the system".
>
>
> Additionally, 128 isn't even _the_ priority to reboot the system as d=
escribed
> above and some drivers use higher priorities per default, see in
> drivers/power/reset arm-versatile-reboot.c; at91-reset.c; rmobile-res=
et.c and
> some more.
>
>
> So I guess this should use some other mechanism (reboot notifier) ins=
tead of
> restart_handlers?

The first problem with reboot notifiers is that they are called too=20
early - before
device_shutdown(), what interferes with the code in mmc_bus_shutdown an=
d=20
causes
lockup. The second problem is
that reboot notifiers are not called from emergency_restart() path. I=20
agree that
129 value for priority might not be the best, maybe according to=20
documentation,
255 value should be used to ensure that the handler will be called firs=
t=20
before
any real restart handler.

If you have any idea how to avoid restart handler and ensure proper eMM=
C=20
card
reboot sequence on any system reboot, I'm open for suggestions.

Best regards
--=20
Marek Szyprowski, PhD
Samsung R&D Institute Poland

