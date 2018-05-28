From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date: Mon, 28 May 2018 15:19:24 +0300
Message-ID: <CAHp75VcT+HEb67q0XbMvi9xQ4s0nyVKnoYRm5KN42z8h2FSu1g@mail.gmail.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 22, 2018 at 9:42 AM, Prabu Thangamuthu <Prabu.T@synopsys.com> wrote:
> To enable Synopsys DWC MSHC controller on HPAS-DX platform connected using
> PCIe interface. As Clock generation logic is implemented in MMCM module of
> HAPS-DX platform, we have separate functions to control the MMCM to
> generate required clocks with respect to speed mode. Also we have platform
> specific set_power function to support different VDD of eMMC devices.

> + * Authors:
> + *    Prabu Thangamuthu <prabu.t@synopsys.com>
> + *    Manjunath M B <manjumb@synopsys.com>
> + *

Redundant last line in above excerpt.

> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>

> +#include <linux/moduleparam.h>

This one is effectively included by module.h.

> +/* Default emmc vdd is set to 3.3V */
> +static unsigned int emmc_vdd = SDHC_EMMC_VDD_330V;
> +module_param(emmc_vdd, int, 0444);

This looks weird. Why do you need a module parameter?

> +    u16 clk = 0;
> +    u32 reg = 0;
> +    u32 vendor_ptr = 0;

Why do above have assignments?

> +MODULE_PARM_DESC(emmc_vdd, "VDD to configure eMMC device supply voltage");
This better to be near to the parameter declaration. Though, as I said
above, it feels wrong to have it in the first place.


> +/* Synopsys Vendor Specific Registers */
> +#define SDHC_GPIO_OUT                          0x34
> +#define SDHC_AT_CTRL_R                   0x40
> +
> +#define SDHC_SW_TUNE_EN                   0x00000010
> +
> +/* MMCM DRP */
> +#define SDHC_MMCM_DIV_REG               0x1020
> +#define DIV_REG_100_MHZ                   0x1145
> +
> +#define SDHC_MMCM_CLKFBOUT               0x1024
> +#define CLKFBOUT_100_MHZ               0x0000
> +
> +#define SDHC_CCLK_MMCM_RST               0x00000001

Do you need these all in the header file? Why?


> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xC202

Absent blank line.
Broken style of the value.

Who knows what else wrong with this patch? Please, pay attention to
the details and check twice before submit.

-- 
With Best Regards,
Andy Shevchenko
