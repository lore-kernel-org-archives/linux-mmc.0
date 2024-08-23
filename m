Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F16185B52;
	Fri, 23 Aug 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416881; cv=none; b=UMzU5UHKQnSPKsKoIvJJXCZNW8PscPJW59W9PqlWLfUcHKeTAjLJC3LRWsNK8rwQZYAb6lvqKLDx1jubOsq+OSGKyu2GLtTPvR109D8r/bt1TYlKsvnqiwnqRheeU4RaQpgddge5g0bMpvykxvY0qAIlEYJEFuFy7bj6/n+dLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416881; c=relaxed/simple;
	bh=wpWgo90tUs2YbSUQzYrnP4a1Qlk5b/3coumaFXD4oZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ng0IgxfN676LXSwUfM7zcKpMU3DeoKimouoHKfO5pLuiFLrDvLN+UmQvDRUsGXYtzhASEdn+XCeFcFNXfuwimZGbLV2z2/kLi4ka9u2ZnMNKyUo1n0FtU4nxBCpdgjx7eqPa4J/Td61k/D0T8in6+aULyk45x8ndFkYhsy9xd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aw7VIQlO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw7VIQlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416879; x=1755952879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wpWgo90tUs2YbSUQzYrnP4a1Qlk5b/3coumaFXD4oZ8=;
  b=Aw7VIQlOqgcq6z0pIzuZ47B+Gh/cl3MLimdBGToD+XWB99Xtg4w56hLU
   v9T2Svbc5+TYgrk4ZyrqJAcbTbDCbOhFG998Aa6plJYsuuRb4v5Ot4YRj
   nYG7jzm1ASwHidW7C52XlIRVxKXukVVkmqgiC3VJMWtcfo+PC2ruaWnbU
   LoqCFgjTIz6RmoQgf45B+HPjkHQ6SGQ2VzkWmhCWbUGwMRYzyeuOEYrx2
   chyAt/nCPN7m4P5wl0Oz8hZ9uHeOHY1SJbxgT+mTS6Vm0dKhDTzoQV/mg
   GiNLNf88tmEyD/2J+8MamVZPKuEoGeOUxElCLroU9ATDRmD8vcJ78lLYf
   w==;
