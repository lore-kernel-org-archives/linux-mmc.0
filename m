From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Fri, 1 Feb 2013 20:58:20 +0200
Message-ID: <20130201185820.GE29898@arwen.pp.htv.fi>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
	<1359742975-10421-2-git-send-email-mporter@ti.com>
	<5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
	<20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1072047156=="
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <510C1D0E.6030401-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5ug@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============1072047156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline

--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 01, 2013 at 10:52:46PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 02/01/2013 09:49 PM, Matt Porter wrote:
>=20
> >>> Move mach-davinci/dma.c to common/edma.c so it can be used
> >>> by OMAP (specifically AM33xx) as well.
>=20
> >> I think this should rather go to drivers/dma/?
>=20
> > No, this is the private EDMA API. It's the analogous thing to
> > the private OMAP dma API that is in plat-omap/dma.c. The actual
> > dmaengine driver is in drivers/dma/edma.c as a wrapper around
> > this...same way OMAP DMA engine conversion is being done.
>=20
>   Keeps me wondering why we couldn't have the same with CPPI 4.1 when I p=
roposed
> that, instead of waiting indefinitely for TI to convert it to drivers/dma/
> directly. We could have working MUSB DMA on OMAP-L1x/Sitara all this time=
=2E.. Sigh.

good point, do you wanna send some patches ?

I guess to make the MUSB side simpler we would need musb-dma-engine glue
to map dmaengine to the private MUSB API. Then we would have some
starting point to also move inventra (and anybody else) to dmaengine
API.

Once that's done, we drop MUSB's private API.

--=20
balbi

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRDBBMAAoJEIaOsuA1yqREl64P/1L6sI+7Q0wkbE+G/SzHutfJ
EvDFskR7FIk4c3nWFb57t8m7drRueQcReuCRHicfzrwxPRzWGhSVNfOCHTn+2H4e
D5fP9/vH99cxaEbckBYz28NUT0f6qv+1O8pFT3YI6ggb4crbYBp9k36ZYeO4V9g8
Ek2WVRIXY7WGo15K+hW4LP5zV36iwJIzeWg7T6NNddenRA4mkQtP/kDtVTxBCs8G
ew5mQ9pOYOO9iLwovKwuVSqB3gW7ekKWK5PaJqvMYB4op04tGSjKZbYHNeusxdF0
sMRbdqfbIxKybdI1nE3Gno0Z0KaogYJzSyVJZrsrj9ao7Q/NMcMuVmPW5iToj66I
twcezMYZOh0QcPSJfY9LOsrfIPx3giQq4CbS/KB2p8fW3MZtlKiTlFrhaw8t9P9d
oIhIi5autXnbAnt6tP3rnTi39Vg61/8l5x2thzsjaH581n1OAvayEWuLg/GBQK52
ZpBomWcRl2lJN63WPCrqI50GVmSe4Bjh4QFyZJ4HFNqoskxfwatNRMhdnWZ167pr
ak/XCR2kTwg/8ExBqaJZWsfuKQL9MqGMGscYiY4krCA5/qfH3O1gGcLhsug7ETfn
P6W0qeOlLAm0vhQUAUwM1TZEVfrqa9Ltbpn9itPu5wnK9XYdIe88rSsJXWDb/K1r
Y46NwB5l1mxXXQCkiauY
=htAV
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

--===============1072047156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1072047156==--
