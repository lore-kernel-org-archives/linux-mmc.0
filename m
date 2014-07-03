From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: One bug of SDHCI driver
Date: Thu, 03 Jul 2014 23:47:47 +0800
Message-ID: <53B57B23.4020607@linux.intel.com>
References: <53B249A4.2040404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54960 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbaGCPrv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Jul 2014 11:47:51 -0400
In-Reply-To: <53B249A4.2040404@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org


Hi, all

The statement "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" is added in "sdhci_add_host" function in host/sdhci.c file. In some cases, this will make  "host->sdio_irq_thread" a NULL pointer in "mmc_sdio_resume" functon of core/sdio.c file and lead to resume failure. Could you please give me some advice how to fix this bug?



Thanks,
Zhonghui





