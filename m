From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci: Fix O2 Host PLL and card detect issue
Date: Fri, 21 Dec 2018 15:42:02 +0200
Message-ID: <4124aeab-b281-372f-7802-a699d3226da7@intel.com>
References: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Andy Dai (WH)" <andy.dai@bayhubtech.com>, "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "Mike Li (WH)" <mike.li@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 18/12/18 1:40 PM, Ernest Zhang(WH) wrote:
> From: "Ernest Zhang" <ernest.zhang@bayhubtech.com>
> 
> 1. O2 Host Controller PLL lock status is not in compliance with
> CLOCK_CONTROL register bit 1
> 2. O2 Host Controller card detect function only work when PLL is
> enabled and locked
> 
> Signed-off-by: Ernest Zhang <ernest.zhang@bayhubtech.com>

If you put the other patch first, then this patch will need some minor
modifications, otherwise I have no further comments.

> ---
> Change in V2:
> 	1. Remove unused sdhci_ops function pointer
> 	2. Change kind of timeout check, get the time first
> 	3. Rename CARD PRESENT register bit16 and bit 18 macro
> 
> Change in V1:
> 	N/A
> ---
>  drivers/mmc/host/sdhci-pci-core.c    |   9 +++
>  drivers/mmc/host/sdhci-pci-o2micro.c | 121 ++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-pci.h         |   1 +
>  drivers/mmc/host/sdhci.h             |   4 ++
>  4 files changed, 132 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 2a6eba74b94e..fc4f35653602 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1257,6 +1257,14 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
>  }
>  #endif
>  
> +static const struct sdhci_ops sdhci_pci_o2_ops = {
> +	.set_clock = sdhci_pci_o2_set_clock,
> +	.enable_dma = sdhci_pci_enable_dma,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_o2 = {
>  	.probe = sdhci_pci_o2_probe,
>  	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> @@ -1265,6 +1273,7 @@ static const struct sdhci_pci_fixes sdhci_o2 = {
>  #ifdef CONFIG_PM_SLEEP
>  	.resume = sdhci_pci_o2_resume,
>  #endif
> +	.ops = &sdhci_pci_o2_ops,
>  };
>  
>  static const struct sdhci_pci_fixes sdhci_jmicron = {
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index cc3ffeffd7a2..506b93e5dcd8 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -60,6 +60,13 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_DISABLE	BIT(4)
>  
> +#define O2_PLL_WDT_CONTROL1	0x1CC
> +#define  O2_PLL_FORCE_ACTIVE	BIT(18)
> +#define  O2_PLL_LOCK_STATUS	BIT(14)
> +#define  O2_PLL_SOFT_RESET	BIT(12)
> +
> +#define O2_SD_DETECT_SETTING 0x324
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -283,6 +290,113 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  	host->irq = pci_irq_vector(chip->pdev, 0);
>  }
>  
> +static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	/* Wait max 50 ms */
> +	timeout = ktime_add_ms(ktime_get(), 50);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> +		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> +			break;
> +
> +		if (timedout) {
> +			pr_err("%s: Card Detect debounce never finished.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +
> +static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u16 scratch;
> +	u32 scratch32;
> +
> +	/* PLL software reset */
> +	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 |= O2_PLL_SOFT_RESET;
> +	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	udelay(1);
> +	scratch32 &= ~(O2_PLL_SOFT_RESET);
> +	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +
> +	/* PLL force active */
> +	scratch32 |= O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> +		if (scratch & O2_PLL_LOCK_STATUS)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			goto out;
> +		}
> +		udelay(10);
> +	}
> +
> +	/* Wait for card detect finish */
> +	udelay(1);
> +	sdhci_o2_wait_card_detect_stable(host);
> +
> +out:
> +	/* Cancel PLL force active */
> +	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +}
> +
> +static int sdhci_o2_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	sdhci_o2_enable_internal_clock(host);
> +
> +	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> +}
> +
> +static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
> +{
> +	/* Enable internal clock */
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	if (sdhci_o2_get_cd(host->mmc)) {
> +		clk |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +	sdhci_o2_enable_clk(host, clk);
> +}
> +
>  int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
> @@ -316,7 +430,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  				host->flags |= SDHCI_SIGNALING_180;
>  				host->mmc->caps2 |= MMC_CAP2_NO_SD;
>  				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +				pci_write_config_dword(chip->pdev,
> +						       O2_SD_DETECT_SETTING, 3);
>  			}
> +
> +			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>  		}
>  
>  		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
> @@ -490,9 +608,6 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>  		break;
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> -		if (chip->pdev->revision == 0x01)
> -			chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> -		/* fall through */
>  	case PCI_DEVICE_ID_O2_SEABIRD1:
>  		/* UnLock WP */
>  		ret = pci_read_config_byte(chip->pdev,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 2ef0bdca9197..e41a85f0b40a 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -184,6 +184,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
>  #ifdef CONFIG_PM_SLEEP
>  int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
>  #endif
> +void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock);
>  
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  extern const struct sdhci_pci_fixes sdhci_snps;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6cc9a3c2ac66..924e03332cf7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -73,6 +73,10 @@
>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
>  #define  SDHCI_DATA_AVAILABLE	0x00000800
>  #define  SDHCI_CARD_PRESENT	0x00010000
> +#define   SDHCI_CARD_PRES_SHIFT	16
> +#define  SDHCI_CD_STABLE	0x00020000
> +#define  SDHCI_CD_LVL		0x00040000
> +#define   SDHCI_CD_LVL_SHIFT	18
>  #define  SDHCI_WRITE_PROTECT	0x00080000
>  #define  SDHCI_DATA_LVL_MASK	0x00F00000
>  #define   SDHCI_DATA_LVL_SHIFT	20
> 
