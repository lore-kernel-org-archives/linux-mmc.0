From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 07/11] arm64: dts: r8a7795: remove unnecessary
 cap-mmc-highspeed property
Date: Fri, 16 Sep 2016 12:29:42 +0200
Message-ID: <20160916102942.GK1411@katana>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-8-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="73fGQZLCrFzENemP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52771 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753058AbcIPK3t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 16 Sep 2016 06:29:49 -0400
Content-Disposition: inline
In-Reply-To: <1472591399-13907-8-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2016 at 11:09:55PM +0200, Simon Horman wrote:
> Remove cap-mmc-highspeed property from SDHI2 and SDHI3.
>=20
> This property is unnecessary as the driver automatically sets
> the highspeed capability. Furthermore its use is inconsistent with SDHI0
> and SDHI1 which are also highspeed capable but do not have this property
> present.
>=20
> Found by inspection.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

For completeness:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--73fGQZLCrFzENemP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX28mWAAoJEBQN5MwUoCm22OcP/2w8r1eR9sBf8H480U1BfOsT
IYjss6jEfLE8AFyC+2mGFLtb3PjpaaR/8lND3LVQieBuHZkT+VraxrWLc9TCj8o+
Zz7eNfdQb5elogJLI9AdOArE4vpaektbOMq+/FZeYp6RWAztIZS2N14zIwdhk9p7
vDVwJJVXgt/20cWXms4Ps//PhGCc4NfpjGVsoNw0I6lmd1WsOVNd8t+1i4blaSaY
ja/ETlTUh92BXoDs9sl8cTFtnStRx0PwVeG6ghRE+fbq4WArSltJhdJd27D4avos
sNW/brk3AOOXD/SD6HvZIA+Ckia5q1e1fMqXJP6LSIsEbmIYuBjPd/3bLF7SfyYx
pavif4nh3kZA5AgI4P6p4zmsBsga1OasfOjLANf3J5WE9n61lI6qTJKvfNmMKNs2
3Xw4H2uvLSSt7wT4DFLxMKnsCVehyFE6YpRW3uuBggtgixGM+4gTBUOWp69dziqA
/leK6SdxTPOMBZdxl/tuxb7ri+8aG8MVKuILsk8iMpwA7EW1KU+B9spekWx4hf9W
WCCTxpQJ7UofAbLPcibNqFqYGzaMoV3855WZUcgOrTiVCTELd0IHqOuoCKDGpRtP
HFQxhIa44/UJ9kwlFBcWYuQVOVnCS2HGJS0VdHIFdAL88iaqfA1rKQzfnFD/tEmj
2QdkH4wffNnjFMl11OWY
=YWKj
-----END PGP SIGNATURE-----

--73fGQZLCrFzENemP--
