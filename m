From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 16/22] mmc: tmio: fix never-detected card insertion bug
Date: Sat, 13 Jan 2018 21:59:38 +0100
Message-ID: <20180113205938.dlfwxvmfnukvfl3f@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-17-git-send-email-yamada.masahiro@socionext.com>
 <20180102131555.z6amjfqtadkh2w77@ninjato>
 <20180102171321.mxhcenirdx6ohbyo@ninjato>
 <CAK7LNAThnAY43OMPDMaw4DSdtJCVTUTm4-NrTgWD-6SE-yCp=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lvfysjqgqkmt3h4b"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAThnAY43OMPDMaw4DSdtJCVTUTm4-NrTgWD-6SE-yCp=g@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--lvfysjqgqkmt3h4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I am talking about the card detection
> by the IP-builtin circuit.

Yes, I know. As I wrote in one of the previous patches when reviewing
it, I disabled GPIO CD and used the internal mechanism (for tests where
it is relevant). Like here, too.

>  - GPIO is not set up                     -> mmc_gpio_get_cd() returns -ENOSYS

Thanks! That pointed me to the right direction. I missed that patch
10/22 was still under discussion and not applied to mmc/next, so I had
to pick it manually.

I can confirm now that there is an issue and your patch fixes it for the
non-GPIO case. For the GPIO case, however, the TMIO_STAT_CARD_REMOVE |
TMIO_STAT_CARD_INSERT interrupts are enabled now, too. It didn't harm
when doing my tests, but we shouldn't do it, to be safe IMO.


--lvfysjqgqkmt3h4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpaczYACgkQFA3kzBSg
KbY+ZxAAo52LmovtrbFQroGjH1IETD+DWGcpxItNF9jSbV9pMy7aOKEsTHhCZg9p
6ad67g+UwUUkT1Lq0/eM+Qu0JlbJ15AU9ePQk4M7VPbkKSWz5Sj1a8/qzd6K8th6
E6KE/o8M3ye/6jWwdIEDMwTEjOTM3TTKpoHNXOF+cG+7yUwpCNtAy8SnVI9oyOCH
wVunOZpKWua2fMbfSLVbG3uTQOMwaBJmTEjRbkd7ix0yD4aFmvrtl7HE3oRQfWdS
GsD/zYIeYi3BUKJtX8pJBzF+rAsM7gJfA1DmKF6XUslOwG1KHAAJp5mkBsukfrgE
NVptyWr7XWYjnzJx9SmpNWqeG3cHhuNGJk1F9c1gLVfRRGYHOwpgjca6dHyXkECl
c+H4LuHaWkT6pjGRtTDe5beTzG5AK16sbLqdz+2rwABMkN5GTV3ZlOP05wI2i8yV
fV/XBb+1iCQpBHEMTg0mbPFVBAfn7tf0kZtIS4BqQiYLhEzZPxOpKIJwmnYetIJ9
f3RXO1e+cEReDQxFs9wljRwCo/FWCOrfKmnDhO2hYkHQVpfoZZ+gpxha0Mh0mjeV
TGuO/a85veLyyuqwq1IDeYyoCK4L6J/EmRGXAluCHjKmSMQGY5xHT3vfcrHu6mi1
gJPk0Kj0mdpQNkKQX6E9oRMCneNDYK7Z3YV307QvxAoJtkExInU=
=ZU88
-----END PGP SIGNATURE-----

--lvfysjqgqkmt3h4b--
