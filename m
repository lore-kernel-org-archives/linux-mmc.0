From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set
 in meson_mmc_clk_init
Date: Sat, 18 Feb 2017 12:26:49 +0100
Message-ID: <98176614-e3e8-731e-7a34-788655b2be8a@poczta.onet.pl>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
 <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
 <ef2944b5-e04c-780b-6256-31af7ceb87dc@poczta.onet.pl>
 <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="okian4PuDjN4kmdbnFwNPPb2HkE5cCCep"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpo77.poczta.onet.pl ([141.105.16.27]:37755 "EHLO
        smtpo77.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbdBRLgR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 06:36:17 -0500
In-Reply-To: <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--okian4PuDjN4kmdbnFwNPPb2HkE5cCCep
Content-Type: multipart/mixed; boundary="R5X6Id91TK3ORNBJL8AGhu7NQm8x4qXaw";
 protected-headers="v1"
From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Message-ID: <98176614-e3e8-731e-7a34-788655b2be8a@poczta.onet.pl>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set
 in meson_mmc_clk_init
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
 <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
 <ef2944b5-e04c-780b-6256-31af7ceb87dc@poczta.onet.pl>
 <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>
In-Reply-To: <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>

--R5X6Id91TK3ORNBJL8AGhu7NQm8x4qXaw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



W dniu 18.02.2017 o 11:37, Heiner Kallweit pisze:
> Am 18.02.2017 um 04:44 schrieb Micha=C5=82 Zegan:
>> Hello Heiner,
>>
>> W dniu 16.02.2017 o 20:42, Heiner Kallweit pisze:
>>> This clk_disable_unprepare isn't right here. At first the condition
>>> should be "if (ret)" as the disable/unprepare is supposed to be
>>> executed if the previous command fails.
>>> And if the previous command fails and meson_mmc_clk_init returns
>>> an error, then probe jumps to label free_host where we have this
>>> disable/unprepare already.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>> v2:
>>> - extended commit message
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson=
-gx-mmc.c
>>> index 68e76fa8..850b0152 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -320,11 +320,7 @@ static int meson_mmc_clk_init(struct meson_host =
*host)
>>>  	/* Get the nearest minimum clock to 400KHz */
>>>  	host->mmc->f_min =3D clk_round_rate(host->cfg_div_clk, 400000);
>>> =20
>>> -	ret =3D meson_mmc_clk_set(host, host->mmc->f_min);
>>> -	if (!ret)
>>> -		clk_disable_unprepare(host->cfg_div_clk);
>>> -
>>> -	return ret;
>>> +	return meson_mmc_clk_set(host, host->mmc->f_min);
>>>  }
>>> =20
>>>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *=
ios)
>>>
>>
>> I see one problem here.
>> As you said, if the previous command (that is the meson_mmc_clk_set
>> function call) fails, then the whole meson_mmc_clk_init returns an err=
or
>> value, and meson_mmc_probe jumps to free_host and disables the clock t=
here.
>> But what happens if the clk_prepare_enable is the line that fails? in
>> this case, the function returns an error value too, and in the free_ho=
st
>> meson_mmc_probe tries to disable the clock that is not enabled, and th=
at
>> probably results in a kernel warning because you tried to disable a
>> disabled clock.
>> I was preparing a patch to disable clocks in the probe function only i=
f
>> they were enabled before, but then the meson_mmc_clk_init function
>> remains a problem, because we don't know if the clock was enabled
>> successfully or not when it returns an error.
>>
> Thanks for pointing out, you're right. The solution however should be
> quite easy. I meson_mmc_clk_init we just change the condition of
> the disable/unprepare to "if (ret)" and in probe we remove this
> disable/unprepare from the error path.
>=20
If you do that, then if something fails *after* the meson_mmc_clk_init
returns success, but something else fails later, then you will end up
not disabling those clocks. What I thought about is: change the
condition as you said. but in meson_mmc_probe, either check if clock is
enabled in free_host before disabling it, or have two additional error
passes: one used after the core_clk is enabled (currently if it fails
then it will also be a kernel warning), and one used after the
meson_mmc_clk_init returns success that would also disable the div
clock. Not sure if that second one is appropriate or not.
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>=20


--R5X6Id91TK3ORNBJL8AGhu7NQm8x4qXaw--

--okian4PuDjN4kmdbnFwNPPb2HkE5cCCep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEE8PeJXyv9t1Bfiq63mRxoPZnIFPkFAlioL3kbHHdlYmN6YXRf
MjAwQHBvY3p0YS5vbmV0LnBsAAoJEJkcaD2ZyBT5TPwH/320URjYZtozb9Tfs/hB
xk/Fa042Rr7Kd0uOa5yv/1G0tStEJPuL5jLHNMPDOmFoS0VpfGBBUzr8A3usZSXu
0RHzhSN02GEOUAc5/NEZu/41VgbcWFrJimV4K3rL4xooxilL1krbSxcyAfaN0JMI
BMCz/y1H8PFuJ+wborvMSQu0XUFnOf1z3PX3jq7kINxyjv2rYgklD/GMCclCDf12
DEj2t+DgCfJF5hdVIwR0PdWOdMS9n7KJ6Ib7JEQda/+bXehQVAXIwHQovoJs/xM7
yZVMIngOfYdo18xknnZ6ljyFUhxh69WgjqQ8DNxkuOtxQT9kwidFj8qyaohm489s
CVs=
=4D0i
-----END PGP SIGNATURE-----

--okian4PuDjN4kmdbnFwNPPb2HkE5cCCep--
