From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Tue, 1 Nov 2016 16:07:59 +0100
Message-ID: <20161101150759.GA1436@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161101084938.GA1576@katana>
 <SG2PR06MB11652157C1DA12165852747C8AA10@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54240 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757936AbcKAPIL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Nov 2016 11:08:11 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11652157C1DA12165852747C8AA10@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I don't understand "TMIO_MMC_BIG_DATA_PORT" (How do you know 32-bit?? How do you know 64-bit??)

I think 16 << host->bus_shift should work; need to verify this, though.

> So......maybe you can change it later and your idea will be more clear to me then.

Yes, fine with me.


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYGK/PAAoJEBQN5MwUoCm2aIcQAJKu36ITt9RFta3lmkXdvGFd
vCMmaz+dQsbIC2swD+mXWrNYR72lm4tUzVc+i/X+r/KTRJtm+2KfNT40d8/fhYQB
0lqDb7Wei+CpyVZ4++p0EBkSZxRo6Vt4skfazXolZtYiTN4BaTE5K/nis4mHnjk/
r7hv+tAJa6xHDE0uk1KAOzIJo+belnJb+NFqZ1Nd3vni6JOaL0H4rj+Es9EsWOvH
RcJEzxgYrWpZcxBotiI8l89s5mbVBgJZ2xXPV8O6zezKEf/A36E/TReT5PNbnWxx
48n7W5ZD9CFvvlImDxNM23qhbkuYg6qPYcOPVyHINtzedjochMnAZV2sbxFDoy3c
/kkUS3UtImGkfxZvWu6Hu3bFHEaG5RAJa53R9JCstDcSsR91DJpOulaLDPJkT9iN
EfpnlgX3luvlhTX2DmZf+wEfwPicAAyPMGAZ1asFOmFZ10lZQmkKiK+2nsQu0fXg
EdUpaF2/9BOudMmYAfD1D/5E3182Jn/fgIeDghNFk7EkU526giFrDTENyRYLoIt9
5rgmd0xMhDbK5+pvt+B5uZGJ+YlBKLo6iSbEs6g+8ntdOI+PayCCKAdJlQmXWL02
7pJEd2W32DWA4qhs4+o7w9hysjikLC87I4832HYp0eBBnx8XfU153BNabqGwIQbl
0fRx8AWe+KKZxpfBuwnB
=aZ1q
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
