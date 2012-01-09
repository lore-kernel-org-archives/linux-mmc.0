From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: typo in Documentation/devices.txt  ?
Date: Mon, 9 Jan 2012 16:41:05 +0800
Message-ID: <20120109084103.GA26745@ladygaga>
References: <31861576.535331325747307853.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:2120 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab2AIIlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2012 03:41:13 -0500
Content-Disposition: inline
In-Reply-To: <31861576.535331325747307853.JavaMail.weblogic@epml02>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?7ZeI7KKF66eM?= <jongman.heo@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Jan 05, 2012 at 07:08:27AM +0000, =ED=97=88=EC=A2=85=EB=A7=8C w=
rote:
>=20
> Hi, all..
>=20
> Here is description for MMC block devices in Documentation/devices.tx=
t :
>=20
>     179 block       MMC block devices
>                       0 =3D /dev/mmcblk0      First SD/MMC card
>                       1 =3D /dev/mmcblk0p1    First partition on firs=
t MMC card
>                       8 =3D /dev/mmcblk1      Second SD/MMC card
>                       ^^^^^^^^^^^^^^^^^^
>                     The start of next SD/MMC card can be configured w=
ith
>                     CONFIG_MMC_BLOCK_MINORS, or overridden at boot/mo=
dprobe
>                     time using the mmcblk.perdev_minors option. That =
would
>                     bump the offset between each card to be the confi=
gured
>                     value instead of the default 8.
>=20
>=20
> Shouldn't  "8 =3D /dev/mmcblk1" be "9 =3D /dev/mmcblk1" ?

No, mmcblk1's minor is 8, mmcblk2's minor is 16, etc...

>=20
> If we have 8 partitions on first MMC card, we need mmcblk0p1 ~ mmcblk=
0p8 devices, with minor number 1 ~ 8.
> Am I misunderstanding?

Each mmc block device by default has 8 minors, not 8 partitions. Minor =
0
represent the whole disk. So each mmc block device at most has 7
partitions instead of 8.

See code in function mmc_blk_alloc_req on assigning minor value to the
whole disk of the block device:
md->disk->first_minor =3D devidx * perdev_minors;

And code in function blk_alloc_devt on checking partition number agains=
t
disk minors:
	/* in consecutive minor range? */
	if (part->partno < disk->minors) {
		*devt =3D MKDEV(disk->major, disk->first_minor + part->partno);
		return 0;
	}

-Aaron

>=20
> Regards,
> Jongman Heo.

