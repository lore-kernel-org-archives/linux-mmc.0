From: David Jander <david@protonic.nl>
Subject: Re: SDHCI long sleep with interrupts off
Date: Thu, 17 Dec 2015 13:22:29 +0100
Message-ID: <20151217132229.1c699f69@archvile>
References: <20151217112814.6250a3b9@archvile>
	<1450350190.3163.93.camel@pengutronix.de>
	<20151217122053.036daf37@archvile>
	<1450351655.3163.97.camel@pengutronix.de>
	<CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:21889 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbbLQMWb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 07:22:31 -0500
In-Reply-To: <CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 17 Dec 2015 12:39:20 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 17 December 2015 at 12:27, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Donnerstag, den 17.12.2015, 12:20 +0100 schrieb David Jander:
> >> Hi Lucas,
> >>
> >> Thanks for reacting.
> >>
> >> On Thu, 17 Dec 2015 12:03:10 +0100
> >> Lucas Stach <l.stach@pengutronix.de> wrote:
> >>
> >> > Am Donnerstag, den 17.12.2015, 11:28 +0100 schrieb David Jander:
> >> > > Hi all,
> >> > >
> >> > > I was investigating the source of abnormal irq-latency spikes on an
> >> > > i.MX6 (ARM) board, and discovered this:
> >> > >
> >> > > # tracer: preemptirqsoff
> >> > > #
> >> > > # preemptirqsoff latency trace v1.1.5 on 4.4.0-rc4+
> >> > > # --------------------------------------------------------------------
> >> > > # latency: 2068 us, #4/4, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0
> >> > > #P:1) #    -----------------
> >> > > #    | task: mmcqd/0-92 (uid:0 nice:0 policy:0 rt_prio:0)
> >> > > #    -----------------
> >> > > #  => started at: _raw_spin_lock_irqsave
> >> > > #  => ended at:   _raw_spin_unlock_irqrestore
> >> > > #
> >> > > #
> >> > > #                  _------=> CPU#
> >> > > #                 / _-----=> irqs-off
> >> > > #                | / _----=> need-resched
> >> > > #                || / _---=> hardirq/softirq
> >> > > #                ||| / _--=> preempt-depth
> >> > > #                |||| /     delay
> >> > > #  cmd     pid   ||||| time  |   caller
> >> > > #     \   /      |||||  \    |   /
> >> > >  mmcqd/0-92      0d...    1us#: _raw_spin_lock_irqsave
> >> > >  mmcqd/0-92      0.n.1 2066us : _raw_spin_unlock_irqrestore
> >> > >  mmcqd/0-92      0.n.1 2070us+: trace_preempt_on
> >> > > <-_raw_spin_unlock_irqrestore mmcqd/0-92      0.n.1 2107us : <stack
> >> > > trace> => sdhci_runtime_resume_host
> >> > >  => __rpm_callback
> >> > >  => rpm_callback
> >> > >  => rpm_resume
> >> > >  => __pm_runtime_resume
> >> > >  => __mmc_claim_host
> >> > >  => mmc_blk_issue_rq
> >> > >  => mmc_queue_thread
> >> > >  => kthread
> >> > >  => ret_from_fork
> >> > >
> >> > > 2 ms with interrupts disabled!!! To much dismay, I later discovered
> >> > > that this isn't even the worst case scenario. I also discovered that
> >> > > this has been in the kernel for a long time without a fix (I have
> >> > > tested from 3.17 to 4.4-rc4). There has been an attempt by someone to
> >> > > address this back in 2010, but apparently it never hit mainline.
> >> > > Going through the code in sdhci.c, I found this troublesome code-path:
> >> > >
> >> > > sdhci_do_set_ios() {
> >> > >   spin_lock_irqsave(&host->lock, flags);
> >> > >   ...
> >> > >   sdhci_reinit() --> sdhci_init() --> sdhci_do_reset() -->
> >> > >           host->ops->reset() --> sdhci_reset()
> >> > >   ...
> >> > >   spin_unlock_irqrestore(&host->lock, flags);
> >> > > }
> >> > >
> >> > > And in sdhci_reset(), which may be called with held spinlock:
> >> > >
> >> > >   ...
> >> > >   /* Wait max 100 ms */
> >> > >   timeout = 100;
> >> > >
> >> > >   /* hw clears the bit when it's done */
> >> > >   while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> >> > >           if (timeout == 0) {
> >> > >                   pr_err("%s: Reset 0x%x never completed.\n",
> >> > >                           mmc_hostname(host->mmc), (int)mask);
> >> > >                   sdhci_dumpregs(host);
> >> > >                   return;
> >> > >           }
> >> > >           timeout--;
> >> > >           mdelay(1);
> >> > >   }
> >> > >
> >> > > I am wondering: There either must be a reason this hasn't been fixed
> >> > > in such a long time, or I am not understanding this correctly, so
> >> > > please enlighten me. Before trying a cowboy attempt at "fixing" this,
> >> > > I'd really like to know why am I seeing this?
> >> > > I mean... how can such a problem get unnoticed and unfixed for so
> >> > > long? Will an attempt at fixing this issue even be accepted?
> >> > >
> >> > I would like to see the sdhci spinlock killed and replaced by a mutex
> >> > for exactly this reason.
> >> >
> >> > That said, your problem is card polling, when no card is present in the
> >> > slot. This is most probably caused by CD gpios having the wrong
> >> > polarity.
> >>
> >> ... or not having a CD pin at all.
> >> I am using an embedded eMMC chip and a uSD card inserted into a slot. The
> >> card is present and also detected as such. If I never access the card, I
> >> see no spikes (filesystem is mounted but not accessed). If I try to read
> >> a file or directory I get the above trace.
> >> OTOH, if I disable PM functionality in the kernel, the spike is gone, and
> >> worst-case latency is in the 300us range, so I don't think this is
> >> related to card polling.
> >>
> > You may be right. If the SDHCI host gets runtime suspended it needs a
> > reset after waking up, causing this latency.
> >
> > Killing the sdhci spinlock may not be straight forward, as a lot of code
> > paths need to be audited for irq safety, but it's the only thing to fix
> > this properly.
> >
> > Regards,
> > Lucas
> >
> 
> If/when you decide to fix this issue. Please keep in mind the following
> things.
> 
> - Try to convert the SDHCI into a pure library. No more quirks or callbacks.
> - I assume we can simplify lots of code if we convert SDHCI into using
> a threaded IRQ in favour of the tasklet.
> 
> Any patches that moves SDHCI into this direction will be greatly appreciated!

Ok, this sounds like a good way to go. Unfortunately it also sounds like a
major endeavor, for which good knowledge of the SDHCI standard is necessary.
This knowledge is based on documentation that is not openly available without
cost AFAIK. This probably also explains why there hasn't been a real fix ever.
On top of that, the whole sdhci code is unmaintained currently as it seems.
I was studying the code a bit more, and I now understand that I am not even
close to having the experience and standards-knowledge it takes to pull this
off reliably. I guess the one who takes on this task may as well become
official maintainer afterwards...
OTOH, we pretty much depend on this driver now, since all of our new i.MX6/7
boards have eMMC flash. We also use the flexcan peripheral on all designs,
which is specially sensible to these latency spikes, so we will have to do
something on the long run.... we cannot live forever with disabled PM ;-)

Best regards,

-- 
David Jander
Protonic Holland.
