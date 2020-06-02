Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F5C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF2C20757
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBNQk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:16:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:63334 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgFBNQj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jun 2020 09:16:39 -0400
IronPort-SDR: HDxTSHXPcMFPXFKYLCTE7Ik8H1gdfo1yvS0bGBqiGWy+8Y1Iq2sL9hI4ivqNqdl2KqnBxT3jHQ
 Wy2uzPJjIzYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 06:16:39 -0700
IronPort-SDR: 8TTdbBZeMQqVC/ylkl2M5O0ARGh3ki3G0YsuzCncdcsFFjdm50X7xagw7PWVsqUCfd23Xr3KU1
 VLExTbNj1LLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="444690043"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2020 06:16:37 -0700
Subject: Re: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4be034bd-c11d-4f8b-153d-f771c1ea71e7@intel.com>
Date:   Tue, 2 Jun 2020 16:16:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/06/20 12:20 pm, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c     | 3 +--
>  drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index fd76aa672e02..d14997f9cbf9 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -271,8 +271,7 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>  {
>  	int ret;
>  
> -	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
> -				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
>  	if (ret < 0) {
>  		pr_warn("%s: enable PCI MSI failed, error=%d\n",
>  		       mmc_hostname(slot->host->mmc), ret);
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa8105087d68..498c51207bfb 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -470,8 +470,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  		return;
>  	}
>  
> -	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
> -				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
>  	if (ret < 0) {
>  		pr_err("%s: enable PCI MSI failed, err=%d\n",
>  		       mmc_hostname(host->mmc), ret);
> 

