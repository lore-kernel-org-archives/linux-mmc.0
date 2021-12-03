Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CFC433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhLCJaK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:30:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:35226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235226AbhLCJaK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Dec 2021 04:30:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="216965198"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="216965198"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 01:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="561603384"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2021 01:26:44 -0800
Subject: Re: [PATCH V1 2/2] mmc:sdhci-pci-o2micro:Change implementation of
 setting corresponding PLL frequency according to card mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211203035759.2183-1-fred.ai@bayhubtech.com>
 <20211203035759.2183-2-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1c4e155f-ff7c-aa94-ab4d-17a598679ce5@intel.com>
Date:   Fri, 3 Dec 2021 11:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211203035759.2183-2-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03/12/2021 05:57, fred wrote:
> 1.SDR104 card mode PLL frequency is 0x2c28.
> 2.SD2.0/SDR50 card mode PLL frequency is 0X2510.

As before, this commit message is a bit brief.  Can you explain a bit more,
to explain things like:
Why?  Is this a fix?  What difference does an end-user see?

If it is a fix, can you add a Fixes: tag.

Subject line should have a space after each ':'

> 
> Signed-off-by: fred<fred.ai@bayhubtech.com>

Add a space between fred and <fred.ai@bayhubtech.com>

> 
> change in v1:
> When SD2.0/SDR50 card mode,driver need to set PLL frequency 0x2510.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index bac3f0f8185b..32a8ef874efa 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -568,9 +568,17 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
> +		/*SDR104 card mode PLL frequency value is 0x2c28*/

For this and other comments, please put a space after '/*' and before '*/'

>  		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>  			o2_pci_set_baseclk(chip, 0x2c280000);
>  
> +	} else {

Should this 'else' be in the previous patch instead?

> +		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
> +
> +		/*SD2.0,SDR50 card mode PLL DMDN value is 0X2510*/
> +		if ((scratch_32 & 0xFFFF0000) != 0x2510000)
> +			o2_pci_set_baseclk(chip, 0x25100000);
> +
>  		/*If not SDR104 card mode, set 0x354 value 0*/
>  		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
>  		scratch_32 &= ~(1 << 16);
> 

