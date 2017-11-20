From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Mon, 20 Nov 2017 10:20:23 +0100
Message-ID: <20171120092023.nc3oxnawxqwa3ofs@tetsubishi>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com>
 <20171119194930.npqfzqvmh4zbcb34@tetsubishi>
 <CAK7LNAQZQ13O1pSd5Ah7VDWrZF1MSkLT_QoTDS+uT7C-r09b+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lft6ts6rkgirl2l6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48833 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdKTJUZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 04:20:25 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNAQZQ13O1pSd5Ah7VDWrZF1MSkLT_QoTDS+uT7C-r09b+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>


--lft6ts6rkgirl2l6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yamada-san,

> My best guess is unnecessary if-conditional was added
> and overlooked in the review process.

I agree.

So, from visual review, most patches look good to me. I will give them
testing on HW this evening and add my Reviewed-by tags then. I'll also
reply to the driver rename thread later today.

Thanks!

   Wolfram


--lft6ts6rkgirl2l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloSnlAACgkQFA3kzBSg
KbawUBAAmzTwEF7qXLMV5Sv03UmOpyyqs90JccpbnmLGoTvd9Qd74LShCmZERt6Y
aZvL7L74fVVeM32VlwitQpZWlzVCFwuHHyYKlzogsMyMPqNVkybg7JnlntkItfR0
Dpj6brZGIR52cDQMyvOt0d+RG1qJuwmvpfDpteH0Es6UnvEVle/oepadpVLi5YG2
mBEjoRihtDb826R2EG/VGC2kMk21VxyHj9E+iPlZN4DmxFm4dm/kS+qAQg51wXJF
Wfkk46CBU08+cNahQHk17e1IPVsTYeGzA5fa/DsItRszj2MQDvZ7frjTnSv0U2S3
B3JiaX17woN33OZy43f87ll93SgY+Dp/tofgni1CktXaoaTXQ0cYqz2xHlxPQaKj
HwemOvCUGrg+QEJ54yO37wDgD1pCzbkPAGR67gNdcKtvOV6cEk9tp3pcEsKNuMRL
BfvDHEoasEHg/jq0uzmfKLXFCKdp+nQbu3Gje1E7C1DuOBZWLowhdy84yYsrHHj8
oJcM/G3R0pM3tvtoxW2a1gBXngCsPjVxaifMID6ZS05o/M7jTPlUL0JdhIvOMGaE
HsOlMEPshhn4b8+TlTp386hmecf8L5+iC6CNREvR4641a+9ZRnYZ1ZYoJk0SnP/y
j+e0KKEk4y7iSZe+ftjwcXloYzzUPzS4E88cDAeEnBoVCyBtsvU=
=dS7S
-----END PGP SIGNATURE-----

--lft6ts6rkgirl2l6--
