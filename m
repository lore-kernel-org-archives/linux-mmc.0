Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEFC33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144F52077B
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgAOMGs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:06:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:64416 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOMGs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 07:06:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 04:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="397865696"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 04:06:44 -0800
Subject: Re: [PATCH v4 07/11] mmc: sdhci-omap: Disable data timeout interrupt
 during erase
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, tony@atomide.com
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-8-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ebec95f9-006f-2a13-05df-8b473e121d31@intel.com>
Date:   Wed, 15 Jan 2020 14:05:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106110133.13791-8-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/01/20 1:01 pm, Faiz Abbas wrote:
> Disable data timeout interrupt during an erase operation
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 84d85aa743da..1f05c8e98d62 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -827,6 +828,15 @@ static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
>  	return intmask;
>  }
>  
> +static void sdhci_omap_set_timeout(struct sdhci_host *host,
> +				   struct mmc_command *cmd)
> +{
> +	if (cmd->opcode == MMC_ERASE)
> +		sdhci_set_data_timeout_irq(host, false);
> +
> +	__sdhci_set_timeout(host, cmd);
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>  	.set_clock = sdhci_omap_set_clock,
>  	.set_power = sdhci_omap_set_power,
> @@ -838,6 +848,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>  	.reset = sdhci_omap_reset,
>  	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
>  	.irq = sdhci_omap_irq,
> +	.set_timeout = sdhci_omap_set_timeout,
>  };
>  
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> 

