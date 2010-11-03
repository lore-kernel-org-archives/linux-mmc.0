From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Wed, 3 Nov 2010 06:03:35 -0400
Message-ID: <AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
References: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62019 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab0KCKD4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 06:03:56 -0400
Received: by iwn10 with SMTP id 10so582858iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Nov 2010 03:03:55 -0700 (PDT)
In-Reply-To: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, jh80.chung@samsung.com, Kyungmin Park <kmpark@infradead.org>, arm-kernel@lists.infradead.org

On Sun, Oct 31, 2010 at 6:06 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This patch modifies the MMC core code to optionally call the
> set_ios() operation on the driver with the clock frequency set
> to 0 (gate) after a grace period of at least 8 MCLK cycles, then
> restore it (ungate) before any new request. This gives
> the driver the option to shut down the MCI clock to the MMC/SD

Have you considered migrating this to runtime PM API ?

Runtime PM core already provides most of the necessary plumbing:
referred work, reference counting, tunable delay, active/suspended
status, etc..

It will also allow you to avoid overloading the set_ios() operation:
once suspended, host controllers will receive an idle notification
from runtime PM core. also CONFIG_MMC_CLKGATE will probably not be
needed anymore (no API changes so everything should just work as
before. only difference is that now hosts can start supporting  these
runtime PM notifications).

