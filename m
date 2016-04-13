From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/5] mmc: sdhci: Fix error paths in sdhci_add_host()
Date: Wed, 13 Apr 2016 14:41:29 +0300
Message-ID: <570E3069.5010903@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
 <1460460309-13619-5-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqJf4hNVeYw8wvp3aOp9fLSXMADVrGaBeZFG=QLAR1tZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54196 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbcDMLpP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2016 07:45:15 -0400
In-Reply-To: <CAPDyKFqJf4hNVeYw8wvp3aOp9fLSXMADVrGaBeZFG=QLAR1tZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13/04/16 14:41, Ulf Hansson wrote:
> [...]
> 
>>
>>         pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>>                 mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>> @@ -3331,15 +3337,27 @@ int sdhci_add_host(struct sdhci_host *host)
>>
>>         return 0;
>>
>> +unled:
>>  #ifdef SDHCI_USE_LEDS_CLASS
> 
> Shouldn't this ifdef be removed in the earlier patch?

It gets removed in the next patch.  Is that what you meant?

> 
>> -reset:
>> +       led_classdev_unregister(&host->led);
>> +unirq:
>> +#endif
>>         sdhci_do_reset(host, SDHCI_RESET_ALL);
>>         sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>>         sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>>         free_irq(host->irq, host);
>> -#endif
>>  untasklet:
>>         tasklet_kill(&host->finish_tasklet);
>> +unreg:
>> +       if (!IS_ERR(mmc->supply.vqmmc))
>> +               regulator_disable(mmc->supply.vqmmc);
>> +undma:
>> +       if (host->align_buffer)
>> +               dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
>> +                                 host->adma_table_sz, host->align_buffer,
>> +                                 host->align_addr);
>> +       host->adma_table = NULL;
>> +       host->align_buffer = NULL;
>>
>>         return ret;
>>  }
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

