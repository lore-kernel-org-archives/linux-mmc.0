Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DABC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVRsu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiLVRsq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 12:48:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60C2B24E;
        Thu, 22 Dec 2022 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671731322; x=1703267322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BnC8T4VGuonP76djADZkjYi8kYvrKbib64niYPPMjVE=;
  b=W+SPeXPhOfFaLkGSPiDp5cGSpuTlldtJrKAozZN0+mXNUomH8C7+xEmY
   hqJF68Q+t/NEs+VPwJVgR7x9RwCZq3bObuXNM9Ue6opnXg7+exi5kSikE
   koiFHaXX0YZzbtxVqOLHDyRQq0zb3To7pirqlzQWO/wePubf0E9nX2b9Z
   Roma1v58i1M/pKUER+ewsaKYCxCRPpCyp7lgbG35MrfOYEOHE7uQUxhip
   tWv8WLV7ESgVuqN4/o8/c/E8jC+V4U+zQ07gmI1E7ZS6GM9Ya4TwL3WrB
   aVkT0NSQ+elZqGUTiN1oIEchLVlJz/rdVYj93KgkhoF5ySBemEzajbMjT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="299854195"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="299854195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:48:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="759044799"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="759044799"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.195])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:48:39 -0800
Message-ID: <ba8e615a-d1b5-eb9a-1fc4-d30b0acb0db9@intel.com>
Date:   Thu, 22 Dec 2022 19:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for
 PXA168 V1 controller
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-7-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221202031330.94130-7-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/22 05:13, Doug Brown wrote:
> The PXA168 has a documented silicon bug that causes SDIO card IRQs to be
> missed. Implement the first half of the suggested workaround, which
> involves resetting the data port logic and issuing a dummy CMD0 to
> restart the clock.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 1f0c3028987a..912b2aad9f2e 100644
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
> +	struct mmc_request *sdio_mrq;
>  };
>  
>  static void pxav2_reset(struct sdhci_host *host, u8 mask)
> @@ -93,6 +96,50 @@ static u16 pxav1_readw(struct sdhci_host *host, int reg)
>  	return readw(host->ioaddr + reg);
>  }
>  
> +static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
> +
> +	if (pxav2_host->sdio_mrq && (intmask & SDHCI_INT_CMD_MASK)) {
> +		/* The dummy CMD0 for the SDIO workaround just completed */
> +		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
> +		intmask &= ~SDHCI_INT_CMD_MASK;
> +		mmc_request_done(host->mmc, pxav2_host->sdio_mrq);
> +		pxav2_host->sdio_mrq = NULL;

Pedantically, things should be finished before calling
mmc_request_done() i.e. last 2 line the other way around

		pxav2_host->sdio_mrq = NULL;
		mmc_request_done(host->mmc, pxav2_host->sdio_mrq);

> +	}
> +
> +	return intmask;
> +}
> +
> +static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	u16 tmp;
> +	struct sdhci_pxav2_host *pxav2_host;
> +
> +	/* If this is an SDIO command, perform errata workaround for silicon bug */
> +	if (mrq->cmd && !mrq->cmd->error &&
> +	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
> +	     mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
> +		/* Reset data port */
> +		tmp = readw(host->ioaddr + SDHCI_TIMEOUT_CONTROL);
> +		tmp |= 0x400;
> +		writew(tmp, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
> +
> +		/* Clock is now stopped, so restart it by sending a dummy CMD0 */
> +		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
> +		pxav2_host->sdio_mrq = mrq;
> +		sdhci_writel(host, 0, SDHCI_ARGUMENT);
> +		sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
> +		sdhci_writew(host, SDHCI_MAKE_CMD(MMC_GO_IDLE_STATE, SDHCI_CMD_RESP_NONE),
> +			     SDHCI_COMMAND);
> +
> +		/* Don't finish this request until the dummy CMD0 finishes */
> +		return;
> +	}
> +
> +	mmc_request_done(host->mmc, mrq);
> +}
> +
>  static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
> @@ -117,10 +164,12 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  static const struct sdhci_ops pxav1_sdhci_ops = {
>  	.read_w        = pxav1_readw,
>  	.set_clock     = sdhci_set_clock,
> +	.irq           = pxav1_irq,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_bus_width = pxav2_mmc_set_bus_width,
>  	.reset         = pxav2_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.request_done  = pxav1_request_done,
>  };
>  
>  static const struct sdhci_ops pxav2_sdhci_ops = {

