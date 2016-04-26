From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name
 registration
Date: Tue, 26 Apr 2016 17:47:54 +0200
Message-ID: <20160426154754.GA2943@katana>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
 <1459934734-3613-3-git-send-email-wsa@the-dreams.de>
 <CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I need and ack from the Superh arch maintainer to apply this one.
>=20
> It seems like you didn't include them on "to/cc" list, perhaps repost!?

Nothing happened...

So, I'll repost the series without the removal of the include file and
not touching SH boards. It will be your realm only then.

I'll repost the SH relevant parts as a seperate patch to the SH list, so
this can have then its own timeframe.


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH42qAAoJEBQN5MwUoCm29KUP/3fmryHJgKn3XBqHGuM7jbc6
A6kdr7ceU9+zL+mVaXGs31STxfXS91fsknx0dyzUZC3jjE95464QcWZL/WEuoqHo
ioyJndEHhnL0fK6s6ahZc5zD+o1I1rIrTIfs7BQTFwO6EtQS+4m/tmAZy5s8NrGF
yVMOVkz7p308KJJCidpi4XWs3kxad+v969E4K+doVjVA2yP48ZX5IHGQHEqUITHW
Rnpw7WP1nkLSGxbtbpBPjsV9Bkxu3vNZQs3ooydoLsZI/jGfvqtmSjPOKr0gjcZg
NQ9dIzzMGzMftEO9k4tjW5ltpqIRnmNFRRHkPOnHxSzQCoBNL6t/Fg8ET1XHrhUe
4Sz1gP+DqFiFJkpe6p+radjnRcssSx4IlCRqW14KV/k8PFtyOhNwsfskIv8wGjxZ
zNmi2QDGf/2UScq2tBHMqnVzsuURgTK7Grw1bpHX3k+KKdHBo6ySZqYUcIDp4nhf
N28A9SV57Xt/LHENLXRBgQsWGCpYtnxhzPq3I1xsijfOEofP5usOt6fofq6fPIhp
spusvrG/JBMDWS4aRiPSNvD/SaQQGi1MJwM/iy1snHxO835puV6L3hk9APaATrBC
O33Ak8pWFXSkmlI3HuJ5U6lP+c7gAbNhqZDS/Kjmqs+/LuFAzNHLK3axDjJirFPG
VUfRyhqZkXbOSI00MiZx
=FxlG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
