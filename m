From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-s3c: Fix base clock source management
Date: Mon, 13 Jan 2014 14:47:19 +0900
Message-ID: <52D37DE7.1000407@samsung.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
 <1704043.sYrCOYas4N@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43904 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaAMFrF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 00:47:05 -0500
In-reply-to: <1704043.sYrCOYas4N@phil>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

Hi, All.

On 01/13/2014 06:18 AM, Heiko St=C3=BCbner wrote:
> Am Samstag, 11. Januar 2014, 22:39:00 schrieb Tomasz Figa:
>> Tested on S3C6410-based Mini6410 board, with following performance
>> figures:
>>
>> * Before this series (133 MHz HCLK always selected, leading to at mo=
st
>>   33 MHz card clock):
>>
>> root@tiny6410:~# hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>  Timing buffered disk reads:  42 MB in  3.10 seconds =3D  13.54 MB/s=
ec
>=20
> # hdparm -t /dev/mmcblk0
>=20
> /dev/mmcblk0:
>  Timing buffered disk reads: 44 MB in  3.12 seconds =3D  14.11 MB/sec

/dev/mmcblk0:
 Timing buffered disk reads:  38 MB in  3.14 seconds =3D  12.12 MB/sec
>=20
>=20
>> * After this series (48 MHz EPLL clock selected, leading to 48 MHz c=
ard
>>   clock):
>>
>> root@tiny6410:~# hdparm -t /dev/mmcblk0
>>
>> /dev/mmcblk0:
>>  Timing buffered disk reads:  56 MB in  3.04 seconds =3D  18.41 MB/s=
ec
>=20
> # hdparm -t /dev/mmcblk0
>=20
> /dev/mmcblk0:
>  Timing buffered disk reads: 48 MB in  3.01 seconds =3D  15.94 MB/sec

 /dev/mmcblk0:
 Timing buffered disk reads:  56 MB in  3.05 seconds =3D  18.35 MB/sec
>=20
>=20
> So on a s3c2416:
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Tested with exynos4 board.

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by; Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

>=20
>=20
> Thanks for the added bandwidth :-)
> Heiko
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

