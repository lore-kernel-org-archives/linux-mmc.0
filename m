From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and
 cleanups
Date: Wed, 7 Feb 2018 20:11:52 +0100
Message-ID: <20180207191152.kvqrugblst2cko3c@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmv3ictfz5w3jtha"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org


--hmv3ictfz5w3jtha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I picked patch5 and patch6, as those seemed trivial. Unless there is a
> rc9, let's aim for 4.17 for the rest.

I can't find the branch where you picked these patches? I wanted to use
it to apply the rest of the patches. They don't seem to fit on v4.15
or current linus/master. Can you share this branch?

I will do reviewing now "visually". But please wait until I tested them
before applying.

Thanks,

   Wolfram


--hmv3ictfz5w3jtha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7T3gACgkQFA3kzBSg
KbYcLRAAi0hE9uVMzeGBlvgjQGw54Uj+EbBvYeUyO4pa7I38zge+HfGCGjF0mhBB
y7ABAjSittWqEubxBhY1PRgkx3SduAyMV2muz4mUSYbn6fpllR9ov89t273b02FE
d17wq52rLPUpQxw3TlBGmR9yKIxPW0fKVM91Pg+NfpbtMChwri+HMY4z5iT+qdSE
757D3k1xwxr33yBQrlj83DA1ipusuGkYNzcKneDwT1qIheQUAZ/aSR5Q3m4AHKJ0
dVTBpeepl7ei1enze8EhM/zi3fH5l4icGmnqT9WJbyYN48StYa7dEYpvECpqaG23
cSo4ce3verU12aI/+BXkoGIQUc5xT8bQwVWqTdkX6fqp/hI5tV4kVMfd8H080Yv8
mbqc/CjU2AV94EIgHrzaIlAm+DBeCzbdRlmFg/Pa2tINfQjzhxfBaSu02nfIqEsa
uJ/G2BUPjanzVWebP2/mQtvMAVm67ZAiRMjg91aE2BXWK+LqSqaQ+L22MgBJiVf0
b0QaCGMUmS12P+shRSqUn56Pxs33YGEEw3agIGYRhhsrns67lDiKrt63tK6rkINQ
HM5TSfHviIVBtj75Lq9XoyPpqBj1askTtRsQxXUkTGqVrJI50UyJC3ANVzteOm/Y
IKAmVgx+wn4eKr3A29PXQmpTlxuLqt0v5KKn+1x1rEW+b5e9hkU=
=bDb4
-----END PGP SIGNATURE-----

--hmv3ictfz5w3jtha--
