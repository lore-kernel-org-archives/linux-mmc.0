Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4022DC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 06:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhLQGiy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:38:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:16328 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233442AbhLQGiy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Dec 2021 01:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639723134; x=1671259134;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RcphfbxGjoXkXZaTQJEQETQ+hOXHy+30z21aj+YG57Y=;
  b=RLC6z9P79nHCloIqHPyZ2pjmq8e3W20y2123booe5jf8e4akoYWSMhbM
   HZeBFAkZJXfazWOitm1tu6EmiH22lqyT+dufXO/d7QNuDcJHlNr2ptZhi
   mRwoeg5Frqrjp6CEartgKBZsMC9sUMGzNckg/AeWB6UlAH73V51fS7tEs
   tjbd7jS6zR6PjCDZV9CbukMPfYHh91ktZxYhoZKDjasXWXiNN6zlgfCt2
   1IFS9dIqwC1Vph3sEY8rbXA7yed/3znFa8VAdKd4GppvfehyDXlgWm+pQ
   J66boTP42xCvn7tr6O+yvdPj26J35mFVVdGZXBQMBdiLmbyn21PydovGD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263864905"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="263864905"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 22:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466396674"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 22:38:51 -0800
Subject: Re: [PATCH V3 1/2] mmc:sdhci-pci-o2micro:Improve card input timing at
 SDR104/HS200 mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211216060824.357-1-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2cd4e191-87eb-04fd-465d-bd567d87cf58@intel.com>
Date:   Fri, 17 Dec 2021 08:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216060824.357-1-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/12/2021 08:08, fred wrote:
> From: Fred Ai <fred.ai@bayhubtech.com>
> 
> Card input timing is margin, need to adjust the hold timing of card input.
> 
> Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
> ---
> Change in V3:
> 1.Select suit DLL phase's output clock as SD interface clock at SDR104/HS200 mode.
> 2.Deselect DLL output phase as SD interface clock before next card initialization.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 56 +++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f045c1ee4667..f55602609f8c 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -43,11 +43,15 @@
>  #define O2_SD_CAP_REG0		0x334
>  #define O2_SD_UHS1_CAP_SETTING	0x33C
>  #define O2_SD_DELAY_CTRL	0x350
> +#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH	0x354
>  #define O2_SD_UHS2_L1_CTRL	0x35C
>  #define O2_SD_FUNC_REG3		0x3E0
>  #define O2_SD_FUNC_REG4		0x3E4
>  #define O2_SD_LED_ENABLE	BIT(6)
>  #define O2_SD_FREG0_LEDOFF	BIT(13)
> +#define O2_SD_SEL_DLL		BIT(16)
> +#define O2_SD_FIX_PHASE		(BIT(23) | BIT(20))
> +#define O2_SD_PHASE_MASK	GENMASK(23, 20)
>  #define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
>  
>  #define O2_SD_VENDOR_SETTING	0x110
> @@ -301,9 +305,13 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct sdhci_pci_chip *chip = slot->chip;
>  	int current_bus_width = 0;
>  	u32 scratch32 = 0;
>  	u16 scratch = 0;
> +	u8  scratch_8 = 0;
> +	u32 reg_val;
>  
>  	/*
>  	 * This handler only implements the eMMC tuning that is specific to
> @@ -322,6 +330,32 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	scratch |= O2_SD_PWR_FORCE_L0;
>  	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
>  
> +	/* Stop clk */
> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
> +	/* UnLock WP */
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +	reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +	reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +
> +	/* Lock WP */
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +	/* Start clk */
> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
>  	/* wait DLL lock, timeout value 5ms */
>  	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>  		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
> @@ -533,22 +567,26 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (clock == 0)
>  		return;
>  
> -	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> -
> -		scratch &= 0x7f;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +	/* UnLock WP */
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	scratch &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
> +	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
>  		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>  			o2_pci_set_baseclk(chip, 0x2c280000);
> +	}
>  
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> +	scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>  
> -		scratch |= 0x80;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> -	}
> +    /* Lock WP */

Also please nudge this indent into line.

> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	scratch |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_o2_enable_clk(host, clk);
> 

