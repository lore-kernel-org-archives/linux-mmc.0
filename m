From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 14:39:14 +0200
Message-ID: <201104211439.14510.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104211315.51984.arnd@arndb.de> <BANLkTikTBK+0_KLjcB_sk4kF+a_vdaOckQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61785 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1DUMj3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 08:39:29 -0400
In-Reply-To: <BANLkTikTBK+0_KLjcB_sk4kF+a_vdaOckQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

On Thursday 21 April 2011, Micha=B3 Miros=B3aw wrote:
> W dniu 21 kwietnia 2011 13:15 u=BFytkownik Arnd Bergmann <arnd@arndb.=
de> napisa=B3:

> static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mo=
de,
>     unsigned int cmd, unsigned long arg)
> {
>   struct mmc_ioc_cmd blk;
>=20
>   if (cmd !=3D MMC_IOC_CMD)
>     return -EINVAL;
>=20
>   copy_from_user(compat_ptr(arg), &blk) ...
>   blk.data_ptr =3D compat_ptr(blk.__data_ptr_storage32);
>=20
>   return mmc_blk_ioctl_cmd(bdev, &blk);
> }

Yes, this works, but it requires having a compat_ioctl() handler functi=
on that
knows about the data structure, which we generally try to avoid.
The same method would even work if you only had a pointer member in the
structure and did not even attempt to make the structure compatible.

	Arnd
