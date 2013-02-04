From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 4 Feb 2013 19:02:16 +0200
Message-ID: <20130204170216.GC4269@arwen.pp.htv.fi>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
	<20130204164712.GB4269@arwen.pp.htv.fi>
	<510FF5C9.3030600@mvista.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844909107=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <510FF5C9.3030600-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>Li
List-Id: linux-mmc@vger.kernel.org

--===============1844909107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline

--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 04, 2013 at 08:54:17PM +0300, Sergei Shtylyov wrote:
> > On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
> >>> opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
> >>> Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.
>=20
> >>> Granted, CPPI 4.1 makes some assumptions about the fact that it's
> >>> handling USB tranfers,
>=20
> >>    What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it=
's just
>=20
> > HW makes the asumptions
>=20
>    Not true at all. There is a separate set of registers (at offset 0) wh=
ich
> copes with USB specifics, but CPPI 4.1 itself doesn't know about USB anyt=
hing.

CPPI 4.1 was made for USB transfers.

> It's just the way the driver was written that it used both sets of regist=
ers but
> this needs to be changed into more abstacted accesses to the USB-specific=
 part,
> to cope with it being different on different platfroms, like AM35x. The d=
river
> as it was last posted, just needs rework now.

are you saying you will do the work ?

> >>    Don't know, I was quite content with the abstraction when writing C=
PPI 4.1
> >> driver for MUSB...
>=20
> > look closer. The whole:
>=20
> > if (is_cppi())
> > 	foo();
> > else if (is_inventra())
> > 	bar();
> > else if (is_omap_sdma())
> > 	baz();
>=20
> > is bogus.
>=20
>    That part -- yes. There were attempt to get rid of this, but without c=
hanging
> the DMA API. It was left halfway done after my only critical comment, IIR=
C. Will
> we ever see the continuation of this effort?

patches are welcome

--=20
balbi

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD+mYAAoJEIaOsuA1yqREYRYP/3EKttosWR93nRGgtWaJhy1X
3YAOwIxCTY96/vju2F32NVPkEzM86iQ5bGy7iUf+YSeq7zHE/jxI9WqXYQNVVOsU
MikYsqHQqZH1xy0Th4l8Un/tRTxG9y5fWDLXSsCyajmD9M0g5RfCHOz1glZLcVRD
Jnu1oHwFG7ls0Nsldeg6mCoR+33jl2w2KdvRMmDEm/rsqbXCg2OugWXOCEZMv7Jc
XISYbyaz2t3uatXFRKMxnpw+r1ziYzuQIqGYI7CKhowYOD7I9eokpiDRfSYzzAF2
ck4ZVAOKG+FI1lTRC3Wd9DQDgkiVxWC0QFXfHaUO8ukX0zk6Twlvf6ZLkhAHLE73
DSFwV1YElY6acAGC8UG1HFPEN0BPf2kyVZdq9jXXxCyA/ZvzEPNuaBjp5UscE7Iw
Of3VM3bpOiMer859VsZZ16z6fPTAhrTzui3icVEoeop9WaQ2wKZvVW1pAYdDjgem
Si/ywEtjIe724KjjTR8VMp2CEyziXNapbPDJ860s84EveCEFjeyOtTNH0kIP09s6
kPFmE31yi28lFSPAqc7ohO3jqDR7z+qqF2DvOh+miSKUll7TCSpnXN2wT4UJ5HGm
YLJLRe9wxrHBvb3tz02qtt0PyQAIfHAIGs8Llas+/ki2eFeise0fFWP54zjIe9eR
AEDTciWKFntvCb+P2OYt
=nSAz
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

--===============1844909107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1844909107==--
