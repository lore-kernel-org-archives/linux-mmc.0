Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54EC33CB3
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7426D2084D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAONNA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:13:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:58723 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONM7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 08:12:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 05:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="256769759"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 05:12:57 -0800
Subject: Re: [PATCH 1/3] mmc: sdhci_am654: Remove Inverted Write Protect flag
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20200108143301.1929-1-faiz_abbas@ti.com>
 <20200108143301.1929-2-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <518a9ea9-84e6-c9d4-90b6-7f13c9ab8d04@intel.com>
Date:   Wed, 15 Jan 2020 15:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108143301.1929-2-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 4:32 pm, Faiz Abbas wrote:
> The MMC/SD controllers on am65x and j721e don't in fact detect the write
> protect line as inverted. No issues were detected because of this
> because the sdwp line is not connected on any of the evms. Fix this by
> removing the flag.
> 
> Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b8e897e31e2e..2d38b1e12a7e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -253,8 +253,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>  	.ops = &sdhci_am654_ops,
> -	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> @@ -290,8 +289,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
>  	.ops = &sdhci_j721e_8bit_ops,
> -	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> @@ -314,8 +312,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
>  	.ops = &sdhci_j721e_4bit_ops,
> -	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> -		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> 

