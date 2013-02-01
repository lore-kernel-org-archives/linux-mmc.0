From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Fri, 1 Feb 2013 22:56:00 +0200
Message-ID: <20130201205600.GA31762@arwen.pp.htv.fi>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7764280878580205488=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <510C2A47.1090607-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============7764280878580205488==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Feb 01, 2013 at 11:49:11PM +0300, Sergei Shtylyov wrote:
> > good point, do you wanna send some patches ?
>=20
>    I have already sent them countless times and even stuck CPPI 4.1 suppo=
rt (in
> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remo=
ve the
> patch. :-(

sticking into arch/arm/common/ wasn't a nice move. But then again, so
wasn't asking for the patch to be removed :-s

> > I guess to make the MUSB side simpler we would need musb-dma-engine glue
> > to map dmaengine to the private MUSB API. Then we would have some
> > starting point to also move inventra (and anybody else) to dmaengine
> > API.
>=20
>    Why? Inventra is a dedicated device's private DMA controller, why make
> universal DMA driver for it?

because it doesn't make sense to support multiple DMA APIs. We can check
=66rom MUSB's registers if it was configured with Inventra DMA support and
based on that we can register MUSB's own DMA Engine to dmaengine API.

> > Once that's done, we drop MUSB's private API.
>=20
>    Don't think it's a good idea.

see above.

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRDCvfAAoJEIaOsuA1yqREUjQP/RqhK6sXFPDiZQokepbVHvh1
/QY/xwmvqJ5sC+OJn99FrQ0Lp+4awceYRrx3d/aLbZ2ato58jLpdXNMOSyYiJR5R
gE4nNYafHmv070vFnkt87M9VsEZY7hERUh0UjNoqcREKYLSJ5Te0CkN2Dfewx4Ub
dX3UQKVxjjCsxcNEg2+Ssyw1+oMTbjkSjkAwQbet8ZFsZSqXXoJ5xuRh1Ik2VD0M
Xuc+MAAWbzilgcyM7C9Yxw5cvlan7ei6hsPgAq2kNai7WK2lm47h+enwW41q/nbs
iXIhXM7qFHpwsByG3K3Rpkmtsg75SM8ymyNohdxb5odwh4Evzw2Z/ed6Vu+t0JK6
vK1/mSOP7QtQCNFcO0gOvLT3NCavEf372bTLiKNWvSb1KecC4BB84tJ+oGrGxCKS
BnhVKCKtq5PqGBoBxv29JVaTgNh0djr804bLYssB9RNvnigYh8ZD6CCLr8aDT8P5
fyZWjXY74K8N8sfTHBYASUIhC7IVeDDFApt/0UKt8+OLPwJ9aLxXHhx+xBG96Im9
d0Jx31hInwZ+2l7ZZr8CE/1Oy79qtAX2ANJOjSSuR8SGah+ipW40Er2nYbN0+0hx
QiDPcezowX/2yVF7HNQjiYfAoq3pwiESXlPfN3/BnAwIsP5p/HGT9nRun2yiQJL1
U0qONWBg4L7gNQUFhURD
=dgm9
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============7764280878580205488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7764280878580205488==--
