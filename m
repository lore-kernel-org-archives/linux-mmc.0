From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 10 Nov 2010 17:25:43 +0100
Message-ID: <4CDAC787.3040005@stericsson.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com> <AANLkTinmPY8mGEjGq50niOb1CsHE67jVO8OS6JhcF1be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:50599 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756384Ab0KJQ0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 11:26:44 -0500
In-Reply-To: <AANLkTinmPY8mGEjGq50niOb1CsHE67jVO8OS6JhcF1be@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

Ohad Ben-Cohen wrote:

> Hi Linus,
> On Wed, Nov 3, 2010 at 11:22 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> ...
>> +static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>> +{
>> +       unsigned long tick_ns;
>> +       unsigned long freq = host->ios.clock;
>> +       unsigned long flags;
>> +       int users;
>> +
>> +       if (!freq) {
>> +               pr_err("%s: frequency set to 0 in disable function, "
>> +                      "this means the clock is already disabled.\n",
>> +                      mmc_hostname(host));
>> +               return;
>> +       }
>> +       /*
>> +        * New requests may have appeared while we were scheduling,
>> +        * then there is no reason to delay the check before
>> +        * clk_disable().
>> +        */
>> +       spin_lock_irqsave(&host->clk_lock, flags);
>> +       users = host->clk_requests;
>> +       /*
>> +        * Delay n bus cycles (at least 8 from MMC spec) before attempting
>> +        * to disable the MCI block clock. The reference count
>> +        * may have gone up again after this delay due to
>> +        * rescheduling!
>> +        */
>> +       if (!users) {

Note to self: remove the local users variable and look directly
at host->clk_requests.

>> +               spin_unlock_irqrestore(&host->clk_lock, flags);
>> +               tick_ns = DIV_ROUND_UP(1000000000, freq);
>> +               ndelay(host->clk_delay * tick_ns);
>> +       } else {
>> +               /* New users appeared while waiting for this work */
>> +               host->clk_pending_gate = false;
>> +               spin_unlock_irqrestore(&host->clk_lock, flags);
>> +               return;
>> +       }
>> +       spin_lock_irqsave(&host->clk_lock, flags);
>> +       if (!host->clk_requests) {
>> +               spin_unlock_irqrestore(&host->clk_lock, flags);
> 
> What if mmc_host_clk_ungate() is invoked (and completely executes) at
> this point (as a result of a new mmc request) ?
> 
>> +               /* this will set host->ios.clock to 0 */
>> +               mmc_gate_clock(host);
> 
> Will this clock gating not disrupt that new mmc request ?

Not that one, because the only place where ungate is called
is immediately before the request or set_ios(). So the request
or set_ios() will complete, and immediately after that
this gating will be triggered.

So the real bug is that if we get this race we don't get
the 8 MCI cycles of delay that we want.

But I guess I can replace all spinlocks with a mutex instead
and still hold it across the gate operation, since all
gate/ungate calls should be coming from process context?

That simplifies things.

I'll see if this works...

>> +               spin_lock_irqsave(&host->clk_lock, flags);
>> +               pr_debug("%s: gated MCI clock\n",
>> +                        mmc_hostname(host));
>> +       }
>> +       host->clk_pending_gate = false;
> 
> What is clk_pending_gate used for (I can only see it being assigned values) ?

Hm, a development artifact from patchset v4 2009-06-18...
It's replaced with host->clk_gated instead.

I'll remove it.

> (PS sorry for the belated posting of these questions)

No problem, I'll fix.

Chris, do you want an incremental patch or shall I spin an all-new
v10 patch?

Yours,
Linus Walleij
