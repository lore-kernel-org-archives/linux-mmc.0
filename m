From: wwang <wei_wang@realsil.com.cn>
Subject: [drivers/mmc]Issue on DMA out of SW-IOMMU space
Date: Thu, 23 Aug 2012 09:45:23 +0800
Message-ID: <50358B33.2030603@realsil.com.cn>
References: <cover.1345516106.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:40741 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab2HWBpy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 21:45:54 -0400
In-Reply-To: <cover.1345516106.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>

Hi all:

Several days ago I sent out a series of patches to support Realtek
SD/MMC reader. Boris helped to give it a test using his Thinkpad x121e,
with a built-in Realtek card reader named rts5209. (Hi, Thank you, Boris
.. ) And he reported that some error messages, as below shows, would
arise when formating a 16G SD UHS-I card using mkfs.ext3.

[ 286.244866] mmc0: new ultra high speed SDR50 SDHC card at address e624
[ 286.277199] mmcblk0: mmc0:e624 SU16G 14.8 GiB
[ 286.318163] mmcblk0:
[ 363.754647] mmcblk0: p1
[ 379.545510] DMA: Out of SW-IOMMU space for 438272 bytes at device
0000:03:00.0
[ 389.578514] DMA: Out of SW-IOMMU space for 380928 bytes at device
0000:03:00.0
[ 399.590953] DMA: Out of SW-IOMMU space for 524288 bytes at device
0000:03:00.0
[ 409.590698] DMA: Out of SW-IOMMU space for 380928 bytes at device
0000:03:00.0
[ 419.589054] DMA: Out of SW-IOMMU space for 380928 bytes at device
0000:03:00.0

That's to say, in some situation dma_map_sg would fail when transferring
massive data.
By adding more debug message I found some facts:
1. In Thinkpad x121e, the transfer size in one transfer is often 512KB.
(But in my notebook, the largest transfer size I found is 64KB);
2. When dma_map_sg succeeds, the largest sg size in the sglist will not
be larger than 256KB;
3. When dma_map_sg fails, the sg number of the sglist is always 2, and
the total transfer size is circa 512KB. So I guess that the largest sg
size may be larger than 256KB.

Based on the above facts and guess, I asked Boris to help to change
mmc->max_seg_size from 512KB to 64KB in Realtek SD/MMC host driver, and
everything is OK.

(Hi Boris, you have also tested 256KB later, and the result is still OK,
right ?)

So my question comes out.
>From our experiment, it seems that mmc host driver must set a proper
value to max_seg_size at first. But I really don't think it's the host
driver's responsibility to guess/inquiry the max DMA segment size before
declaring it.
The host driver is all along passive to response the request from the
upper layer. If the segment is too large to handle, that buffer should
be divided into more smaller pieces at first in the upper layer and then
pass on to the lower layer, which is our host driver in this case. And I
didn't find any host driver in drivers/mmc/host to inquiry the max DMA
segment size that this platform can afford before declaring their
max_seg_size.

Maybe I missed something , but I still can't find the answer for now. So
please help :-)

BR,
wwang

