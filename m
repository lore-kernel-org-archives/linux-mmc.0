From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 10 Nov 2010 21:22:11 +0200
Message-ID: <AANLkTi=9YPNUfDZNRjkK_BJE+UTVQ3Q9nKfXMecmmPgo@mail.gmail.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
 <AANLkTinmPY8mGEjGq50niOb1CsHE67jVO8OS6JhcF1be@mail.gmail.com> <4CDAC787.3040005@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53942 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab0KJTWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 14:22:32 -0500
Received: by iwn10 with SMTP id 10so1154595iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 11:22:32 -0800 (PST)
In-Reply-To: <4CDAC787.3040005@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

On Wed, Nov 10, 2010 at 6:25 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> Not that one, because the only place where ungate is called
> is immediately before the request or set_ios(). So the request
> or set_ios() will complete

How can you assume that ? Nothing prevents a context switch after
ungate, and before the actual request.

Here is what I had in mind:

Thread 1
=3D=3D=3D=3D=3D=3D=3D

calling mmc_host_clk_gate_delayed()
=2E..
spin_unlock_irqrestore(&host->clk_lock, flags);

About to execute mmc_gate_clock(host)

context switch to Thread 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

calling mmc_start_request()
=2E..
executes mmc_host_clk_ungate();

back to Thread 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

executes mmc_gate_clock(host);


back to Thread 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

/* clock is gated now */
host->ops->request(host, mrq);


>, and immediately after that
> this gating will be triggered.
>
> So the real bug is that if we get this race we don't get
> the 8 MCI cycles of delay that we want.
>
> But I guess I can replace all spinlocks with a mutex instead
> and still hold it across the gate operation, since all
> gate/ungate calls should be coming from process context?
>
> That simplifies things.
>
> I'll see if this works...
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->clk_lock, fl=
ags);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: gated MCI clock\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host)=
);
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 host->clk_pending_gate =3D false;
>>
>> What is clk_pending_gate used for (I can only see it being assigned =
values) ?
>
> Hm, a development artifact from patchset v4 2009-06-18...
> It's replaced with host->clk_gated instead.
>
> I'll remove it.
>
>> (PS sorry for the belated posting of these questions)
>
> No problem, I'll fix.
>
> Chris, do you want an incremental patch or shall I spin an all-new
> v10 patch?
>
> Yours,
> Linus Walleij
>
