Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85892C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 07:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK2H35 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 02:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK2H34 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 02:29:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150C41995;
        Mon, 28 Nov 2022 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669706996; x=1701242996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2pKMbJv7ZgufIhMDCy1EMsEMYkc02alj834eWl8+JI=;
  b=B3CPLzif/IOp1BsUelHxE4Y+FwRkNO6vrZMtKd23cL6hT25vl+rYDz48
   tP9oq8J6Gr7vxMDbYkQU1+A8LK3VYq/S0bZCC6K0c+PZXaC08lmrldds3
   DJsCnUia3vPz98CCYaHnhVRJCBosPLBvNZj8nnLILnSkbgM27itgJt1MF
   LOTGToGsi7ZKdaJ+tU9e553g6GmpaDCECjXs7rdzMGZjCjVNkrdNkmTml
   SCxqVK0NZV43RVxk3SRJfIpVgIiq78rQd65GppiKpEk4vLABPhCTKbgf4
   lt9hAIhXuQL07IZ43HCBglkZrGDjwixjO4l/rw0IxxFhxA+0tyhj45NLl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316177698"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="316177698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 23:29:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972568062"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="972568062"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.177])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 23:29:53 -0800
Message-ID: <1a8c5b33-172d-b72b-f3c9-81a6c15b5d2d@intel.com>
Date:   Tue, 29 Nov 2022 09:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for
 PXA168 V1 controller
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-7-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221128024407.224393-7-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/11/22 04:44, Doug Brown wrote:
> The PXA168 has a documented silicon bug that causes SDIO card IRQs to be
> missed. Implement the first half of the suggested workaround, which
> involves resetting the data port logic and issuing a dummy CMD0 to
> restart the clock.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 4996d72c6d23..0b9b2e4b2153 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -20,6 +20,8 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/mmc.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -43,6 +45,7 @@
>  
>  struct sdhci_pxav2_host {
>  	struct clk *clk_core;
> +	void (*orig_post_req)(struct mmc_host *mmc, struct mmc_request *mrq, int err);
>  };
>  
>  static void pxav2_reset(struct sdhci_host *host, u8 mask)
> @@ -96,6 +99,37 @@ static inline u16 pxav1_readw(struct sdhci_host *host, int reg)
>  	return readw(host->ioaddr + reg);
>  }
>  
> +static void pxav1_post_req(struct mmc_host *mmc, struct mmc_request *mrq, int err)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pxav2_host *pxav2_host;
> +	struct mmc_command dummy_cmd = {};
> +	u16 tmp;
> +
> +	/* If this is an SDIO command, perform errata workaround for silicon bug. */
> +	if (!err && mrq->cmd && !mrq->cmd->error &&
> +	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
> +	    mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
> +		/* Reset data port */
> +		tmp = readw(host->ioaddr + SDHCI_TIMEOUT_CONTROL);
> +		tmp |= 0x400;
> +		writew(tmp, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
> +
> +		/* Clock is now stopped, so restart it by sending a dummy CMD0. */
> +		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
> +
> +		dummy_cmd.opcode = MMC_GO_IDLE_STATE;
> +		dummy_cmd.arg = 0;
> +		dummy_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> +
> +		mmc_wait_for_cmd(host->mmc, &dummy_cmd, 0);

This is not what post_req() is for.  Instead could you use SDHCI
host op ->request_done()?  Also, do you really need to wait for
the dummy CMD0 - perhaps just write SDHCI_ARGUMENT,
SDHCI_TRANSFER_MODE, and SDHCI_COMMAND ?


> +	}
> +
> +	/* Pass onto SDHCI host driver now */
> +	if (pxav2_host->orig_post_req)
> +		pxav2_host->orig_post_req(mmc, mrq, err);
> +}
> +
>  static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
> @@ -252,6 +286,8 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  	if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
>  		host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
>  		host->ops = &pxav1_sdhci_ops;
> +		pxav2_host->orig_post_req = host->mmc_host_ops.post_req;
> +		host->mmc_host_ops.post_req = pxav1_post_req;
>  	} else {
>  		host->ops = &pxav2_sdhci_ops;
>  	}

