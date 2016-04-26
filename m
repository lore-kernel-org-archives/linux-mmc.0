From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Tue, 26 Apr 2016 19:00:02 +0200
Message-ID: <20160426170001.GB3444@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
 <1460477978.32355.14.camel@codethink.co.uk>
 <20160415202803.GA3105@katana>
 <20160415204156.GB3105@katana>
 <CAMuHMdUccqGDWRqKhoHO7ED7X_uOk7nX8dKGTJDzTGjLZx-7+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51396 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbcDZRAM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 13:00:12 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdUccqGDWRqKhoHO7ED7X_uOk7nX8dKGTJDzTGjLZx-7+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> To fix this regression in the short term, can we just enable this feature in
> the sh_mobile_sdhi driver on SoCs where we know it's safe to change the clock,
> i.e. on R-Car Gen2 and H3?

I'll try a workaround next week.


--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH56RAAoJEBQN5MwUoCm2288P/3Y+UkbuxddIamwa4IwA4ovc
OHIzCalJyY1fxMR2U1H8wi0dYphZ9/7xZ57mef054/uml7KkEv/RvQIQKtB6aDnu
xe8jQVTZ2Um6ZFQ/mCrFmiE2E9bH0VrZFRkFfCoysgg4oF+skkA88LOdskfbGyBm
PxRH4H1k5Kfggcqd3ruvUV97Our0jZ2kGB5r1iZSNQ4hIj++q4purEPpPgQic4G7
cpkV6mON72+ZtpPhyM2/nL8xBuxeHDHBgtWVw1bY6dWHCUeViZp5waNupK7xqHwp
vN/DwIqDGgqJ8p808e9Amr+SoRwnsUVg9t/TT1DA/Kxv7hmw0JFFTSydpqKdiUlO
V/fgxTG1yQK3+oThhlKxsHmc+X7QpKAdOgDFSVCZbvHU67SlSLezSjEjmK6PSV4n
WvVgZfHPt2d0RBhwXvG7bjV2TNQbHNhCYHDyycsEyEHfwyA8vpdAASSfghMLUwio
5evkAmmRsi4mfNAZNTFxtSP/lEtq+IVEgi7xb5SC5fTuCgRGWOZklTxs6VLur7bE
zWfubPqGLzgKsXE7z4VN1I8IxOsnNsBhioB7Eo3gBos4vpc7JcH3ZrG9bMBwhWXg
9yQnzbkekuUHZdiqgiPRIi/Hrmg/wXZ7f+j7/Hw9c+MpH4FADLSSNOCY7WrLeGSq
FInUmtzJ6DuUKKFCTgOr
=mSoI
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
