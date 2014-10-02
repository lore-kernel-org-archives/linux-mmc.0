From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Thu, 02 Oct 2014 13:49:57 +0200
Message-ID: <542D3BE5.2050407@rempel-privat.de>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>	<CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>	<53B3D562.1030707@rempel-privat.de>	<CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>	<542A81EC.40708@rempel-privat.de> <CAPDyKFoAzeYjvuP=5W8r7NQjnL9OzWXP=+Y+b_1ZZgWRbUXsZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mmq6h3CMWVvjx12a7GmuoDRCvKjk3u3fP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59502 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaJBLuH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Oct 2014 07:50:07 -0400
In-Reply-To: <CAPDyKFoAzeYjvuP=5W8r7NQjnL9OzWXP=+Y+b_1ZZgWRbUXsZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmq6h3CMWVvjx12a7GmuoDRCvKjk3u3fP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 30.09.2014 um 13:00 schrieb Ulf Hansson:
> On 30 September 2014 12:11, Oleksij Rempel <linux@rempel-privat.de> wro=
te:
>> Am 09.07.2014 um 14:52 schrieb Ulf Hansson:
>>> [snip]
>>>
>>>>>
>>>>> I am just a bit curious, does this controller support hardware busy=

>>>>> detection on DAT1 line while waiting for command completion?
>>>>
>>>> Do you mean AU6601_REG_BUS_STATUS?
>>>> See at the beginning of patch.
>>>
>>> While reviewing the code, it seems like the controller are handling
>>> hardware busy detection on DAT1. On the other hand you don't enable
>>> MMC_CAP_WAIT_WHILE_BUSY, shouldn't you be doing that?
>>
>> Hi Ulf,
>>
>> what is better way to use sg with dma? This controller support only
>> 0x4000 alight addresses. It is possible to solve it per driver basis,
>> but i have seen already more then one driver which need it. Should it =
be
>> done in  mmc block code? Any other suggestions?
>=20
> I don't quite follow. Does your DMA controller put constraints on
> buffer alignment/length or is it the mmc controller?

mmc controller. it can only accept addresses aligned to the PAGE_SIZE.

> I am aware of that drivers may have special treatments of buffer
> alignment/length to be able to handle some corner cases. And yes we
> don't have a common interface in the mmc core to handle that. I am not
> sure how that could be done? Do you have any suggestions?

hmm... theoretically SG allocation should always be page aligned.
Right now i found probable reason for this issue. Looks like i
misinterpreted max_segs parameter. If i use value bigger then 1, then
can get fragmented SG request. For example, by limit to blk_size=3D512,
block_count=3D8 and  max_segs > 1 request will be 4K (=3Dpage size), but =
the
request can be spread to different pages with offsets !=3D the page begin=
=2E
Which is not optimal for many reasons. On other side, if max_segs=3D1,
then all requests will be aligned.
I don't know if it is expected behavior. If yes, then looks like some
drivers can be simplified just by setting max_segs=3D1.

--=20
Regards,
Oleksij


--mmq6h3CMWVvjx12a7GmuoDRCvKjk3u3fP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlQtO+oACgkQHwImuRkmbWlRzgD/einvp22H35gfL2Wy2WGGb7ty
/qeEox5z5GaG19a22qUBAJHd1myHQXGLtCPjvPxf76E5i7x0gYufMEPDghpBbrA7
=A6sP
-----END PGP SIGNATURE-----

--mmq6h3CMWVvjx12a7GmuoDRCvKjk3u3fP--
