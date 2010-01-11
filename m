From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 resubmit] mmc-omap: Add support for 16-bit and
 32-bit registers
Date: Mon, 11 Jan 2010 15:31:54 -0800
Message-ID: <20100111233153.GG5055@atomide.com>
References: <1263059536-11397-1-git-send-email-darkstar6262@gmail.com>
 <20100111104402.GA2587@localhost.localdomain>
 <6cb013311001111114g6cd49663ja9f2099b6431d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54555 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0AKXbt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2010 18:31:49 -0500
Content-Disposition: inline
In-Reply-To: <6cb013311001111114g6cd49663ja9f2099b6431d28@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>

* Cory Maccarrone <darkstar6262@gmail.com> [100111 11:13]:
> On Mon, Jan 11, 2010 at 2:44 AM, Ladislav Michl
> <Ladislav.Michl@seznam.cz> wrote:
> >
> > This patch differs from v5 you sent earlier:
> > =C2=A0Subject: [PATCH v5] mmc-omap: Add support for 16-bit and 32-b=
it registers
> > =C2=A0Date: Mon, 23 Nov 2009 10:37:28 -0800
> > =C2=A0Message-Id: <1259001448-9574-1-git-send-email-darkstar6262@gm=
ail.com>
> >
> > Patch below is not going to work with 32-bit wide registers. Whoeve=
r is going
> > to apply it, please don't. Use original version referred above.
> >
> > <snip>
> >
> > This is not going to work =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^
>=20
> Ah, right, good catch.  I thought I got the same one submitted -- thi=
s
> is an older one.  Sorry about that.

I'll add the working v5 into omap-testing so we can make sure it works =
with
other omaps. Will not merge it further, it still needs to get to mainli=
ne
via linux-mmc list.

Regards,

Tony
