From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC] mmc: host: sdhci-msm: Use the interconnect API
Date: Wed, 28 Nov 2018 14:23:34 -0800
Message-ID: <20181128222333.GA24969@minitux>
References: <20181011120336.9129-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011120336.9129-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu 11 Oct 05:03 PDT 2018, Georgi Djakov wrote:

> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
> 
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the SD host controller and report the needed bandwidth
> based on the clock rate, bus width and mode.
> 

Although the Qualcomm SDHCI driver is our primary target, wouldn't it be
possible to add this in the mmc core or sdhci helper functions instead,
so that other platforms doesn't need to duplicate this code?

[..]
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
[..]
> @@ -1917,6 +1957,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
> +	icc_set(msm_host->path, 0, 0);

The use sdhci_msm_icc_update() to enable a bus vote and icc_set() to
disable the vote lacks symmetry. Please see if this can be improved,
e.g. by passing a boolean to the update function to "enable"/"disable"
the vote.

>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);
>  
> @@ -1929,6 +1970,7 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
> +	sdhci_msm_icc_update(msm_host);
>  	return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>  				       msm_host->bulk_clks);
>  }

Regards,
Bjorn
