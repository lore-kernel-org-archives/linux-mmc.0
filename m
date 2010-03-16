From: Philip Rakity <prakity@marvell.com>
Subject: Re: Bug in mmc.c == stops eMMC toshiba from working - sector check
 not good (REPOST)  (PATCH)
Date: Tue, 16 Mar 2010 13:25:42 -0700
Message-ID: <A62B1F69-6787-4BB8-B629-929D3B7B1A70@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:34213 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0CPUZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Mar 2010 16:25:47 -0400
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by dakia2.marvell.com with ESMTP id bC0o7ReEPaquzEzL for <linux-mmc@vger.kernel.org>; Tue, 16 Mar 2010 13:25:46 -0700 (PDT)
Received: from MSI-MTA.marvell.com (msi-mta.marvell.com [10.68.76.91])
	by maili.marvell.com (Postfix) with ESMTP id 9DB7C88A63
	for <linux-mmc@vger.kernel.org>; Tue, 16 Mar 2010 13:25:46 -0700 (PDT)
In-Reply-To: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>


On Mar 11, 2010, at 9:17 PM, Philip Rakity wrote:

> MMC 4.4 Spec JEDEC Standard No. 84-A44 says CMD1 response from card
> has bit 30 set if card is high capacity.  (page 111 - Section 8.1)
> 
> Toshiba flash <= 2GB has EXT_CSD sectors but does not support
> High Capacity but because of bad test -- card was put into sector mode
> causing failure.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> 
> diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/mmc/core/mmc.c
> --- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -0800
> +++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-11 14:15:03.000000000 -0800
> @@ -221,8 +221,6 @@
> 			ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
> 			ext_csd[EXT_CSD_SEC_CNT + 2] << 16 |
> 			ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
> -		if (card->ext_csd.sectors)
> -			mmc_card_set_blockaddr(card);
> 	}
> 
> 	switch (ext_csd[EXT_CSD_CARD_TYPE]) {
> @@ -306,6 +304,7 @@
> 	int err;
> 	u32 cid[4];
> 	unsigned int max_dtr;
> +	u32 rocr;
> 
> 	BUG_ON(!host);
> 	WARN_ON(!host->claimed);
> @@ -319,7 +318,7 @@
> 	mmc_go_idle(host);
> 
> 	/* The extra bit indicates that we support high capacity */
> -	err = mmc_send_op_cond(host, ocr | (1 << 30), NULL);
> +	err = mmc_send_op_cond(host, ocr | MMC_CARD_SECTOR_ADDR, &rocr);
> 	if (err)
> 		goto err;
> 
> @@ -407,6 +406,9 @@
> 		err = mmc_read_ext_csd(card);
> 		if (err)
> 			goto free_card;
> +
> +		if(rocr & MMC_CARD_SECTOR_ADDR)
> +		  mmc_card_set_blockaddr(card);
> 	}
> 
> 	/*
> diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include/linux/mmc/mmc.h
> --- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0800
> +++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-11 13:47:00.000000000 -0800
> @@ -202,6 +202,7 @@
>  * OCR bits are mostly in host.h
>  */
> #define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
> +#define MMC_CARD_SECTOR_ADDR	0x40000000	/* Card supports sectors */
> 
> /*
>  * Card Command Classes (CCC)
> <eMMCHighCapacity.patch>

