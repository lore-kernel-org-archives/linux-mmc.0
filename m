From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 041/102] mmc: tegra: explicitly request exclusive reset control
Date: Thu, 27 Jul 2017 16:49:05 +0200
Message-ID: <CAPDyKFqaae9L=H68kFZDXdwLj=ofuorWvpR8w-0ye3k4RPN7nw@mail.gmail.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de> <20170719152646.25903-42-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-42-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 July 2017 at 17:25, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>


Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7f93079c7a3ad..f668a6fa17654 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -508,7 +508,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         clk_prepare_enable(clk);
>         pltfm_host->clk = clk;
>
> -       tegra_host->rst = devm_reset_control_get(&pdev->dev, "sdhci");
> +       tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
> +                                                          "sdhci");
>         if (IS_ERR(tegra_host->rst)) {
>                 rc = PTR_ERR(tegra_host->rst);
>                 dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
> --
> 2.11.0
>
