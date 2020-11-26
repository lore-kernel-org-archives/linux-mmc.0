Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F3C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D63520857
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgKZIPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:15:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:54185 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgKZIPB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:15:01 -0500
IronPort-SDR: o73TE2EC9GsrGxmSwP43h4r04R/Aio1KUS6l1x7jURtl8CT7OoiEoOmTqhdi+BfIfozznZTMjo
 Fz3rBlWa/hpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="171474067"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="171474067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:15:01 -0800
IronPort-SDR: GT+jV+6JhxKeFSmlKrsBn6C4JcsItW6B4g5fgGn0cw9Gud+1a99YgD1DichrH3SosrivxQU61G
 ggQYIjdtPqIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362720839"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:14:59 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 08/27] mmc: sdhci: add a kernel configuration for
 enabling UHS-II support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-9-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <98a9d355-80fe-ad48-e5c4-552e88e1c499@intel.com>
Date:   Thu, 26 Nov 2020 10:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-9-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.

This patch needs to be combined with a patch that actually uses the config.

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 31481c9fcc2e..5ca9ac03db40 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>  
>  	  This is the case for the Nintendo Wii SDHCI.
>  
> +config MMC_SDHCI_UHS2
> +	tristate "UHS2 support on SDHCI controller"
> +	depends on MMC_SDHCI
> +	help
> +	  This option is selected by SDHCI controller drivers that want to
> +	  support UHS2-capable devices.
> +
> +	  If you have a controller with this feature, say Y or M here.
> +
>  config MMC_SDHCI_PCI
>  	tristate "SDHCI support on PCI bus"
>  	depends on MMC_SDHCI && PCI
> 

