From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 11:58:36 +0100
Message-ID: <20181120105836.qf2tzqz2m3l4wrxv@ninjato>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai>
 <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai>
 <568297e2-9fe2-1d34-beda-35d4906e3b8b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbzfitgnhnvbplef"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568297e2-9fe2-1d34-beda-35d4906e3b8b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--lbzfitgnhnvbplef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > No strong opinion. Especially not if you say it is in the spec (although
> > "must be sufficient" would be better than "should be" ;)). Also, I
> > assume this failure is reproducible and should turn up during
> > development? Compared to "happens once in a while randomly"?
>=20
> At least for me, the failure happens only on some units but is
> consistent for a given unit.

I hoped for that, thanks!

> The QUIRK needs to be card specific. The software should automatically
> detect the card (from the CID) and apply the quirk. Please see patch in
> my original reply.

I understand that. What I meant was the case when you discover your card
times out on 'cache on' but it doesn't have a quirk entry yet. So, you
are the first do discover the flag is needed. I would like a pointer
there ("timeout on activating caches. Maybe your card needs $quirk?").
Because for someone just enabling the HW and not deep into MMC stuff,
the path from some -ETIMEOUT to this specific quirk may take some time
otherwise.


--lbzfitgnhnvbplef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvz6NgACgkQFA3kzBSg
KbabIA/9FqPfinxY5BTPdb6Qc6HJvOgDoslulPtIETgHQ2CgTuDm7k5UOox6pSE0
l1Iww2W4BPZ5mxim8TP1dslLr2B/xxFyn2aFMCfHqyc2/5GEb4heYqp0Spm7Y8q3
W0e1DjfkZnFrQtgzdl8/vXEAV7ETdhFu6rSPET82hGI2UbFgoXYrYPBSPaJUhoGD
YbIEyNCBSsdqp8WZRP2VyLNOq//FZuTn2JVIexSQWzSvmEwXCQD05UwoJ3gbWerW
KmjI8zO05FZVWceidY40FyyjPTqG0rYDtjZgmL8qS/Dx8y9+gTvrz/u56HGPo1Dd
Z1YuwXMcnwlD+Cn6Dop3wN6ssv+rmXHrZhbBETjN6QF/0VmLvaNeRxbOHQib/O7M
66ypLvbhp3CYTQN8t/ud7V3u2xTqYhyWUIuJjbhipbJs+e1SNlaT60GpF9+f4Gfj
M18TI7w9k76wqoKDKjd1nm01RbG+txw13jpSOTLFkYj9H7zxhNxJinLJM7d89eTW
qWpzspjcGKsZKlVcyKNw6KIG2v/IoBsb1iB78t0I4XRGlh6D/UX4/7z35XT8luhg
vtcGCALpKMJH7B5YUfiESZRiUNF9IEZzlDsn59maWFNx2oOL5hcbCkxYG8GKtIT5
JZo97TDfWYeLzViaIWuAn8fNfHjpJZCykmGZ1ojdyt+ayXdbNiw=
=98cO
-----END PGP SIGNATURE-----

--lbzfitgnhnvbplef--
