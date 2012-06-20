From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Wed, 20 Jun 2012 02:18:39 -0400
Message-ID: <87oboe4ibk.fsf@octavius.laptop.org>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45753 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab2FTGSn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 02:18:43 -0400
In-Reply-To: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	(Johan Rudholm's message of "Tue, 12 Jun 2012 15:04:13 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Johan,

On Tue, Jun 12 2012, Johan Rudholm wrote:
> Do not scan boot partitions for "soft" partitions, since the boot
> partitions are supposed to contain boot code. Silences the following
> message during boot:
>
>  mmcblkXbootY: unknown partition table
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
>  drivers/mmc/card/block.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 7e3f453..efdea68 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1515,6 +1515,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	md->disk->queue = md->queue.queue;
>  	md->disk->driverfs_dev = parent;
>  	set_disk_ro(md->disk, md->read_only || default_ro);
> +	if (area_type & MMC_BLK_DATA_AREA_BOOT)
> +		md->disk->flags = GENHD_FL_NO_PART_SCAN;
>  
>  	/*
>  	 * As discussed on lkml, GENHD_FL_REMOVABLE should:

Would it be impossible to add a partition table to mmcblkXbootY,
or just unlikely?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
