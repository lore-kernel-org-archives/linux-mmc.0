From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC, PATCHv3 3/3] mmc: sdhci: handle wake-up from
 runtime_pm
Date: Tue, 1 Mar 2011 15:27:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011525040.2034-100000@iolanthe.rowland.org>
References: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> >> + =A0 =A0 if (pm_runtime_suspended()) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the i=
nterrupt until we do the
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get =
constantly interrupted
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might no=
t be very friendly to our
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime work=
queue should really be
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
> >
> > Instead of disabling the IRQ, would it be possible to tell the devi=
ce
> > to stop generating an interrupt request?
>=20
> Well, the device is power gated, so any access to it will cause a bus
> timeout (depending of the platform)

But could you gate the power back on and then turn off the interrupt=20
request?

It seems like a foolish design to have an interrupt request that can't
be turned off by an interrupt handler.

Alan Stern
