From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 16/22] mmc: tmio: fix never-detected card insertion bug
Date: Tue, 2 Jan 2018 18:13:21 +0100
Message-ID: <20180102171321.mxhcenirdx6ohbyo@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
 <20180102131555.z6amjfqtadkh2w77@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sij7llbdkcmlsamu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42836 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeABRNX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jan 2018 12:13:23 -0500
Content-Disposition: inline
In-Reply-To: <20180102131555.z6amjfqtadkh2w77@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


--sij7llbdkcmlsamu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The TMIO mmc cannot detect the card insertion in native_hotplug mode
> > if the driver is probed without a card inserted.
>=20
> Hmm, it works for me without your patch just fine. Iam currently
> researching it...

It really doesn't work for you?

mmc_add_host -> mmc_start_host -> _mmc_detect_change ->
mmc_schedule_delayed_work -> mmc_rescan -> mmc_start_request


--sij7llbdkcmlsamu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpLva0ACgkQFA3kzBSg
KbYJNQ/6A4+xI1/7e1x06zwF8RyECfxoM8TWd+7LIGMJ/UO+R2clIzo1rUJgrJBi
X2Ljm8MmeITtw8vqjgPUZUaWyX9TaypWm6VIOtJPXOONQHEkg/uakCNmcgHGPhKN
UnShaigmpaBZEuH1WGyjTFu6n5O5vsDvgPLvOYN8uQWeEwurcNstcllBjHH+Wl3+
m0cq59BkePqSiPo10b/aa/lRORceNLqWe9MyDTzWBlRmqGMnLE1snJftDTNrnRQF
4QS0LM0DSmDDIO9shg1Z+HJ9SAW46LF1cZq6l9lyA15kygxGy9Ax/Nc+O+OC9+XV
oC1k3kXhWSDxTKYp876GKwIhfvUkvoEqIsv5S/XGIEsUZJS9/VwHbdb4lQWD1Kqq
tK5n866lA5LtSTl8enoOsQKgWHso6iSLYaG4noRaqYyaVYWQlB711x87eqVBsmmj
ocd6adnNwLi6H2d7RxqWzTLeNniztQ6VnYFpRLbU4iSaihNS4zRyGVGj0k1RcsAf
SgZYNwl5qxGJjHayiYcoiQ+M3jTcmL2GfIpIBd/vYhs16vAzW5Szk4Emk/sbCOgB
sCmWhxxvrLTU7XHSMMODQr2gK6mwPGz2jjgpvAOv4SVCVkhL486DXyC1cjoBhV2v
nIjN3bHN9Am/W5+Oo+Cms6LmSYk2dLVHaSDZFObGIiPqAiMIrnw=
=ecA+
-----END PGP SIGNATURE-----

--sij7llbdkcmlsamu--
