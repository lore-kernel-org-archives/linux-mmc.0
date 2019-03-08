From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci-of-arasan: Add DTS property to disable
 DCMDs.
Date: Fri, 8 Mar 2019 14:47:19 +0200
Message-ID: <9136f429-251a-87d3-8d6e-bf07c6882c8a@intel.com>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Viresh Kumar <viresh.kumar@linaro.org>, Emil Renner Berthing <kernel@esmil.dk>, Lin Huang <hl@rock-chips.com>, Tony Xie <tony.xie@rock-chips.com>, Randy Li <ayaka@soulik.info>, Vicente Bergas <vicencb@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 7/03/19 10:43 AM, Christoph Muellner wrote:
> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> which exposes a control register bit to enable the feature.
> The current implementation sets this bit unconditionally.
> 
> This patch allows to suppress the feature activation,
> by specifying the property disable-cqe-dcmd.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..88dc3f00a5be 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		host->mmc_host_ops.start_signal_voltage_switch =
>  					sdhci_arasan_voltage_switch;
>  		sdhci_arasan->has_cqe = true;
> -		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +		host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
> +			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  
>  	ret = sdhci_arasan_add_host(sdhci_arasan);
> 
