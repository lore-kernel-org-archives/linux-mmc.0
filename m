From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3 2/2] mmc: sdhci-brcmstb: Fix incorrect capability
Date: Thu, 8 Sep 2016 10:57:11 +0300
Message-ID: <0f29f3f5-67d4-9ce1-eaee-6406c424b06b@intel.com>
References: <20160830063010.10171-1-jaedon.shin@gmail.com>
 <20160830063010.10171-3-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160830063010.10171-3-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30/08/16 09:30, Jaedon Shin wrote:
> Clear incorrect SDHCI_CAN_64BIT capatility on Broadcom MIPS based SoCs.

capatility -> capability

> The MIPS based SoCs are using ADMA only, but the several SoCs have
> incorrect capability bit about ADMA 64-bit. The "brcm,bcm7425-sdhci" is
> compatible string for MIPS based SoC.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index cce10fe3e19e..464d9f9a4c06 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -98,6 +98,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	 * properties through mmc_of_parse().
>  	 */
>  	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (of_device_is_compatible(pdev->dev.of_node, "brcm,bcm7425-sdhci"))
> +		host->caps &= ~SDHCI_CAN_64BIT;
>  	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>  	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>  			SDHCI_SUPPORT_DDR50);
> @@ -121,6 +123,7 @@ err_clk:
>  
>  static const struct of_device_id sdhci_brcm_of_match[] = {
>  	{ .compatible = "brcm,bcm7425-sdhci" },
> +	{ .compatible = "brcm,bcm7445-sdhci" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