X-CSE-ConnectionGUID: D3tj3+1CQbe4WYLiYvgXOg==
X-CSE-MsgGUID: UHHfPfVCR42oy4eHAJSk6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23052672"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23052672"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:41:18 -0700
X-CSE-ConnectionGUID: XwAB/7YvSg+TA5xQYAvR7w==
X-CSE-MsgGUID: pr8J8gJYTEC7KcQPpC1KWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="84969844"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:41:14 -0700
Message-ID: <7b68185d-6847-4482-b1c2-403bf5fa78d5@intel.com>
Date: Fri, 23 Aug 2024 15:41:08 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V18 22/22] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9767
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 takahiro.akashi@linaro.org, dlunev@chromium.org,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <20240802102229.10204-23-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240802102229.10204-23-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/08/24 13:22, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Changes are:
>  * Enable the internal clock when do reset on UHS-II mode.
>  * Increase timeout value before detecting UHS-II interface.
>  * Add vendor settings for UHS-II mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V18:
>  - Add new register settings for gl9767.
>  - Add card_event in the sdhci_ops for gl9767.
>  - Add sdhci_gl9767_set_card_detect_debounce_time()
>    to configure the gl9767.
>  - Adjust the sdhci_gl9767_reset() process for gl9767.
> 
> Updates in V17:
>  - Use mmc_card_uhs2() to simplify the code in the sdhci_gl9767_reset().
>  - Use mmc_card_uhs2() to simplify the code in the
>    sdhci_gl9767_set_power().
>  - Add sdhci_gli_overcurrent_event_enable() to sdhci_gl9767_set_power().
> 
> Updates in V15:
>  - Add gl9767 to support uhs2 function.
> 
> ---
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 214 ++++++++++++++++++++++++++++++-
>  1 file changed, 212 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index a4164948de81..26f7cf4cb109 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -174,6 +174,15 @@
>  #define PCI_GLI_9755_MISC	    0x78
>  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
>  
> +#define SDHCI_GLI_9767_SD_HOST_OPERATION_CTL				0x508
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK	  BIT(0)
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE			  GENMASK(21, 16)
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE	  0x05
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE	  0x3F
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE		  GENMASK(23, 22)
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS	  0x2
> +#define   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS	  0x3
> +
>  #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
>  
> @@ -210,6 +219,13 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_RESET_REG				0x8E4
> +#define   PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET	  BIT(0)
> +
> +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1				0x90C
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR		  GENMASK(31, 29)
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE	  0x3
> +
>  #define PCIE_GLI_9767_SDHC_CAP			0x91C
>  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
>  
> @@ -228,9 +244,15 @@
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
>  
>  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2		  BIT(5)
> +#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL	  BIT(8)
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
>  
> +#define PCIE_GLI_9767_UHS2_PHY_SET_REG2					0x948
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING		  GENMASK(22, 21)
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE		  0x0
> +
>  #define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
>  #define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
>  
> @@ -240,6 +262,28 @@
>  #define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
>  #define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
>  
> +#define PCIE_GLI_9767_UHS2_CTL1				0x95C
> +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS		  BIT(5)
> +#define   PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE	  0x1
> +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL		  BIT(6)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE	  0x1
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN		  GENMASK(10, 7)
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE	  0x3
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV		  GENMASK(14, 11)
> +#define   PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE	  0xf
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS		  GENMASK(16, 15)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE	  0x0
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV		  GENMASK(18, 17)
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE	  0x0
> +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST			  BIT(25)
> +#define   PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE		  0x1
> +
> +#define PCIE_GLI_9767_UHS2_CTL2			0x964
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC		  GENMASK(3, 0)
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
> +#define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -1152,6 +1196,31 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  	gl9767_vhs_read(pdev);
>  }
>  
> +static void sdhci_gl9767_set_card_detect_debounce_time(struct sdhci_host *host)
> +{
> +	u32 value;
> +
> +	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> +	value &= ~(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE |
> +		   SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE);
> +	if (host->mmc->ops->get_cd(host->mmc))

This is OK from the ->card_event() path but not from others like:

sdhci_gl9767_reset() -> gli_set_9767() -> sdhci_gl9767_set_card_detect_debounce_time()
	o Reset can be called in atomic context (under spin lock), but
	host->mmc->ops->get_cd() can be reading a card detect GPIO which
	might sleep.

gli_probe_slot_gl9767() -> gli_set_9767() -> sdhci_gl9767_set_card_detect_debounce_time()
	o gli_probe_slot_gl9767() gets called before card detect GPIO
	is set up in sdhci-pci-core.c

However, presumably you are always using SDHCI_PRESENT_STATE register
for card detect (hence the debounce settings on the controller), so
it would be better to just read SDHCI_PRESENT_STATE here.

> +		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
> +				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_IN_VALUE) |
> +			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
> +				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_1MS);
> +	else
> +		value |= FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE,
> +				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_PLUG_OUT_VALUE) |
> +			 FIELD_PREP(SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE,
> +				    SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_DEBOUNCE_SCALE_10MS);
> +	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> +}
> +
> +static void sdhci_gl9767_card_event(struct sdhci_host *host)
> +{
> +	sdhci_gl9767_set_card_detect_debounce_time(host);
> +}
> +
>  static void gli_set_9767(struct sdhci_host *host)
>  {
>  	u32 value;
> @@ -1159,6 +1228,12 @@ static void gli_set_9767(struct sdhci_host *host)
>  	value = sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
>  	value &= ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
>  	sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
> +
> +	value = sdhci_readl(host, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> +	value &= ~SDHCI_GLI_9767_SD_HOST_OPERATION_CTL_CMD_CONFLICT_CHECK;
> +	sdhci_writel(host, value, SDHCI_GLI_9767_SD_HOST_OPERATION_CTL);
> +
> +	sdhci_gl9767_set_card_detect_debounce_time(host);
>  }
>  
>  static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
> @@ -1197,8 +1272,54 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
>  
>  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
>  {
> -	sdhci_reset(host, mask);
> -	gli_set_9767(host);
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +	u16 clk_ctrl;
> +	u16 ctrl2;
> +
> +	/* need internal clock */
> +	if (mask & SDHCI_RESET_ALL) {
> +		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +		if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHCI_CTRL_UHS2_ENABLE)) {
> +			sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +		} else {
> +			sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +			sdhci_wait_clock_stable(host);
> +			sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL2);
> +		}

Same code is in sdhci_gl9755_reset(), so could factor it out into
a separate function.

