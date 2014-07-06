From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: One bug of SDHCI driver
Date: Sun, 06 Jul 2014 23:19:07 +0800
Message-ID: <53B968EB.60401@linux.intel.com>
References: <53B249A4.2040404@linux.intel.com> <53B57B23.4020607@linux.intel.com> <53B61403.7040602@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18459 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaGFPTO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Jul 2014 11:19:14 -0400
In-Reply-To: <53B61403.7040602@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org


Yes, "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" of "sdhci_add_host" function in host/sdhci.c file make oops.

"sdio_card_irq_get" function in core/sdio_irq.c file:
if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {  /* the condition is false */
            atomic_set(&host->sdio_irq_thread_abort, 0);
            host->sdio_irq_thread =                                               
                kthread_run(sdio_irq_thread, host,
                        "ksdioirqd/%s", mmc_hostname(host));


This will make  "host->sdio_irq_thread" a NULL pointer in "mmc_sdio_resume" functon of core/sdio.c file.



Thanks,
Zhonghui



On 2014/7/4 10:40, Jaehoon Chung wrote:
> Hi,
>
> just use the MMC_CAP2_SDIO_IRQ_NOTHREAD?
>
> if (!err && host->sdio_irq && !(host->quirks & MMC_CAP2_SDIO_IRQ_NOTHREAD))
> 	wake_up_process(host->sdio_irq_thread);
>
> I didn't test this..but i believe that it will be fixed.
>
> Best Regards,
> Jaehoon Chung
>
> On 07/04/2014 12:47 AM, Fu, Zhonghui wrote:
>> Hi, all
>>
>> The statement "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" is added in "sdhci_add_host" function in host/sdhci.c file. In some cases, this will make  "host->sdio_irq_thread" a NULL pointer in "mmc_sdio_resume" functon of core/sdio.c file and lead to resume failure. Could you please give me some advice how to fix this bug?
>>
>>
>>
>> Thanks,
>> Zhonghui
>>
>>
>>
>>
>>
>>

