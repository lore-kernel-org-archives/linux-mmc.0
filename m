From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Thu, 21 May 2015 18:56:13 +0800
Message-ID: <20150521105613.GB26848@pek-khao-d1.corp.ad.wrs.com>
References: <1431673364.13197.10.camel@transmode.se>
 <1431674695.13197.14.camel@transmode.se>
 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
 <1431693634.13197.29.camel@transmode.se>
 <20150517050602.GB23513@pek-khao-d1.corp.ad.wrs.com>
 <1431851766.6782.7.camel@transmode.se>
 <20150519092014.GR26848@pek-khao-d1.corp.ad.wrs.com>
 <1432133667.6782.81.camel@transmode.se>
 <20150521010750.GU26848@pek-khao-d1.corp.ad.wrs.com>
 <1432200282.6782.104.camel@transmode.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fo/b2PYVqg2cQvBK"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35081 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbEUK4V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2015 06:56:21 -0400
Received: by qgew3 with SMTP id w3so36719705qge.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2015 03:56:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432200282.6782.104.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--fo/b2PYVqg2cQvBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 09:24:43AM +0000, Joakim Tjernlund wrote:
> The HW 8BIT can be confused with SDHCI_CTRL_HISPD(0x04) as it is the same=
 bit.
>=20
> However, now I see that  esdhc_writeb() has
>   /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
>         if (reg =3D=3D SDHCI_HOST_CONTROL)
>                 val &=3D ~ESDHC_HOST_CONTROL_RES;
> and
>    #define ESDHC_HOST_CONTROL_RES       0x05
>=20
> so any esdhc_writeb() to SDHCI_HOST_CONTROL will clear the HW 8BIT.
> What a mess.

Aha, I see. Thanks for the explanation.

Thanks,
Kevin

--fo/b2PYVqg2cQvBK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVXbnNAAoJEJNY7TDerrFxsGsH/jf0bhTqPiBYpBsarOu0kpPW
5pMxJOsV7v6FkZ/OrJWbyOApVSI40j2dwIosKtqT7Qqc+ddt17hyYf/1yPRJAaqv
W7L9QyBHHVm57B1Xvdv/HkzbY60jvpx5T2kmqzQBsyCfrDwKMCE+XRHA34t2vEdP
BUxLcYrIwhFTswTv5v1F1I4vc7ey1vO8uFp1OiD6qRNFHxEWZGuKM/yH/hFf9cNo
dt5z3sIDp4E/wRjtUiFc9quJJxq1+J6KElUdlOFzc0nMNckU/zXMXj9KQIOnMXAP
XuwhiXIVjJO2xcpgeNz4xnTMPvfGxatgnFNZEE2s5SsnoLaPdusKzrZVk+BTlzM=
=UdBf
-----END PGP SIGNATURE-----

--fo/b2PYVqg2cQvBK--
