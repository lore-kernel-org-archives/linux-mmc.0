From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: fix inconsistent IS_ERR and PTR_ERR
Date: Tue, 4 Sep 2018 16:34:36 +0200
Message-ID: <CAPDyKFqSqsXLt0HPJNXbmsfia53yHk5GaPhDpGo=NL1nMp-JRw@mail.gmail.com>
References: <20180904025909.13700-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904025909.13700-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 4 September 2018 at 04:59, YueHaibing <yuehaibing@huawei.com> wrote:
> Fix inconsistent IS_ERR and PTR_ERR in tegra_sdhci_init_pinctrl_info,
> the proper pointer to be passed as argument is 'pinctrl_state_1v8'
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e80716c..c789158 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -724,7 +724,7 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
>         if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
>                 dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
> -                        PTR_ERR(tegra_host->pinctrl_state_3v3));
> +                        PTR_ERR(tegra_host->pinctrl_state_1v8));
>                 return -1;
>         }
>
> --
> 2.7.0
>
>
