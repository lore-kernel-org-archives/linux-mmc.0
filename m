From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: use SDIO master interrupt bit only when
 allowed
Date: Thu, 18 May 2017 08:17:47 +0200
Message-ID: <20170518061746.GA1454@katana>
References: <20161209165141.26599-1-wsa+renesas@sang-engineering.com>
 <TY1PR06MB099248E104D6762E9E860BF3D8E70@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35596 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbdERGRv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 May 2017 02:17:51 -0400
Content-Disposition: inline
In-Reply-To: <TY1PR06MB099248E104D6762E9E860BF3D8E70@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Yasushi SHOJI <yashi@atmark-techno.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Shimoda-san,

> This patch enables CTL_TRANSACTION_CTL to 0x0001 in tmio_mmc_host_probe().
> But, I have a concern we have to disable/enable the register in suspend/resume()
> because registers setting is possible to be cleared after resume.
> What do you think?

This is very likely true. I'll cook up a patch today.

Thanks,

   Wolfram


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkdPIYACgkQFA3kzBSg
KbamTQ//e+n5FzavWQ692RwwkkbooFqtPd0a3tG91rVEpySGPeCxQvRuH4LXP5Ta
F0qIK1BakAqLM8jS7RZyGsIeI86NEPui+y1Pd26qW/4BFhUFPpiVDUZ4BzW50OdJ
fLjvBy4FusPAIJ4IVMYIQdkdjsRI0k5l3jqvTWBDHMDp1XT91fkELcCWppzNwIEJ
mH5L5XkN84OqxXqL7PTIH7NSotWPGFDYhzxcbFbtrZgAyo0EVL4nhrWj/3ooosXk
HVxy8DQx3HoFU4g+pgAckUh2KHtNH92g/3bDvWM76qHwk3ua3S/gfaVsHPP3V0NP
hvzXI/SkkLRZQ2VUOl5QWPENm090iS0xFASS75XoiUakhNweFXh7nHAAcHXOmkwJ
MqpgsxEKnvwfzYU7tRqQ0aQazDypapRA8h1M4n14kWpPMR+WCJCLooTMdHi7ZO7B
eM2nUY5kqa8DjozHyWcEI/cZrlm7Y4evi19Up5hOSZr+8zPOm5VJgJMX+atnlKRJ
i5wIE/mc05EsnNWiSLqEa5Z/LQGfhTSMurtJ59q4Ya8y8C6YCt5EDS/9YSVS4Aly
AWPP+L0ExjXNCzzAYWFcHJNmy83q83Z6ThJsng2r1AynZElK5lDcnI2+Y6bpQjsN
ynRqR6b3g1c9/0b2NTiDaZ0eOKtYGSz+WviOOU9r7lZDnr+OUX0=
=IZFg
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
