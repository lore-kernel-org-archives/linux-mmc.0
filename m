Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AD19CC0F;
	Mon,  2 Sep 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302423; cv=none; b=P1EHMaz90IxF7HsM++BOYCjUZgcsLFprdvhlE1XirBlzyRhKVVRIfbS/B639ho67fGJPIMGN0Y2KGF2Lgg4d6pT3Fn9CuvoLjng9+YyIwiDCqVIFsppidEALdGySfXCcVfL1DVfTpeW0PhFjm57141a1u1G/K6C525vmUM9ZmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302423; c=relaxed/simple;
	bh=bpd74QikijB4g8+p117ugdSH+nKENzLiA0ChjiIZUH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4O1cGzF5ZJ+Rm6COiSWDz3LiNosat/H/hJFN7VnO4Wq1VEP4TPjJZJWaNHN0QfRcBdOoWpdy4nfIrzAZErX6rolPKCmtZwXCGq9m8jKN4qCgzJAz6JyYD/gOqQirSCLhRevAaJuRYPBz+5WP6WdLJsVD+B5L3P3GtPcySOuMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaLQrpZb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaLQrpZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725302421; x=1756838421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bpd74QikijB4g8+p117ugdSH+nKENzLiA0ChjiIZUH8=;
  b=GaLQrpZby/tF5Xu12QM8FM2cXjYmdHIL2cOFS588jkchCUrZcmmkWnzn
   dVDsPm5jLMc5BWlR/NZZgIiDOH44t/qBTgLX6KMSqQJIeY6dRtjY/Jn7d
   Xh+3lrhp5nf5rfpH37Bivv1TcoJyzzaRK969U0x99qrwjk4/zU9onHFlA
   QoYDb9RkAc5ROvRiOE5pfJqFCRP3udIm95RKXyT9w740dW5bjAIAANq0c
   4jHGJd3eIOXDPAt89XanQEA4+LSEBQ0HU0hyi0WTO2aVN7plPLdUFwmTl
   bC0iAiiAIDGfqE0U6Eox4A/4jILQt7DrNV99dDDGN92ktK5i86z3GyUsb
   w==;
X-CSE-ConnectionGUID: DAg7RM8UT6yBVm4Isr0FIQ==
X-CSE-MsgGUID: C735gF6dTAaVJ8wn+0RJfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="26800868"
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="26800868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 11:40:20 -0700
X-CSE-ConnectionGUID: 3mfsYe4ERBaZfItTmLpTAA==
X-CSE-MsgGUID: Xbq79/zhSWakoD5kPXNlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="102118585"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 11:40:16 -0700
Message-ID: <1bf5c397-5d07-4bd5-a769-e10751bb0da2@intel.com>
Date: Mon, 2 Sep 2024 21:39:20 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V19 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9755
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
 <20240829101539.5058-22-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240829101539.5058-22-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/24 13:15, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Changes are:
>  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
>  * Enable the internal clock when do reset on UHS-II mode.
>  * Increase timeout value before detecting UHS-II interface.
>  * Add vendor settings fro UHS-II mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> ---
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
>  drivers/mmc/host/sdhci-pci-gli.c | 230 ++++++++++++++++++++++++++++++-
>  1 file changed, 229 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..e826e02a0d52 100644
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
> @@ -779,6 +807,198 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
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
> +	u16 clk_ctrl;
> +	u16 ctrl2;
> +
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

clk_ctrl is not used?

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
> +	u8 rst;
> +
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
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
> +				     10, 100000, false, host, SDHCI_SOFTWARE_RESET)) {
> +		pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(host->mmc), (int)mask);
> +		sdhci_dumpregs(host);
> +		/* manual clear */
> +		sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
> +		return;
> +	}
> +}
> +
>  static inline void gl9767_vhs_read(struct pci_dev *pdev)
>  {
>  	u32 vhs_enable;
> @@ -1086,6 +1306,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
> +	gl9755_vendor_init(host);
>  
>  	return 0;
>  }
> @@ -1524,17 +1745,24 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
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