> +
> +		gl9767_vhs_write(pdev);
> +
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_RESET_REG, &value);
> +		value &= ~PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_RESET_REG, value);
> +
> +		if (read_poll_timeout_atomic(pci_read_config_dword, value,
> +					     !(value & PCIE_GLI_9767_RESET_REG_SD_HOST_SW_RESET),
> +					     1, 5, true, pdev, PCIE_GLI_9767_RESET_REG, &value)) {
> +			pr_warn("%s: %s: Reset SDHC AHB and TL-AMBA failure.\n",
> +				__func__, mmc_hostname(host->mmc));
> +			return;
> +		}
> +
> +		gl9767_vhs_read(pdev);
> +	}
> +
> +	if (mmc_card_uhs2(host->mmc)) {
> +		if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) {
> +			sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);

Don't you need to wait for that reset at some point?

> +			sdhci_gli_uhs2_reset_sd_tran(host);
> +		} else {
> +			sdhci_uhs2_reset(host, mask);
> +		}
> +		gli_set_9767(host);
> +	} else {
> +		sdhci_reset(host, mask);
> +		gli_set_9767(host);
> +	}

gli_set_9767() is always called, so could be moved here.

>  }
>  
>  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -1288,6 +1409,86 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>  	return 0;
>  }
>  
> +static void gl9767_vendor_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	gl9767_vhs_write(pdev);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, &value);
> +	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR,
> +			    PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG1, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, &value);
> +	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING,
> +			    PCIE_GLI_9767_UHS2_PHY_SET_REG2_SSC_PPM_SETTING_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_PHY_SET_REG2, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, &value);
> +	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS,
> +			    PCIE_GLI_9767_UHS2_CTL1_TRANS_PASS_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL,
> +			    PCIE_GLI_9767_UHS2_CTL1_DECODING_CTL_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN,
> +			    PCIE_GLI_9767_UHS2_CTL1_SERDES_TRAN_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV,
> +			    PCIE_GLI_9767_UHS2_CTL1_SERDES_RECV_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS,
> +			    PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_DIR_RECV,
> +			    PCIE_GLI_9767_UHS2_CTL1_DIR_RECV_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL1_PDRST,
> +			    PCIE_GLI_9767_UHS2_CTL1_PDRST_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL1, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> +	value |= FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC,
> +			    PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE) |
> +		 FIELD_PREP(PCIE_GLI_9767_UHS2_CTL2_ZC_CTL,
> +			    PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> +
> +	gl9767_vhs_read(pdev);
> +}
> +
> +static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,	unsigned short vdd)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	if (mmc_card_uhs2(host->mmc)) {
> +		gl9767_vhs_write(pdev);
> +
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +		value |= PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
> +			 PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +		gl9767_vhs_read(pdev);
> +
> +		sdhci_gli_overcurrent_event_enable(host, false);
> +		sdhci_uhs2_set_power(host, mode, vdd);
> +		sdhci_gli_overcurrent_event_enable(host, true);
> +	} else {
> +		gl9767_vhs_write(pdev);
> +
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +		value &= ~(PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
> +			   PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL);
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +		gl9767_vhs_read(pdev);
> +
> +		sdhci_gli_overcurrent_event_enable(host, false);
> +		sdhci_set_power(host, mode, vdd);
> +		sdhci_gli_overcurrent_event_enable(host, true);
> +	}
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
> @@ -1324,6 +1525,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
>  	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
>  	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
>  	sdhci_enable_v4_mode(host);
> +	gl9767_vendor_init(host);
>  
>  	return 0;
>  }
> @@ -1827,12 +2029,20 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
>  	.reset			 = sdhci_gl9767_reset,
>  	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
>  	.voltage_switch		 = sdhci_gl9767_voltage_switch,
> +	.dump_uhs2_regs		 = sdhci_uhs2_dump_regs,
> +	.set_timeout		 = sdhci_uhs2_set_timeout,
> +	.irq			 = sdhci_uhs2_irq,
> +	.set_power		 = sdhci_gl9767_set_power,
> +	.uhs2_pre_detect_init	 = sdhci_gli_pre_detect_init,
> +	.card_event		 = sdhci_gl9767_card_event,
>  };
>  
>  const struct sdhci_pci_fixes sdhci_gl9767 = {
>  	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
>  	.probe_slot	= gli_probe_slot_gl9767,
> +	.add_host	= sdhci_pci_uhs2_add_host,
> +	.remove_host	= sdhci_pci_uhs2_remove_host,
>  	.ops		= &sdhci_gl9767_ops,
>  #ifdef CONFIG_PM_SLEEP
>  	.resume		= sdhci_pci_gli_resume,

