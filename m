From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in
 meson_mmc_clk_init / meson_mmc_probe
Date: Sat, 18 Feb 2017 16:30:27 +0100
Message-ID: <4c098dd5-89a7-b657-b699-950f8eb7dc8b@poczta.onet.pl>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
 <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
 <f152d90b-5105-82b5-c7ec-f1868741739b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lUhMhDPn2uqfx053FxxPCU43b4i202pIH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpo33.poczta.onet.pl ([213.180.142.164]:56564 "EHLO
        smtpo33.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdBRPaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 10:30:39 -0500
In-Reply-To: <f152d90b-5105-82b5-c7ec-f1868741739b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lUhMhDPn2uqfx053FxxPCU43b4i202pIH
Content-Type: multipart/mixed; boundary="IX9JAXxgDsWvf2qmV9CNsvVlUUgdtOj6I";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-amlogic@lists.infradead.org
Message-ID: <4c098dd5-89a7-b657-b699-950f8eb7dc8b@poczta.onet.pl>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in
 meson_mmc_clk_init / meson_mmc_probe
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
 <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
 <f152d90b-5105-82b5-c7ec-f1868741739b@gmail.com>
In-Reply-To: <f152d90b-5105-82b5-c7ec-f1868741739b@gmail.com>

--IX9JAXxgDsWvf2qmV9CNsvVlUUgdtOj6I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



W dniu 18.02.2017 o 16:22, Heiner Kallweit pisze:
> Am 18.02.2017 um 14:57 schrieb Micha=C5=82 Zegan:
>>
>>
>> W dniu 18.02.2017 o 14:19, Heiner Kallweit pisze:
>>> The condition should be "if (ret)" as the disable/unprepare is
>>> supposed to be executed if the previous command fails.
>>> In addition adjust the error path in probe to properly deal
>>> with the case that cfg_div_clk can be registered successfully
>>> but enable/prepare fails.
>>> In this case we shouldn't call clk_disable_unprepare.
>>>
>>> Reported-by: Micha=C5=82 Zegan <webczat_200@poczta.onet.pl>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>> v2:
>>> - extended commit message
>>> v3:
>>> - adjust error path in probe
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson=
-gx-mmc.c
>>> index 68e76fa8..002e4aac 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -321,7 +321,7 @@ static int meson_mmc_clk_init(struct meson_host *=
host)
>>>  	host->mmc->f_min =3D clk_round_rate(host->cfg_div_clk, 400000);
>>> =20
>>>  	ret =3D meson_mmc_clk_set(host, host->mmc->f_min);
>>> -	if (!ret)
>>> +	if (ret)
>>>  		clk_disable_unprepare(host->cfg_div_clk);
>>> =20
>>>  	return ret;
>>> @@ -771,7 +771,7 @@ static int meson_mmc_probe(struct platform_device=
 *pdev)
>>>  					meson_mmc_irq_thread, IRQF_SHARED,
>>>  					DRIVER_NAME, host);
>>>  	if (ret)
>>> -		goto free_host;
>>> +		goto err_div_clk;
>>> =20
>>>  	mmc->max_blk_count =3D CMD_CFG_LENGTH_MASK;
>>>  	mmc->max_req_size =3D mmc->max_blk_count * mmc->max_blk_size;
>>> @@ -784,7 +784,7 @@ static int meson_mmc_probe(struct platform_device=
 *pdev)
>>>  	if (host->bounce_buf =3D=3D NULL) {
>>>  		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");=

>>>  		ret =3D -ENOMEM;
>>> -		goto free_host;
>>> +		goto err_div_clk;
>>>  	}
>>> =20
>>>  	mmc->ops =3D &meson_mmc_ops;
>>> @@ -792,8 +792,9 @@ static int meson_mmc_probe(struct platform_device=
 *pdev)
>>> =20
>>>  	return 0;
>>> =20
>>> -free_host:
>>> +err_div_clk:
>>>  	clk_disable_unprepare(host->cfg_div_clk);
>>> +free_host:
>>>  	clk_disable_unprepare(host->core_clk);
>>>  	mmc_free_host(mmc);
>>>  	return ret;
>>>
>> Doesn't the same problem exist with a core clock? It also could error
>> when being enabled, and it will be disabled even if not enabled before=
=2E..
>>
> Yes, there it's basically the same issue. Feel free to submit a patch.
>=20
Okay, I will submit a patch based on this series to fix that too, thanks.=

Reviewed-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>


--IX9JAXxgDsWvf2qmV9CNsvVlUUgdtOj6I--

--lUhMhDPn2uqfx053FxxPCU43b4i202pIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAlioaJQbHHdlYmN6YXRf
MjAwQHBvY3p0YS5vbmV0LnBsAAoJEJkcaD2ZyBT5040IALOaSjD6fb5utZM+oQMy
EJS2RLx++td1GOT5W44OzEOUE7gb4XnxZSwZQ0l12j6uZ6VDeWUvZoZTw/R8wq84
0wXl3VGLS06PH8G9/mO965qCbJRFcx0ab09YIXYGlNLSUC0wgsfW0rpZfmX+pEoz
e0C462pcDcBF6HJ3ZR7pEkybmJzrQkFn7juda3azoheWqAMkYOCLYpaSX0gdsyi5
163ZGzIp1gLJCnE5GCPwYhkUyutzJjd/m+1W7tnZOJ977+VwsIoz5NXtar5irp4b
L73d9mbd4la2ods0qskvDH53Yc9/O1cZHUd7u9Q6rVPlh6HWWiQmmhs6BsJM+ewf
k5E=
=QvyL
-----END PGP SIGNATURE-----

--lUhMhDPn2uqfx053FxxPCU43b4i202pIH--
