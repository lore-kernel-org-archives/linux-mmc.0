From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: Packed commands amount limitation
Date: Mon, 13 May 2013 21:09:07 +0900
Message-ID: <003c01ce4fd2$ab91ab20$02b50160$%jun@samsung.com>
References: <4A8F1406B5725C4A80D5792137FCE51B268B5D71@MILMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54743 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab3EMMJJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 08:09:09 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMQ00J66KESJ1H0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 13 May 2013 21:09:08 +0900 (KST)
In-reply-to: <4A8F1406B5725C4A80D5792137FCE51B268B5D71@MILMBXIP01.sdcorp.global.sandisk.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ilan Smith' <Ilan.Smith@sandisk.com>, linux-mmc@vger.kernel.org
Cc: 'Arnd Bergmann' <arnd@arndb.de>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Alex Lemberg' <Alex.Lemberg@sandisk.com>

On Monday, May 13, 2013, Ilan Smith wrote:
> Hi,
> 
> In card/block.c:mmc_blk_prep_packed_list(), there is generic logic for determining the maximum number
> of blocks that can be sent in a single transaction:
> 
>         max_blk_count = min(card->host->max_blk_count,
>                             card->host->max_req_size >> 9);
> 
> This value is used to limit the total size of accumulated packed commands in a single transaction.
> Running on the Samsung Arndale platform (Exynos5), it evaluates to 256 (128K) or 512 (256K) depending
> on whether CONFIG_MMC_DW_IDMAC is set or not (respectively), while
> ext_csd[MAX_PACKED_WRITES]==ext_csd[MAX_PACKED_READS]=63, which is also the spec limit (JEDEC 4.51).
> This value results in very little packing activity, and if any occurs, it consists of very few
> requests (usually around 5) of relatively small sizes (probably random writes since sequential write
> requests within these size constraints would no doubt be merged to a single request). I would expect
> to see a limitation of 512K * 63 (or close to that), that is: a max_blk_count of ~64512.
> 
> I suspect that much larger sizes can be transferred resulting in increased utilization of packed
> commands and significant enhancement of overall performance.
> 
> I'd appreciate any insights on the matter.
Host side should be configured to increase the maximum number of blocks.

Thanks,
Seungwon Jeon
> 
> Thanks,
>  - Ilan
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

