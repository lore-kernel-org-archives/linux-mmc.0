From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Thu, 17 Sep 2015 13:44:42 +0200
Message-ID: <CAPDyKFqgHwb7a+wbO_mB6NLGrYtQvTqeeHWhfaz_LX_DoMdmpA@mail.gmail.com>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442212161-23234-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: =Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 14 September 2015 at 08:29, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> This patch adds Generic PHY access for sdhci-of-arasan. Driver
> can get PHY handler from dt-binding, and power-on/init the PHY.
> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
> Currently, it's just mandatory for arasan,sdhci-5.1.

I am trying to understand how a PHY can be used together with a
MMC/SD/SDIO controller. Normally the card connector doesn't hold any
intelligence, so I wonder if PHY is correctly used here.

Could you try to explain, HW-wise, what role the PHY has for you?

Kind regards
Uffe

>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> Serise-changes: 2
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
>
> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 97 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 75379cb..2c13ef8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -21,6 +21,7 @@
>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/phy/phy.h>
>  #include "sdhci-pltfm.h"
>
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET   0x2c
> @@ -35,6 +36,7 @@
>   */
>  struct sdhci_arasan_data {
>         struct clk      *clk_ahb;
> +       struct phy      *phy;
>  };
>
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
> @@ -70,6 +72,62 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>
>  #ifdef CONFIG_PM_SLEEP
>  /**
> +  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
> +  * @phy:        Handler of phy structure
> +  * Returns 0 on success and error value on error
> +  *
> +  * Put the phy in a deactive state.
> +  */
> +static int sdhci_arasan_suspend_phy(struct phy *phy)
> +{
> +       int ret;
> +
> +       ret = phy_exit(phy);
> +       if (ret < 0)
> +               goto err_phy_exit;
> +
> +       ret = phy_power_off(phy);
> +       if (ret < 0)
> +               goto err_phy_pwr_off;
> +
> +       return 0;
> +
> +err_phy_pwr_off:
> +       phy_power_on(phy);
> +err_phy_exit:
> +       phy_init(phy);
> +       return ret;
> +}
> +
> +/**
> +  * sdhci_arasan_resume_phy - Resume phy method for the driver
> +  * @phy:        Handler of phy structure
> +  * Returns 0 on success and error value on error
> +  *
> +  * Put the phy in a active state.
> +  */
> +static int sdhci_arasan_resume_phy(struct phy *phy)
> +{
> +       int ret;
> +
> +       ret = phy_power_on(phy);
> +       if (ret < 0)
> +               goto err_phy_pwr_on;
> +
> +       ret = phy_init(phy);
> +       if (ret < 0)
> +               goto err_phy_init;
> +
> +       return 0;
> +
> +err_phy_init:
> +       phy_exit(phy);
> +err_phy_pwr_on:
> +       phy_power_off(phy);
> +       return ret;
> +}
> +
> +/**
>   * sdhci_arasan_suspend - Suspend method for the driver
>   * @dev:       Address of the device structure
>   * Returns 0 on success and error value on error
> @@ -91,6 +149,12 @@ static int sdhci_arasan_suspend(struct device *dev)
>         clk_disable(pltfm_host->clk);
>         clk_disable(sdhci_arasan->clk_ahb);
>
> +       if (sdhci_arasan->phy) {
> +               ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
>         return 0;
>  }
>
> @@ -122,6 +186,12 @@ static int sdhci_arasan_resume(struct device *dev)
>                 return ret;
>         }
>
> +       if (sdhci_arasan->phy) {
> +               ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
>         return sdhci_resume_host(host);
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
> @@ -166,6 +236,33 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
>
> +       sdhci_arasan->phy = NULL;
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "arasan,sdhci-5.1")) {
> +               sdhci_arasan->phy = devm_phy_get(&pdev->dev,
> +                                                "phy_arasan");
> +               if (IS_ERR(sdhci_arasan->phy)) {
> +                       ret = -ENODEV;
> +                       dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
> +                       goto clk_dis_ahb;
> +               }
> +
> +               ret = phy_power_on(sdhci_arasan->phy);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "phy_power_on err.\n");
> +                       phy_power_off(sdhci_arasan->phy);
> +                       goto clk_dis_ahb;
> +               }
> +
> +               ret = phy_init(sdhci_arasan->phy);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "phy_init err.\n");
> +                       phy_exit(sdhci_arasan->phy);
> +                       phy_power_off(sdhci_arasan->phy);
> +                       goto clk_dis_ahb;
> +               }
> +       }
> +
>         host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
