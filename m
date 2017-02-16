From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Thu, 16 Feb 2017 09:37:24 +0100
Message-ID: <20170216083724.GA1443@katana>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
 <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
 <HK2PR06MB05484A4141A1A9AC8BE54E00D8580@HK2PR06MB0548.apcprd06.prod.outlook.com>
 <20170214105226.GB1453@katana>
 <CAPDyKFobQ07u_xUgpm7iQRJkCqVS9_6JvyoTDhqLM-R3qCFeGQ@mail.gmail.com>
 <20170215150240.GA1430@katana>
 <CAPDyKFqkWYgDkrnG+VCtSHiXvhoGqRxYir3UGC9yx_4mDubhUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47262 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbdBPIh2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Feb 2017 03:37:28 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFqkWYgDkrnG+VCtSHiXvhoGqRxYir3UGC9yx_4mDubhUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, Feb 16, 2017 at 08:57:36AM +0100, Ulf Hansson wrote:
> On 15 February 2017 at 16:02, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> > I see. Ulf, do you think it makes sense to extend the condition when=
 to
> >> > call mmc_blk_cmd_recovery() with checking if stop.resp[0] has one of=
 the
> >> > R1_* bits set which are marked with 'ex' (and probably 'erx', too)? I
> >> > agree with Shimoda-san, that the core is a good place to do it, sinc=
e it
> >> > is about parsing the R1 and not the status bits of the host hardware.
> >>
> >> The method we use to indicate a stop command error to the mmc core, is
> >> to set ->stop.error in the host driver before completing the request.
> >> Perhaps set it to -EIO or -EILSEQ.
> >>
> >> In that way mmc_blk_err_check() sees the error and invokes the
> >> mmc_blk_cmd_recovery() to deal with it (response parsing etc).
> >>
> >> Does that work for you?
> >
> > It would work, yes. Since R1 response format is hardware independent, I
> > wondered if checking for ECC errors wouldn't be better suited in the
> > core. We roughly need something like this:
> >
> >         if (stop.resp[0] & R1_CARD_ECC_FAILED)
> >                 stop.error =3D -EIO;
> >
> > We can copy this into every driver, of course. Yet, I wondered if we
> > couldn't have a helper function mapping the R1 error bits to an
> > apropriate error value and call that just before the check in
> > mmc_blk_err_check().
> >
> > Do you get what I mean?
>=20
> I get it - and yes you have a point.

Cool.

> By looking at the code in mmc_blk_err_check() and
> mmc_blk_cmd_recovery(), it deserves a clean-up. That said, I don't

What do you mean with clean-up here? I would have just added the helper
function checking R1 error bits and setting stop.error accordingly.

> want to treat R1_CARD_ECC_FAILED as a special case.
>=20
> So if you decide to add this check in the core (which I am open to),
> we should also add checks the other potential R1 errors, to be
> consistent.

I agree. That's what I meant with "checking if stop.resp[0] has one of
the R1_* bits set which are marked with 'ex' (and probably 'erx',
too)?". I think these are the candidates we care about.

Thanks,

   Wolfram

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYpWTEAAoJEBQN5MwUoCm2ccQP/3airK25hz+fMysIdfPxHHGI
IM+BHxKN6M+Ysfi9085tZaigcGx9ZFi4GWiZp8PWC7cD19/AVfQQGDon7VMder4L
A1pkxx/7snvBZViS1hdGI7H8lD5zec6d/aoGJYjnCKBHnPZXGVXD0PAY6VfB32QI
2954j4YVzYLMOgUv8SVpXJyMwFcC1jwTCWpf8EeY3vfWyQXfwifUfEV3+QSVfZVA
WkqFSdUn6JHudY8XAdSREfiyr1cTyVAqh2Vdo6KBmfylRzqXro7xQgWBjw/GEMGj
xIMNByc2oKQ0ppXzw9J2XZNu9j2kI8I85g8ZqEWBjKulhh+o7L4YMCrnplhNxMpm
J3sD90ydl9BZlr0eqdH94BObI9U/yCMdj89Q98ZKkpMKnxrCy+rKINJ0gjSWXfJV
aZdEF96tU4JfAUbSUeyEk/cKzOr7Mi1lHffwGPyakC2KQ8NRRmc2GRA9yGm34C5h
KJIpubyJrL8YiPCPFmc9AIepcJim00yZvtwZ61QbswxlAeM4ISPvOdm9YBSti36P
uID59OIjl95KbuwpbC/rF1dxXJt8THsA/sLMyo8lP4VvtMxsH95wE1LleQIbJHrt
J45AjMXo8ONg+9L2OJQJKfdP2DTmXA+Owgef/5fitZB+pAXtY0AwFFr+ePC4wXPW
6AvTaUo7J7QNwRULFAsx
=v0i+
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
