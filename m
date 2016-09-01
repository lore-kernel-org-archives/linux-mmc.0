From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 10/11] arm64: dts: r8a7795: salvator-x: Enable UHS-I
 SDR-104
Date: Thu, 1 Sep 2016 16:29:43 +0200
Message-ID: <20160901142943.GC4824@katana>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-11-git-send-email-horms+renesas@verge.net.au>
 <20160901072354.GA2893@katana>
 <20160901142539.GI14300@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160901142539.GI14300@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2016 at 04:25:40PM +0200, Simon Horman wrote:
> On Thu, Sep 01, 2016 at 09:23:54AM +0200, Wolfram Sang wrote:
> > On Tue, Aug 30, 2016 at 11:09:58PM +0200, Simon Horman wrote:
> > > Add the sd-uhs-sdr104 property to SDHI0 and SDHI1.
> > >=20
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >=20
> > After removing a SDR104 card from the slot, the interface is stalled
> > here. No new cards (even non-SDR104) can be detected anymore, sadly.
> > Happens for both slots on my H3 Salvator-X.
>=20
> Bother. That is rather difficult for me to exercise.
> Does this occur without sdr104 enabled (e.g. in DT)?

No, then it works fine.

I'll try to get you more information. Might be not before Monday,
though.


--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXyDtXAAoJEBQN5MwUoCm2RzYQALL+64xq54DTFCMhF6EElu/I
uGZ1z+pq60deT2adBubAtns2youuHqmaKwJY4xvAuo9CgjFiOuJiwvI3pxB7ikgD
/NGNrvK4kJeRtuQSctimqbRTn+1FYDzEarCCxGbiDKA79CFA15Awhi3UCcHZcr6Q
qJonruKErQVqdQplyttWu5BciV8s6U7ucHwKuRvEw7PY9aOBUwmxXShl9Aldq5yL
iHFy3hpQQdapm43OBp4ffPibIVqwTF0YHlJ96nP38m1CTH/5RXWCuoIzGUnq0PGD
cXtBnJq7kOd9IR39ay5JD3fTx+3+62sFpWnvTUz5wTqZpAIkUS1b6nY5gIPcbIeC
NUCPspiOIzTbokSl92R9fKEgI+mWXDdK8tL6NYarNTsHQkl90+55M7Db1yiGm///
L0+h0QE9IcTbDwiqi16GXfO25V3OfrhsPan1VrL1wcRREWNQRBfXWGl3zFzUI9Kb
b/GQU9kxdlx/ygoMogNy39a/E0AeGPK0SS8jgZ16sClGbZ6bYjuRpYXEgQodN52f
3pdFV7RJfGyRaENNyYsZ/SaBe3b794Ti2htmVcAhvnCQsIBBSfxxYu1i+UWU4cHO
Srg2p6wRDIgddgpKdxI7xIqh/EYsv1rIpE5T5I6/xt6KcmnmamvtOPGQDselrZT+
c5t8VLOQzvOz9udHoIVc
=xKbh
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
