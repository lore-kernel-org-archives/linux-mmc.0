Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CDC64EC4
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 11:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCJLnZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCJLnU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 06:43:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ADB2471D;
        Fri, 10 Mar 2023 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678448587; x=1709984587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LRxW5Wq7WPFhpM3fw7IImF+pnI1/yJrimQmf3FE581A=;
  b=LvQiiZpwSDPh6LZJ4P/DBlb9YcLcrKj5KyhcuBLkXD0oY5jRIimii/lA
   qCEf4EigBVhFp8//3AaeP8kBWZmj6ZMm5si55nKxLNV4IhBmsBaGoAozE
   X8blQhydnPfYdaae2HMOTMEY1gDFzuSVsDIMQ4353HTrvBMT05g11CTAc
   GrDNYujx+trV2U1sTpqYU3ytcDN/ukVFRV7yL1MhG+hdp0+vC50LGRqEr
   WitEG5KOR/KBh2qiGM3w6tqPCYtG64LNi+LS1HFjS9uPzQrubj+oYXcuM
   Tf3BvGQXC4amZaF0wO5euCa5fYVl2Hy2eKnOU3YRvwckoFofte6kGzcBl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401570308"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401570308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="710256003"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="710256003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:43:01 -0800
Message-ID: <8647cc1c-e301-867d-3fe4-f290548d5798@intel.com>
Date:   Fri, 10 Mar 2023 13:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Fix SDR50 mode timing issue
Content-Language: en-US
To:     fredaibayhubtech@126.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux.kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
References: <20230223120450.16858-1-fredaibayhubtech@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230223120450.16858-1-fredaibayhubtech@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/02/23 14:04, fredaibayhubtech@126.com wrote:
> From: Fred <fred.ai@bayhubtech.com>
> 
> Change SDR50 mode clock source from DLL output clock to PLL open clock
> 1.HS200 and SDR104 mode select DLL output clock
> 2.SDR50 mode select PLL open clock
> 
> Signed-off-by: Fred <fred.ai@bayhubtech.com>

Seems like it could use a fixes tag? Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Change in V1
> SDR50 mode select PLL open clock as its clock source.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++-------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 98cadff47b2b..620f52ad9667 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -339,22 +339,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	reg_val &= ~SDHCI_CLOCK_CARD_EN;
>  	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>  
> -	/* UnLock WP */
> -	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -	scratch_8 &= 0x7f;
> -	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> -
> -	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> -	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> -	reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> -	reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> -	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +	if ((host->timing == MMC_TIMING_MMC_HS200) ||
> +		(host->timing == MMC_TIMING_UHS_SDR104)) {
> +		/* UnLock WP */
> +		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +		scratch_8 &= 0x7f;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>  
> -	/* Lock WP */
> -	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -	scratch_8 |= 0x80;
> -	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +		/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +		reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +		reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
>  
> +		/* Lock WP */
> +		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +		scratch_8 |= 0x80;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	}
>  	/* Start clk */
>  	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>  	reg_val |= SDHCI_CLOCK_CARD_EN;

