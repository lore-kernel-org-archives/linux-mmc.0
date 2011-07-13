From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: sdhci-s3c: add quirk about BROKEN_ADMA_ZEROLEN_DESC
Date: Wed, 13 Jul 2011 13:13:40 +0900
Message-ID: <000c01cc4113$403a2c00$c0ae8400$%jun@samsung.com>
References: <4E1C0637.2090603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63929 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab1GMENo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 00:13:44 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LO900KNA7QHAQ10@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 13:13:42 +0900 (KST)
Received: from DOTGIHJUN01 (12-23-121-83.csky.net [12.23.121.83])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LO900MYZ7QUN3@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 13:13:42 +0900 (KST)
In-reply-to: <4E1C0637.2090603@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Ben Dooks' <ben-linux@fluff.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>

Hi,

I don't know meaning of QUIRK_BROKEN_ADMA_ZEROLEN_DESC exactly.
Is there any problem in ADMA descriptors?
Could you explain for this?

The following table is for ADMA length field from Host controller spec.
The maximum data length descriptor line is less than 64KiB.
Samsung also conforms this.
----------------------------------
Length Field  | Value of Length
----------------------------------
0000h		| 65536 bytes
0001h		| 1 byte
0002h		| 2bytes
... 		| ...
FFFFh		| 65535 bytes
----------------------------------

Best regards,
Seungwon Jeon.

Jaehoon Chung wrote: 
> This patch is added the quirk for Samsung SoCs.
> 
> Samsung SoCs need to set QUIRK_BROKEN_ADMA_ZEROLEN_DESC.
> (If ADMA operation is more than 65535, maybe set by zero.)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 460ffaf..03da44a 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -502,6 +502,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	/* This host supports the Auto CMD12 */
>  	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> 
> +	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
> +	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
> +
>  	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>  	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

