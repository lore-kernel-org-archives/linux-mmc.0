From: Diogo Sousa <diogogsousa@gmail.com>
Subject: Re: rtsx_pci issue: Realtek 5289 SDHC/SDXC
Date: Mon, 22 Jul 2013 05:41:30 +0100
Message-ID: <51ECB7FA.8070508@gmail.com>
References: <51D77CDF.4070106@gmail.com> <51EC910A.7090507@gmail.com> <51EC94D9.20303@realsil.com.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LCAWPBUHRCRCCNXTBWRU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:46027 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab3GVElk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2013 00:41:40 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so5373065wev.8
        for <linux-mmc@vger.kernel.org>; Sun, 21 Jul 2013 21:41:38 -0700 (PDT)
In-Reply-To: <51EC94D9.20303@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: pclinux <pclinux@realsil.com.cn>
Cc: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LCAWPBUHRCRCCNXTBWRU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22-07-2013 03:11, pclinux wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8822=E6=97=A5 09:55, Diogo Sousa =E5=86=
=99=E9=81=93:
>> Hi,
>>
>> I have sent this mail before to this mailing list but got no response =
so
>> I'm resending it:
>>
>> I'm not sure if this is the proper way to report bugs, I will gladly
>> report it bugzilla if that is preferred.
>>
>> I have been experiencing an issue with the rtsx_pci driver.
>> I cannot read SDHC or SDXC cards. I'm running linux 3.9.9 on a x86_64.=

>> Normal SD cards seems to work fine.
>=20
> Hi Diogo:
>=20
> From your description, it looks like a compatibility issue. But I can't=

> reproduce the case in my site.
> You said you can't read SDHC or SDXC cards. Does it mean that all of th=
e
> HCXC card can't be accessed, or just one card?
> Please tell me the exact model type of your card and your notebook. So
> we will try to find the exact same platform so we can reproduce the cas=
e.
>=20
> Thanks!
> Wei WANG

I have tried two SDHC card with the same results, and only one SDXC card
(I only have this one).

The cards I'm using are all from sandisk: 8GB 95MB/s, 16GB 30MB/s and
64GB 45MB/s. The laptop I'm using is Asus K55VJ-SX061H.

Thanks,
Diogo Sousa



------enig2LCAWPBUHRCRCCNXTBWRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR7LgAAAoJEN6T8FNssaHVcMAQALBVV/4lUocGo8PKO3j1jzvd
Z9OIovq1+wVkqu4Whwn1C0iPWQkhiHs/Rudf3K75En8TUpiI+r/UQ0y+873P5WFG
sGuT1reL6Yw/fStBOlmj3T9HWe1F8rpHCluL5xPzo2A8KfVd/UjekH6zX6gcfw7G
Qspl6vZIJZ7Y3NVeevH/Y0dPiHeUY/CsVUXdrZvOZiyFMRmfrwYVc7tO81bHjMdO
2GwDWEqaA3cOHns5mjY4PZR5gQyH4/2sr7ViXhLQC6l48yi1t2Ivh/xXiLZ40GCE
siDP3vRu8u4V2BzO7DmiMZkyxqEf7gNGzK+wEuNhwD2vEdq9/yXIgxVBdhA/xOT1
GTFDblDavi5XHI/p2ZcR8g6gzt1+kFKIASFfk5vuUy3aqiph8zKII6/wvgokhK2W
11Pw06d0gF5340TDxpf5HuW5ALyKwvqIsUd/xZUI0MVUBCaT8YmYKYxI7td2Srh3
4hTVRU/F0vTHKvuNq/8OzABOtsVQSTSr71IhLlyQoeogDJQyFOq+tz0S8Xdwzjww
P0qs5ooJAn+O/xJO68HNRsX7/qBCXjvBH5ZvkQ47mgg9UCd+zbY31221RlH4A5AI
uZbIdVJ0N1W3G6C0t+9o7U1TVNUctFR7BX+M1qx9pFHDK1cu/xaCxK560a4zK68u
ke/YWq0Q79X05YSQsdII
=ENnZ
-----END PGP SIGNATURE-----

------enig2LCAWPBUHRCRCCNXTBWRU--