An additional benefit of using runtime PM is that we will then support
new debug and statistics features of powertop, that will present
useful runtime pm stats about the various devices in the system
(http://www.mail-archive.com/linaro-dev@lists.linaro.org/msg00506.html)=
=2E

Thanks,
Ohad.

>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes v6->v7: found a bug when "gearing up" cards to higher
> frequencies while the clock is gated. Regard this set_ios()
> event as an "ungate".
> ---
> =A0drivers/mmc/core/Kconfig =A0 | =A0 11 +++
> =A0drivers/mmc/core/core.c =A0 =A0| =A0 45 +++++++++++-
> =A0drivers/mmc/core/core.h =A0 =A0| =A0 =A02 +
> =A0drivers/mmc/core/debugfs.c | =A0 =A05 +
> =A0drivers/mmc/core/host.c =A0 =A0| =A0182 ++++++++++++++++++++++++++=
+++++++++++++++++-
> =A0drivers/mmc/core/host.h =A0 =A0| =A0 21 +++++
> =A0include/linux/mmc/host.h =A0 | =A0 10 +++
> =A07 files changed, 274 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bb22ffd..1018ccc1 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -16,3 +16,14 @@ config MMC_UNSAFE_RESUME
>
> =A0 =A0 =A0 =A0 =A0This option sets a default which can be overridden=
 by the
> =A0 =A0 =A0 =A0 =A0module parameter "removable=3D0" or "removable=3D1=
".
> +
> +config MMC_CLKGATE
> + =A0 =A0 =A0 bool "MMC host clock gating (EXPERIMENTAL)"
> + =A0 =A0 =A0 depends on EXPERIMENTAL
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This will attempt to agressively gate the clock to =
the MMC card.
> + =A0 =A0 =A0 =A0 This is done to save power due to gating off the lo=
gic and bus
> + =A0 =A0 =A0 =A0 noise when the MMC card is not in use. Your host dr=
iver has to
> + =A0 =A0 =A0 =A0 support handling this in order for it to be of any =
use.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8f86d70..1be5d65 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -130,6 +130,8 @@ void mmc_request_done(struct mmc_host *host, stru=
ct mmc_request *mrq)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mrq->done)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->done(mrq);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_gate(host);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -190,6 +192,7 @@ mmc_start_request(struct mmc_host *host, struct m=
mc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->stop->mrq =3D mrq=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 mmc_host_clk_ungate(host);
> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
> =A0}
>
> @@ -296,7 +299,7 @@ void mmc_set_data_timeout(struct mmc_data *data, =
const struct mmc_card *card)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout_us =3D data->timeout_ns / 1000=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout_us +=3D data->timeout_clks * 1=
000 /
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->host->ios.clock =
/ 1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_host_clk_rate(card=
->host) / 1000);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_WRITE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -614,6 +617,12 @@ static inline void mmc_set_ios(struct mmc_host *=
host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ios->power_mode, ios->chip_select, io=
s->vdd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ios->bus_width, ios->timing);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We get a new frequency while the clock is gated,
> + =A0 =A0 =A0 =A0* so make sure we regard this as ungating it.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (ios->clock > 0 && host->clk_gated)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clk_gated =3D false;
> =A0 =A0 =A0 =A0host->ops->set_ios(host, ios);
> =A0}
>
> @@ -641,6 +650,40 @@ void mmc_set_clock(struct mmc_host *host, unsign=
ed int hz)
> =A0 =A0 =A0 =A0mmc_set_ios(host);
> =A0}
>
> +#ifdef CONFIG_MMC_CLKGATE
> +/*
> + * This gates the clock by setting it to 0 Hz.
> + */
> +void mmc_gate_clock(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 host->clk_old =3D host->ios.clock;
> + =A0 =A0 =A0 host->ios.clock =3D 0;
> + =A0 =A0 =A0 host->clk_gated =3D true;
> + =A0 =A0 =A0 mmc_set_ios(host);
> +}
> +
> +/*
> + * This restores the clock from gating by using the cached
> + * clock value.
> + */
> +void mmc_ungate_clock(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We should previously have gated the clock, so the =
clock
> + =A0 =A0 =A0 =A0* shall be 0 here!
> + =A0 =A0 =A0 =A0* The clock may however be 0 during intialization,
> + =A0 =A0 =A0 =A0* when some request operations are performed before =
setting
> + =A0 =A0 =A0 =A0* the frequency. When ungate is requested in that si=
tuation
> + =A0 =A0 =A0 =A0* we just ignore the call.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->clk_old) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(host->ios.clock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_clock(host, host->clk_old);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->clk_gated =3D false;
> +}
> +#endif
> +
> =A0/*
> =A0* Change the bus mode (open drain/push-pull) of a host.
> =A0*/
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 77240cd..9972808 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -33,6 +33,8 @@ void mmc_init_erase(struct mmc_card *card);
>
> =A0void mmc_set_chip_select(struct mmc_host *host, int mode);
> =A0void mmc_set_clock(struct mmc_host *host, unsigned int hz);
> +void mmc_gate_clock(struct mmc_host *host);
> +void mmc_ungate_clock(struct mmc_host *host);
> =A0void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
> =A0void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
> =A0void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int wid=
th,
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index eed1405..998797e 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -183,6 +183,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&mmc_clock_fops))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_node;
>
> +#ifdef CONFIG_MMC_CLKGATE
> + =A0 =A0 =A0 if (!debugfs_create_u32("clk_delay", (S_IRUSR | S_IWUSR=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root, &=
host->clk_delay))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_node;
> +#endif
> =A0 =A0 =A0 =A0return;
>
> =A0err_node:
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 10b8af2..f1834fb 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -3,6 +3,7 @@
> =A0*
> =A0* =A0Copyright (C) 2003 Russell King, All Rights Reserved.
> =A0* =A0Copyright (C) 2007-2008 Pierre Ossman
> + * =A0Copyright (C) 2010 Linus Walleij
> =A0*
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> @@ -50,6 +51,182 @@ void mmc_unregister_host_class(void)
> =A0static DEFINE_IDR(mmc_host_idr);
> =A0static DEFINE_SPINLOCK(mmc_host_lock);
>
> +#ifdef CONFIG_MMC_CLKGATE
> +
> +/*
> + * Enabling clock gating will make the core call out to the host
> + * once up and once down when it performs a request or card operatio=
n
> + * intermingled in any fashion. The driver will see this through
> + * set_ios() operations with ios.clock field set to 0 to gate
> + * (disable) the block clock, and to the old frequency to enable
> + * it again.
> + */
> +static void mmc_host_clk_gate_delayed(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned long tick_ns;
> + =A0 =A0 =A0 unsigned long freq =3D host->ios.clock;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int users;
> +
> + =A0 =A0 =A0 if (!freq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: frequency set to 0 in disab=
le function, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"this means the clock is=
 already disabled.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* New requests may have appeared while we were sched=
uling,
> + =A0 =A0 =A0 =A0* then there is no reason to delay the check before
> + =A0 =A0 =A0 =A0* clk_disable().
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flags);
> + =A0 =A0 =A0 users =3D host->clk_requests;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Delay n bus cycles (at least 8 from MMC spec) befo=
re attempting
> + =A0 =A0 =A0 =A0* to disable the MCI block clock. The reference coun=
t
> + =A0 =A0 =A0 =A0* may have gone up again after this delay due to
> + =A0 =A0 =A0 =A0* rescheduling!
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!users) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock,=
 flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tick_ns =3D DIV_ROUND_UP(1000000000, fr=
eq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ndelay(host->clk_delay * tick_ns);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* New users appeared while waiting for=
 this work */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clk_pending_gate =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock,=
 flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flags);
> + =A0 =A0 =A0 if (!host->clk_requests) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock,=
 flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will set host->ios.clock to 0 *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_gate_clock(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flag=
s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: gated MCI clock\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host));
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->clk_pending_gate =3D false;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock, flags);
> +}
> +
> +/*
> + * Internal work. Work to disable the clock at some later point.
> + */
> +static void mmc_host_clk_gate_work(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct mmc_host *host =3D container_of(work, struct mmc=
_host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 clk_disable_work);
> +
> + =A0 =A0 =A0 mmc_host_clk_gate_delayed(host);
> +}
> +
> +/*
> + * =A0 =A0 mmc_host_clk_ungate - make sure the host ios.clock is
> + * =A0 =A0 restored to some non-zero value past this call.
> + * =A0 =A0 @host: host to ungate.
> + *
> + * =A0 =A0 Increase clock reference count and ungate clock if first =
user.
> + */
> +void mmc_host_clk_ungate(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flags);
> + =A0 =A0 =A0 if (host->clk_gated) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock,=
 flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ungate_clock(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flag=
s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: ungated MCI clock\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host));
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->clk_requests++;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock, flags);
> +}
> +
> +/*
> + * =A0 =A0 mmc_host_clk_gate - call the host driver with ios.clock
> + * =A0 =A0 set to zero as often as possible so as to make it
> + * =A0 =A0 possible to gate off hardware MCI clocks.
> + * =A0 =A0 @host: host to gate.
> + *
> + * =A0 =A0 Decrease clock reference count and schedule disablement o=
f clock.
> + */
> +void mmc_host_clk_gate(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flags);
> + =A0 =A0 =A0 host->clk_requests--;
> + =A0 =A0 =A0 if (!host->clk_requests) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clk_pending_gate =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&host->clk_disable_work);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock, flags);
> +}
> +
> +/*
> + * =A0 =A0 mmc_host_clk_rate - get current clock frequency setting n=
o matter
> + * =A0 =A0 whether it's gated or not.
> + * =A0 =A0 @host: host to get the clock frequency for.
> + */
> +unsigned int mmc_host_clk_rate(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned long freq;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flags);
> + =A0 =A0 =A0 if (host->clk_gated)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq =3D host->clk_old;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq =3D host->ios.clock;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->clk_lock, flags);
> + =A0 =A0 =A0 return freq;
> +}
> +
> +/*
> + * =A0 =A0 mmc_host_clk_init - set up clock gating code
> + * =A0 =A0 @host: host with potential clock to control
> + */
> +static inline void mmc_host_clk_init(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 host->clk_requests =3D 0;
> + =A0 =A0 =A0 host->clk_delay =3D 8; /* hold MCI clock in 8 cycles by=
 default */
> + =A0 =A0 =A0 host->clk_gated =3D false;
> + =A0 =A0 =A0 host->clk_pending_gate =3D false;
> + =A0 =A0 =A0 INIT_WORK(&host->clk_disable_work, mmc_host_clk_gate_wo=
rk);
> + =A0 =A0 =A0 spin_lock_init(&host->clk_lock);
> +}
> +
> +/*
> + * =A0 =A0 mmc_host_clk_exit - shut down clock gating code
> + * =A0 =A0 @host: host with potential clock to control
> + */
> +static inline void mmc_host_clk_exit(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Wait for any outstanding gate and then make sure w=
e're
> + =A0 =A0 =A0 =A0* ungated before exiting.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (cancel_work_sync(&host->clk_disable_work))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_gate_delayed(host);
> + =A0 =A0 =A0 if (host->clk_gated)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_ungate(host);
> + =A0 =A0 =A0 BUG_ON(host->clk_requests > 0);
> +}
> +
> +#else
> +
> +static inline void mmc_host_clk_init(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_host_clk_exit(struct mmc_host *host)
> +{
> +}
> +
> +#endif
> +
> =A0/**
> =A0* =A0 =A0 mmc_alloc_host - initialise the per-host structure.
> =A0* =A0 =A0 @extra: sizeof private data structure
> @@ -82,6 +259,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct =
device *dev)
> =A0 =A0 =A0 =A0host->class_dev.class =3D &mmc_host_class;
> =A0 =A0 =A0 =A0device_initialize(&host->class_dev);
>
> + =A0 =A0 =A0 mmc_host_clk_init(host);
> +
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0init_waitqueue_head(&host->wq);
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> @@ -163,6 +342,8 @@ void mmc_remove_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0device_del(&host->class_dev);
>
> =A0 =A0 =A0 =A0led_trigger_unregister_simple(host->led);
> +
> + =A0 =A0 =A0 mmc_host_clk_exit(host);
> =A0}
>
> =A0EXPORT_SYMBOL(mmc_remove_host);
> @@ -183,4 +364,3 @@ void mmc_free_host(struct mmc_host *host)
> =A0}
>
> =A0EXPORT_SYMBOL(mmc_free_host);
> -
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 8c87e11..de199f9 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -10,10 +10,31 @@
> =A0*/
> =A0#ifndef _MMC_CORE_HOST_H
> =A0#define _MMC_CORE_HOST_H
> +#include <linux/mmc/host.h>
>
> =A0int mmc_register_host_class(void);
> =A0void mmc_unregister_host_class(void);
>
> +#ifdef CONFIG_MMC_CLKGATE
> +void mmc_host_clk_ungate(struct mmc_host *host);
> +void mmc_host_clk_gate(struct mmc_host *host);
> +unsigned int mmc_host_clk_rate(struct mmc_host *host);
> +
> +#else
> +static inline void mmc_host_clk_ungate(struct mmc_host *host)
> +{
> +}
> +
> +static inline void mmc_host_clk_gate(struct mmc_host *host)
> +{
> +}
> +
> +static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 return host->ios.clock;
> +}
> +#endif
> +
> =A0void mmc_host_deeper_disable(struct work_struct *work);
>
> =A0#endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 6d87f68..c38c400 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -171,6 +171,16 @@ struct mmc_host {
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> +#ifdef CONFIG_MMC_CLKGATE
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_request=
s; =A0 /* internal reference counter */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_delay; =A0 =A0 =
=A0/* number of MCI clk hold cycles */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_gated; =
=A0 =A0 =A0/* clock gated */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_pending=
_gate; /* pending clock gating */
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0clk_disable_work; /* dela=
yed clock disablement */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_old; =A0 =A0 =A0=
 =A0/* old clock value cache */
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_lock; =A0 =A0=
 =A0 /* lock for clk fields */
> +#endif
> +
> =A0 =A0 =A0 =A0/* host specific block data */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_seg_size; =A0 =
/* see blk_queue_max_segment_size */
> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0max_segs; =A0 =A0 =A0=
 /* see blk_queue_max_segments */
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
