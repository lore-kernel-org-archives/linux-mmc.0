From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Date: Thu, 8 Aug 2019 10:35:08 +0300
Message-ID: <2f5477ef-e30b-fabc-50d9-5ecbd0fcd0f3@intel.com>
References: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 8/08/19 12:10 AM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
> ---
> change in V5:
>  1. split 2 patches into 3 patches
>  2. make dll_adjust_count start from 0
>  3. fix ret overwritten issue
>  4. use break instead of goto
> 
> change in V4:
>  1. add a bug fix for V3
> 
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
> 
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 111 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index c780888..443d2a3 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -55,9 +55,17 @@
>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> +#define  O2_DLL_LOCK_STATUS	BIT(11)
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static const u32 dmdn_table[4] = {0x2B1C0000,

The size is not needed here i.e.

static const u32 dmdn_table[] = {0x2B1C0000,

> +	0x2C1A0000, 0x371B0000, 0x35100000};

But please define the constant:

#define DMDN_SZ ARRAY_SIZE(dmdn_table)

> +
> +struct o2_host {
> +	u8 dll_adjust_count;
> +};
> +
>  static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
>  {
>  	ktime_t timeout;
> @@ -153,6 +161,32 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  			       O2_SD_PLL_SETTING, scratch_32);
>  }
>  
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	usleep_range(5000, 6000);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
> +		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
> +			mmc_hostname(host->mmc));
> +	}
> +
> +	/* Detect 1 s */
> +	timeout = ktime_add_ms(ktime_get(), 1000);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (!(scratch32 & O2_DLL_LOCK_STATUS))
> +			return 0;
> +
> +		if (timedout)
> +			return 1;

There should be a usleep_range here.

> +	}
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -190,6 +224,66 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	sdhci_reset_tuning(host);
>  }
>  
> +/* this function is used to fix o2 dll shift issue */
> +static int sdhci_o2_dll_recovery(struct sdhci_host *host)
> +{
> +	int ret = 0;
> +	u8 scratch_8 = 0;
> +	u32 scratch_32 = 0;
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct sdhci_pci_chip *chip = slot->chip;
> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
> +
> +	/* Disable clock */
> +	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +	while (o2_host->dll_adjust_count < 4 && 0 == ret) {

Please use DMDN_SZ here instead of 4

> +		/* UnLock WP */
> +		pci_read_config_byte(chip->pdev,
> +				O2_SD_LOCK_WP, &scratch_8);
> +		scratch_8 &= 0x7f;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +		/* PLL software reset */
> +		scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		scratch_32 |= O2_PLL_SOFT_RESET;
> +		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +		pci_read_config_dword(chip->pdev,
> +					    O2_SD_FUNC_REG4,
> +					    &scratch_32);
> +		/* Enable Base Clk setting change */
> +		scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> +		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
> +		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
> +		o2_host->dll_adjust_count++;
> +		/* Enable internal clock */
> +		scratch_8 = SDHCI_CLOCK_INT_EN;
> +		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
> +
> +		if (sdhci_o2_get_cd(host->mmc)) {
> +			if (sdhci_o2_wait_dll_detect_lock(host)) {
> +				scratch_8 |= SDHCI_CLOCK_CARD_EN;
> +				sdhci_writeb(host, scratch_8,
> +					SDHCI_CLOCK_CONTROL);
> +				ret = 1;
> +			} else {
> +				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
> +					mmc_hostname(host->mmc),
> +					o2_host->dll_adjust_count);
> +			}
> +		}

if !sdhci_o2_get_cd(host->mmc) this will loop forever

> +	}
> +	if (o2_host->dll_adjust_count == 5)

Shouldn't that be:

	if (!ret && o2_host->dll_adjust_count == DMDN_SZ)

> +		pr_err("%s: DLL adjust over max times\n",
> +		mmc_hostname(host->mmc));
> +	/* Lock WP */
> +	pci_read_config_byte(chip->pdev,
> +				   O2_SD_LOCK_WP, &scratch_8);
> +	scratch_8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	return ret;
> +}
> +
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -204,7 +298,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
>  		return -EINVAL;
> -
> +	/*
> +	 * Judge the tuning reason, whether caused by dll shift
> +	 * If cause by dll shift, should call sdhci_o2_dll_recovery
> +	 */
> +	if (!sdhci_o2_wait_dll_detect_lock(host))
> +		if (!sdhci_o2_dll_recovery(host)) {
> +			pr_err("%s: o2 dll recovery failed\n",
> +				mmc_hostname(host->mmc));
> +			return -EINVAL;
> +		}
>  	/*
>  	 * o2 sdhci host didn't support 8bit emmc tuning
>  	 */
> @@ -371,7 +474,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  	/* Enable internal clock */
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -

Please leave the blank line. It improves readability.

> +	sdhci_o2_enable_internal_clock(host);
>  	if (sdhci_o2_get_cd(host->mmc)) {
>  		clk |= SDHCI_CLOCK_CARD_EN;
>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -397,12 +500,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> +	struct o2_host *o2_host = sdhci_pci_priv(slot);
>  	u32 reg, caps;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> -

Please leave the blank line. It improves readability.

> +	o2_host->dll_adjust_count = 0;
>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
>  	/*
> @@ -689,4 +793,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>  	.resume = sdhci_pci_o2_resume,
>  #endif
>  	.ops = &sdhci_pci_o2_ops,
> +	.priv_size = sizeof(struct o2_host),
>  };
> 
