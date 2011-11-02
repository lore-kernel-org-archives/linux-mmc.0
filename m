From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: move suspend/resume hooks to dev_pm_ops
Date: Wed, 02 Nov 2011 12:09:12 +0200
Message-ID: <4EB116C8.3060207@intel.com>
References: <1320150845-4185-1-git-send-email-manuel.lauss@googlemail.com> <4EB11137.4090404@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab1KBKJO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Nov 2011 06:09:14 -0400
In-Reply-To: <4EB11137.4090404@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 02/11/11 11:45, Adrian Hunter wrote:
> On 01/11/11 14:34, Manuel Lauss wrote:
>> Move suspend/resume/freeze/thaw hooks from struct pci_driver to dev_pm_ops,
>> mainly to shut up the driver cores' complaints about this driver using
>> both new and legacy PM methods.
> 
> Thanks for picking up on this


Also use to_pci_dev(dev) instead of container_of(dev, struct pci_dev, dev)

> 
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> I've only tested suspend to ram, but it works.
>>
>>  drivers/mmc/host/sdhci-pci.c |   24 ++++++++++++++++++++----
>>  1 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
>> index d833d9c..53bfbe7 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -993,7 +993,7 @@ static struct sdhci_ops sdhci_pci_ops = {
>>  
>>  #ifdef CONFIG_PM
>>  
>> -static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>> +static int sdhci_pci_do_suspend(struct pci_dev *pdev, pm_message_t state)
>>  {
>>  	struct sdhci_pci_chip *chip;
>>  	struct sdhci_pci_slot *slot;
>> @@ -1050,8 +1050,9 @@ static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>>  	return 0;
>>  }
>>  
>> -static int sdhci_pci_resume(struct pci_dev *pdev)
>> +static int sdhci_pci_resume(struct device *dev)
>>  {
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>>  	struct sdhci_pci_chip *chip;
>>  	struct sdhci_pci_slot *slot;
>>  	int i, ret;
>> @@ -1085,9 +1086,22 @@ static int sdhci_pci_resume(struct pci_dev *pdev)
>>  	return 0;
>>  }
>>  
>> +static int sdhci_pci_suspend(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	return sdhci_pci_do_suspend(pdev, PMSG_SUSPEND);
> 
> We need to get rid of state entirely.  Unfortunately that means
> changing sdhci_suspend_host() and all callers
> 
>> +}
>> +
>> +static int sdhci_pci_freeze(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	return sdhci_pci_do_suspend(pdev, PMSG_FREEZE);
>> +}
>> +
>>  #else /* CONFIG_PM */
>>  
>>  #define sdhci_pci_suspend NULL
>> +#define sdhci_pci_freeze NULL
>>  #define sdhci_pci_resume NULL
>>  
>>  #endif /* CONFIG_PM */
>> @@ -1176,6 +1190,10 @@ static int sdhci_pci_runtime_idle(struct device *dev)
>>  #endif
>>  
>>  static const struct dev_pm_ops sdhci_pci_pm_ops = {
>> +	.suspend = sdhci_pci_suspend,
>> +	.freeze = sdhci_pci_freeze,
>> +	.resume = sdhci_pci_resume,
>> +	.thaw = sdhci_pci_resume,
> 
> freeze and thaw are not needed
> 
>>  	.runtime_suspend = sdhci_pci_runtime_suspend,
>>  	.runtime_resume = sdhci_pci_runtime_resume,
>>  	.runtime_idle = sdhci_pci_runtime_idle,
>> @@ -1428,8 +1446,6 @@ static struct pci_driver sdhci_driver = {
>>  	.id_table =	pci_ids,
>>  	.probe =	sdhci_pci_probe,
>>  	.remove =	__devexit_p(sdhci_pci_remove),
>> -	.suspend =	sdhci_pci_suspend,
>> -	.resume	=	sdhci_pci_resume,
>>  	.driver =	{
>>  		.pm =   &sdhci_pci_pm_ops
>>  	},
> 
> 

