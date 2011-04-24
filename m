From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: block: init force_ro sysfs attribute
Date: Sat, 23 Apr 2011 20:47:36 -0500
Message-ID: <BANLkTikdfQTtE6jmsVRpUdHh4eTeEBEFEw@mail.gmail.com>
References: <1303572178-6349-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:51495 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab1DXBrk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2011 21:47:40 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3O1m461000957
	for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2011 21:48:04 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3O1m3Q9000948
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2011 21:48:04 -0400 (EDT)
Received: by wwb28 with SMTP id 28so1347772wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2011 18:47:36 -0700 (PDT)
In-Reply-To: <1303572178-6349-1-git-send-email-rabin@rab.in>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Sat, Apr 23, 2011 at 10:22 AM, Rabin Vincent <rabin@rab.in> wrote:
> To avoid lockdep warnings:
>
> BUG: key dc90a520 not in .data!
> ------------[ cut here ]------------
> WARNING: at /home/rabin/kernel/arm/kernel/lockdep.c:2701 sysfs_add_fi=
le_mode+0x4c/0xb0()
> Modules linked in:
> [<c004b5d8>] (unwind_backtrace+0x0/0xe4) from [<c0074f20>] (warn_slow=
path_common+0x4c/0x64)
> [<c0074f20>] (warn_slowpath_common+0x4c/0x64) from [<c0074f50>] (warn=
_slowpath_null+0x18/0x1c)
> [<c0074f50>] (warn_slowpath_null+0x18/0x1c) from [<c0157fec>] (sysfs_=
add_file_mode+0x4c/0xb0)
> [<c0157fec>] (sysfs_add_file_mode+0x4c/0xb0) from [<c02d61e4>] (mmc_a=
dd_disk+0x40/0x64)
> [<c02d61e4>] (mmc_add_disk+0x40/0x64) from [<c02d64cc>] (mmc_blk_prob=
e+0x188/0x1fc)
> [<c02d64cc>] (mmc_blk_probe+0x188/0x1fc) from [<c02ce820>] (mmc_bus_p=
robe+0x14/0x18)
> ...
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
> =A0drivers/mmc/card/block.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 9e30cf6..179a607 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -967,6 +967,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
> =A0 =A0 =A0 =A0add_disk(md->disk);
> =A0 =A0 =A0 =A0md->force_ro.show =3D force_ro_show;
> =A0 =A0 =A0 =A0md->force_ro.store =3D force_ro_store;
> + =A0 =A0 =A0 sysfs_attr_init(&md->force_ro.attr);
> =A0 =A0 =A0 =A0md->force_ro.attr.name =3D "force_ro";
> =A0 =A0 =A0 =A0md->force_ro.attr.mode =3D S_IRUGO | S_IWUSR;
> =A0 =A0 =A0 =A0ret =3D device_create_file(disk_to_dev(md->disk), &md-=
>force_ro);
> --
> 1.7.4.1
>
>

Thanks for catching this. I should really fix the lockdep issues with
our platform (some deadlock/hang with a watchdog reboot).

A
