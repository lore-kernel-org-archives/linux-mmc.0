From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Mon, 7 Nov 2011 14:17:26 -0700
Message-ID: <20111107211726.GC28491@ponder.secretlab.ca>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's sdhci controller
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> +Example:
> +	sdhci@12530000 {
> +		compatible = "samsung,exynos4210-sdhci";
> +		reg = <0x12530000 0x100>;
> +		interrupts = <139>;
> +		samsung,sdhci-bus-width = <4>;
> +		linux,mmc_cap_4_bit_data;

Following on from my reply on patch 5, this is an example of exactly
what I'm talking about.  This node both sets bus-width to '4', and
sets the 4_bit_data flag.  Don't you think that the driver would be
smart enough to set the 4_bit_data flag when the bus width was set to
4?

g.
