From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: add quirk about BROKEN_ADMA_ZEROLEN_DESC
Date: Tue, 12 Jul 2011 21:18:37 -0700
Message-ID: <8CFE1B8F-6466-4A1C-983A-42FE0B094F09@marvell.com>
References: <4E1C0637.2090603@samsung.com>
 <000c01cc4113$403a2c00$c0ae8400$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52550 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1GMESp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Jul 2011 00:18:45 -0400
In-Reply-To: <000c01cc4113$403a2c00$c0ae8400$%jun@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>



One use for this is as follows:

Without the QUIRK
imagine there is one SG descriptor passed in and it is properly aligned etc.  The prepare_data function (and friends) will 
change this to 2 ADMA descriptors.  The first descriptor will point to the data / length passed in via the SG descriptor.  The
second descriptor will say END OF CHAIN.

With the Quirk
Only one ADMA descriptor will be used.  It will contain the pointer to the data/length and be marked END OF CHAIN.

The quirk save a needless fetch.

Philip

On Jul 12, 2011, at 9:13 PM, Seungwon Jeon wrote:

> Hi,
> 
> I don't know meaning of QUIRK_BROKEN_ADMA_ZEROLEN_DESC exactly.
> Is there any problem in ADMA descriptors?
> Could you explain for this?
> 
> The following table is for ADMA length field from Host controller spec.
> The maximum data length descriptor line is less than 64KiB.
> Samsung also conforms this.
> ----------------------------------
> Length Field  | Value of Length
> ----------------------------------
> 0000h		| 65536 bytes
> 0001h		| 1 byte
> 0002h		| 2bytes
> ... 		| ...
> FFFFh		| 65535 bytes
> ----------------------------------
> 
> Best regards,
> Seungwon Jeon.
> 
> Jaehoon Chung wrote: 
>> This patch is added the quirk for Samsung SoCs.
>> 
>> Samsung SoCs need to set QUIRK_BROKEN_ADMA_ZEROLEN_DESC.
>> (If ADMA operation is more than 65535, maybe set by zero.)
>> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> drivers/mmc/host/sdhci-s3c.c |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 460ffaf..03da44a 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -502,6 +502,9 @@ static int __devinit sdhci_s3c_probe(struct
>> platform_device *pdev)
>> 	/* This host supports the Auto CMD12 */
>> 	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>> 
>> +	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
>> +	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
>> +
>> 	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>> 	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>> 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

