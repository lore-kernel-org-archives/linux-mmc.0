From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Mon, 20 Jun 2016 18:06:10 +0100
Message-ID: <20160620170609.GA26099@sirena.org.uk>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2>
 <20160620161607.GA11427@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fKtH0JUtvN5p2ETH"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160620161607.GA11427@rob-hp-laptop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Philipp Zabel <p.zabel@pengutron>
List-Id: linux-mmc@vger.kernel.org


--fKtH0JUtvN5p2ETH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 11:16:07AM -0500, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 07:26:51PM +0800, Peter Chen wrote:

> > If the node has property "power-sequence", the pwrseq core will create
> > related platform device, and the driver under pwrseq driver will handle
> > power sequence stuffs.=20

> This I have issue with. If you are creating a platform device here, you=
=20
> are trying to work-around limitations in the linux driver model. Either=
=20
> we need some sort of pre-probe hook to the drivers to call or each=20
> parent node driver is responsible for checking and calling pwr-seq=20
> functions for child nodes. e.g. The host controller calls pwr-seq for=20
> the hub, the hub driver calls the power seq for the asix chip. Soon as=20
> we have a case too complex for the generic pwr-seq, we're going to need=
=20
> the pre-probe hook as I don't want to see a continual expansion of=20
> generic pwr-seq binding for ever more complex cases.

I think it's fairly clear that we need one or both of these mechanisms
for enumerable buses in embedded contexts - it's something that keeps
croping up.

--fKtH0JUtvN5p2ETH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaCKAAAoJECTWi3JdVIfQSx0H/A8CgWBIxx6BRObIJtvZqknF
Q3EiIP60kb6FR1CxObdWXAf7bx9gFZYaOQ4nyh1lS40woh55wStbDlsAfe3/xRVe
ZgnwYlWgL2DVeyG0nqd3VFE+gTCVWgFZM0PMJrcNTUsVUItoRHeZHTPnskwuGa8i
uVCBvvOjJ9vKenPNCpv9S8sqk51d1sQ/e9Z6ydy15xmQVNkTczSVpJW4H6N3mqYA
IEugYPm3AzJ8fOFMrU84f2vwL7xPfnsZjseczRVobCebL1iJub0b+3WxlUUy1aiE
oJ9uAVSYl0TOgo6HoWO3t4KFNU6MFNTlAwCRVmBzIIMhH9GYDOrZDOsP6awOEVE=
=aFUu
-----END PGP SIGNATURE-----

--fKtH0JUtvN5p2ETH--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
