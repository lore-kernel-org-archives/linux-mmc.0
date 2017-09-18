From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: remove outdated declaration
Date: Mon, 18 Sep 2017 10:04:09 +0300
Message-ID: <03bc3268-d50f-6ba3-09fa-be012474cbe6@intel.com>
References: <20170915181328.31510-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbdIRHKw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Sep 2017 03:10:52 -0400
In-Reply-To: <20170915181328.31510-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

On 15/09/17 21:13, Wolfram Sang wrote:
> The function was removed half a year ago, so this declaration can go,
> too.
> 
> Fixes: 51ced59cc02e0d ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  include/linux/mmc/sdhci-pci-data.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
> index fda15b6d4135d3..618f90d6e1ba1a 100644
> --- a/include/linux/mmc/sdhci-pci-data.h
> +++ b/include/linux/mmc/sdhci-pci-data.h
> @@ -14,7 +14,4 @@ struct sdhci_pci_data {
>  
>  extern struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev,
>  				int slotno);
> -
> -extern int sdhci_pci_spt_drive_strength;
> -
>  #endif
> 

