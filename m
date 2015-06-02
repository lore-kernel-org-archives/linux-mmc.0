From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Usage of restart_handler in pwrseq_emmc
Date: Tue, 02 Jun 2015 09:42:39 -0700
Message-ID: <556DDCFF.8000200@roeck-us.net>
References: <1789396.sexGZzDeEb@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1789396.sexGZzDeEb@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 06/02/2015 08:29 AM, Heiko St=FCbner wrote:
> Hi,
>
> I'm confused by the pwrseq-emmc registering a restart_handler for res=
etting an
> emmc in a panic-reboot case at priority 129 to "schedules it just bef=
ore
> system reboot".
>
>>From what I remember from the restart-handler discussion the actuall =
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
>

Looks like it. Assuming that a restart handler with priority 129 will a=
lways
be executed is a bad idea, and having it do anything but restart the sy=
stem
is an even worse idea and is really asking for trouble.

Guenter
