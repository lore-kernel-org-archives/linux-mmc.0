From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix initialization order of mmc block
 devices
Date: Tue, 13 Oct 2015 10:00:43 -0400
Message-ID: <20151013140043.GT23893@bill-the-cat>
References: <1444714193-24816-1-git-send-email-hs@denx.de>
 <561CA8D3.2090507@ti.com>
 <561CB653.5020707@denx.de>
 <561CBAE3.3020707@ti.com>
 <CAGo_u6oDMH+Aj41fCsqEuTK1TXocUe=zU9No4=_QmZWg3FXb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nreWiX4Cj9hiu/Wx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33000 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbbJMOAh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2015 10:00:37 -0400
Received: by qgeb31 with SMTP id b31so14738000qge.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2015 07:00:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGo_u6oDMH+Aj41fCsqEuTK1TXocUe=zU9No4=_QmZWg3FXb0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lokesh Vutla <a0131933@ti.com>, hs@denx.de, lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@bosch.com>, Georg.Soffel@bosch-si.com, linux-omap <linux-omap@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, u-boot <u-boot@lists.denx.de>


--nreWiX4Cj9hiu/Wx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 08:24:08AM -0500, Nishanth Menon wrote:
> On Tue, Oct 13, 2015 at 3:03 AM, Lokesh Vutla <a0131933@ti.com> wrote:
> >
> >
> > On Tuesday 13 October 2015 01:14 PM, Heiko Schocher wrote:
> >> Hello Lokesh,
> >>
> >> Am 13.10.2015 um 08:46 schrieb Lokesh Vutla:
> >>> +Nishanth,
> >>>
> >>> On Tuesday 13 October 2015 10:59 AM, Heiko Schocher wrote:
> >>>> On embedded devices, often there is a combination of
> >>>> removable mmc devices (e.g. MMC/SD cards) and hard
> >>>> wired ones (e.g. eMMC). Depending on the hardware
> >>>> configuration, the 'mmcblkN' node might change if
> >>>> the removable device is available or not at boot time.
> >>>>
> >>>> E.g. if the removable device is attached at boot time,
> >>>> it might become mmxblk0. And the hard wired one mmcblk1.
> >>>> But if the removable device isn't there at boot time,
> >>>> the hard wired one will become mmcblk0. This makes it
> >>>> somehow difficult to hard code the root device to the
> >>>> non-removable device and boot fast.
> >>>
> >>> Why not use "root=3DPARTUUID=3D${uuid}" option instead of relying on
> >>> mmcblk no?
> >>> U-Boot can easily detect your partuuid. Refer to [1] on how TI platfo=
rms
> >>> does this in u-boot.
> >>
> >> Good tip ... I do not know, if it is possible to update U-Boot
> >> on this boards...
> >>
> >> Current U-Boot says:
> >> U-Boot 2013.01.01_heads/master-gc7900a0 (2015-05-06 - 20:37:15)
> >>
> >> I2C:   ready
> >> DRAM:  512 MiB
> >> [...]
> >> U-Boot# mmc rescan
> >> U-Boot# mmc part
> >>
> >> Partition Map for MMC device 0  --   Partition Type: DOS
> >>
> >> Part    Start Sector    Num Sectors     UUID            Type
> >>   1     63              144522          000ce343-01     0e Boot
> >>   2     144585          659861          000ce343-02     83
> >> U-Boot# part uuid mmc 0:2 uuid
> >> Unknown command 'part' - try 'help'
> >> U-Boot#
> >>
> >> So, if this patch has no chance for mainline, please let me
> >> know it, thanks!
> >>
> >
> > IIRC, Nishanth had posted a patch something similar but got rejected for
> > some reason. Probably Nishanth can comment more here.
> >
>=20
> overall the feedback I received was for block devices, there is
> already an unique method(PARTUUID/uuid) of referencing required device
> and mmcxblky aliasing was not really needed - hence dropped my patch
> and switched over to partuuid.

Not telling the kernel what to do here but root=3DPARTUUID=3D$x is the long
standing portable multi-architecture (and storage medium) way to have a
stable name for your root device.  The automatic way of digging this
information out in U-Boot is dates back to Sept 2012 in mainline.

--=20
Tom

--nreWiX4Cj9hiu/Wx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJWHQ6LAAoJEIRElH1W1v7NWdsP/0kV/0vEKfnxUDxynyd/Gilc
eXYNHXOgDWy9PH7KctM3GfG/TcW6elHv6bx9MZRCNJ2MeC5QNCcuQmBo+W8rYiRa
8h2qfsiHzXr6x0X0pZ6iIEsbDa0sexAaI01Bj4m7593O3ULziLd5uGuJbvd4qo/H
fLQ1HSHbOpbaKQnwNMYpQH1T87ZkeWh5+vLShD4nhAjjhAvRC26nrWifwbkYlWJr
nY41DUTsV8zRiXEvFgabiHQ6KHCu0VWgnwD8dSoIWbKrMTvx7fwfPUfbzsCfYtNA
NGopcKQ3MzTlPi0wI8IBtMgWk2NElTL2PuOoJGRMju9AFMj19GcnpOjgiAQvgT9t
HK5pd6OWgztMdC6JAKLHmXtlDId625yh9Qi+JdSGg0aflKfsE4CbELvI7B4AvQte
bc8dY7c8T8wCKiMAPDaMyNknlWhH/idAVPzraglSpQ0gJHmx2kf8MPFBhNbyTOEL
84RjFwCOWOcbBdsJBeVoIdI5rM4OqJm/ztyYcq+HgFp+2V0JQH6fiYX3CLpUSXSb
B2OSvWuRJcaRZIN1Swn6efLyGTPM+OIGzVB5k4sGZUBPbIIwVSj2L/dZE2hygi6F
xMj0E9hTAbQkySaH7x+QoDE7SuYD8uf8WmJXLXN3zyfwpZ4Mz5mS4VwG85ywQa5O
/pJnUytTnOM5bQO8A0y+
=hU8O
-----END PGP SIGNATURE-----

--nreWiX4Cj9hiu/Wx--
