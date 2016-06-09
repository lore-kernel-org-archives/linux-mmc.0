From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Thu, 9 Jun 2016 16:57:46 +0100
Message-ID: <20160609155746.GZ7510@sirena.org.uk>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
 <20160609102925.GS7510@sirena.org.uk>
 <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OCeUrMLoh2ht7f6S"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>linu
List-Id: linux-mmc@vger.kernel.org


--OCeUrMLoh2ht7f6S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 02:50:26PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 9, 2016 at 12:29 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > The external interface shouldn't be DT specific, the Intel people are
> > busy importing all of DT into ACPI

> Well, not really.

> If you are referring to the pinctrl proposal discussed recently, that
> was a proposal from one group at Intel and AFAICS it has been
> abandoned.

Well, it was that, it was the device properties stuff in general and the
overlays stuff - plus just the fact that with the Minnowboard style use
case people have and the desire to use ACPI it seems like that's going
to be something you need.

--OCeUrMLoh2ht7f6S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWZH5AAoJECTWi3JdVIfQvS4H/i9Q+NK3qFJ20x5n4tnU3Kqb
R5CadVol9AxuB5DmzVxduAAdc4YGDBs+cxJXQVJ0kjNNETE0V/5g6AhHf1frJe5c
yctigVuTXIeHXHQOS1NfpmjVKQwIFMJ5xvHy+XRAcAeNlmkKEGR+Ayma3sFk3XY7
MfUWd7652D2mejDNXLp6V3UhgfDX8u5qMuYazGor98EVDaiidh4k1AqK7LyfMQQm
5f8El3h6+LOCHyxPBF+hopBJwoKg1FLoYiXzBWAzbXajTmpBkQdXLa0QaoKYu/2j
vzrTjqjb2zvvbvQbEnDz4ZjXcrfK2Aa2qjfrohDSp+hO4uqtnU1URD/19EfObuA=
=tIVl
-----END PGP SIGNATURE-----

--OCeUrMLoh2ht7f6S--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
