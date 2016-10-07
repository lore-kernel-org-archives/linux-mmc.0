From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v2 4/4] mmc: dw_mmc-rockchip: disable biu clk and genpd
 if possible
Date: Fri, 07 Oct 2016 13:15:55 +0900
Message-ID: <b9180674-648a-d2d1-0221-cec90b73adab@samsung.com>
References: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160930084711epcas1p39c48a870457a6f9985574963ae683354@epcas1p3.samsung.com>
 <1475225317-2815-5-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <1475225317-2815-5-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 09/30/2016 05:48 PM, Shawn Lin wrote:
> We could disable biu clk and power-off genpd if gpio
> card detect available.
> 
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  drivers/mmc/host/dw_mmc-rockchip.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 3ad041c..e7b3b6d 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -13,6 +13,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
>  #include <linux/of_address.h>
> +#include <linux/mmc/slot-gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
> @@ -366,14 +367,29 @@ static int dw_mci_rockchip_remove(struct platform_device *pdev)
>  static int dw_mci_rockchip_runtime_suspend(struct device *dev)
>  {
>  	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret;
>  
> -	return dw_mci_runtime_suspend(host);
> +	ret = dw_mci_runtime_suspend(host);
> +	if (ret)
> +		return ret;
> +
> +	if (mmc_can_gpio_cd(host->slot[0]->mmc)) {

Can use cur_slot instead of slot[0]? And doesn't need to check "host->slot[]" or "host->cur_slot"?

Best Regards,
Jaehoon Chung

> +		clk_disable_unprepare(host->biu_clk);
> +		pm_runtime_put(dev);
> +	}
> +
> +	return 0;
>  }
>  
>  static int dw_mci_rockchip_runtime_resume(struct device *dev)
>  {
>  	struct dw_mci *host = dev_get_drvdata(dev);
>  
> +	if (mmc_can_gpio_cd(host->slot[0]->mmc)) {
> +		pm_runtime_get_sync(dev);
> +		clk_prepare_enable(host->biu_clk);
> +	}
> +
>  	return dw_mci_runtime_resume(host);
>  }
>  #endif /* CONFIG_PM */
> 
