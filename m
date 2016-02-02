From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/9] mmc: sdhi: some refactoring and adding basic r8a7795
 support
Date: Tue, 2 Feb 2016 15:06:31 +0100
Message-ID: <20160202140631.GA2887@tetsubishi>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
 <CAPDyKFqQ8qMRW_ztMw4giJ062jY7Z1oz_VmOAVX71TAQm3QJAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQ8qMRW_ztMw4giJ062jY7Z1oz_VmOAVX71TAQm3QJAg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Although, I couldn't apply patch1, could you please send a new version
> rebased onto my next branch.

I rebased to your tree (especially patch 1, rest stayed the same) and
pushed patches 1-8 here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git mmc/sdhi-refactor

Is pulling okay, or do you want me to resend?

Thanks,

   Wolfram


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWsLfnAAoJEBQN5MwUoCm2sLEQAJ2sa6r1CYbx5ooGXskM5b5W
e+qXdMLOoXn77wspQLR77w0MZXpwucHdf8bQfsPaRmqYZirU0QltZZ/UKl2HseWa
N0DW3yijQQjMb2HiFg1/koM1T/RONmYWAZjMpXF0X+KFro/OIoYaBcwwnW3UjB6F
qCUDM794g3e9bIQjrJmjEl1dSJGlTaDUJetKu1hWunD4bQc0AZb/OMoWm47nOl5r
pUyGY+LSv02b+wW0Ol2QolMAne1X8CBpCcB174P3Vc0+KkXtSHuCukFp3XDw5NKp
MPBTKS92wlFWM01NIzu/4AmorN+13+c4Iw+jMGc6K+yvqZS+1e78GxajwXkxMyRQ
dZfGJdZhD7Dzsp2WgvZYeLzB9CbH0gzNdm1SWnijJ/FgmgXOTtozcvJOqLh3A6fD
eEk30ApSDj2gJHvMOBPGAQqbGCdtX4HnPalxZQS3/+a0VBJLbbfhopvfZgXaPAHp
qQUiA5Gj89ISES3c/SfRvrkVkb5NI51Hdt5E3kBQbSo0BzRHCRLzcDnuGZwKPPvs
Jp9dWq/ywl4cL9t/a4Pa03IYwFqTNK//yDaGbbu9SaWOs8eTUCjUdYGW3Vw5m5CN
/OWMBvelAYucN0nkgOlf4gqj9v0oUlVW+25OwUl2xi179r3YoedU1MB/XsebTPqJ
Vr6WQLNf6TsQKnz0gH3H
=p7+q
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
