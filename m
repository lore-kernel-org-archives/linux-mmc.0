From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 2/2] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Date: Tue, 6 Aug 2019 14:28:58 +0300
Message-ID: <882064c3-3228-464e-d517-eee7c18c02c4@intel.com>
References: <1564767615-4566-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564767615-4566-1-git-send-email-shirley.her@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 2/08/19 8:40 PM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> 
> Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
> ---
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 305 ++++++++++++++++++++++++-----------
>  1 file changed, 208 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 186a33d..aee0d15 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -55,9 +55,138 @@
>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> +#define  O2_DLL_LOCK_STATUS	BIT(11)
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static const u32 dmdn_table[5] = {0x25100000, 0x2B1C0000,
> +	0x2C1A0000, 0x371B0000, 0x35100000};
> +
> +struct o2_host {
> +	u8 dll_adjust_count;
> +};
> +
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
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 |= O2_PLL_SOFT_RESET;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +	udelay(1);
> +	scratch32 &= ~(O2_PLL_SOFT_RESET);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* PLL force active */
> +	scratch32 |= O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
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
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +static int sdhci_o2_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
> +		sdhci_o2_enable_internal_clock(host);
> +
> +	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> +}
> +
> +static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)

Please make a separate patch (i.e. 3 patches total) for moving the existing
functions: sdhci_o2_wait_card_detect_stable, sdhci_o2_enable_internal_clock,
sdhci_o2_get_cd, o2_pci_set_baseclk

> +{
> +	u32 scratch_32;
> +
> +	pci_read_config_dword(chip->pdev,
> +			      O2_SD_PLL_SETTING, &scratch_32);
> +
> +	scratch_32 &= 0x0000FFFF;
> +	scratch_32 |= value;
> +
> +	pci_write_config_dword(chip->pdev,
> +			       O2_SD_PLL_SETTING, scratch_32);
> +}
> +
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
> +	}
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -73,7 +202,6 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	int i;
>  
>  	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
> -
>  	for (i = 0; i < 150; i++) {
>  		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  
> @@ -95,12 +223,87 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
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
> +	while (o2_host->dll_adjust_count < 5) {
> +		o2_host->dll_adjust_count++;

So dll_adjust_count will always be at least 1, which means dmdn_table[0] is
never used?

> +		/* UnLock WP */
> +		ret = pci_read_config_byte(chip->pdev,
> +				O2_SD_LOCK_WP, &scratch_8);
> +		if (ret)
> +			return ret;
> +
> +		scratch_8 &= 0x7f;
> +		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +		/* PLL software reset */
> +		scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		scratch_32 |= O2_PLL_SOFT_RESET;
> +		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +		ret = pci_read_config_dword(chip->pdev,
> +					    O2_SD_FUNC_REG4,
> +					    &scratch_32);
> +		/* Enable Base Clk setting change */
> +		scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> +		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
> +		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
> +
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

'ret' always gets overwritten

> +				goto out;

Please use 'break' instead of 'goto'

> +			} else {
> +				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
> +					mmc_hostname(host->mmc),
> +					o2_host->dll_adjust_count);
> +			}
> +		}

Does it make sense to continue if there is no card at this point?

> +	}
> +out:
> +	if (o2_host->dll_adjust_count == 5)
> +		pr_err("%s: DLL adjust over max times\n",
> +		mmc_hostname(host->mmc));
> +	/* Lock WP */
> +	ret = pci_read_config_byte(chip->pdev,
> +				   O2_SD_LOCK_WP, &scratch_8);
> +	if (ret)
> +		return ret;
> +	scratch_8 |= 0x80;
> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +	return ret;
> +}
> +
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	int current_bus_width = 0;
>  
>  	/*
> +	 * Judge the tuning reason, whether caused by dll shift
> +	 * If cause by dll shift, should call sdhci_o2_dll_recovery
> +	 */
> +	if (!sdhci_o2_wait_dll_detect_lock(host))
> +		sdhci_o2_dll_recovery(host);
> +
> +	/*
>  	 * This handler only implements the eMMC tuning that is specific to
>  	 * this controller.  Fall back to the standard method for other TIMING.
>  	 */
> @@ -131,24 +334,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
>  		sdhci_set_bus_width(host, current_bus_width);
>  	}
> -
>  	host->flags &= ~SDHCI_HS400_TUNING;
>  	return 0;
>  }
>  
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> -{
> -	u32 scratch_32;
> -	pci_read_config_dword(chip->pdev,
> -			      O2_SD_PLL_SETTING, &scratch_32);
> -
> -	scratch_32 &= 0x0000FFFF;
> -	scratch_32 |= value;
> -
> -	pci_write_config_dword(chip->pdev,
> -			       O2_SD_PLL_SETTING, scratch_32);
> -}
> -
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>  {
>  	int ret;
> @@ -284,92 +473,12 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  	host->irq = pci_irq_vector(chip->pdev, 0);
>  }
>  
> -static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u32 scratch32;
> -
> -	/* Wait max 50 ms */
> -	timeout = ktime_add_ms(ktime_get(), 50);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> -		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> -			break;
> -
> -		if (timedout) {
> -			pr_err("%s: Card Detect debounce never finished.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			return;
> -		}
> -		udelay(10);
> -	}
> -}
> -
> -static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u16 scratch;
> -	u32 scratch32;
> -
> -	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> -	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> -	udelay(1);
> -	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> -
> -	/* PLL force active */
> -	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> -
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> -		if (scratch & O2_PLL_LOCK_STATUS)
> -			break;
> -		if (timedout) {
> -			pr_err("%s: Internal clock never stabilised.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			goto out;
> -		}
> -		udelay(10);
> -	}
> -
> -	/* Wait for card detect finish */
> -	udelay(1);
> -	sdhci_o2_wait_card_detect_stable(host);
> -
> -out:
> -	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> -	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> -}
> -
> -static int sdhci_o2_get_cd(struct mmc_host *mmc)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -
> -	sdhci_o2_enable_internal_clock(host);
> -
> -	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> -}
> -
>  static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  {
>  	/* Enable internal clock */
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -
> +	sdhci_o2_enable_internal_clock(host);
>  	if (sdhci_o2_get_cd(host->mmc)) {
>  		clk |= SDHCI_CLOCK_CARD_EN;
>  		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -395,12 +504,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
> +	o2_host->dll_adjust_count = 0;
>  	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>  
>  	/*
> @@ -687,4 +797,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>  	.resume = sdhci_pci_o2_resume,
>  #endif
>  	.ops = &sdhci_pci_o2_ops,
> +	.priv_size = sizeof(struct o2_host),
>  };
> 
