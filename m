Return-Path: <SRS0=OWc9=4P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31929C4BA24
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B62469D
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 13:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgB0NMC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:12:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:31938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgB0NMC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 Feb 2020 08:12:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 05:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="231834432"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 05:12:00 -0800
Subject: Re: [PATCH] mmc: Replace zero-length array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200226223125.GA20630@embeddedor>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b472b3c0-b6a0-f67f-2628-6688b5e0e7f6@intel.com>
Date:   Thu, 27 Feb 2020 15:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226223125.GA20630@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/02/20 12:31 am, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c    | 2 +-
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  drivers/mmc/host/sdhci-pci.h     | 2 +-
>  drivers/mmc/host/sdhci-pltfm.h   | 2 +-
>  drivers/mmc/host/sdhci.h         | 2 +-
>  drivers/mmc/host/vub300.c        | 2 +-
>  include/linux/mmc/host.h         | 2 +-
>  include/linux/mmc/sdio_func.h    | 2 +-
>  include/uapi/linux/mmc/ioctl.h   | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 9651dca6863e..ea0e4fda3a9e 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -72,7 +72,7 @@ struct sdhci_acpi_host {
>  	const struct sdhci_acpi_slot	*slot;
>  	struct platform_device		*pdev;
>  	bool				use_runtime_pm;
> -	unsigned long			private[0] ____cacheline_aligned;
> +	unsigned long			private[] ____cacheline_aligned;
>  };
>  
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5827d3751b81..9af3fe48d62f 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -67,7 +67,7 @@ struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	bool enhanced_strobe;
>  	unsigned int nr_phy_params;
> -	struct sdhci_cdns_phy_param phy_params[0];
> +	struct sdhci_cdns_phy_param phy_params[];
>  };
>  
>  struct sdhci_cdns_phy_cfg {
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 981bbbe63aff..42ccd123b046 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -163,7 +163,7 @@ struct sdhci_pci_slot {
>  	bool			cd_override_level;
>  
>  	void (*hw_reset)(struct sdhci_host *host);
> -	unsigned long		private[0] ____cacheline_aligned;
> +	unsigned long		private[] ____cacheline_aligned;
>  };
>  
>  struct sdhci_pci_chip {
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 2af445b8c325..6301b81cf573 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -25,7 +25,7 @@ struct sdhci_pltfm_host {
>  	unsigned int clock;
>  	u16 xfer_mode_shadow;
>  
> -	unsigned long private[0] ____cacheline_aligned;
> +	unsigned long private[] ____cacheline_aligned;
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cac2d97782e6..249635692112 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -614,7 +614,7 @@ struct sdhci_host {
>  
>  	u64			data_timeout;
>  
> -	unsigned long private[0] ____cacheline_aligned;
> +	unsigned long private[] ____cacheline_aligned;
>  };
>  
>  struct sdhci_ops {
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 6ced1b7f642f..a5a90d133f1f 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -95,7 +95,7 @@ struct sd_response_header {
>  	u8 port_number;
>  	u8 command_type;
>  	u8 command_index;
> -	u8 command_response[0];
> +	u8 command_response[];
>  } __packed;
>  
>  struct sd_status_header {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 562ed06881b0..2629329ab9f2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -465,7 +465,7 @@ struct mmc_host {
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
>  
> -	unsigned long		private[0] ____cacheline_aligned;
> +	unsigned long		private[] ____cacheline_aligned;
>  };
>  
>  struct device_node;
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index 5a177f7a83c3..fa2aaab5e57a 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -25,7 +25,7 @@ struct sdio_func_tuple {
>  	struct sdio_func_tuple *next;
>  	unsigned char code;
>  	unsigned char size;
> -	unsigned char data[0];
> +	unsigned char data[];
>  };
>  
>  /*
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 00c08120f3ba..98e29e7f54ac 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -57,7 +57,7 @@ struct mmc_ioc_cmd {
>   */
>  struct mmc_ioc_multi_cmd {
>  	__u64 num_of_cmds;
> -	struct mmc_ioc_cmd cmds[0];
> +	struct mmc_ioc_cmd cmds[];
>  };
>  
>  #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> 

