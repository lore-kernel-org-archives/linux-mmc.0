From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: block: init force_ro sysfs attribute
Date: Sat, 23 Apr 2011 22:25:57 -0400
Message-ID: <m3oc3wv0zu.fsf@pullcord.laptop.org>
References: <1303572178-6349-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60237 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757365Ab1DXCW2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 23 Apr 2011 22:22:28 -0400
In-Reply-To: <1303572178-6349-1-git-send-email-rabin@rab.in> (Rabin Vincent's
	message of "Sat, 23 Apr 2011 20:52:58 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: andreiw@motorola.com, linux-mmc@vger.kernel.org

Hi Rabin,

On Sat, Apr 23 2011, Rabin Vincent wrote:
> To avoid lockdep warnings:
>
> BUG: key dc90a520 not in .data!
> ------------[ cut here ]------------
> WARNING: at /home/rabin/kernel/arm/kernel/lockdep.c:2701 sysfs_add_file_mode+0x4c/0xb0()
> Modules linked in:
> [<c004b5d8>] (unwind_backtrace+0x0/0xe4) from [<c0074f20>] (warn_slowpath_common+0x4c/0x64)
> [<c0074f20>] (warn_slowpath_common+0x4c/0x64) from [<c0074f50>] (warn_slowpath_null+0x18/0x1c)
> [<c0074f50>] (warn_slowpath_null+0x18/0x1c) from [<c0157fec>] (sysfs_add_file_mode+0x4c/0xb0)
> [<c0157fec>] (sysfs_add_file_mode+0x4c/0xb0) from [<c02d61e4>] (mmc_add_disk+0x40/0x64)
> [<c02d61e4>] (mmc_add_disk+0x40/0x64) from [<c02d64cc>] (mmc_blk_probe+0x188/0x1fc)
> [<c02d64cc>] (mmc_blk_probe+0x188/0x1fc) from [<c02ce820>] (mmc_bus_probe+0x14/0x18)
> ...
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  drivers/mmc/card/block.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 9e30cf6..179a607 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -967,6 +967,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
>  	add_disk(md->disk);
>  	md->force_ro.show = force_ro_show;
>  	md->force_ro.store = force_ro_store;
> +	sysfs_attr_init(&md->force_ro.attr);
>  	md->force_ro.attr.name = "force_ro";
>  	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
>  	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
