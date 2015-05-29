From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] mmc: sdhci-bcm2835: Actually enable the clock
Date: Fri, 29 May 2015 14:03:50 -0700
Message-ID: <87eglzcczt.fsf@eliezer.anholt.net>
References: <1432857792-7421-1-git-send-email-eric@anholt.net> <20150529083541.GH2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:56966 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828AbbE2VDv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2015 17:03:51 -0400
In-Reply-To: <20150529083541.GH2067@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, May 28, 2015 at 05:03:12PM -0700, Eric Anholt wrote:
>> We're currently using a fixed frequency clock specified in the DT, so
>> enabling is a no-op.  However, the RPi firmware-based clocks driver
>> can actually disable unused clocks, so when switching to use it we
>> ended up losing our MMC clock once all devices were probed.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/mmc/host/sdhci-bcm2835.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-b=
cm2835.c
>> index 0ef0343..09aff3a 100644
>> --- a/drivers/mmc/host/sdhci-bcm2835.c
>> +++ b/drivers/mmc/host/sdhci-bcm2835.c
>> @@ -172,6 +172,11 @@ static int bcm2835_sdhci_probe(struct platform_devi=
ce *pdev)
>>  		ret =3D PTR_ERR(pltfm_host->clk);
>>  		goto err;
>>  	}
>> +	ret =3D clk_prepare_enable(pltfm_host->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable host clk\n");
>> +		goto err;
>> +	}
>>=20=20
>>  	return sdhci_add_host(host);
>
> Where's the error clean-up path for a failed sdhci_add_host()?

We were already missing required cleanup in that path, so I didn't
notice.  Sending a new version with a fix for that.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVaNQ2AAoJELXWKTbR/J7odsYQAKgweZi8FXRXiNg7KaMBCwx3
ynluaK+F5G4L8jfZnhLFzrefCWf4xcGuobMdlj3XBwzlEruM/JA0eYVHQLo6LZAb
5B9boXW9KcSxlKfYgJOqsqbdoJksM6SPRBLdZsrPdNtQGP5qvsAtaVjlbFBpcSyu
GihWcFlRCOppqUc8yURxF+FlU/yFzqx/gNPVwerzhsj2R8afZ07s9bWOp+fdO59K
U9wQ1kwM1XSBYUOnZJ+shJDXs/v+cHEmQhmNzZcaOqbrrGqydiLuJczY9dadek45
Wdscw9KMkllqq9dikajci+zTwKwSdYnKWMfAnBRA5vYO5yIYWqPo0iKt/qNGD39J
mrQzKF5ktEn1flFH0cd6ay+1KepDt7LbZAQd7ppYPlwHQwQVRYIaKqCQ8xmAgVlL
qB4hrlVPTi3LmFlZ0CStYIHwErEAjgjIIxCzUx5aHIx6okqGrybYS/wTG3cGFlTM
PhYGL4yDFGLDfTywj/8t8eAaTKwDLG9vHGE+vMFWoaHD19/Me5MyzNLC/BBo62eF
AQ3ATTprjqT5H/niC+5IcEvYIfKhxa+MKxxp/G+guWwWBv3qSUfuXHgyFdJzHxnw
uYFSaYcnOUPiq+zUsZ2A/v5KFDMOtXsEvN4WlDCMWzNeo+P5X+Ig4XPwJKJmRsTS
KvAfZ6uHIFbJpP0TdPnB
=THP0
-----END PGP SIGNATURE-----
--=-=-=--
