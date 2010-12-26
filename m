From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 26 Dec 2010 07:55:05 +0200
Message-ID: <AANLkTinyKfwcZLD5D4rdF6OpQqr79F==GRjAMBjjbupW@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com> <Pine.LNX.4.44L0.1012252041260.10725-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1012252041260.10725-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Dec 26, 2010 at 4:48 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>=
 wrote:
> Is there a separate handler responsible for powering the device back
> on? =A0What are the names of these handlers?

wl1271_sdio_power_on() and wl1271_sdio_power_off().

If you're taking a look, please do so using the latest code as seen on =
mmc-next:

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next

> That's not a race

It is.

If system suspend will continue uninterruptedly, and the driver will
be suspended (by the SDIO subsystem), then the device will be powered
down, and everything will work.

But if something will interrupt the suspend transition _before_ our
driver is suspended (e.g. some other suspend() handler will fail),
then we have a problem, because the device will not be reset as the
driver needs it to be.

> What is the name of the driver's runtime_suspend routine?

The driver itself doesn't have one; power is being controlled by the
MMC/SDIO subsystem, so the actual runtime_suspend handler is
mmc_runtime_suspend().

> And while we're at it, what is the name of the routine that _actually=
_ changes the
> device's power level?

mmc_power_save_host(), which is called by mmc_runtime_suspend().

(well, more accurately it is actually fixed_voltage_disable(), but
that's a few levels deeper than I think you'll be interested in)

> Evidently you are facing two distinct problems, and they need to be
> solved together. =A0In fact, solving one problem (bypassing runtime P=
M)
> will probably help to solve the other (doing system resume correctly)=
=2E

I agree.

> Well, I'd like to help you find the best solution, but I can't becaus=
e
> I don't understand how the subsystem and driver are structured, and y=
ou
> aren't providing enough details. =A0We won't make any further progres=
s on
> this unless you abandon the incomplete high-level overviews and inste=
ad
> give a more or less complete lower-level description -- including the
> subroutine names!

In fact, I'd appreciate if we can abandon the high-level discussions to=
o :)

I have provided pointers to the actual code, please tell me if you're
interested in any other parts or have questions about it.

> Maybe you mean that you want to prevent dpm_complete() from powering
> the device down while it is in use.

Yes.

> That should never be a problem --
> the device should never be used without the PM core being aware.

That's why I said we will have to both directly manipulate the power
of the device, and also maintain usage_count.

> Therefore you need to have a single routine that actually powers-down
> the device, and you need to call this routine in different settings:
> during system sleep or runtime suspend (the same code in the driver
> handles these two cases, right?) and when a reset is needed.

Yes. and sometimes also just because the user turned wlan off.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
