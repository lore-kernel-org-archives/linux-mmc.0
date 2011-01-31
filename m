From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix the block device read only flag
Date: Mon, 31 Jan 2011 17:33:56 +0000
Message-ID: <20110131173355.GB28016@void.printf.net>
References: <AANLkTin71fwTVtVY0j-VNPQpGRkwossvhN+28V=VV-pN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36549 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab1AaRd5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Jan 2011 12:33:57 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin71fwTVtVY0j-VNPQpGRkwossvhN+28V=VV-pN@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-1?Q?Marc-Andr=E9_H=E9bert?= <hebert.marcandre@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Mon, Jan 31, 2011 at 11:42:17AM -0500, Marc-Andr=E9 H=E9bert wrote:
> While the MMC handled the card's read only flag correctly on open,
> it did not setup the flag in the allocated disk structure. The
> consequence being that probing the /sys/class/block/mmcblkX/ro
> attribute always reported 0.
>=20
> Signed-off-by: Marc-Andre Hebert <hebert.marcandre@gmail.com>
> ---
>  drivers/mmc/card/block.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index bfc8a8a..61d233a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -621,6 +621,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct
> mmc_card *card)
>  	md->disk->private_data =3D md;
>  	md->disk->queue =3D md->queue.queue;
>  	md->disk->driverfs_dev =3D &card->dev;
> +	set_disk_ro(md->disk, md->read_only);
>=20
>  	/*
>  	 * As discussed on lkml, GENHD_FL_REMOVABLE should:

Thanks very much, pushed to mmc-next and queued as a .38 fix.

(The patch was corrupt due to line-wrapping; something to fix for next
time.)
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
