From: Stephen Warren <swarren@nvidia.com>
Subject: Dynamic MMC device naming vs. bootloaders
Date: Mon, 4 Apr 2011 10:39:49 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6448 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab1DDRjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 13:39:32 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris et. al.,

I'm working on an ARM system that contains at least two MMC/SD devices;
specifically the board has an internal MMC device, and an SD card slot,
although the SoC has four MMC/SD hosts IIRC.

The kernel's naming of these devices is dynamic. If the SD card is not
plugged in, the internal MMC is always known as mmcblock0. If the SD card
is plugged in too, sometimes the internal MMC is mmcblk0 and sometimes it's
mmcblk1. I assume this is timing related; 2.6.37 usually seemed to name
them "in order", whereas 2.6.38 usually seems to name them "backwards".

This causes problems with the bootloader scripts I'm using, which assumes
that the internal MMC is always device 0 and the SD slot is always device 1,
and hence provides kernel command-line argument root=/dev/mmcblk0p3 or
root=/dev/mmcblk1p3 based on whether it booted from SD or internal MMC (SD
is searched for a valid image first by the bootloader).

This could be solved by naming the kernel MMC devices statically based on
the host controller, rather than dynamically based on the first available
ID when the actual storage is detected. The patch below implements this.

Is this patch conceptually acceptable for the MMC driver? Obviously, a
complete patch would need to also remove the dev_use structure etc.

Another solution might be for the kernel command-line to specify the
filesystem UUID, rather than a device node. However, this entails much more
work for the bootloader. I'm not sure whether U-Boot can do this right now?
And actually, the filesystem images I'm using don't always have a UUID by
dDefault IIRC.

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bfc8a8a..5131b02 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -581,7 +581,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
        struct mmc_blk_data *md;
        int devidx, ret;
 
-       devidx = find_first_zero_bit(dev_use, max_devices);
+       devidx = card->host->index;
        if (devidx >= max_devices)
                return ERR_PTR(-ENOSPC);
        __set_bit(devidx, dev_use);

Thanks for any feedback.

-- 
nvpublic

