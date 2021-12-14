Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE8C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Dec 2021 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhLNJVF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Dec 2021 04:21:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:5371 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhLNJVE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Dec 2021 04:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639473664; x=1671009664;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6oBRK++h2cEtY1dfA874wK5NQNqj4GBYhGovxyvCjK8=;
  b=lUoOrGnQDEVe1XK2zTcd50JlX3sagSPKJYOFF+y2shxlGaIXP7BXE0hH
   MQOKJV65qkzCGupKsChKlzzUSf8si8AAX5oz8iLkUrWShOSqwcqwjQHuU
   bPsnfae4U51TS+jVreeNjmvDYaSxkVlacostsozOLCIpDTtLdsfZz/twB
   AoPAyFkMJAlEYl9P7AwBkeUj+W7vFObT4sFIc2rsap/RU3GBWrGZPAWrM
   QOFAzUM1eTdM8YYBXWHeHjFd3Oq1grrrmE/niMZJX2SP5EttH1O8OfbhG
   Hvzv8RpFdIHoTMEUldPU6Xr3X7oZNSY9RmkAQliIkgeH2E3y2/3MDc2dM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236470661"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236470661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 01:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465000061"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 01:21:02 -0800
Subject: Re: [[PATCH V2]] mmc:sdhci-pci-o2micro: Change implementation of
 tuning for SDR104 and HS200 mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211206131507.411-1-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <62714fdb-bb51-f05d-c2b7-e2841667ae27@intel.com>
Date:   Tue, 14 Dec 2021 11:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206131507.411-1-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/12/2021 15:15, fred wrote:
> From: "fred.ai" <fred.ai@bayhubtech.com>
> 
> Adjust the timing of an interface in SDR104 mode. After sending CMD6
> successfully to switch card mode,driver need to select DLL output
> clock as SD clock.Setting DLL output clock phase value 0x9 when> select DLL output clock source.

There are some kernel-style issues.

Only single '[' in subject please e.g. should have been
[PATCH V2 1/2] not [[PATCH V2]].  Also missing patch number and a
space after mmc: i.e. should have been:

[PATCH V2 1/2] mmc: sdhci-pci-o2micro: Change implementation of tuning for SDR104 and HS200 mode

> 
> Signed-off-by: fred.ai <fred.ai@bayhubtech.com>

Normally names are separated with space and capitalized,
so perhaps Fred Ai rather than fred.ai ?

> ---
> Change in V2:
> 1.Set register 0x354 bit 16 to select DLL clock
> 2.Set register 0x354 bit [23:20] to select fixed output tuning phase 0x9
> 3.Driver need to clear 0x354 bit 16 and bit [23:20] to 0 when setting clock
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 57 ++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f045c1ee4667..98c1a17eb619 100644
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
> @@ -301,9 +302,14 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
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
> +	u8  dll_mode;
>  
>  	/*
>  	 * This handler only implements the eMMC tuning that is specific to
> @@ -322,6 +328,28 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	scratch |= O2_SD_PWR_FORCE_L0;
>  	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
>  
> +	/* stop clk */
> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val &= ~(SDHCI_CLOCK_CARD_EN);

Parenthesis not needed

> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
> +
> +	/* UnLock WP */
> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 &= 0x7f;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +	dll_mode = 0x9;
> +	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +	reg_val &= 0xFF0EFFFF;
> +	reg_val |= ((1 << 16) | (dll_mode << 20));

It would be nicer to define BIT() and GENMASK() and use FIELD_PREP here,
refer include/linux/bitfield.h

> +	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +
> +    /* start clk */

Indent should be a single tab.

> +	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	reg_val |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);

Other places in the code seem to pair "Unlock WP" with "Lock WP"
but there is not one here. Is that correct?

> +
>  	/* wait DLL lock, timeout value 5ms */
>  	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
>  		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
> @@ -520,11 +548,11 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  
>  static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
> -	u16 clk;
> -	u8 scratch;
> -	u32 scratch_32;
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
>  	struct sdhci_pci_chip *chip = slot->chip;
> +	u32 scratch_32;
> +	u8 scratch;
> +	u16 clk;

Please do not make unrelated changes

>  
>  	host->mmc->actual_clock = 0;
>  
> @@ -533,22 +561,27 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
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
> +	scratch_32 &= ~(1 << 16);
> +	scratch_32 &= ~(0xf << 20);

It would be nicer to define BIT() and GENMASK() and use them here,
refer include/linux/bitfield.h

> +	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
>  
> -		scratch |= 0x80;
> -		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> -	}
> +    /* Lock WP */

Indent a single tab

> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
> +	scratch |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_o2_enable_clk(host, clk);
> 

