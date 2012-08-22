From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/10] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Wed, 22 Aug 2012 14:28:32 +0300
Message-ID: <20120822112830.GB27029@arwen.pp.htv.fi>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
 <1345229550-8672-10-git-send-email-svenkatr@ti.com>
 <20120821104248.GR10347@arwen.pp.htv.fi>
 <CANfBPZ-VbkDRADNgecyXSqj3YH-mAZcihEm2YRrMW8_RWpORyQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANfBPZ-VbkDRADNgecyXSqj3YH-mAZcihEm2YRrMW8_RWpORyQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: balbi@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 22, 2012 at 04:08:17PM +0530, S, Venkatraman wrote:
> >> @@ -992,7 +996,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_ho=
st *host, int status)
> >>                       hsmmc_command_incomplete(host, -EILSEQ);
> >>
> >>               end_cmd =3D 1;
> >> -             if (host->data || host->response_busy) {
> >> +             if (data || host->response_busy) {
> >
> > This doesn't seem like it belongs to $SUBJECT...
> >
> I thought is was a small fix which didn't warrant a separate patch though.

sure, that's fair. But it does deserve a mention on commit log too.
Something along the lines of "while at that, also use a 'data' variable
which was already defined instead of dereferencing host again".

--=20
balbi

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNMJeAAoJEIaOsuA1yqREerAP/0KwE1LQ663Z9gMKXbMQJSXI
bk2qD0RWwDRm8tg3/1eQtGx+QyfcWIEVh9cXKo/VqbLNXrDikUNP+N0z99gki+A+
drQ2z11BgfGPD9EM9n88a9lbtFmWkkFEbd+2+xclniGi7lax7U86hIT0+a+lPOgy
jB2a+4xxPViXzeJp8NnJ7l8TiuuKUo3yuncnZuPe9dqM7gAS/8/TofN2VbODvhNP
Ynu5J2oh63kBbJ4VhLLCkCRVhMKqq+eR4ptsxYxwJBP63azOcGUgb9FJGAhWV5Ez
D0vQdDc902v5JznV2Fire+WASGaqlYO+STjrQK514zPLDOfKjYUZ6IVTZDMfudW/
/MAuT/teY265opSZX5D9u8rPMExjV05w2WtK0P8P66EJte+Wr6CfaeCB4ehORDQF
qEYrQXcOoX5Y9B8z8kOOBNG5z+oxsv1pqlx0xFtJ2ZA686vrvIFH0sFGp5Y8PwQu
H7aqB8jf43I6Y4Ee9ze9H4f0acS5TZpsL9s9cnPRrco8aEnDR2eUvr+QQfjpIFBW
70IugMoVjc+wjlBWhmxvWG8YUDxgNOENpmhtqHW+yja1ajSdMvtmqmOTEOrxlTS7
uVY5cGEAvFdQaboibO/2dmYmA9eFY8B3/N1pt1pvQzv95CKIHv/jT/6zRmUKK/1s
eTEDASdUV5WSO3Frp18W
=dmek
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
