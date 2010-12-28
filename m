From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 16:46:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012281541580.22998-100000@netrider.rowland.org>
References: <AANLkTim7pGtO=vjKmA_3O74Kwvio124cgoaMeUSB70dW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51428 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752433Ab0L1Vqe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2010 16:46:34 -0500
In-Reply-To: <AANLkTim7pGtO=vjKmA_3O74Kwvio124cgoaMeUSB70dW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Tue, 28 Dec 2010, Ohad Ben-Cohen wrote:

> On Sun, Dec 26, 2010 at 7:00 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> > Hmm. =A0It's a little difficult to untangle the web of dev_pm_ops
> > pointers and other stuff.
>=20
> Yeah, SDIO suspend/resume is very different from other subsystems.
>=20
> There are several layers of abstractions involved, from the host
> controller driver, to the MMC core code, to the SDIO core code, to
> finally get to the actual SDIO function driver.

Actually that sounds quite a lot like the USB subsystem, except perhaps
for the fact that you have two layers of core code instead of just one.=
 =20
The cards are much like USB devices (indivisible for the purposes of
power management) and the functions are much like USB interfaces (bound
to individual drivers but not independently power-managed or
resettable).

> I'll try to explain it below by addressing your questions. If
> something is still unclear, feel free to ask me.
>=20
> > There's wl1271_suspend() and wl1271_resume()
> > (which don't do anything)
>=20
> It just looks like they don't. In fact, by returning 0,
> wl1271_suspend() is telling the SDIO subsystem that it's OK to power
> down the SDIO function (in general an SDIO card can have several SDIO
> functions, each of which may be driven by a separate SDIO driver). If
> all the SDIO functions agreed, then SDIO core (mmc_sdio_suspend())
> tells MMC core (mmc_suspend_host()) it's OK to power down the card (b=
y
> directly calling mmc_power_off()).

What's the relation between mmc_power_off() and mmc_power_save_host()? =
=20

When you say "power down", which of these routines do you mean?  I get
the feeling that sometimes you mean one and sometimes the other, which
leads to problems in understanding.

Why are there two separate routines?

Does one merely go into a low-power state whereas the other does the=20
complete-power-off reset?

If so, which does which? =20

What's the reason for not going into the complete-power-off state every
time?

If it is latency, shouldn't the runtime-PM path use the low-latency
routine and the system-sleep path use the high-latency routine? =20
Although I can't tell for certain, it seems to be the other way around.

> > Under what circumstances does the MMC/SDIO core call
> > wl1271_sdio_set_power(), and where are those function calls?
>=20
> The relations are actually reversed: the MMC/SDIO core never calls
> this function.
>=20
> This function is called by the wl1271 driver itself, mostly as a
> response to a request by the mac80211 layer (but also as a response t=
o
> a hardware error), that requires manipulation of the power of the
> card.
>=20
> There are a handful of reasons this may happen:
>=20
> error recovery:
>=20
> wl1271_recovery_work() ->
>     __wl1271_op_remove_interface() ->
>           wl1271_power_off() ->
>                wl1271_sdio_set_power() ->
>                       wl1271_sdio_power_off() ->
>                              pm_runtime_put_sync()
>=20
> wlan interface goes down:
>=20
> ieee80211_do_stop() ->
>   wl1271_op_remove_interface() ->
>     __wl1271_op_remove_interface() ->
>           ...
>=20
> system suspend:
>=20
> __ieee80211_suspend ->
>   wl1271_op_remove_interface() ->
>       ...

Okay.  These paths should be interrelated with power management in a=20
different way.

It's correct for wl1271_op_remove_interface() to be called in these=20
three situations, and it's correct to do a pm_runtime_put_sync().  But=20
it's not correct to rely on that to actually change any power levels or=
=20
do a reset.

Instead, wl1271_error_recovery_work() should call either
mmc_suspend_host() or mmc_power_save_host() (whichever one does the
actual power-off reset) directly, after calling wl1271_power_off(). =20
In fact, you might even want to do a pm_runtime_get_noresume() before
calling wl1271_power_off(), to prevent the PM core from interfering
with the reset.

Similarly, during system suspend mmc_suspend_host() should be=20
responsible for doing all the necessary power-down operations.  Runtime=
=20
PM is completely out of the picture at this time.  And this should be=20
independent of mac80211 -- in fact, the card should be powered down=20
appropriately even if the kernel doesn't have a mac80211 layer.

During wlan-interface-down, it's not necessary to reduce the power
level; it's merely desirable.  That's exactly the sort of thing runtime
PM is meant for.  Hence the existing call to pm_runtime_put_sync() is
sufficient.

> > Is it possible for there to be more than one device connected to th=
e
> > same MMC/SDIO controller?
>=20
> Generally yes, host controllers may have several slots, but to the
> MMC/SDIO core, it is presented as each slot is a separate host
> controller (personally I have never seen such hardware, but I did fin=
d
> an example for that in the host controller's source folder).

Put it another way:  Suppose an SDIO card has more than one function=20
and you need to reset the wl1271 function.  It sounds like there's no=20
way to do this without resetting the other functions as well.  What=20
happens if another function's driver is busy and can't allow a reset=20
just then?

Alan Stern

