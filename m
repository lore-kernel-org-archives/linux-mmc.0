From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] mmc: sdhci: clear interrupt when retune interrupt
 received
Date: Fri, 9 Jun 2017 08:45:47 -0700
Message-ID: <e43d517d-2a73-e619-eba8-f652da15ccd5@boundarydevices.com>
References: <1496947916-15785-1-git-send-email-troy.kisky@boundarydevices.com>
 <9b1a2764-e348-b032-a61b-e2c09286aa0a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36800 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdFIPpz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 11:45:55 -0400
Received: by mail-oi0-f53.google.com with SMTP id k145so23600740oih.3
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 08:45:49 -0700 (PDT)
In-Reply-To: <9b1a2764-e348-b032-a61b-e2c09286aa0a@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, aisheng.dong@nxp.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, fabio.estevam@nxp.com, gary.bisson@boundarydevices.com

On 6/9/2017 5:46 AM, Adrian Hunter wrote:
> On 08/06/17 21:51, Troy Kisky wrote:
>> This lets the loop exit before max_loops reaches 0.
> 
> Needs more explanation.
> 
>>
>> Fixes: f37b20ebc4bc ("mmc: sdhci: add standard hw auto retuning support")
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ecd0d43..e104194 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2687,7 +2687,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>  
>>  		/* Clear selected interrupts. */
>>  		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
>> -				  SDHCI_INT_BUS_POWER);
>> +				  SDHCI_INT_BUS_POWER | SDHCI_INT_RETUNE);
> 
> SDHCI_INT_RETUNE is defined to be read-only so why write to it.


SDHCI_INT_RETUNE is bit 12
host/sdhci.h:#define  SDHCI_INT_RETUNE  0x00001000

Which at least from i.mx6/i.mx7 reference manuals, is a write 1 to clear bit(marked as w1c).



> 
>>  		sdhci_writel(host, mask, SDHCI_INT_STATUS);
>>  
>>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
>>
> 
> 

