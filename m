From: Ilan Smith <Ilan.Smith@sandisk.com>
Subject: Packed commands amount limitation
Date: Mon, 13 May 2013 08:09:05 +0000
Message-ID: <4A8F1406B5725C4A80D5792137FCE51B268B5D71@MILMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:22280
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996Ab3EMIJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 May 2013 04:09:10 -0400
Received: from mail95-ch1 (localhost [127.0.0.1])	by mail95-ch1-R.bigfish.com
 (Postfix) with ESMTP id EBDA148021B	for <linux-mmc@vger.kernel.org>; Mon, 13
 May 2013 08:09:08 +0000 (UTC)
Received: from CH1EHSMHS032.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail95-ch1.bigfish.com (Postfix) with ESMTP id 0B5304E0062
	for <linux-mmc@vger.kernel.org>; Mon, 13 May 2013 08:09:07 +0000 (UTC)
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Ilan Smith <Ilan.Smith@sandisk.com>

Hi,

In card/block.c:mmc_blk_prep_packed_list(), there is generic logic for determining the maximum number of blocks that can be sent in a single transaction:

        max_blk_count = min(card->host->max_blk_count,
                            card->host->max_req_size >> 9);

This value is used to limit the total size of accumulated packed commands in a single transaction. Running on the Samsung Arndale platform (Exynos5), it evaluates to 256 (128K) or 512 (256K) depending on whether CONFIG_MMC_DW_IDMAC is set or not (respectively), while ext_csd[MAX_PACKED_WRITES]==ext_csd[MAX_PACKED_READS]=63, which is also the spec limit (JEDEC 4.51). This value results in very little packing activity, and if any occurs, it consists of very few requests (usually around 5) of relatively small sizes (probably random writes since sequential write requests within these size constraints would no doubt be merged to a single request). I would expect to see a limitation of 512K * 63 (or close to that), that is: a max_blk_count of ~64512.

I suspect that much larger sizes can be transferred resulting in increased utilization of packed commands and significant enhancement of overall performance.

I'd appreciate any insights on the matter.

Thanks,
 - Ilan


