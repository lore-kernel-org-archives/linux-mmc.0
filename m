From: Jiri Slaby <jslaby@suse.cz>
Subject: [4.0.5] sdhci+swiotlb => Corrupted low memory
Date: Fri, 12 Jun 2015 10:46:41 +0200
Message-ID: <557A9C71.6090700@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35315 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbFLIqp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 04:46:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>

Hi,

today I plugged in an SD card into the laptop's built-in reader on
x86-64 and got "Corrupted low memory" as a result:
Corrupted low memory at ffff880000001000 (1000 phys) = 22b7d67df2f6d1cf
Corrupted low memory at ffff880000001008 (1008 phys) = 63848a5216b7dd95
Corrupted low memory at ffff880000001010 (1010 phys) = 330eb7ddef39e427
Corrupted low memory at ffff880000001018 (1018 phys) = 8017ac7295039bda
Corrupted low memory at ffff880000001020 (1020 phys) = 8ce039eac119074f
Corrupted low memory at ffff880000001028 (1028 phys) = f2de46b94adf3ef4
Corrupted low memory at ffff880000001030 (1030 phys) = d1d3f48600fff7be
Corrupted low memory at ffff880000001038 (1038 phys) = 3f7e796b65efa819
Corrupted low memory at ffff880000001040 (1040 phys) = 79c63b3920597681
Corrupted low memory at ffff880000001048 (1048 phys) = 608c93712487996f
Corrupted low memory at ffff880000001050 (1050 phys) = 1f5354ad4f729cf1
...
Corrupted low memory at ffff88000000fff0 (fff0 phys) = e1e41c03059ba547
Corrupted low memory at ffff88000000fff8 (fff8 phys) = e20f4297ab84fbe


The reader:
02:00.0 System peripheral [0880]: Ricoh Co Ltd MMC/SD Host Controller
[1180:e822] (rev 07)

MMC complained upon insertion (this happens sometimes and can be fixed
by replugging):

mmc0: new high speed SDHC card at address e624
mmcblk0: mmc0:e624 SU16G 14.8 GiB
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0xb00
mmc0: tried to reset card
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 0
mmcblk0: error -84 transferring data, sector 1, nr 7, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 1
mmcblk0: error -84 transferring data, sector 2, nr 6, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 2
mmcblk0: error -84 transferring data, sector 3, nr 5, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 3
mmcblk0: error -84 transferring data, sector 4, nr 4, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 4
mmcblk0: error -84 transferring data, sector 5, nr 3, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 5
mmcblk0: error -84 transferring data, sector 6, nr 2, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 6
mmcblk0: error -84 transferring data, sector 7, nr 1, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 7
Buffer I/O error on dev mmcblk0, logical block 0, async page read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 0
mmcblk0: error -84 transferring data, sector 1, nr 7, cmd response
0x900, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 1
mmcblk0: error -84 transferring data, sector 2, nr 6, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 3, nr 5, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 4, nr 4, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 5, nr 3, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 6, nr 2, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 7, nr 1, cmd response
0x900, card status 0x0
Buffer I/O error on dev mmcblk0, logical block 0, async page read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 1, nr 7, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 2, nr 6, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 3, nr 5, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 4, nr 4, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 5, nr 3, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 6, nr 2, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 7, nr 1, cmd response
0x900, card status 0x0
Buffer I/O error on dev mmcblk0, logical block 0, async page read
ldm_validate_partition_table(): Disk read failed.
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0xb00
mmcblk0: retrying using single block read
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 1, nr 7, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 2, nr 6, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 3, nr 5, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 4, nr 4, cmd response
0x900, card status 0x0
mmcblk0: error -84 transferring data, sector 6, nr 2, cmd response
0x900, card status 0x0
mmc0: tried to reset card
Buffer I/O error on dev mmcblk0, logical block 0, async page read
 mmcblk0: unable to read partition table


Then SWIOTLB complained a lot:
swiotlb_tbl_map_single: 555 callbacks suppressed
sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 65536 bytes)
DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0
sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 65536 bytes)
DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0

This SWIOTLB splat is intermixed with WARNINGs from sdhci:
WARNING: CPU: 0 PID: 8669 at drivers/mmc/host/sdhci.c:857
sdhci_prepare_data+0x8ec/0x900 [sdhci]()

There is a lot of them. Full log of these:
http://www.fi.muni.cz/~xslaby/sklad/panics/sdhci.txt

I checked the DMA mappings in sdhci.c, but they seem to be OK:
                sg_count = dma_map_sg(...);
...
        if (sg_count == 0)
                return -EINVAL;

AND
        host->align_addr = dma_map_single(mmc_dev(host->mmc), ...);
        if (dma_mapping_error(mmc_dev(host->mmc), host->align_addr))
                goto fail;


Any ideas?

thanks,
-- 
js
suse labs
