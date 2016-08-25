From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 11:50:07 +0300
Message-ID: <38d4d636-dc98-cc3b-3397-75924200ef9f@intel.com>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <1472080984-17373-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472080984-17373-2-git-send-email-zach.brown@ni.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zach Brown <zach.brown@ni.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, soren.brinkmann@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On 25/08/16 02:23, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the cd bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function with out the cd bit.

with out -> without

> 
> The device property "fake-cd" will let the arasan driver know it needs
> to fake the cd bit for the controller inorder for the controller to

inorder -> in order

> function with a SD card that does not provide the CD bit.

Please use either 'cd' or 'CD' consistently.

> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 23 ++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.h           |  4 ++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e0f193f..a74bcf5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -26,6 +26,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include "sdhci-pltfm.h"
> +#include <linux/of.h>
>  
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
>  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
> @@ -203,12 +204,26 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>  
> +void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u8 ctrl;
> +
> +	sdhci_reset(host, mask);
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_NEED_FAKE_CD) {
> +		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);

Is there a reason this is sdhci_readl instead of sdhci_readb

> +		ctrl |= SDHCI_CTRL_CD_TEST_INSERTED |
> +		SDHCI_CTRL_CD_TEST_ENABLE;

Please indent SDHCI_CTRL_CD_TEST_ENABLE

> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
>  	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_arasan_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> @@ -516,6 +531,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	}
>  
>  	sdhci_get_of_property(pdev);
> +
> +	if (of_get_property(pdev->dev.of_node, "fake-cd", NULL))
> +		host->quirks2 |= SDHCI_QUIRK2_NEED_FAKE_CD;

Please don't use a quirk bit for this.  Instead add a flag to, for example,
struct sdhci_arasan_data.

> +
> +	pltfm_host = sdhci_priv(host);
> +	pltfm_host->priv = sdhci_arasan;

These 2 lines don't belong.

>  	pltfm_host->clk = clk_xin;
>  
>  	sdhci_arasan_update_baseclkfreq(host);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0411c9f..ff3c8ba 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -84,6 +84,8 @@
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
>  #define   SDHCI_CTRL_8BITBUS	0x20
> +#define  SDHCI_CTRL_CD_TEST_INSERTED   0x40
> +#define  SDHCI_CTRL_CD_TEST_ENABLE     0x80

For the sake of neatness, let's make these a little more abbreviated, say:

	SDHCI_CTRL_CDTEST_INS
	SDHCI_CTRL_CDTEST_EN

>  
>  #define SDHCI_POWER_CONTROL	0x29
>  #define  SDHCI_POWER_ON		0x01
> @@ -422,6 +424,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> +/* Controller needs the cd bit faked */
> +#define SDHCI_QUIRK2_NEED_FAKE_CD (1<<16)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 
