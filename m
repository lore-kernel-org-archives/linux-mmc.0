From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: Extend sysfs with OCR register
Date: Mon, 4 Jul 2016 23:40:21 +0900
Message-ID: <20160704144021.GC1410@tetsubishi>
References: <20160704115818.35614-1-prtvar.b@gmail.com>
 <20160704141345.GA1410@tetsubishi>
 <CAOmT4fSX8du7zXcMyOFA8JAams2OWvxUvMJc66wsyVNSL+v9Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOmT4fSX8du7zXcMyOFA8JAams2OWvxUvMJc66wsyVNSL+v9Uw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: bojan prtvar <prtvar.b@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Gwendal Grignou <gwendal@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-doc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Registers CID and CSD are already exported through sysfs so let's make
> this interface complete by adding missing OCR register.

This sentence was missing for me, thanks.

> Do I need to send v2 with updated change log?

Ulf will tell us.


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXenVUAAoJEBQN5MwUoCm2AqkP/jtKVe+At9SVjrYizlX0mma3
6ey5aRHij1dSZDTcUlUmR3t8RDElDL6D5s+vmj0R07VHzEylmGKk9Z5e2ZwA+g7U
Q80FF+T2OFSkTKg66jmhHzY8KzfS8H9NBXgcdshCAqchDCQvwbSrT+Wse+4pdOsh
RinqcrQ5EvBDZHi5Aa1C/926gOIoopxKXL3vZj6rnrOUaGupYRQ4f0elzrAGdiIf
YAdatNI93TBo5Io3sAgI8Btk2Zfnl1QqUak3Cf+T4KH5wQzzIUk7/cHjvBJLOS/C
YJwDOeq6Gdj6UVtrwuYvBBD88w01eUZT5KmB8fV7pXGbXovIJi5NbWILRNg/xJx2
GIBOsDzsRcpY9Z6MA4cKqT4n2fdMzC/I3H0scbM9nY+RGuVy9tX/8rlJYrRa8H6y
nMcamce716I6nAUxnkvEpRO/ssAdx4jYSiMyAUXS7pVoAOEG114po6/HIywO7cBZ
SFJrL0EGPEjUPIPQaqVwNzMXBvQ17UuHTNgvV15PMU4g+7iUVMsaQ/mKqpxqpPST
vhxPpd5TiWDHFfpaudQ6BPEwFVjVvEv/YnyAvqPPitRzzI38ep0/nYPMA8/7MoqU
t5PO8P+O9kwN8c7rngDH4pXPuDYaUK4KU1RBUDTuHjjpMMvO/+omJomIhybooxs6
+syWWe3dix4jxtrOaW1d
=bc53
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
