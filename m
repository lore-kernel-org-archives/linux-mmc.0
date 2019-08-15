From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 1/3] mmc: sdhci: Change O2 Host PLL and DLL register
 name
Date: Thu, 15 Aug 2019 14:07:06 +0300
Message-ID: <242852f2-a70e-c233-7893-eb7b346950a9@intel.com>
References: <1565372245-4598-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565372245-4598-1-git-send-email-shirley.her@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>, "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 9/08/19 8:37 PM, Shirley Her (SC) wrote:
> Change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1
> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>

Please change the subject to:

mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL register name

> ---
> change in V6:
>  1. change subject and commit message to match the patch
>  2. change register name O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1
> 
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548..b3a33d9 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -51,7 +51,7 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_DISABLE	BIT(4)
>  
> -#define O2_PLL_WDT_CONTROL1	0x1CC
> +#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
>  #define  O2_PLL_FORCE_ACTIVE	BIT(18)
>  #define  O2_PLL_LOCK_STATUS	BIT(14)
>  #define  O2_PLL_SOFT_RESET	BIT(12)
> @@ -316,23 +316,23 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  	u32 scratch32;
>  
>  	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  	udelay(1);
>  	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* PLL force active */
>  	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  
>  	/* Wait max 20 ms */
>  	timeout = ktime_add_ms(ktime_get(), 20);
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> -		scratch = sdhci_readw(host, O2_PLL_WDT_CONTROL1);
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
>  		if (scratch & O2_PLL_LOCK_STATUS)
>  			break;
>  		if (timedout) {
> @@ -350,9 +350,9 @@ static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
>  
>  out:
>  	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_WDT_CONTROL1);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
>  	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
>  }
>  
>  static int sdhci_o2_get_cd(struct mmc_host *mmc)
> 
