From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 4/7] mmc: tmio: Add UHS-I mode support
Date: Sun, 6 Mar 2016 16:25:41 +0100
Message-ID: <20160306152541.GB5376@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-5-git-send-email-wsa@the-dreams.de>
 <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60012 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbcCFPZt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Mar 2016 10:25:49 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2016 at 03:41:13PM +0100, Ulf Hansson wrote:
> On 19 February 2016 at 21:16, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> >
> > Based on work by Shinobu Uehara and Ben Dooks.  This adds the voltage
> > switch operation needed for all UHS-I modes, but not the tuning needed
> > for SDR-104 which will come later.
> >
> > The card_busy implementation is a bit of a guess, but works for me on
> > an R8A7790 chip.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/mmc/host/tmio_mmc.h     |  3 +++
> >  drivers/mmc/host/tmio_mmc_pio.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index b44b5890290622..aabd36955e73fb 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -101,6 +101,9 @@ struct tmio_mmc_host {
> >         void (*clk_disable)(struct tmio_mmc_host *host);
> >         int (*multi_io_quirk)(struct mmc_card *card,
> >                               unsigned int direction, int blk_size);
> > +
> > +       int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
> > +                                          unsigned char signal_voltage=
);
>=20
> Do you really need to add a new tmio specific callback for this?
>=20
> Why can't you instead have the tmio variant driver assign the
> ->start_signal_voltage_switch() callback into the struct mmc_host_ops
> instead?

Can do if you prefer that. I agree that it will save a bit of code; but
it also hides this feature, because all the other config is in struct
tmio_mmc_host. I like the better visibility a tad more.


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW3Ev0AAoJEBQN5MwUoCm2gYUP/2Q0goLacQ0SHnMLxk/qp8eL
trU9mAB9LZnJfQpEP9mB8sGJobxvcQXMFSbf5YS0D2SOwI1U3N2/hjlO4in0RL+0
hC4ApoqNgZzHQ7fYM0TEQijkoMN8nhOh5hLlm/uF4uYq+bC5a6DnJNkI0xHsUlfr
VcC7TqDXY8lNJGeIfLsh8LtFDTiDRr0l00ENdBaGwTdE2mSj7wczVDhGy4MfjFn3
q00lQN55L8Xvk7JY2znGXWccofjPnwr38CBohE3QV0oTF5jg9X+j5mWhtkVH6mQS
aG9lZiZ6MEn03Yu5CM/mj32eZ4WKFciOR9PO/iF61h1AjR9qKq1Fqqo7x0qXsPyc
66bENN06/kiinCVkHIfZ+M5389UP3t3oPvuTVnKbOqw57ai2ZKqy5nFUoGqFnWG8
CjOW3hc2lxB6FMQP9tNg3AmpWJnyZpHH906LceJX+mRDcMogAIf7QFIfGK5gH6g6
BptOfVw9cuiW3pHF8oj06xR9F8OGeuzAohwUgi0sONRd9asQtcoInVgynYvTeI9m
V3xGGn+3OXwUgweyLk/8VVf9xM019XDcAxfVOJfjlH5j/i0NcAg8s9OvxHI+ZNtX
diV6EmPeFrv1O6lG6DY3hPJGWslDrvxTZyohTIblV4AT268nzmqwr7TjJvH/oIjn
SXFPV5/EinsBxmSE2ljC
=2hzz
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
