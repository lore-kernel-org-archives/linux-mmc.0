From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Wed, 29 Dec 2010 23:30:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012292326220.13580-100000@netrider.rowland.org>
References: <AANLkTi=QT1thWxy94=imJhbbcXQ1CD36=PnkAyaaA6Hj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=QT1thWxy94=imJhbbcXQ1CD36=PnkAyaaA6Hj-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 29 Dec 2010, Ohad Ben-Cohen wrote:

> On Tue, Dec 28, 2010 at 11:46 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLrNAH6kLmebB@public.gmane.org=
du> wrote:
> > Similarly, during system suspend mmc_suspend_host() should be
> > responsible for doing all the necessary power-down operations. =A0R=
untime
> > PM is completely out of the picture at this time. =A0And this shoul=
d be
> > independent of mac80211 -- in fact, the card should be powered down
> > appropriately even if the kernel doesn't have a mac80211 layer.
>=20
> And it is.
>=20
> But in order to boot the firmware on resume, we need to reset the
> device. And if system suspend has been cancelled before
> mmc_power_off() was invoked, we will not be able to. So, in this case
> too, the driver will have to power the device off.

If the suspend transition was cancelled before mmc_power_off(), why do=20
you need to boot the firmware on resume?  Since the device hasn't=20
actually been powered off, can't it continue using the same firmware as=
=20
before?

What routine is responsible for deciding to boot the firmware, and what=
=20
is its call path?

> It all really boils down to the same solution - we will always have t=
o
> bypass runtime PM and directly control the power of the device.

While this is probably true, I'm not at all convinced that the current=20
design is layered correctly.  Fixing the design might reduce the amount=
=20
of bypassing required.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
