From: Lei Wen <adrian.wenl@gmail.com>
Subject: Re: [PATCH] mmc_block: Allow more than 8 partitions per card
Date: Thu, 9 Sep 2010 10:49:40 +0800
Message-ID: <AANLkTi=qyKCYuZ4esATV1ArBb_GrpqRW7bwdJnZnonVe@mail.gmail.com>
References: <AANLkTinUNpWsu=AY+1EeG8xznPaESL8XnjGo7613yoMt@mail.gmail.com>
	<1283964637-28246-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46470 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0IICtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Sep 2010 22:49:41 -0400
In-Reply-To: <1283964637-28246-1-git-send-email-ccross@android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>, Kay Sievers <kay.sievers@vrfy.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mandeep Baines <msb@chromium.org>

On Thu, Sep 9, 2010 at 12:50 AM, Colin Cross <ccross@android.com> wrote=
:
> Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
> in major 259 for partitions past disk->minors.
>
> Also remove the use of disk_devt to determine devidx from md->disk.
> md->disk->first_minor is always initialized from devidx and can
> always be used to recover it.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> =C2=A0drivers/mmc/card/block.c | =C2=A0 =C2=A07 ++-----
> =C2=A01 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d545f79..07d8eb0 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -87,11 +87,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&open_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->usage--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (md->usage =3D=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int devmaj =3D MAJ=
OR(disk_devt(md->disk));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int devidx =3D MIN=
OR(disk_devt(md->disk)) >> MMC_SHIFT;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devmaj)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 devidx =3D md->disk->first_minor >> MMC_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int devidx =3D md-=
>disk->first_minor >> MMC_SHIFT;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_cleanup_qu=
eue(md->queue.queue);
>
> @@ -607,6 +603,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct =
mmc_card *card)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->private_data =3D md;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->queue =3D md->queue.queue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0md->disk->driverfs_dev =3D &card->dev;
> + =C2=A0 =C2=A0 =C2=A0 md->disk->flags =3D GENHD_FL_EXT_DEVT;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * As discussed on lkml, GENHD_FL_REMOVABL=
E should:
> --
> 1.7.1
>

Looks good to me.
Acked-by: Lei Wen <leiwen@marvell.com>
