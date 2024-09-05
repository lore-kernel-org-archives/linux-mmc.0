Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827019D899;
	Thu,  5 Sep 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544556; cv=none; b=rl4t3aJi1fp/Psp1udT+DZ+lG3J3q9YLi1mhocDIpfAta5SxxVnbo8peUmFONa1fmbgQDsmomYMw6lSA289KmnKZPXaavVsSEyASm6Vxfb7WAowZrAJdS7bRJkPsXEUb6rvnIzPgiVkCVHVLvQqNtTVEzKt/rXzcUeYtD1Eht2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544556; c=relaxed/simple;
	bh=NJ+0kQrUrJhviaNBbH/iCuvwDSf+9TUbT7/bcFaCyjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVHZudTkkeyi2flLaYJ1FnsimHWj5tw740rsWtlYDfjT9ekoMtJe3iHv0Ud1vU8VwwdIadgXkWyAgVvkOrrWIXanNAugbHJ63lyS4ZBIcXJ1nwYXmhyCgPVISEbS+oEO4cI0JoQ5YQlrq/0acz4yVMW9HDwwp5pOBlk7Kf9zcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNwcTi1n; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNwcTi1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725544555; x=1757080555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NJ+0kQrUrJhviaNBbH/iCuvwDSf+9TUbT7/bcFaCyjI=;
  b=TNwcTi1nDeP0T+hzdR+MiXQ8S+flM1idgb8lnLa+VwMcZHhLZbGrLN1v
   sUtFiPEStBzHh/RuF34JeobkEz2uaXiImoEx9lLehqwuROK4jnBykeTfv
   IHh3znpEYP3mgVRFLWo1aODokwqVr1Rvktmzy7r2Z1XWtbEEHNMFfLYae
   5XJNK9x9vnsnD24izFGg0wpruD2vPYHEgCMkaowrwmX7Ot65ckSIXAUZv
   JBBfPPqn9Sa/z+vFC18gB2ghOl6x8jJkbdCh1KQG69PlgDQYr5Os/s69k
   m54ZZLpFUWZ96IV4t2zVplG03brIqL9QsKVK0AY2PO3zRfan3a61kuWKM
   Q==;
X-CSE-ConnectionGUID: 9YkHK2tDRreXYTb8Lqd4Lw==
X-CSE-MsgGUID: BtlMEQNYSbWMTkYqTvqurg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24212956"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24212956"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:55:54 -0700
X-CSE-ConnectionGUID: pnjkRgn2ROGBiU36nbkUIA==
X-CSE-MsgGUID: /7/TVQi7Ql+Cwn14Q+/DAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65643239"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:55:49 -0700
Message-ID: <313ed563-8839-418f-8c1f-3275081d1258@intel.com>
Date: Thu, 5 Sep 2024 16:55:44 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V20 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9755
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
 <20240905102000.5020-22-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240905102000.5020-22-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/09/24 13:19, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Changes are:
