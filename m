Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C7C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 09:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbhLCJV7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:21:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:49671 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379503AbhLCJV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="223817633"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="223817633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 01:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="561601484"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2021 01:18:31 -0800
Subject: Re: [PATCH V1 1/2] mmc:sdhci-pci-o2micro: Change implementation of
 tuning for SDR104 and HS200 mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211203035759.2183-1-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6f35e217-f606-dbcb-2cfa-7a9105716d04@intel.com>
Date:   Fri, 3 Dec 2021 11:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211203035759.2183-1-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03/12/2021 05:57, fred wrote:
> Select DLL clock of output tuning
> Select fixed output tuning phase 0x9

This commit message is a bit brief.  Can you explain a bit more,
to explain things like:
Why?  Is this a fix?  What difference does an end-user see?

If it is a fix, can you add a Fixes: tag.

> 
> Signed-off-by: fred<fred.ai@bayhubtech.com>

Add a space between fred and <fred.ai@bayhubtech.com>

> 

No blank line here

> ---
> Change in V1:
> 1. Set register 0x354 bit 16 to select DLL clock
> 2. Set register 0x354 bit [23:20] to select fiexd output tuning phase 0x9
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 51 +++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f045c1ee4667..dfd447c1c367 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -43,6 +43,7 @@
>  #define O2_SD_CAP_REG0		0x334
>  #define O2_SD_UHS1_CAP_SETTING	0x33C
>  #define O2_SD_DELAY_CTRL	0x350
> +#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH	0x354
>  #define O2_SD_UHS2_L1_CTRL	0x35C
>  #define O2_SD_FUNC_REG3		0x3E0
>  #define O2_SD_FUNC_REG4		0x3E4
> @@ -304,6 +305,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	int current_bus_width = 0;
>  	u32 scratch32 = 0;
>  	u16 scratch = 0;
> +	u8  scratch_8 = 0;
> +	u32 reg_val;
> +	u8  dll_mode;
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct sdhci_pci_chip *chip = slot->chip;

It is nicer kernel style to try to arrange the declarations in
descending line length e.g.

	struct sdhci_host *host = mmc_priv(mmc);
	struct sdhci_pci_slot *slot = sdhci_priv(host);
	struct sdhci_pci_chip *chip = slot->chip;
	int current_bus_width = 0;
	u32 scratch32 = 0;
	u16 scratch = 0;
	u8  scratch_8 = 0;
	u8  dll_mode;
	u32 reg_val;


>  
>  	/*
>  	 * This handler only implements the eMMC tuning that is specific to
> @@ -322,6 +328,28 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	scratch |= O2_SD_PWR_FORCE_L0;
>  	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
>  
> +	/*stop clk*/

For this and other comments, please put a space after '/*' and before '*/'
i.e.
	/* stop clk */

> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val &= ~(SDHCI_CLOCK_CARD_EN);
> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
> +	/*UnLock WP*/
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +	//Set pcr 0x354[16] to choose dll clock ,and set the default phase

Please use /* ... */ instead of //

Also 'clock ,and' -> 'clock, and'

> +	dll_mode = 0x9; //set default phase 9

Please use /* ... */ instead of //

> +	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +	reg_val &= 0xFF0EFFFF;
> +	reg_val |= ((1 << 16) | (dll_mode << 20));
> +	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +
> +    /*open clk*/

'open' -> 'start'

> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
>  	/* wait DLL lock, timeout value 5ms */
>  	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>  		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
> @@ -532,24 +560,29 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	if (clock == 0)
>  		return;
> +	/*UnLock WP*/
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	scratch &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
>  	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> -
> -		scratch &= 0x7f;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> -
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
>  		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>  			o2_pci_set_baseclk(chip, 0x2c280000);
>  
> -		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> -
> -		scratch |= 0x80;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +		/*If not SDR104 card mode, set 0x354 value 0*/

This comment contradicts the 'if' statement before it, because
host->timing == MMC_TIMING_UHS_SDR104 implies that it is SDR104 card mode.


> +		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> +		scratch_32 &= ~(1 << 16);
> +		scratch_32 &= ~(0xf << 20);
> +		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH,scratch_32);

Please add a space before 'scratch_32'

>  	}
>  
> +    /*Lock WP*/
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	scratch |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_o2_enable_clk(host, clk);
>  }
> 

