From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] MMC: Block: Ensure hardware partitions don't mess with mmcblk device naming.
Date: Thu, 21 Apr 2011 20:20:38 -0400
Message-ID: <m3ipu76srt.fsf@pullcord.laptop.org>
References: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
	<1303366079-2196-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34701 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab1DVAQg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 20:16:36 -0400
In-Reply-To: <1303366079-2196-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Thu, 21 Apr 2011 01:07:59 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Thu, Apr 21 2011, Andrei Warkentin wrote:
> With the hardware partitions support (which represent additional logical devices
> present on MMC), devidx does not correspond with index used to form
> /dev/mmcblkX names. So use an additional allocated index for device names.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/card/block.c |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 9e30cf6..5572012 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -75,6 +75,7 @@ static int max_devices;
>  
>  /* 256 minors, so at most 256 separate devices */
>  static DECLARE_BITMAP(dev_use, 256);
> +static DECLARE_BITMAP(name_use, 256);
>  
>  /*
>   * There is one mmc_blk_data per slot.
> @@ -88,6 +89,7 @@ struct mmc_blk_data {
>  	unsigned int	usage;
>  	unsigned int	read_only;
>  	unsigned int	part_type;
> +	unsigned int	name_idx;
>  
>  	/*
>  	 * Only set in main mmc_blk_data associated
> @@ -776,6 +778,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	}
>  
>  	/*
> +	 * !subname implies we are creating main mmc_blk_data that will be
> +	 * associated with mmc_card with mmc_set_drvdata. Due to device partitions,
> +	 * devidx will not coincide with a per-physical card index anymore
> +	 * so we keep track of a name index.
> +	 */
> +	if (!subname)
> +		md->name_idx = find_first_zero_bit(name_use, max_devices);
> +	else
> +		md->name_idx = ((struct mmc_blk_data *)
> +				dev_to_disk(parent)->private_data)->name_idx;
> +
> +	/*
>  	 * Set the read-only status based on the supported commands
>  	 * and the write protect switch.
>  	 */
> @@ -820,13 +834,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	 * messages to tell when the card is present.
>  	 */
>  
> -	if (subname)
> -		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -			 "mmcblk%d%s",
> -			 mmc_get_devidx(dev_to_disk(parent)), subname);
> -	else
> -		snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -			 "mmcblk%d", devidx);
> +	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> +		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
>  
>  	blk_queue_logical_block_size(md->queue.queue, 512);
>  	set_capacity(md->disk, size);
> @@ -953,6 +962,7 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
>  	struct list_head *pos, *q;
>  	struct mmc_blk_data *part_md;
>  
> +	__clear_bit(md->name_idx, name_use);
>  	list_for_each_safe(pos, q, &md->part) {
>  		part_md = list_entry(pos, struct mmc_blk_data, part);
>  		list_del(pos);

This is crashing for me on insertion of the external card after boot:

[    2.479319] mmc2: new high speed MMC card at address 0001
[    2.485055] mmcblk0: mmc2:0001 SEM04G 3.68 GiB 
[    2.489656] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
[    2.495850] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
[    2.503984]  mmcblk0: p1 p2
[    2.509273]  mmcblk0boot1: unknown partition table
[    2.515308]  mmcblk0boot0: unknown partition table
[    2.524044] psmouse.c: Failed to enable mouse on ec touchpad (phys)
[    2.532834] EXT3-fs: barriers not enabled
[    4.996102] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended
[    5.007285] kjournald starting.  Commit interval 5 seconds
[    5.014595] EXT3-fs (mmcblk0p2): using internal journal
[    5.019791] EXT3-fs (mmcblk0p2): recovery complete
[    5.026713] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[    5.026725] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    5.039565] Freeing init memory: 116K

