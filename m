From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: Add support for o2 eMMC HS200 mode and
 hardware tuning
Date: Tue, 9 Jan 2018 14:36:33 +0200
Message-ID: <feb4d1f9-1180-ffc7-6d2e-1e062acd129e@intel.com>
References: <20171228095942.3994-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228095942.3994-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

On 28/12/17 11:59, ernest.zhang wrote:
> Add register definition for eMMC HS200 mode. Add bitmask definition
> for hardware tuning function.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.h | 3 +++

drivers/mmc/host/sdhci-pci-o2micro.h doesn't exist anymore.  Please re-base
on mmc tree next branch.  Also these changes do not need to be a separate
patch anyway.


>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-pci-o2micro.h
> index 770f53857211..5a4671d5a511 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.h
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.h
> @@ -49,6 +49,7 @@
>  #define O2_SD_MISC_CTRL4	0xFC
>  #define O2_SD_TUNING_CTRL	0x300
>  #define O2_SD_PLL_SETTING	0x304
> +#define O2_SD_MISC_SETTING	0x308
>  #define O2_SD_CLK_SETTING	0x328
>  #define O2_SD_CAP_REG2		0x330
>  #define O2_SD_CAP_REG0		0x334
> @@ -62,6 +63,8 @@
>  #define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
>  
>  #define O2_SD_VENDOR_SETTING	0x110
> +#define O2_SD_HW_TUNING_ENABLE	BIT(4)
> +
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  
>  extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
> 
