From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: question about block layer and dma alignment issue.
Date: Wed, 08 Oct 2014 08:50:02 +0200
Message-ID: <5434DE9A.1030009@rempel-privat.de>
References: <542F9AD9.7020104@rempel-privat.de> <543027BD.5090009@kernel.dk> <5433B469.4060807@rempel-privat.de> <543405F0.4030103@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E8lxMgpldtexpVT6pKIXSjXn7Dj825Gos"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51197 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaJHGuJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Oct 2014 02:50:09 -0400
In-Reply-To: <543405F0.4030103@kernel.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, "ulf.hansson@linaro.org >> Ulf Hansson" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org >> linux-mmc" <linux-mmc@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8lxMgpldtexpVT6pKIXSjXn7Dj825Gos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 07.10.2014 um 17:25 schrieb Jens Axboe:
> On 10/07/2014 03:37 AM, Oleksij Rempel wrote:
>> Am 04.10.2014 um 19:00 schrieb Jens Axboe:
>>> On 2014-10-04 00:59, Oleksij Rempel wrote:
>>>> Hello Jens,
>>>>
>>>> i hope it is OK to ask you directly, i didn't found better way to do=

>>>> this.
>>>> I'm writing MMC driver based on reverse engineering for au6601 mmc
>>>> controller. This driver uses MMC API, and last one trying to use BLK=
 API
>>>> as directly as possible. So far so gut, but i have a problem by usin=
g SG
>>>> requests with DMA without conversation. This controller accepts only=

>>>> addresses with this mask 0xffff.f000 - also page aligned.
>>>> Till now i tried different QUEUE_FLAG_ flags and blk_queue settings,=
 but
>>>> i never had absolute aligned quarantine.
>>>> Please tell me if i do some thing wrong or go in the wrong direction=
=2E
>>>
>>> Unless you can accept a 4kb hardware block size (and I'm assuming you=

>>> cannot, since you need to support 512b file systems?), then you'd hav=
e
>>> to bounce the requests that don't align properly. You can fix some of=

>>> them by setting blk_queue_dma_alignment(q, 4095).
>>
>> I needed to include MMC list with Ulf Hansson at the beginning, so her=
e
>> we are.
>>
>> Hi Ulf,
>>
>> here is the list of drivers which do care about dma alignment . Some o=
f
>> them use bounce_buffer, some will use PIO instead of DMA, for not
>> aligned requests:
>>
>> dw_mmc.c: dw_mci_pre_dma_transfer
>> wbsd.c
>> usdhi6rol0.c
>> tmio_mmc_dma.c
>> sunxi-mmc.c
>> sdhci.c
>> pxamci.c
>> mvsdio.c
>> au6601.c(not upstream jet)
>>
>> The problem of all this driver is that each of them use own solution. =
I
>> think this code can be moved to some common place. For example, it can=

>> be done in drivers/mmc/card/queue.c and enabled by
>> mmc_host_dma_alignment variable. Or provide a mmc_sg_align() function,=

>> which should be called explicatively by driver.
>>
>> Which option is preferable?
>=20
> I would roll a block version that they all can use, you can look at
> block/bounce.c for inspiration. That file deals with bouncing higher
> pages to lower memory, so it's not exactly what you want. But the metod=

> of allocating a new bio that meets criteria and copying data over, that=

> is the same that you need.

Ok,

i will need to setup testing board for this kind of work. It will take
some time.

--=20
Regards,
Oleksij


--E8lxMgpldtexpVT6pKIXSjXn7Dj825Gos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EAREIAAYFAlQ03p4ACgkQHwImuRkmbWkqPAD/ZPdfO7m0Og+7gT/C7IogIUkI
nM02oAf8O4IjwdMM7xAA/A1ZbKfu3UuZ2lAazCQaOmDjcVHuNnTj2hC+n3totpUA
=2euv
-----END PGP SIGNATURE-----

--E8lxMgpldtexpVT6pKIXSjXn7Dj825Gos--
