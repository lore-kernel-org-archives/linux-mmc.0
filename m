From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Sat, 23 Oct 2010 12:09:01 +0200
Message-ID: <AANLkTi=iC1uKyToEXrroOj+JxQ2mW97WRVEXjv+9oQEa@mail.gmail.com>
References: <1286788315.3101.11.camel@sven> <1286955116-22793-1-git-send-email-ohad@wizery.com>
 <1287704855.12734.14.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287704855.12734.14.camel@maxim-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, libertas-dev@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Maxim,

On Fri, Oct 22, 2010 at 1:47 AM, Maxim Levitsky <maximlevitsky@gmail.co=
m> wrote:
> On Wed, 2010-10-13 at 09:31 +0200, Ohad Ben-Cohen wrote:
>> Fix SDIO suspend/resume regression introduced by
>> 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e "mmc: fix all hangs related=
 to
>> mmc/sd card insert/removal during suspend/resume":
=2E..
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index c94565d..515ff39 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
>> =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->suspend)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->s=
uspend(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err =3D=3D -ENOSYS || !host->bus_ops->=
resume) {
> This reintroduces the bug I fixed.
>
> if the CONFIG_MMC_UNSAFE_RESUME isn't set (and that is default
> unfortunately), the host->bus_ops->resume will be NULL (see core/mmc.=
c
> mmc_ops), and therefore card will be removed, that will trigger a blo=
ck
> device removal, sync, and deadlock).

Have you reproduced this or is it just a general concern ?

I'm asking this because if CONFIG_MMC_UNSAFE_RESUME isn't set, then
mmc_pm_notify() will remove the card and detach the bus.

As a result, host->bus_ops will be unset, and host->bus_dead will be se=
t.

In this case, mmc_suspend_host() should skip the code you are concerned=
 about.

Regards,
Ohad.
