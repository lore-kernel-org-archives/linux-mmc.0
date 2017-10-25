From: Mark Brown <broonie@kernel.org>
Subject: Re: spi-atmel.c: regression
Date: Wed, 25 Oct 2017 11:24:28 +0200
Message-ID: <20171025092428.6pkfbiaq2ymrviea@sirena.org.uk>
References: <0876ce0a-cb93-07b7-8019-e365d08cca2a@gmail.com>
 <1ab533fa-7bb5-8a83-c4a3-8f066754a27c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="alqxb2vvz3mo4m7y"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbdJYJYd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2017 05:24:33 -0400
Content-Disposition: inline
In-Reply-To: <1ab533fa-7bb5-8a83-c4a3-8f066754a27c@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Cyrille Pitchen <cyrille.pitchen@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--alqxb2vvz3mo4m7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 10:05:57AM +0300, Igor Plyatov wrote:

> > please help to manage issue with data corruption by PDC of SPI.
> >=20
> >=20
> > I have compared operation of Linux-2.6.39 and linux4sam kernel 4.9.36+
> > on the AT91SAM9G20 (Stamp9G20 SOM from Taskit.de) and found regression
> > in the spi-atmel.c.

Nobody working on the driver has any thoughts on this?

> >=20
> > New spi-atmel.c driver works very bad with SPI speeds above 6 MHz. I see
> > corruption in data received by Linux and SPI overruns when OS has big
> > CPI and IO load.
> >=20
> > Old kernel works fine at 22 MHz with the same device driver and hardwar=
e.
> >=20
> > Can somebody comment and/or help on how to resolve this issue?
> >=20
> > Best wishes.
> > --=20
> > Igor Plyatov
>=20
> For those, who has same interest or encountered the same issue as I had...
>=20
> Notes:
> A) My "gs_mgms_dsp" linux driver is the same for linux-2.6.39 and
> linux-4.9.36
>    and communicates with DSP through SPI-bus, where data packets are 32 b=
yte
>    long and last byte is CRC8 to check data integrity.
> B) CPU is AT91SAM9G20.
>=20
> I have encoutered SPI data corruption during receiving of data from DSP by
> linux-4.9.36 if SPI-bus has big traffic in parallel with big traffic at M=
MC
> interface.
>=20
> Old linux-2.6.39 does not suffer from such issue, because atmel-mci.c dri=
ver
> has
> PIO access to MMC interface. While new kernel has changed the atmel-mci.c
> driver
> for use of PDC (Peripheral DMA Controller) for access to MMC interface.
>=20
> Both kernels have Atmel SPI driver where PDC used for SPI data transfers.
>=20
> SPI data corruption looks like duplication of one of received bytes.
> Such bytes surrounded by "**" at log below.
>=20
> gs_mgms_dsp spi32766.0: CRC error.
> gs_mgms_dsp spi32766.0: <- 35 36 37 38 39 3A 3B 3C 3D  3E 3F  40 41 42 43=
 44
> gs_mgms_dsp spi32766.0: <- 45 46 47 48 49 4A 4B 4C 4D *4F 4F* 50 51 52 53=
 A4
> gs_mgms_dsp spi32766.0: -> EIO=3D0x05
> gs_mgms_dsp spi32766.0: CRC error.
> gs_mgms_dsp spi32766.0: <- 0F C2 C3 C4 C5 C6 C7 C8 C9  CA CB  CC CD CE CF=
 D0
> gs_mgms_dsp spi32766.0: <- D1 D2 D3 D4 D5 D6 D7 D8 D9 *DB DB* DC DD DE DF=
 02
> gs_mgms_dsp spi32766.0: -> EIO=3D0x05
> gs_mgms_dsp spi32766.0: CRC error.
> gs_mgms_dsp spi32766.0: <-  03 5A  5B 5C 5D 5E 5F 60 61 62 63 64 65 66 67=
 68
> gs_mgms_dsp spi32766.0: <- *6A 6A* 6B 6C 6D 6E 6F 70 71 72 73 74 75 76 77=
 25
> gs_mgms_dsp spi32766.0: -> EIO=3D0x05
> gs_mgms_dsp spi32766.0: CRC error.
> gs_mgms_dsp spi32766.0: <- 15 76 77 78 79 7A  7B 7C  7D 7E 7F 80 81 82 83=
 84
> gs_mgms_dsp spi32766.0: <- 85 86 87 88 89 8A *8C 8C* 8D 8E 8F 90 91 92 93=
 00
> gs_mgms_dsp spi32766.0: -> EIO=3D0x05
> gs_mgms_dsp spi32766.0: CRC error.
> gs_mgms_dsp spi32766.0: <- 2A EC ED EE EF F0 F1  F2 F3  F4 F5 F6 F7 F8 F9=
 FA
> gs_mgms_dsp spi32766.0: <- FB FC FD FE FF 00 01 *03 03* 04 05 06 07 08 09=
 0A
> gs_mgms_dsp spi32766.0: -> EIO=3D0x05
>=20
> This looks like silent SPI overruns not detected by AT91SAM9G20 HW.
>=20
> At the end, after some seconds or milliseconds of communication, HW SPI
> overrun
> flag detected by the spi-atmel.c driver:
> "atmel_spi fffcc000.spi: overrun (0/0 remaining)".
>=20
> Strictly speaking this is not a regression of spi-atmel.c, but unfortunate
> combination with atmel-mmc.c, where PDC used too and I suppose a HW bug in
> AT91SAM9G20 CPU.
>=20
> Please help to answer on questions:
>   1) How to modify atmel-mci.c driver to have option for PIO access to MMC
>      interface?
>   2) Why SPI overrun flag does not asserted each time? I have not found s=
uch
> HW bug
>      in the Errata for AT91SAM9G20 CPU.
>=20
> Best wishes.
> --
> Igor Plyatov

--alqxb2vvz3mo4m7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnwWEkACgkQJNaLcl1U
h9AQeAf9FPTBK4E5dtx7pPcpGf8D2Posp76yA60wiWWhRpEdRwblKEOiRLD8rtlq
HX5SbiYy+UWrp43Ttuu9XPy1VnZXX4RZTkccNa6P3kVjNoX5rZKGUbl+LNuQTDZv
O9S+f9czeB8rQYhUr67MSu1+pGPO0g85crg9jBrdXT1LAeWPnpQDR25VIqihuDWI
3qeGyIee5qMUwRYJO6sCY9WcQ5PvzFl9vIkBzmPjDuL9jHq4atSnnoKs/2kaaEF7
+2qaLMqd6yMFSEgZf+1QZFKg0bldWYwiCj0S1spIy9XKLlQoCvfhe662m3EdAWMO
yK5BhHsrIe/aiQ4zIZQB8ymqztXBVw==
=lh/2
-----END PGP SIGNATURE-----

--alqxb2vvz3mo4m7y--
