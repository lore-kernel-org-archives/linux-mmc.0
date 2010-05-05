From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH 1/3] s3c6410: Add new quirk in sdhci driver and update
 ADMA descriptor build.
Date: Wed, 05 May 2010 17:06:49 +0200
Message-ID: <4BE18989.2070909@gmail.com>
References: <cover.1272966142.git.mcuelenaere@gmail.com> <4BDFEC3A.9060501@gmail.com> <20100505145913.GI26401@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:55970 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab0EEPGx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2010 11:06:53 -0400
In-Reply-To: <20100505145913.GI26401@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-samsung-soc@vger.kernel.org, pierre@ossman.eu, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, sdhci-devel@lists.ossman.eu, thomas.ab@samsung.com

Op 05-05-10 16:59, Ben Dooks schreef:
> On Tue, May 04, 2010 at 11:43:22AM +0200, Maurus Cuelenaere wrote:
>
> The 'From:' line seems to have been lost?
>   

Hmm that's odd, I'm sure it was in the patch though..
Perhaps Thunderbird/Gmail stripped it while sending..

To be clear: the original author of this patch (and PATCH 2/3) is
Thomas Abraham <thomas.ab@samsung.com>, not me.
I wrote PATCH 3/3.

>> The s3c6410 sdhci controller does not support the 'End' attribute and
>> NOP attribute in the same 8-Byte ADMA descriptor. This patch adds a
>> new quirk to identify sdhci host contollers with such behaviour.
>> In addition to this, for controllers using the new quirk, the last
>> entry in the ADMA descritor table is marked with the 'End' attribute
>> (instead of using a NOP descriptor with 'End' attribute).
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Acked-by: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   20 +++++++++++++++-----
>>  drivers/mmc/host/sdhci.h |    2 ++
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 9d4fdfa..db5d566 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -496,12 +496,22 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
>>  		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
>>  	}
>>  
>> -	/*
>> -	 * Add a terminating entry.
>> -	 */
>> +	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
>> +		/*
>> +		* Mark the last descriptor as the terminating descriptor
>> +		*/
>> +		if (desc != host->adma_desc) {
>> +			desc -= 8;
>> +			desc[0] |= 0x2; /* end */
>> +		}
>> +	} else {
>> +		/*
>> +		* Add a terminating entry.
>> +		*/
>>  
>> -	/* nop, end, valid */
>> -	sdhci_set_adma_desc(desc, 0, 0, 0x3);
>> +		/* nop, end, valid */
>> +		sdhci_set_adma_desc(desc, 0, 0, 0x3);
>> +	}
>>  
>>  	/*
>>  	 * Resync align buffer as we might have changed it.
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 842f46f..7ba0006 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -236,6 +236,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
>>  /* Controller uses SDCLK instead of TMCLK for data timeouts */
>>  #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
>> +/* Controller cannot support End Attribute in NOP ADMA descriptor */
>> +#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<25)
>>  
>>  	int			irq;		/* Device IRQ */
>>  	void __iomem *		ioaddr;		/* Mapped address */
>> -- 
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>   


-- 
Maurus Cuelenaere

