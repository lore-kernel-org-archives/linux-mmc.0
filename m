From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 18 Feb 2014 08:25:11 +0900
Message-ID: <20140217232511.GA2669@sirena.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1580658.FIe4en5bEU@wuerfel>
 <52FF6A16.5080201@gmail.com>
 <1528854.BAQRr94nzx@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1528854.BAQRr94nzx@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2014 at 05:21:11PM +0100, Arnd Bergmann wrote:
> On Saturday 15 February 2014 14:22:30 Tomasz Figa wrote:

> > I'm not sure if we should assume that SPI =3D MMC over SPI. I believe=
=20
> > there might be a custom protocol involved as well.

> In case of SD/MMC, you essentially have three separate command sets:
> SPI, MMC and SD, and each of them has multiple versions. MMC and SD
> compatible devices generally also support the SPI command set (IIRC

=2E..

> If a device supports both SDIO and SPI, I think a straightforward
> implementation would be to use the exact same command set, but
> you are right that this isn't the only possibility, and the SD/MMC
> shows how they can be slightly different already.

I'm aware of existing devices that do in fact break this assumption.

> > Stepping aside from SPI, I already gave an example of a WLAN chip that=
=20
> > supports multiple control busses [1]. In addition to the commonly used=
=20
> > SDIO, it supports USB and HSIC as well:

> > [1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf

> > Moreover, some of Samsung boards use HSIC to communicate with modem=20
> > chips, which have exactly the same problem as we're trying to solve her=
e=20
> > - they need to be powered on to be discovered.

> Thanks, this definitely makes a good example. I see that it also
> supports SPI mode for SDIO as mentioned in your link.

Slimbus has all these issues too with the added fun that for normal
operation some devices want to be in a low power mode where they're
disconnected from the Slimbus a lot of the time.

> * Olof's proposal (add properties or a child node to the host
>   controller node with just power-on sequencing information):
>   + We only need one implementation for each bus, possibly shared
>     across buses to some degree, and can handle lots of devices
>     without having to touch their individual drivers.
>   + A logical extension of things we already do on SD cards
>     (CD/WP GPIOs, external clocks and voltages supplied to
>     standard compliant devices as part of the normal probing)
>   - The shared code may get rather complex to deal with all
>     possible corner cases we run into over the years.
>   - Somewhat harder to do if you have to attach the power
>     information to a device node for a USB hub port, rather
>     than an SDIO controller that only has one slave device.

We would also need mechanisms to allow devices to take over the running
of their own resources for cases like the Slimbus ones I mentioned, and
some mechanism to cope with devices that hotplug themselves in normal
operation.

> * Arnd's proposal (change bus code to probe nonstandard devices
>   from DT if we can't easily detect them):

I've also proposed this in the past FWIW but never got far enough
through my list of things I want to do with my subsystems to actually
start coding.

>   - Has to be implemented in each driver that needs it, making
>     it harder to share code for drivers with the same need
>     (e.g. every device that just needs an external reset
>     trigger).

I think we can probably come up with some standard helpers that work
well for the common case here (see also some of the discussions about
power domains ensuring that core IP clocks are provided for IPs, it's
kind of circling back to the same issues).

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTAppOAAoJELSic+t+oim9JLsP92gJV3S/qwG2/Nsgl7D6ls9l
KWiNnf3tfvdTtWArmZKKXYL9QignB4GDSzpS1ih7OHaZ4O3OFCojSE1RG5+RIikG
j4AlbTFVtGkoOJIX6R3aPhB1fSbAraoWDhqDDobPLMmPg3yxEjerkUKVVmwSpJEK
Xff/vazrAAURFWMPSD01x2FLVdER/mm4bJ0rexcqbx4gC4sUyrM279Xrt59uXFyk
4pInuDuRoSu20C+ay+tkXDqcxca9TUoadKHboLiF7EWDqJvrH2B+d3xfrMpn1+kD
GetGtZ84CDf2xeOjzmBGvWtOwTOTS5lL+GTQpdC+3nwi91/EsXyc012GljaaGaLZ
TXnKN1Gwe7pOKJwqcmxTVmXXljVe8p5lQTZ8QP4+oUpZ7cvR/njuMH3V2GPe463f
PJuoQsuVqRv6MKnlZLtpPHJO+mFDJZIeDj2H4rXYDepSqjUZUPvLuuXg+JqfrSuv
p9xD+TY62xoeE9iqUvZVo4rrRkhdcgxaYHnz2XFOFxNBLTq2iOkGoAFSxgz2b6og
j0SoFjYx6JoB8qNgdIbt8k4xO0qLFxU+bFRcAmNIjlLtn+iHbrlZpZAc+kkiiCOP
39OFko577FTvp59rcY9Q5P5gJUAJNb/DFwTEGYOJt4mwFrYlP0TnjF8YV+ugAh5b
/d3ww6pIFFak3+8kJ/A=
=RdTe
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
