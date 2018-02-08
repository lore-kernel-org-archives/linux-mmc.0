From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Date: Thu, 8 Feb 2018 15:59:52 +0100
Message-ID: <20180208145952.qlq4sxohqd3s7m7o@qschulz>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-3-quentin.schulz@free-electrons.com>
 <4015f7df-36ca-c762-5b9a-94a270f65475@redhat.com>
 <CAPDyKFpePxfAc20NCO7xvbGca8m=Bymc=5KBYFF570rnACViQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="332cqcp7t26jwefa"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46680 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHPAH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Feb 2018 10:00:07 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpePxfAc20NCO7xvbGca8m=Bymc=5KBYFF570rnACViQA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Baolin Wang <baolin.wang@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Icenowy Zheng <icenowy@aosc.xyz>, Chen-Yu Tsai <wens@csie.org>


--332cqcp7t26jwefa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, Aug 30, 2017 at 03:43:49PM +0200, Ulf Hansson wrote:
> On 30 August 2017 at 14:44, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> >
> > On 21-07-17 16:35, Quentin Schulz wrote:
> >>
> >> From: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Some sdio devices have a multiple stage bring-up process. Specifically
> >> the esp8089 (for which an out of tree driver is available) loads firmw=
are
> >> on the first call to its sdio-drivers' probe function and then resets
> >> the device causing it to reboot from its RAM with the new firmware.
> >>
> >> When this sdio device reboots it comes back up in 1 bit 400 KHz mode
> >> again, and we need to walk through the whole ios negatiation and sdio
> >> setup
> >> again.
> >>
> >> There are 2 problems with this:
> >>
> >> 1) Typically these devices are soldered onto some (ARM) tablet / SBC
> >> PCB and as such are described in devicetree as "non-removable", which
> >> causes the mmc-core to scan them only once and not poll for the device
> >> dropping of the bus. Normally this is the right thing todo but in the
> >> eso8089 example we need the mmc-core to notice the module has disconne=
cted
> >> (since it is now in 1 bit mode again it will not talk to the host in 4=
 bit
> >> mode). This can be worked around by using "broken-cd" in devicetree
> >> instead of "non-removable", but that is not a proper fix since the dev=
ice
> >> really is non-removable.
> >>
> >> 2) When the mmc-core detects the device has disconnected it will power=
off
> >> the device, causing the RAM loaded firmware to be lost. This can be wo=
rked
> >> around in devicetree by using regulator-always-on (and avoiding the us=
e of
> >> mmc-pwrseq), but again that is more of a hack then a proper fix.
> >>
> >> This commmit fixes 1) by adding a mmc_force_detect_change function whi=
ch
> >> will cause scanning for device removal / insertion until a new device =
is
> >> detected. 2) Is fixed by a keep_power flag to the mmc_force_detect_cha=
nge
> >> function which when set causes the mmc-core to keep the power to the
> >> device
> >> on during the rescan.
> >>
> >> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> >> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> Cc: Chen-Yu Tsai <wens@csie.org>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >
> > So when I posted this patch quite a while back, there was some discussi=
on
> > about this and a consensus that this is not the right solution.
> >
> > So first of all lets describe the problem:
> >
> > The esp8089 sdio wifi chip is really an ARM core with a wifi phy
> > connected to it (as many wifi chipsets are).
> >
> > But this one comes up in some really generic sdio capable boot-loader
> > mode and we need to feed it firmware and then reboot it into the
> > new firmware.
> >
> > The reboot is where the problems happens. It seems to fallback
> > from the negotiated 4 wire sdio mode to single wire spi mode then.
> >
> > The out of tree version of the driver deals with this by not setting
> > the non-removable flag as well as setting the broken_cd flag so that
> > the mmc core polls the device, after the reboot the poll fails
> > because the mmc-controller and the esp8089 are using a different
> > amount of wires so the mmc-cmd the poll uses times out.
> >
> > After which the esp8089 drivers remove function gets called, and
> > the mmc stack re-discovers the esp8089 by restarting the whole
> > number of wires (and speed) used negotiation. After which the
> > esp8089 driver's probe function gets called (again) and on
> > firmware loading is has set a global flag, so now it actually
> > acts as a wifi driver rather then trying to load the firmware
> > a second time.
> >
> > Since I did not want to rely on broken_cd polling I came up
> > with the hack which is this patch.
> >
> > So when this patch was first discussed we came to the conclusion
> > that what we really need is some sort of mmc_reprobe_device
> > function which the driver can call from probe which will
> > redo the number of wires (and speed) used negotiation,
> > while keeping the sdio_function device as is so that probe can
> > simply continue after this and we also don't need the ugly
> > global flag.
> >
> > The idea would be for this function to be some wrapper
> > around mmc_init_card() which resets the ios settings as is
> > normally done on remove and then call mmc_init_card()
> > passing in the existing card the same way as is done
> > one resume, so that the existing card / sdio_function
> > devices get reused.
> >
> > IIRC Ulf would look into writing this mmc_reprobe_device
> > function and then I would test it with the esp8089, but
> > Ulf never got around to writing the function and I ended
> > up working on other things too.
>=20
> Thanks for summary!
>=20
> Just to let you know, I haven't forgot about this problem. I am
> planning for a major update of the SDIO for power management support,
> within a not too far future.
> The issue described above, is then also one of the things I also plan
> to look into.
>=20

I'd like to know if any progress has been made on that problem (I may
have missed patches).
Had you had the time to look at the issue?

Thanks and kind regards,
Quentin

--332cqcp7t26jwefa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJafGXlAAoJEIS4mnU+4PGjFJcP/2wABRuHxatBtHn4qq+lkfGs
5NHKU/bwH4BJ6YpnbXbdMrQDtc+C0UxVaH+jkyAhJ0ZHTLL+uLQzX3BEbfnAtaVc
MIIi0aa92BbWWOnAmAxZ7MF2/zZICKNRz0GxBTGzMStuuXiBTc+LD8lUbB+C933u
RxWfZ0NuAL4bcOTBfqpWgwXnBA9B8Ex7tugT5nW7v7zc8NkL2OO4dbaFKU3ipoqz
TyGdFuYsByJROs36ZQeSYzgb36hjvK4ls1DEkGDRqJZuEW/M+lzcbYV/McFQ7F81
Tle9iEJitlKXbNML4hSeSJkVqtT/6ExVrhcCH5vH+vm/t85xl1bZuDBdko9HqjSu
bpnXXxM+dRhdbRC/0PqToOMFr1lw8Egx05v5SRr45b+/PKQMlZPQGjJatJANSBlK
czFznaB9ZpqcY3ecvEGAU51VGkxLz2fDs+oI2DkcSVUnmq/7rnyL0/J7awJ7uhr+
z7wLVLFbQUT/rJZseUYMnHEOGSSoHocF2gSzsUA+/NJjXIlAfrjJwmKK/ta4pVC2
DECSDQsUK/7ijkhNzU1N4T94eUjOOWm2U0k8qehOfE8Hh/ImnUV5Ti0uPG58ok6A
9PsyRUBsFCRHmuJ5LCmSN5vSzfLVFmT7ZdASrrnmL5wl7ngD+jwlptLtBCFKamn3
qzhcwk+GK401NHHvpSkC
=LnZD
-----END PGP SIGNATURE-----

--332cqcp7t26jwefa--
