From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3] mmc: sdhci-pci: Fix BYT sd card getting stuck in runtime
 suspend
Date: Mon, 20 Jan 2014 08:18:23 +0200
Message-ID: <52DCBFAF.9060001@intel.com>
References: <1386764492-26444-1-git-send-email-adrian.hunter@intel.com> <52D39684.2020608@intel.com> <52D39A7C.4070002@intel.com> <52DCBF06.1000202@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20009 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbaATGQ4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jan 2014 01:16:56 -0500
In-Reply-To: <52DCBF06.1000202@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

+ chris@printf.net

On 20/01/14 08:15, Adrian Hunter wrote:
> Ping?
> 
> On 13/01/14 09:49, Adrian Hunter wrote:
>> A host controller for a SD card may need a GPIO
>> for card detect in order to wake up from runtime
>> suspend when a card is inserted.  If that GPIO is
>> not configured, then the host controller will not
>> wake up.  Fix that for the affected devices by not
>> enabling runtime PM unless the GPIO is successfully
>> set up.
>>
>> This affects BYT sd card host controller which had
>> runtime PM enabled from v3.11.  For completeness,
>> the MFD sd card host controller is flagged also.
>>
>> The original patch before rebasing (see link below)
>> was tested on v3.11.10 and v3.12.4 although the
>> patch applied with some offsets and fuzz.  The
>> original patch is here:
>>
>>     http://marc.info/?l=linux-mmc&m=138676702327057) was tested on v3.11.10 and v3.12.4
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>> V3: Update comments to reflect that the original patch
>> applies to stable trees whereas the rebased patch does
>> not.
>>
>> V2: Rebased
>>
>>  drivers/mmc/host/sdhci-pci.c | 10 ++++++++++
>>  drivers/mmc/host/sdhci-pci.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
>> index c1a7f31..d520366 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -225,6 +225,7 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
>>  static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
>>  	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>>  	.allow_runtime_pm = true,
>> +	.own_cd_for_runtime_pm = true,
>>  };
>>  
>>  static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
>> @@ -289,6 +290,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>>  	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
>>  	.allow_runtime_pm = true,
>> +	.own_cd_for_runtime_pm = true,
>>  };
>>  
>>  /* Define Host controllers for Intel Merrifield platform */
>> @@ -1370,6 +1372,14 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>  
>>  	sdhci_pci_add_own_cd(slot);
>>  
>> +	/*
>> +	 * Check if the chip needs a separate GPIO for card detect to wake up
>> +	 * from runtime suspend.  If it is not there, don't allow runtime PM.
>> +	 * Note sdhci_pci_add_own_cd() sets slot->cd_gpio to -EINVAL on failure.
>> +	 */
>> +	if (chip->fixes->own_cd_for_runtime_pm && !gpio_is_valid(slot->cd_gpio))
>> +		chip->allow_runtime_pm = false;
>> +
>>  	return slot;
>>  
>>  remove:
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>> index 0347804..6d71871 100644
>> --- a/drivers/mmc/host/sdhci-pci.h
>> +++ b/drivers/mmc/host/sdhci-pci.h
>> @@ -39,6 +39,7 @@ struct sdhci_pci_fixes {
>>  	unsigned int		quirks;
>>  	unsigned int		quirks2;
>>  	bool			allow_runtime_pm;
>> +	bool			own_cd_for_runtime_pm;
>>  
>>  	int			(*probe) (struct sdhci_pci_chip *);
>>  
>>
> 
> 
> 

