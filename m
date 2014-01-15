From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
Date: Wed, 15 Jan 2014 08:46:53 +0100
Message-ID: <20140115084653.4f6aece8@ipc1.ka-ro>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
	<CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
	<20140113120435.GQ31570@twins.programming.kicks-ass.net>
	<CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:63183 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaAOHry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 02:47:54 -0500
In-Reply-To: <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Dong Aisheng wrote:
> On Mon, Jan 13, 2014 at 8:04 PM, Peter Zijlstra <peterz@infradead.org=
> wrote:
> > On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
> >> > It's strange that this issue did not happen on kernel 3.10.17 wi=
th the same
> >> > code. And looking at the code, before call spin_lock we already =
disable the mmc
> >> > controller irq, per on my understanding, the deadlock given by l=
ockdep may not
> >> > be able to happen(pls fix me if wrong).
> >> > May the lockdep not track the specific irq disable?
> >> > Copy lockdep guy to comment.
> >
> > No, lockdep also doesn't know only that one line can take this lock=
=2E
> > Lockdep only knows a lock is taken from IRQ context, and disabling =
one
> > line still allows IRQs to happen and therefore it yells.
>=20
> Okay, thanks for the information.
> If that, kernel 3.10.17 has the same code, do you know why it does no=
t trigger
> such lockdep error?
>=20
compiled with CONFIG_LOCKDEP disabled?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
