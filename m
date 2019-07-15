From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Fix the missing
 pm_runtime_put_noidle()
Date: Mon, 15 Jul 2019 14:26:33 +0300
Message-ID: <dddba0b9-2673-da62-3790-cd88e9dc0cc9@intel.com>
References: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc: vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 15/07/19 1:00 PM, Baolin Wang wrote:
> When the SD host controller tries to probe again due to the derferred
> probe mechanism, it will always keep the SD host device as runtime
> resume state due to missing the runtime put operation in error path
> last time.
> 
> Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
> counter balance, which can make the SD host device's PM runtime work well.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6ee340a..603a5d9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	sdhci_cleanup_host(host);
>  
>  pm_runtime_disable:
> +	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  
> 
