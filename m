From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: One bug of SDHCI driver
Date: Fri, 04 Jul 2014 11:40:03 +0900
Message-ID: <53B61403.7040602@samsung.com>
References: <53B249A4.2040404@linux.intel.com>
 <53B57B23.4020607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23725 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaGDCkG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jul 2014 22:40:06 -0400
In-reply-to: <53B57B23.4020607@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org

Hi,

just use the MMC_CAP2_SDIO_IRQ_NOTHREAD?

if (!err && host->sdio_irq && !(host->quirks & MMC_CAP2_SDIO_IRQ_NOTHREAD))
	wake_up_process(host->sdio_irq_thread);

I didn't test this..but i believe that it will be fixed.

Best Regards,
Jaehoon Chung

On 07/04/2014 12:47 AM, Fu, Zhonghui wrote:
> 
> Hi, all
> 
> The statement "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" is added in "sdhci_add_host" function in host/sdhci.c file. In some cases, this will make  "host->sdio_irq_thread" a NULL pointer in "mmc_sdio_resume" functon of core/sdio.c file and lead to resume failure. Could you please give me some advice how to fix this bug?
> 
> 
> 
> Thanks,
> Zhonghui
> 
> 
> 
> 
> 
> 

