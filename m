From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 1/2] mmc: sdhci: export sdhci_execute_tuning()
Date: Thu, 8 Dec 2016 13:53:03 +0200
Message-ID: <5a38edc8-f9dc-ec58-4faa-996967adc43c@intel.com>
References: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com>
 <1480903854-22701-2-git-send-email-yamada.masahiro@socionext.com>
 <1662520f-5605-8991-73b2-f75af5618a52@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16031 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbcLHL6H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 06:58:07 -0500
In-Reply-To: <1662520f-5605-8991-73b2-f75af5618a52@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org

On 08/12/16 13:49, Adrian Hunter wrote:
> On 05/12/16 04:10, Masahiro Yamada wrote:
>> Some SDHCI-compat controllers support not only SD, but also eMMC,
>> but they use different commands for tuning: CMD19 for SD, CMD21 for
>> eMMC.
>>
>> Due to the difference of the underlying mechanism, some controllers
>> (at least, the Cadence IP is the case) provide their own registers
>> for the eMMC tuning.
>>
>> This commit will be useful when we want to override .execute_tuning
>> callback (for eMMC HS200 tuning), but still let it fall back to
>> sdhci_execute_tuning() for SD timing.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Adrian Hunter <adrian.hunter@intel.com>

I mean:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>> ---
>>
>> I want to use this in the next commit.
>> The Cadence IP supports eMMC as well as SD.
>>
>> I want to re-use the sdhci_execute_tuning() for SD timing.
>>
>> On the other hand, Cadence provides its own way for eMMC HS200 tuning;
>> I need to touch some registers that are specific to Cadence's design.
>>
>>
>> Changes in v4:
>>   - export sdhci_execute_tuning() instead of using
>>     execute_execute_tuning()
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>  drivers/mmc/host/sdhci.c | 3 ++-
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 42ef3eb..0c03a89 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1948,7 +1948,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	return 0;
>>  }
>>  
>> -static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  {
>>  	struct sdhci_host *host = mmc_priv(mmc);
>>  	u16 ctrl;
>> @@ -2141,6 +2141,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  	spin_unlock_irqrestore(&host->lock, flags);
>>  	return err;
>>  }
>> +EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>>  
>>  static int sdhci_select_drive_strength(struct mmc_card *card,
>>  				       unsigned int max_dtr, int host_drv,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 9c35776..786eee9 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -689,6 +689,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>> +int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>>  
>>  #ifdef CONFIG_PM
>>  extern int sdhci_suspend_host(struct sdhci_host *host);
>>
> 
> 

