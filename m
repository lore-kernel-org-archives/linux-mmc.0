From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Fri, 11 Nov 2016 14:25:51 +0100
Message-ID: <307509ddddf1fd672a7e749acd9582c1@walle.cc>
References: <1478796456-30549-1-git-send-email-michael@walle.cc>
 <0a5454e6-efa6-744e-4a2d-123a47e7cc40@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([213.133.101.245]:60810 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbcKKNZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2016 08:25:58 -0500
In-Reply-To: <0a5454e6-efa6-744e-4a2d-123a47e7cc40@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, yangbo lu <yangbo.lu@freescale.com>

Am 2016-11-11 14:15, schrieb Adrian Hunter:
> On 10/11/16 18:47, Michael Walle wrote:
>> Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
>> cards in __mmc_switch()") the ESDHC driver is broken:
>>   mmc0: Card stuck in programming state! __mmc_switch
>>   mmc0: error -110 whilst initialising MMC card
>> 
>> Since this commit __mmc_switch() uses ->card_busy(), which is
>> sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
>> PRESENT_STATE register, specifically the DAT0 signal level bit. But 
>> the
>> ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup 
>> is
>> required to make the driver work again.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Could add a Fixes tag here.

ah, right, will do :)

> 
>> ---
>>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c 
>> b/drivers/mmc/host/sdhci-of-esdhc.c
>> index fb71c86..243fee9 100644
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -66,6 +66,18 @@ static u32 esdhc_readl_fixup(struct sdhci_host 
>> *host,
>>  			return ret;
>>  		}
>>  	}
>> +	/*
>> +	 * The DAT[3:0] line signal levels and the CMD line signal level is
>> +	 * not compatible with standard SDHC reegister. Move the 
>> corresponding
> 
> reegister -> register
ok

> 
>> +	 * bits around.
>> +	 */
>> +	if (spec_reg == SDHCI_PRESENT_STATE) {
>> +		ret = value & 0xf8000000;
>> +		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
>> +		ret |= (value << 1) & 0x01000000;
>> +		return ret;
> 
> SDHCI also uses other bits in SDHCI_PRESENT_STATE like 
> SDHCI_CMD_INHIBIT and
> SDHCI_DATA_INHIBIT etc, but this looks like all those bits will be 
> zero.  Is
> that right?

ugh, thanks for spotting that. actually all lower bits should be taken 
from the original value. Therefore the first statement should be
  ret = value & ~0xf8000000;

Will post a v2 soon.

-michael
