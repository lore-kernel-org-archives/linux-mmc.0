From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/6] mmc: omap_hsmmc: simplify cover/card detect logic
Date: Wed, 4 Mar 2015 16:31:08 +1100
Message-ID: <20150304163108.7b0902c8@notabene.brown>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/8oK3Xg8WulB+OicfDHQ_lDg"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbbCDFbR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Mar 2015 00:31:17 -0500
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>

--Sig_/8oK3Xg8WulB+OicfDHQ_lDg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  3 Mar 2015 13:28:12 +0100 Andreas Fenkart <afenkart@gmail.com> wro=
te:

> These patches are trying to clean up the cover/card detect logic.
>=20
>   Mobile phones (some) have no card detect pin, but
>   can detect if the cover is removed. The purpose is the
>   same; detect if card is being added/removed, but the
>   details differ.
>   When the cover is removed, it does not mean the card is
>   gone. But it might, since it is accessible now. It's like
>   a warning. All the driver does is to limit write access to
>   the card, see protect_card flag. In contrast, card detect
>   notifies us after the fact, e.g. card is gone, card is
>   inserted.
>=20
> While cover detect is only used by one platform (rx51), it
> complicates the card detect logic. By separating the code
> paths they both become easier to understand and maintain=20
>=20
> Patches have been tested by reverting: 95bebb5696ab
> 'mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration'
> otherwise gpio detection is handled by mmc_of_parse

Wouldn't it make more sense to put this core  in mmc/core rather than in ju=
st
one host controller?  That way it would be available to all hosts, and you
wouldn't need to revert that patch.

NeilBrown

--Sig_/8oK3Xg8WulB+OicfDHQ_lDg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPaYnDnsnt1WYoG5AQJc7RAAnBUsmCaBGGQ1ThaHuqmv+nB/j12MlTTL
zz2QQ1FGv9HgTu0rcRxlSYzyUmErlGTxehf7wR+QzNgXGx9VKXsI0mhu7Uq+AKfp
lRNgjYhD+C7PiJdT6Bv3HhpYVu7k8w9DeU/A0Y0wxhj1Wgr+cLNVV9tIb/ToXJ4P
ZmW7GfhfpX/jTkVpDKpy5FyhSQX6yJSfx7r4dUhsJm3Z8KQDMyvA/R56QjZUlim2
kkb04AbVUe7bsLq3K8R3s0JbSj2Pe7rURdAnN2FLVu3VLDO0ydG706bbIV5HQjK3
8VAd3XNUo1VFFAz0Z858WXPWMtjAC0eYizG7qccaM+TXXUul1QPwEC/zGFN9hTJa
7Dp2spPZiKYvxMUUnOmcFPFFDLI5Cr3Fjjze5bjsj+SYru//wydwq5rSr7md3R6f
Z3YseLVYBPrvkqzMt2Z46TyW2rqjLA1M4E59LeWiC2eTL8X1dv+gxGKZN092joZU
shBMZLwtZePrXdsKoL/yar9q6jPaz7qw1XeYJNzw7Cz1KkmjapB2M+BeEhnrLd9o
sgpbBAG8Gqr69CAYqch8+6duTPuN7cRcae4J3DvRjnLVuZVCrUWKvTNckj/CNnWl
Cb1AFHV2j1UMl+wLPDWEhT7Aqd3maPomYBhsrCCAjg3pQPos++1qRaFUqVKDzvXb
HMFMRqDKdDY=
=X/73
-----END PGP SIGNATURE-----

--Sig_/8oK3Xg8WulB+OicfDHQ_lDg--