>  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
>  * Enable the internal clock when do reset on UHS-II mode.
>  * Increase timeout value before detecting UHS-II interface.
>  * Add vendor settings fro UHS-II mode.
>  * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
>  * Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> ---
> 
> Updates in V20:
>  - Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
>  - Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.
> 
> Updates in V19:
>  - Add sdhci_gli_enable_internal_clock() to simplify the code
>    in the sdhci_gl9755_reset().
> 
> Updates in V17:
>  - Rname gl9755_overcurrent_event_enable() to
>    sdhci_gli_overcurrent_event_enable().
> 
> Updates in V15:
>  - Adjust gl9755_vendor_init() to the correct function.
> 
> Updates in V13:
>  - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.
> 
> Updates in V9:
>  - Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_init().
>  - Rename gl9755_uhs2_reset_sd_tran() to sdhci_gli_uhs2_reset_sd_tran().
> 
> Updates in V8:
>  - Use sdhci_get_vdd_value() to simplify code in gl9755_set_power().
>  - Use read_poll_timeout_atomic() to simplify code in
>    sdhci_wait_clock_stable().
>  - Use read_poll_timeout_atomic() to simplify code in sdhci_gl9755_reset().
> 
> Updates in V7:
>  - Drop using gl9755_post_attach_sd().
> 
> ---
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 236 ++++++++++++++++++++++++++++++-
>  1 file changed, 235 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..7cf27a666f34 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -18,6 +18,7 @@
>  #include "sdhci-cqhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> +#include "sdhci-uhs2.h"
>  
>  /*  Genesys Logic extra registers */
>  #define SDHCI_GLI_9750_WT         0x800
> @@ -139,9 +140,36 @@
>  
>  #define PCI_GLI_9755_PLLSSC        0x68
>  #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
> +#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
> +#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
> +#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
> +#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
> +#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
> +#define   GLI_9755_PLLSSC_RECV_VALUE          0x0
> +#define   PCI_GLI_9755_PLLSSC_TRAN            GENMASK(31, 30)
> +#define   GLI_9755_PLLSSC_TRAN_VALUE          0x3
> +
> +#define PCI_GLI_9755_UHS2_PLL            0x6C
> +#define   PCI_GLI_9755_UHS2_PLL_SSC        GENMASK(9, 8)
> +#define   GLI_9755_UHS2_PLL_SSC_VALUE      0x0
> +#define   PCI_GLI_9755_UHS2_PLL_DELAY      BIT(18)
> +#define   GLI_9755_UHS2_PLL_DELAY_VALUE    0x1
> +#define   PCI_GLI_9755_UHS2_PLL_PDRST      BIT(27)
> +#define   GLI_9755_UHS2_PLL_PDRST_VALUE    0x1
>  
>  #define PCI_GLI_9755_SerDes  0x70
> +#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
> +#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
> +#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
> +#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
> +#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
> +#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
> +#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
>  #define PCI_GLI_9755_SCP_DIS   BIT(19)
> +#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
> +#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
> +#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
> +#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
>  
>  #define PCI_GLI_9755_MISC	    0x78
>  #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
> @@ -779,6 +807,204 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  	gl9755_wt_off(pdev);
>  }
>  
> +static void gl9755_vendor_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 serdes;
> +	u32 pllssc;
> +	u32 uhs2_pll;
> +
> +	gl9755_wt_on(pdev);
> +
> +	pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &serdes);
> +	serdes &= ~PCI_GLI_9755_UHS2_SERDES_TRAN;
> +	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_TRAN,
> +			     GLI_9755_UHS2_SERDES_TRAN_VALUE);
> +	serdes &= ~PCI_GLI_9755_UHS2_SERDES_RECV;
> +	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_RECV,
> +			     GLI_9755_UHS2_SERDES_RECV_VALUE);
> +	serdes &= ~PCI_GLI_9755_UHS2_SERDES_INTR;
> +	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_INTR,
> +			     GLI_9755_UHS2_SERDES_INTR_VALUE);
> +	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
> +	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
> +			     GLI_9755_UHS2_SERDES_ZC1_VALUE);
> +	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
> +	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
> +			     GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
> +	pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, serdes);
> +
> +	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, &uhs2_pll);
> +	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_SSC;
> +	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_SSC,
> +			  GLI_9755_UHS2_PLL_SSC_VALUE);
> +	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_DELAY;
> +	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_DELAY,
> +			  GLI_9755_UHS2_PLL_DELAY_VALUE);
> +	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_PDRST;
> +	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_PDRST,
> +			  GLI_9755_UHS2_PLL_PDRST_VALUE);
> +	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, uhs2_pll);
> +
> +	pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &pllssc);
> +	pllssc &= ~PCI_GLI_9755_PLLSSC_RTL;
> +	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RTL,
> +			  GLI_9755_PLLSSC_RTL_VALUE);
> +	pllssc &= ~PCI_GLI_9755_PLLSSC_TRANS_PASS;
> +	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRANS_PASS,
> +			  GLI_9755_PLLSSC_TRANS_PASS_VALUE);
> +	pllssc &= ~PCI_GLI_9755_PLLSSC_RECV;
> +	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RECV,
> +			  GLI_9755_PLLSSC_RECV_VALUE);
> +	pllssc &= ~PCI_GLI_9755_PLLSSC_TRAN;
> +	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRAN,
> +			  GLI_9755_PLLSSC_TRAN_VALUE);
> +	pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, pllssc);
> +
> +	gl9755_wt_off(pdev);
> +}
> +
> +static void sdhci_gli_pre_detect_init(struct sdhci_host *host)
> +{
> +	/* Need more time on UHS2 detect flow */
> +	sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
> +}
> +
> +static void sdhci_gli_overcurrent_event_enable(struct sdhci_host *host, bool enable)
> +{
> +	u32 mask;
> +
> +	mask = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
> +	if (enable)
> +		mask |= SDHCI_INT_BUS_POWER;
> +	else
> +		mask &= ~SDHCI_INT_BUS_POWER;
> +
> +	sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
> +
> +	mask = sdhci_readl(host, SDHCI_INT_ENABLE);
> +	if (enable)
> +		mask |= SDHCI_INT_BUS_POWER;
> +	else
> +		mask &= ~SDHCI_INT_BUS_POWER;
> +
> +	sdhci_writel(host, mask, SDHCI_INT_ENABLE);
> +}
> +
> +static void gl9755_set_power(struct sdhci_host *host, unsigned char mode,
> +			     unsigned short vdd)
> +{
> +	u8 pwr = 0;
> +
> +	if (mode != MMC_POWER_OFF) {
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr)
> +			WARN(1, "%s: Invalid vdd %#x\n", mmc_hostname(host->mmc), vdd);
> +		pwr |= SDHCI_VDD2_POWER_180;
> +	}
> +
> +	if (host->pwr == pwr)
> +		return;
> +
> +	host->pwr = pwr;
> +
> +	if (pwr == 0) {
> +		sdhci_gli_overcurrent_event_enable(host, false);
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +	} else {
> +		sdhci_gli_overcurrent_event_enable(host, false);
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		pwr |= (SDHCI_POWER_ON | SDHCI_VDD2_POWER_ON);
> +
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		/* wait stable */
> +		mdelay(5);
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		/* wait stable */
> +		mdelay(5);
> +		sdhci_gli_overcurrent_event_enable(host, true);
> +	}
> +}
> +
> +static bool sdhci_wait_clock_stable(struct sdhci_host *host)
> +{
> +	u16 clk = 0;
> +
> +	if (read_poll_timeout_atomic(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> +				     10, 20000, false, host, SDHCI_CLOCK_CONTROL)) {
> +		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static void sdhci_gli_enable_internal_clock(struct sdhci_host *host)
> +{
> +	u16 ctrl2;
> +
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +	sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +
> +	if (!((ctrl2 & SDHCI_CTRL_V4_MODE) &&
> +	      (ctrl2 & SDHCI_CTRL_UHS2_ENABLE))) {
> +		sdhci_wait_clock_stable(host);
> +		sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL2);
> +	}
> +}
> +
> +static int sdhci_gli_wait_software_reset_done(struct sdhci_host *host, u8 mask)
> +{
> +	u8 rst;
> +
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
> +				     10, 100000, false, host, SDHCI_SOFTWARE_RESET)) {
> +		pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(host->mmc), (int)mask);
> +		sdhci_dumpregs(host);
> +		/* manual clear */
> +		sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdhci_gli_uhs2_reset_sd_tran(struct sdhci_host *host)
> +{
> +	/* do this on UHS2 mode */
> +	if (host->mmc->uhs2_sd_tran) {
> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +		sdhci_uhs2_clear_set_irqs(host,
> +					  SDHCI_INT_ALL_MASK,
> +					  SDHCI_UHS2_INT_ERROR_MASK);
> +	}
> +}
> +
> +static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
> +{
> +	/* need internal clock */
> +	if (mask & SDHCI_RESET_ALL)
> +		sdhci_gli_enable_internal_clock(host);
> +
> +	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +
> +	/* reset sd-tran on UHS2 mode if need to reset cmd/data */
> +	if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
> +		sdhci_gli_uhs2_reset_sd_tran(host);
> +
> +	if (mask & SDHCI_RESET_ALL)
> +		host->clock = 0;
> +
> +	if (sdhci_gli_wait_software_reset_done(host, mask))
> +		return;

Should be just:

	sdhci_gli_wait_software_reset_done(host, mask);

> +}
> +
>  static inline void gl9767_vhs_read(struct pci_dev *pdev)
>  {
>  	u32 vhs_enable;
> @@ -1086,6 +1312,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
> +	gl9755_vendor_init(host);
>  
>  	return 0;
>  }
> @@ -1524,17 +1751,24 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
>  	.read_w			= sdhci_gli_readw,
>  	.read_b			= sdhci_gli_readb,
>  	.set_clock		= sdhci_gl9755_set_clock,
> +	.set_power		= gl9755_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> -	.reset			= sdhci_reset,
> +	.reset			= sdhci_gl9755_reset,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.voltage_switch		= sdhci_gli_voltage_switch,
> +	.dump_uhs2_regs		= sdhci_uhs2_dump_regs,
> +	.set_timeout		= sdhci_uhs2_set_timeout,
> +	.irq			= sdhci_uhs2_irq,
> +	.uhs2_pre_detect_init   = sdhci_gli_pre_detect_init,
>  };
>  
>  const struct sdhci_pci_fixes sdhci_gl9755 = {
>  	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
>  	.probe_slot	= gli_probe_slot_gl9755,
> +	.add_host	= sdhci_pci_uhs2_add_host,
> +	.remove_host	= sdhci_pci_uhs2_remove_host,
>  	.ops            = &sdhci_gl9755_ops,
>  #ifdef CONFIG_PM_SLEEP
>  	.resume         = sdhci_pci_gli_resume,

