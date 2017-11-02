From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY
 attribute
Date: Wed, 1 Nov 2017 19:08:14 -0500
Message-ID: <20171102000814.ih2ggtfpmfsx3xap@rob-hp-laptop>
References: <20171101002132.13500-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171101002132.13500-1-ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 01, 2017 at 12:21:32AM +0000, Ard Biesheuvel wrote:
> The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
> requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
> F_SDH30_ESD_CONTROL control register.
> 
> So let's add an optional property to this device's binding, and
> set the attribute if it is present in the DT node.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt |  2 ++
>  drivers/mmc/host/sdhci_f_sdh30.c                        | 18 +++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> index de2c53cff4f1..9ad02f743ad0 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> @@ -15,6 +15,8 @@ Required properties:
>  Optional properties:
>  - vqmmc-supply: phandle to the regulator device tree node, mentioned
>    as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- cmd-dat-delay-select: boolean property indicating that this host requires
> +  the CMD_DAT_DELAY control to be enabled.

Needs a vendor prefix unless this is a standard SDHCI bit (in which 
case it should be documented in a common spot).

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
