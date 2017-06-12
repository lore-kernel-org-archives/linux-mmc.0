From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: clear interrupt when retune interrupt
 received
Date: Mon, 12 Jun 2017 15:33:50 +0300
Message-ID: <bf88c79a-acde-9780-b90a-b25dc9f9bae2@intel.com>
References: <1496947916-15785-1-git-send-email-troy.kisky@boundarydevices.com>
 <9b1a2764-e348-b032-a61b-e2c09286aa0a@intel.com>
 <e43d517d-2a73-e619-eba8-f652da15ccd5@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdFLMjw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Jun 2017 08:39:52 -0400
In-Reply-To: <e43d517d-2a73-e619-eba8-f652da15ccd5@boundarydevices.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, aisheng.dong@nxp.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, fabio.estevam@nxp.com, gary.bisson@boundarydevices.com

On 09/06/17 18:45, Troy Kisky wrote:
> On 6/9/2017 5:46 AM, Adrian Hunter wrote:
>> On 08/06/17 21:51, Troy Kisky wrote:
>>> This lets the loop exit before max_loops reaches 0.
>>
>> Needs more explanation.
>>
>>>
>>> Fixes: f37b20ebc4bc ("mmc: sdhci: add standard hw auto retuning support")
>>>
>>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index ecd0d43..e104194 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2687,7 +2687,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>>  
>>>  		/* Clear selected interrupts. */
>>>  		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
>>> -				  SDHCI_INT_BUS_POWER);
>>> +				  SDHCI_INT_BUS_POWER | SDHCI_INT_RETUNE);
>>
>> SDHCI_INT_RETUNE is defined to be read-only so why write to it.
> 
> 
> SDHCI_INT_RETUNE is bit 12
> host/sdhci.h:#define  SDHCI_INT_RETUNE  0x00001000
> 
> Which at least from i.mx6/i.mx7 reference manuals, is a write 1 to clear bit(marked as w1c).

So it doesn't work the way it is specified in the SDHCI spec.

It should be harmless to write 1, but you still need to explain how the bit
works on your hardware.  What does "This lets the loop exit before max_loops
reaches 0" mean?

> 
> 
> 
>>
>>>  		sdhci_writel(host, mask, SDHCI_INT_STATUS);
>>>  
>>>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
>>>
>>
>>
> 
> 

