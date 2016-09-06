From: Zach Brown <zach.brown@ni.com>
Subject: Re: [PATCH 2/2] sdhci-of-arasan: Set controller to test mode when
 fails-without-test-cd is present
Date: Tue, 6 Sep 2016 13:51:08 -0500
Message-ID: <20160906185107.GA5124@zach-desktop>
References: <1472512857-13063-1-git-send-email-zach.brown@ni.com>
 <1472512857-13063-2-git-send-email-zach.brown@ni.com>
 <13c1a30f-fb4f-a813-df0a-3ac9914cfa61@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <13c1a30f-fb4f-a813-df0a-3ac9914cfa61@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, soren.brinkmann@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 30, 2016 at 07:47:17AM +0200, Michal Simek wrote:
> On 30.8.2016 01:20, Zach Brown wrote:
> > The sdhci controller on xilinx zynq devices will not function unless
> > the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
> > In cases where it is impossible to provide the CD bit in hardware,
> > setting the controller to test mode and then setting inserted to true
> > will get the controller to function without the CD bit.
> > 
> > When the device has the property fails-without-test-cd the driver
> > changes the controller to test mode and sets test inserted to true to
> > make the controller function.
> > 
> > Signed-off-by: Zach Brown <zach.brown@ni.com>
> > ---
> >  drivers/mmc/host/sdhci-of-arasan.c | 34 +++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci.h           |  2 ++
> >  2 files changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> > index e0f193f..c3e5145 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/phy/phy.h>
> >  #include <linux/regmap.h>
> >  #include "sdhci-pltfm.h"
> > +#include <linux/of.h>
> > 
> >  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> >  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
> > @@ -92,6 +93,12 @@ struct sdhci_arasan_data {
> > 
> >  	struct regmap	*soc_ctl_base;
> >  	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> > +
> > +	unsigned int arasan_quirks; /* Arasan deviations from spec */
> > +
> > +/* Controller does not have CD wired and will not function normally without */
> > +#define SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD (1<<0)
> 
> Bit macro instead?
> 

Setting bits with notations like (1<<0) is the style which is used for quirks
in sdhci.h Is there a reason it should be different here?
> > +
> 
> remove this line.
> 
> >  };
> > 
> >  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
> > @@ -203,12 +210,32 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
> >  	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> >  }
> > 
> > +void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	u8 ctrl;
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct sdhci_arasan_data *sdhci_arasan;
> > +
> > +	sdhci_reset(host, mask);
> > +
> > +	pltfm_host = sdhci_priv(host);
> > +	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	if (sdhci_arasan->arasan_quirks &
> > +	    SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD) {
> > +		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > +		ctrl |= SDHCI_CTRL_CDTEST_INS |
> > +			SDHCI_CTRL_CDTEST_EN;
> > +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +	}
> > +}
> > +
> >  static struct sdhci_ops sdhci_arasan_ops = {
> >  	.set_clock = sdhci_arasan_set_clock,
> >  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> >  	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
> >  	.set_bus_width = sdhci_set_bus_width,
> > -	.reset = sdhci_reset,
> > +	.reset = sdhci_arasan_reset,
> >  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> >  };
> > 
> > @@ -516,6 +543,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
> >  	}
> > 
> >  	sdhci_get_of_property(pdev);
> > +
> > +	if (of_get_property(pdev->dev.of_node, "fails-without-test-cd", NULL))
> > +		sdhci_arasan->arasan_quirks |=
> > +				SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD;
> > +
> >  	pltfm_host->clk = clk_xin;
> > 
> >  	sdhci_arasan_update_baseclkfreq(host);
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 0411c9f..8d92d6e9 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -84,6 +84,8 @@
> >  #define   SDHCI_CTRL_ADMA32	0x10
> >  #define   SDHCI_CTRL_ADMA64	0x18
> >  #define   SDHCI_CTRL_8BITBUS	0x20
> > +#define  SDHCI_CTRL_CDTEST_INS   0x40
> > +#define  SDHCI_CTRL_CDTEST_EN     0x80
> 
> You should follow coding style above.

I don't understand the issue you're raising. Could you elaborate?
> 
> Thanks,
> Michal
> 