[olpc@localhost ~]$ 
[   33.642250] Unable to handle kernel NULL pointer dereference at virtual address 00000021
[   33.653175] pgd = c0004000
[   33.656119] [00000021] *pgd=00000000
[   33.659673] Internal error: Oops: 17 [#1] PREEMPT
[   33.659673] last sysfs file: /sys/devices/platform/sdhci-pxa.0/mmc_host/mmc0/mmc0:d555/serial
[   33.672798] Modules linked in:
[   33.675826] CPU: 0    Tainted: G        W    (2.6.39-rc4-00194-ge20de60-dirty #4)
[   33.675826] PC is at sysfs_create_dir+0x24/0xd4
[   33.683258] LR is at kobject_add_internal+0x134/0x224
[   33.687761] pc : [<c00f9880>]    lr : [<c01b2600>]    psr: a0000013
[   33.692773] sp : dc131db8  ip : 00000000  fp : 00000000
[   33.704168] r10: dcfe41fc  r9 : c05571e0  r8 : dc205408
[   33.704168] r7 : dcc61c68  r6 : 00000000  r5 : dcc61c68  r4 : dcf441b0
[   33.709357] r3 : dcc61c68  r2 : 00000000  r1 : 0000002f  r0 : dcf441b0
[   33.715834] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   33.722316] Control: 10c5387d  Table: 1cc44019  DAC: 00000015
[   33.729568] Process kworker/u:1 (pid: 27, stack limit = 0xdc1302f8)
[   33.735271] Stack: (0xdc131db8 to 0xdc132000)
[   33.745818] 1da0:                                                       dcf441b0 0000002f
[   33.745818] 1dc0: 00000000 dc3317a0 dcf441b0 dcc61c68 dcc61c68 c01b2600 dcf441b0 0000002f
[   33.753939] 1de0: 00000000 00000001 dcf441b0 dcc61c68 00000000 dcc61c68 dc205408 c01b2a00
[   33.762063] 1e00: dcf441b0 dc131e1c dcf441b0 dcf44040 dcc61c68 c01a3a40 c04bbab4 c04d3ef1
[   33.770188] 1e20: 00000011 dcc61c00 dcf44040 00000000 dcc61c68 c01a89ac c01a79a4 dcc61c00
[   33.778311] 1e40: c05571e0 0b300018 07d8000a dcec6b60 dcec6b60 00000000 dc131e86 c036b964
[   33.786436] 1e60: 00000800 dc205400 dcec6b60 c02a3c30 dc131e86 c04fa28d dcd873f8 00000000
[   33.794560] 1e80: c0557388 2e335408 47203937 00004269 dc205408 c0557388 c01f3d8c 00000000
[   33.802685] 1ea0: 00000000 c029b51c c029b508 c01f3be4 c0557388 dc205408 dc205408 dc131ec8
[   33.818934] 1ec0: c01f3d8c c01f2994 dc070aa8 dcfe74b4 dc205408 dc205408 dc20543c dcfe4008
[   33.827056] 1ee0: 00000000 c01f3a24 dc205408 dc205410 dcfe4008 c01f322c 00000002 c01f1114
[   33.827056] 1f00: da21ecdc dc20551c da21ed38 dc205400 da21ed38 00000000 00061a80 dc205400
[   33.843305] 1f20: dc205408 00000000 00061a80 c0417c28 c05692b4 dcfe41fc 00000000 c029b898
[   33.851429] 1f40: c04ed29d 0000d555 00000002 dcfe4000 00000000 c029e9e8 dcfe4000 00ff8000
[   33.859554] 1f60: dc131f18 dcfe41fc dcfe4000 c029b144 dcfdef20 dc068a00 00000000 c029ae9c
[   33.859554] 1f80: dc068a05 c0053978 dc068a05 dcfdef20 dc130000 c05692ac c05692b4 dcfdef30
[   33.875802] 1fa0: 00000089 c05692b4 00000000 c0054450 dc03df30 dcfdef20 c0054284 00000013
[   33.883925] 1fc0: 00000000 00000000 00000000 c0057cf0 00000000 00000000 dcfdef20 00000000
[   33.892053] 1fe0: dc131fe0 dc131fe0 dc03df30 c0057c74 c002bc34 c002bc34 ffffffff ffffffff
[   33.900184] [<c00f9880>] (sysfs_create_dir+0x24/0xd4) from [<c01b2600>] (kobject_add_internal+0x134/0x224)
[   33.900184] [<c01b2600>] (kobject_add_internal+0x134/0x224) from [<c01b2a00>] (kobject_add+0x68/0x8c)
[   33.918942] [<c01b2a00>] (kobject_add+0x68/0x8c) from [<c01a3a40>] (blk_register_queue+0x48/0xa8)
[   33.927759] [<c01a3a40>] (blk_register_queue+0x48/0xa8) from [<c01a89ac>] (add_disk+0xe8/0x230)
[   33.936404] [<c01a89ac>] (add_disk+0xe8/0x230) from [<c036b964>] (mmc_add_disk+0x10/0x64)
[   33.936404] [<c036b964>] (mmc_add_disk+0x10/0x64) from [<c02a3c30>] (mmc_blk_probe+0x184/0x1f4)
[   33.953174] [<c02a3c30>] (mmc_blk_probe+0x184/0x1f4) from [<c029b51c>] (mmc_bus_probe+0x14/0x18)
[   33.953174] [<c029b51c>] (mmc_bus_probe+0x14/0x18) from [<c01f3be4>] (driver_probe_device+0x144/0x268)
[   33.961904] [<c01f3be4>] (driver_probe_device+0x144/0x268) from [<c01f2994>] (bus_for_each_drv+0x4c/0x84)
[   33.971152] [<c01f2994>] (bus_for_each_drv+0x4c/0x84) from [<c01f3a24>] (device_attach+0x64/0x90)
[   33.989466] [<c01f3a24>] (device_attach+0x64/0x90) from [<c01f322c>] (bus_probe_device+0x24/0x40)
[   33.998281] [<c01f322c>] (bus_probe_device+0x24/0x40) from [<c01f1114>] (device_add+0x3c8/0x54c)
[   34.007007] [<c01f1114>] (device_add+0x3c8/0x54c) from [<c029b898>] (mmc_add_card+0x110/0x158)
[   34.007007] [<c029b898>] (mmc_add_card+0x110/0x158) from [<c029e9e8>] (mmc_attach_sd+0x160/0x1e0)
[   34.024376] [<c029e9e8>] (mmc_attach_sd+0x160/0x1e0) from [<c029b144>] (mmc_rescan+0x2a8/0x314)
[   34.024376] [<c029b144>] (mmc_rescan+0x2a8/0x314) from [<c0053978>] (process_one_work+0x208/0x360)
[   34.041930] [<c0053978>] (process_one_work+0x208/0x360) from [<c0054450>] (worker_thread+0x1cc/0x2ec)
[   34.051097] [<c0054450>] (worker_thread+0x1cc/0x2ec) from [<c0057cf0>] (kthread+0x7c/0x84)
[   34.051097] [<c0057cf0>] (kthread+0x7c/0x84) from [<c002bc34>] (kernel_thread_exit+0x0/0x8)
[   34.059303] Code: e594300c e3530000 15936018 059f60a8 (e5d65021) 
[   34.076293] ---[ end trace 9dee957cd2bd872b ]---

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
