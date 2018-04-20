From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 28/61] mmc: host: simplify getting .drvdata
Date: Fri, 20 Apr 2018 09:10:20 +0200
Message-ID: <CAPDyKFrsnXeuHkAGM-w7hH_HuTr+n62Z1UziP0umNQB-oKn+8g@mail.gmail.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com> <20180419140641.27926-29-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-29-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, Tony Prisk <linux@prisktech.co.nz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 19 April 2018 at 16:05, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Build tested only. buildbot is happy. Please apply individually.
>
>  drivers/mmc/host/davinci_mmc.c     | 6 ++----
>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
>  drivers/mmc/host/wmt-sdmmc.c       | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 8e363174f9d6..9e68c3645e22 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1377,8 +1377,7 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM
>  static int davinci_mmcsd_suspend(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct mmc_davinci_host *host = platform_get_drvdata(pdev);
> +       struct mmc_davinci_host *host = dev_get_drvdata(dev);
>
>         writel(0, host->base + DAVINCI_MMCIM);
>         mmc_davinci_reset_ctrl(host, 1);
> @@ -1389,8 +1388,7 @@ static int davinci_mmcsd_suspend(struct device *dev)
>
>  static int davinci_mmcsd_resume(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct mmc_davinci_host *host = platform_get_drvdata(pdev);
> +       struct mmc_davinci_host *host = dev_get_drvdata(dev);
>
>         clk_enable(host->clk);
>         mmc_davinci_reset_ctrl(host, 0);
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7393bd..bed3612247b0 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -359,8 +359,7 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>   */
>  static int sdhci_arasan_suspend(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>         int ret;
> @@ -403,8 +402,7 @@ static int sdhci_arasan_suspend(struct device *dev)
>   */
>  static int sdhci_arasan_resume(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>         int ret;
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index fd30ac7da5e5..3ba42f508014 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -928,8 +928,7 @@ static int wmt_mci_remove(struct platform_device *pdev)
>  static int wmt_mci_suspend(struct device *dev)
>  {
>         u32 reg_tmp;
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct wmt_mci_priv *priv;
>
>         if (!mmc)
> @@ -953,8 +952,7 @@ static int wmt_mci_suspend(struct device *dev)
>  static int wmt_mci_resume(struct device *dev)
>  {
>         u32 reg_tmp;
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct wmt_mci_priv *priv;
>
>         if (mmc) {
> --
> 2.11.0
>
