From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] mmc: sdhci-iproc: fix spurious interrupts on Multiblock
 reads with bcm2711
Date: Fri, 04 Oct 2019 14:59:35 +0200
Message-ID: <0b544f5bc31857fef2d13bd16275cf09ace58b89.camel@suse.de>
References: <20191004125226.27037-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-E7U/NXt/RvithmmAJCzu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004125226.27037-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
Cc: wahrenst@gmx.net, Matthias Brugger <mbrugger@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--=-E7U/NXt/RvithmmAJCzu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-04 at 14:52 +0200, Nicolas Saenz Julienne wrote:
> The Raspberry Pi 4 SDHCI hardware seems to automatically issue CMD12
> after multiblock reads even when ACMD12 is disabled. This triggers
> spurious interrupts after the data transfer is done with the following
> message:
>=20
>   mmc1: Got data interrupt 0x00000002 even though no data operation was i=
n
> progress.
>   mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>   mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
>   mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>   mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>   mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>   mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
>   mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00080008
>   mmc1: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x00edc87f
>   mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
>   mmc1: sdhci: Host ctl2: 0x00000001
>   mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf3025208
>   mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable ACMD12 on multiblock
> reads and suppress the spurious interrupts.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Matthias Brugger <mbrugger@suse.com>

Forgot to add:

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM271=
1")

I'll resend if needed.

Regards,
Nicolas


--=-E7U/NXt/RvithmmAJCzu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2XQjcACgkQlfZmHno8
x/5CBQf/WvHZDFKw37mxwtwN2x5i0WFg95fBCi+6Hk6D0vDWuVUVMZBYneEUmyIt
p42PpscEU854tHmqpqDn6/g2+O/9+g1XW3HOoOj4WjoP27d8uZPCPa0v8eWpahdI
vGVhVjoCIuFlu3rsBW1tz/zvzVGmRICBY8ZurPqA7Pi+mepPAnWgjC99v4RDUEZc
iqYqSupt4qyT7bhs5JOFywXm1Qu+KHQ0XoqGQdBD/vEVNuJn2bu0gOhvqKeWCWdl
l6cHyjZjtHvtILFZyo1+Ys2DjVJnjPBY3zRBFG2C8I+2Ep3ust80fZ6SbZnMqDGx
jjaH2rBVoZ7Ic5dAcBPXmjieSdo/Bg==
=mtyS
-----END PGP SIGNATURE-----

--=-E7U/NXt/RvithmmAJCzu--
