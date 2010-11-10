From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 10 Nov 2010 11:05:38 +0200
Message-ID: <AANLkTinmPY8mGEjGq50niOb1CsHE67jVO8OS6JhcF1be@mail.gmail.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57159 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab0KJJGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 04:06:07 -0500
Received: by iwn10 with SMTP id 10so537301iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 01:06:06 -0800 (PST)
In-Reply-To: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

Hi Linus,

On Wed, Nov 3, 2010 at 11:22 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
=2E..
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

What if mmc_host_clk_ungate() is invoked (and completely executes) at
this point (as a result of a new mmc request) ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will set host->ios.clock to 0 *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_gate_clock(host);

Will this clock gating not disrupt that new mmc request ?

Or am I missing something ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, flag=
s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: gated MCI clock\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host));
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->clk_pending_gate =3D false;

What is clk_pending_gate used for (I can only see it being assigned val=
ues) ?

Thanks,
Ohad.

(PS sorry for the belated posting of these questions)
