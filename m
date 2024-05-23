Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DA6E60F;
	Thu, 23 May 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484110; cv=none; b=NKi7XXfqEjW0VPD/DpvstA+IJDlt/yk4hLwHktkTIvcz1a7CANdu1K3pX1nfDL9mCYCxAhO+NZAqOpzx4/E9kmmDBNZ8pOHis2cM6UxjxmYAOuvwk+ij+Tkpq54Fs35al6o8KsIVnMhMd1LRhyNfNqa18+YVmqgpUg5l1rwKRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484110; c=relaxed/simple;
	bh=mO2C24AuLnZTL9f5oaz0mHHfnqvOcor9Wz9/UixnKCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2FY6xUMQn7Iet37xnpsLP/2YJVm0XAqRraMKbRCWTAH3D7XA/I4pmoc7KK7pGSNAhc4XgJ+wzd8KOC8Oe8Ze/RRWy1FpWmIdT8JDtngRcErq2xUZfX3OK4VTJ2wITnQAvoLHXPg4veohhPX8MrF5cLPHUoP4LWOvdrw/LjzqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSaKMs1U; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSaKMs1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716484108; x=1748020108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mO2C24AuLnZTL9f5oaz0mHHfnqvOcor9Wz9/UixnKCU=;
  b=BSaKMs1UccJ+naMqch0tP1OPGLsVi+QFEbbXEujQXKsAkqsvwNxqtIEw
   olXOblaiPqH8SBRERIvn1fe1jnTVPOG6mkXZ+w7G6JTLh8VgvvhUCKVzT
   aEHp40B6Mz2tXxJqC9gKOUytjW32FxlRQdmoTsEZcg8htsLD2XG0kQ967
   GETJCb268dwraiqE2eKTMu0MOstkguxtkgu7142FEeRtBkXQ69s3j7g3U
   1VSNHS1wuzI5tSoEUofLfSW9UjdRdTH0xU5nUXgou82n6gE93sakmKq6j
   giNb8qUZwY9U6dZGNURNwzgIlFsFU92GGk8savWQFXes4QgrEZ6OIJHMq
   Q==;
X-CSE-ConnectionGUID: K0CIhHC6RnmyHfIqTSKfKQ==
X-CSE-MsgGUID: ZK3C/eBiRGm/W9aqy8S3Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12939636"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12939636"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:08:27 -0700
X-CSE-ConnectionGUID: VouEAT/LQ/O7XPVIghJ8nA==
X-CSE-MsgGUID: no97A+AZRn+3x3pLl7DiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="56975148"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:08:24 -0700
Message-ID: <75bc82b1-4a2b-4274-b55e-06288af6dc7a@intel.com>
Date: Thu, 23 May 2024 20:08:19 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 23/23] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-24-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240522110909.10060-24-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/24 14:09, Victor Shih wrote:
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
> Updates in V15:
>  - Add gl9767 to support uhs2 function.
> 
> ---
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 152 ++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-uhs2.c    |   3 +-
>  drivers/mmc/host/sdhci-uhs2.h    |   1 +
>  3 files changed, 153 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5df6be758b06..20f19cec6e64 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -210,6 +210,10 @@
>  #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
>  #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
>  
> +#define PCIE_GLI_9767_UHS2_PHY_SET_REG1				0x90C
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR		  GENMASK(31, 29)
> +#define   PCIE_GLI_9767_UHS2_PHY_SET_REG1_SERDES_INTR_VALUE	  0x3
> +
>  #define PCIE_GLI_9767_SDHC_CAP			0x91C
>  #define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
>  
> @@ -228,9 +232,15 @@
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
> @@ -240,6 +250,28 @@
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
> +#define   PCIE_GLI_9767_UHS2_CTL1_DIR_TRANS_VALUE	  0x3
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
> @@ -1198,8 +1230,35 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
>  
>  static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
>  {
> -	sdhci_reset(host, mask);
> -	gli_set_9767(host);
> +	u16 clk_ctrl;
> +	u16 ctrl2;
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {

That is the same as:

	if (mmc_card_uhs2(host->mmc)) {

> +		/* need internal clock */
> +		if (mask & SDHCI_RESET_ALL) {
> +			ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +			if ((ctrl2 & SDHCI_CTRL_V4_MODE) && (ctrl2 & SDHCI_CTRL_UHS2_ENABLE)) {
> +				sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +			} else {
> +				sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +				sdhci_wait_clock_stable(host);
> +				sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL2);
> +			}
> +		}
> +		if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))

Simpler:
		if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))

> +			sdhci_gli_uhs2_reset_sd_tran(host);
> +
> +		sdhci_uhs2_reset(host, mask);
> +		gli_set_9767(host);
> +	} else {
> +		sdhci_reset(host, mask);
> +		gli_set_9767(host);
> +	}
>  }
>  
>  static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -1289,6 +1348,87 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
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
> +	struct pci_dev *pdev;
> +	u32 value;
> +
> +	pdev = slot->chip->pdev;
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {

That is the same as:

	if (mmc_card_uhs2(host->mmc)) {

> +		gl9767_vhs_write(pdev);
> +
> +		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +		value |= PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2 |
> +			 PCIE_GLI_9767_SD_DATA_MULTI_CTL_UHS2_SWITCH_CTL;
> +		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +		gl9767_vhs_read(pdev);
> +
> +		sdhci_uhs2_set_power(host, mode, vdd);
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
> +		sdhci_set_power(host, mode, vdd);
> +	}
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
> @@ -1325,6 +1465,7 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
>  	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
>  	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
>  	sdhci_enable_v4_mode(host);
> +	gl9767_vendor_init(host);
>  
>  	return 0;
>  }
> @@ -1828,12 +1969,19 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
>  	.reset			 = sdhci_gl9767_reset,
>  	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
>  	.voltage_switch		 = sdhci_gl9767_voltage_switch,
> +	.dump_uhs2_regs		 = sdhci_uhs2_dump_regs,
> +	.set_timeout		 = sdhci_uhs2_set_timeout,
> +	.irq			 = sdhci_uhs2_irq,
> +	.set_power		 = sdhci_gl9767_set_power,
> +	.uhs2_pre_detect_init	 = sdhci_gli_pre_detect_init,
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
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c830ee352504..47180429448b 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -125,7 +125,7 @@ static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
>  	}
>  }
>  
> -static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	u8 pwr = 0;
> @@ -165,6 +165,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>  		mdelay(5);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>  
>  static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
>  {
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 42f34ca75275..c4a860f4e1e0 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -185,5 +185,6 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>  int sdhci_uhs2_add_host(struct sdhci_host *host);
>  void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
>  
>  #endif /* __SDHCI_UHS2_H */

