From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND RFC 2/3] mmc: sdhci-msm: Implement platform_dumpregs
 callback in sdhci-msm
Date: Thu, 19 Jan 2017 12:55:02 +0200
Message-ID: <75b74517-39df-c6f4-4967-67c985a5d0e4@intel.com>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19020 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdASLBK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 06:01:10 -0500
In-Reply-To: <1484030515-16722-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

On 10/01/17 08:41, Ritesh Harjani wrote:
> From: Sahitya Tummala <stummala@codeaurora.org>
> 
> Implement ->platform_dumpregs host operation to print the
> platform specific registers in addition to standard SDHC
> register during error conditions.

You could add an example of the prints so we can see it looks nice.

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 32879b8..1241dbd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -29,6 +29,11 @@
>  #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
>  #define CORE_VERSION_MINOR_MASK		0xff
>  
> +#define CORE_MCI_DATA_CNT	0x30
> +#define CORE_MCI_STATUS		0x34
> +#define CORE_MCI_FIFO_CNT	0x44
> +#define CORE_MCI_STATUS2	0x6c
> +
>  #define CORE_HC_MODE		0x78
>  #define HC_MODE_EN		0x1
>  #define CORE_POWER		0x0
> @@ -77,6 +82,10 @@
>  #define CORE_HC_SELECT_IN_HS400	(6 << 19)
>  #define CORE_HC_SELECT_IN_MASK	(7 << 19)
>  
> +#define CORE_VENDOR_SPEC_FUNC2		0x110
> +#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR0	0x114
> +#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR1	0x118
> +
>  #define CORE_CSR_CDC_CTLR_CFG0		0x130
>  #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
>  #define CORE_HW_AUTOCAL_ENA		BIT(17)
> @@ -658,6 +667,30 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>  	return ret;
>  }
>  
> +static void sdhci_msm_dumpregs(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	pr_err("----------- PLATFORM REGISTER DUMP -----------\n");

"PLATFORM" isn't right here.  It should be something that identifies the IP
/ driver. e.g. "SDHCI MSM"

> +
> +	pr_err("Data cnt: 0x%08x | Fifo cnt: 0x%08x | Int sts: 0x%08x | Int sts2: 0x%08x\n",

What sdhci_dumpregs() should do is prefix the message with the host name i.e.

	pr_err("%s: sdhci: Sys addr: 0x%08x | Version:  0x%08x\n",
	       sdhci_readl(host, SDHCI_DMA_ADDRESS),
	       sdhci_readw(host, SDHCI_HOST_VERSION),
	       mmc_hostname(host->mmc));

And then we should do that here too.

> +	       readl_relaxed(msm_host->core_mem + CORE_MCI_DATA_CNT),
> +	       readl_relaxed(msm_host->core_mem + CORE_MCI_FIFO_CNT),
> +	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS),
> +	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS2));
> +	pr_err("DLL cfg:  0x%08x | DLL sts:  0x%08x | SDCC ver: 0x%08x\n",
> +	       readl_relaxed(host->ioaddr + CORE_DLL_CONFIG),
> +	       readl_relaxed(host->ioaddr + CORE_DLL_STATUS),
> +	       readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION));
> +	pr_err("Vndr func: 0x%08x | Vndr adma err : addr0: 0x%08x addr1: 0x%08x\n",
> +	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC),
> +	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR0),
> +	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR1));
> +	pr_err("Vndr func2: 0x%08x\n",
> +	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_FUNC2));
> +}
> +
>  static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	int tuning_seq_cnt = 3;
> @@ -1035,6 +1068,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>  	.voltage_switch = sdhci_msm_voltage_switch,
> +	.platform_dumpregs = sdhci_msm_dumpregs,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> 

