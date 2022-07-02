Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAE3C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  2 Jul 2022 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGBQ7B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 2 Jul 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBQ7B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jul 2022 12:59:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22559DFE6
        for <linux-mmc@vger.kernel.org>; Sat,  2 Jul 2022 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656781140; x=1688317140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0UEa1lR81GWfzji2zM0TZO4N665Z5tHFW43BYJVTeIQ=;
  b=bPRaEeISLFNATLpNDL52h1qfnKdiYDlRvYL/rWoh8WBAl6IShk3G/req
   1YmEWuCVtAJ07kdxwLzQeoI8kSNlJHQThz8X5jdi9pdzcrVFVzNH/LgCu
   vcn4zBaAQF2zvQ4jdn+Qs2IhtjhGbVPYuloxXK/jI5jOKQe/+N8CKhJCW
   IyBRXehR4+Q+TJDgXYmOkXaN2sl2BbfUaOu/vC0eKVoDIG9JEKgsliUgG
   tkR4D2mSyFxqMVSr5qPVr/U8xjm1Q8d0UezouMysTah/pWoxC1fuB7Fv2
   X3dH3cu7+NiclO4l6GVG9kcIBdvsfKRaWJ8lGO1nrj3H3oC4jCbT+zwxP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="280406293"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="280406293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 09:59:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="648789653"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.83])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 09:58:57 -0700
Message-ID: <4f4e3eb7-319f-9280-ba5d-78efe0244fe2@intel.com>
Date:   Sat, 2 Jul 2022 19:58:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] Add define SDHCI_POWER_OFF to improve readability
Content-Language: en-US
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20220630014828epcas1p1e780542d769ff8189bb408449624ffb4@epcas1p1.samsung.com>
 <20220630014425.3643-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220630014425.3643-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/06/22 04:44, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> //sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> A value of '0' has two meanings.
>  - Clear the register.   //2084 line
>  - Set power off.       //2075 line
> 
> To clarify this and improve readability,
> use the 'power_off' value instead of '0'.

The distinction does not seem that important and there is not
much chance such a convention will always be followed in the
future, so I would prefer to leave it as is.

> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  drivers/mmc/host/sdhci.c          | 6 +++---
>  drivers/mmc/host/sdhci.h          | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 622b7de96c7f..a732eec69bf8 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -584,7 +584,8 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>  	if (intel_host->needs_pwr_off) {
>  		intel_host->needs_pwr_off = false;
>  		if (mode != MMC_POWER_OFF) {
> -			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +			sdhci_writeb(host, SDHCI_POWER_OFF,
> +					SDHCI_POWER_CONTROL);
>  			usleep_range(10000, 12500);
>  		}
>  	}
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffec5ad1..602fb3a088e7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2029,7 +2029,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  	if (mode != MMC_POWER_OFF)
>  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>  	else
> -		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +		sdhci_writeb(host, SDHCI_POWER_OFF, SDHCI_POWER_CONTROL);
>  }
>  
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> @@ -2075,8 +2075,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  
>  	host->pwr = pwr;
>  
> -	if (pwr == 0) {
> -		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +	if (pwr == SDHCI_POWER_OFF) {
> +		sdhci_writeb(host, SDHCI_POWER_OFF, SDHCI_POWER_CONTROL);
>  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
>  			sdhci_runtime_pm_bus_off(host);
>  	} else {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 95a08f09df30..f35d6d7b8326 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -95,6 +95,7 @@
>  #define  SDHCI_CTRL_CDTEST_EN	0x80
>  
>  #define SDHCI_POWER_CONTROL	0x29
> +#define  SDHCI_POWER_OFF	0x00
>  #define  SDHCI_POWER_ON		0x01
>  #define  SDHCI_POWER_180	0x0A
>  #define  SDHCI_POWER_300	0x0C

