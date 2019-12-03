Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A6C43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C43F20803
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLCHxY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:53:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:7665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfLCHxX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 02:53:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 23:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="213334512"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.95]) ([10.237.72.95])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2019 23:53:19 -0800
Subject: Re: [PATCH 3/4] mmc: sdhci: Set ctrl_hs400 value in dts
To:     Jun Nie <jun.nie@linaro.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-4-jun.nie@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <525d4414-e55c-c9a4-ad9c-edca908727c4@intel.com>
Date:   Tue, 3 Dec 2019 09:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202144104.5069-4-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/19 4:41 pm, Jun Nie wrote:
> Because ctrl_hs400 value is non-standard, add support to set it
> in dts.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 6 +++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a654f0aeb438..d8a6c1c91448 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1899,7 +1899,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		 (timing == MMC_TIMING_MMC_DDR52))
>  		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>  	else if (timing == MMC_TIMING_MMC_HS400)
> -		ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
> +		ctrl_2 |= host->sdhci_ctrl_hs400; /* Non-standard */

Let's limit this to the correct bits i.e.

		ctrl_2 |= host->sdhci_ctrl_hs400 & 7; /* Non-standard */

>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
> @@ -3635,6 +3635,13 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>  	of_property_read_u64(mmc_dev(host->mmc)->of_node,
>  			     "sdhci-caps", &dt_caps);

Would you mind changing these APIs from 'of' to 'dev' properties?
Needs to be a separate patch.

>  
> +	if (of_property_read_u32(mmc_dev(host->mmc)->of_node,
> +				 "sdhci-ctrl-hs400", &host->sdhci_ctrl_hs400))

And then use a 'dev' property API here.

> +		host->sdhci_ctrl_hs400 = SDHCI_CTRL_HS400;
> +	else
> +		WARN_ON(host->sdhci_ctrl_hs400 > 7
> +			|| host->sdhci_ctrl_hs400 < 5);

Please remove this warning.

> +
>  	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0e6f97eaa796..cac4d819f62c 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -184,7 +184,8 @@
>  #define   SDHCI_CTRL_UHS_SDR50		0x0002
>  #define   SDHCI_CTRL_UHS_SDR104		0x0003
>  #define   SDHCI_CTRL_UHS_DDR50		0x0004
> -#define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
> +/* SDHCI_CTRL_HS400 is non-standard value, can change it in dts */
> +#define   SDHCI_CTRL_HS400		0x0005
>  #define  SDHCI_CTRL_VDD_180		0x0008
>  #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
>  #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
> @@ -605,6 +606,9 @@ struct sdhci_host {
>  
>  	u64			data_timeout;
>  
> +	/* SDHCI_CTRL_HS400 value */
> +	u32			sdhci_ctrl_hs400;
> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> 

