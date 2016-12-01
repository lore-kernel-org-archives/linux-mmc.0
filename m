From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: mmc: tmio: why enable/disable SDIO irq on every transaction with
 IOMOD?
Date: Thu, 1 Dec 2016 11:46:22 +0100
Message-ID: <20161201104622.GA1541@katana>
References: <87h96qkdn0.wl@dns1.atmark-techno.com>
 <CAPDyKFop3a6eHhOZq1E=BdFiHzmpu4uEx0F79nyBVCOu6z6usw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58297 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbcLAKq0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 05:46:26 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFop3a6eHhOZq1E=BdFiHzmpu4uEx0F79nyBVCOu6z6usw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for the report and thanks to Ulf for forwarding. Adding
renesas-soc list, too.

> > So my question is that "What is the reason behind to disable IRQ with
> > SDIO_MODE?  Is there any situation which masking with SDIO_INFO1_MASK
> > is not enough?

This code predates the time since I took over maintainership of the
driver, so I had to dig in git history.

The code was introduced with 845ecd20239c28 ("mmc: tmio_mmc: implement
SDIO IRQ support") which was in 2010. I don't have that old datasheets
to check if the SCLKDIVEN restriction was already present in the SDHI
cores which were available back then.

My assumption is that it was not, or it was overlooked. So, it might be
just for completeness that not only the individual IRQs have been
disabled but also the big master switch (IOMOD) was turned off.

My further assumption is that it is very likely good enough to disable
the individual IRQs. If we can't guarantee the conditions to set IOMOD,
it seems okay to me to just leave it.

Do you have a patch which works for you?

Regards,

   Wolfram


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYP/9+AAoJEBQN5MwUoCm27mIP/0Eclxe6j41WRlyBLevwZo/Z
rUyS7yBkxcrQcYIuBiCBVIrwK6ZvTnpy4FQpfUsAeLJK7+c81/tOx0Ki1VljN+L5
6cLYBBV/vsr4/OEnE7CJOK7IqRclrqa8Q8G48xAoZMXERnW/70rVc6/vJt8+Cskh
VEWSkD7I6HyAqWbLtgcqG0pKCM8cpHQlAvXN62NLM58OAbOUmm6rOItksfUEpszc
9ygrZWuM20zFfPO6ebIEGJNZv091WgkMuUwtqBm8uYdscfg0lbZIoUgSqYSdBATA
frkM1zkwvqeCpensYMDIy0eJS5UdBNEsU9aMqJEp0Lf5Pm6rb2dYs1qpOAfJzvvt
aF1vtkE6hrMcXfXrA6UPk+O4JPrsTGIDrB6Eshz6KIWl5MflBYITxHdJGx1ZaaeY
JfR0mP+hyaposJ0L0jpL/KP8RbV4aVA2ToSTmod/lNkPHSfcDb92UJl2RrWyICKK
EX1F10lEWpyQai22oxQJ4WA86Mq7RSKP7eQ7GVrZEyhOOUEkRfNU70QCJGzsVsi9
bFc21iCCSaqMiWDGuh6+EYFh7xX9CbnwxrOVcmpP/dVuXw/xh3qE3tofwZ2xE1D2
YYmqXSo2QavldCjcqAE1yEtgUPrr2y5X3hw0hIgbnHT1tugW/0gHWMS0Jv1XY1LQ
K8iVMRyMgwUwmRPzyc3e
=Fahq
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
