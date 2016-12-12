From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Mon, 12 Dec 2016 11:14:08 -0600
Message-ID: <20161212171408.2yf4jauz7czv44fy@rob-hp-laptop>
References: <1481201455-3483-1-git-send-email-yamada.masahiro@socionext.com>
 <1481201455-3483-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481201455-3483-3-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Andrei Pistirica <andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 08, 2016 at 09:50:55PM +0900, Masahiro Yamada wrote:
> Add a driver for the Cadence SD4HC SD/SDIO/eMMC Controller.
> 
> For SD, it basically relies on the SDHCI standard code.
> For eMMC, this driver provides some callbacks to support the
> hardware part that is specific to this IP design.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> 
> Changes in v5:
>   - Fix calculation of the center of the tuned window
> 
> Changes in v4:
>   - Override mmc_host_ops.execute_tuning instead of the
>     .platform_execute_tuning implementation
> 
> Changes in v3:
>   - Remove unneeded explanation about HRS and SRS from DT binding;
>     the offsets to HRS/SRS are fixed for this hardware and this is
>     quite normal, like each hardware has a fixed register view except
>     the register base.  The detailed register map is what the driver
>     cares about, so no need to explain it in the binding.
> 
> Changes in v2:
>   - Remove unnecessary "select MMC_SDHCI_IO_ACCESSORS"
> 
>  .../devicetree/bindings/mmc/sdhci-cadence.txt      |  30 +++
>  drivers/mmc/host/Kconfig                           |  11 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-cadence.c                   | 283 +++++++++++++++++++++
>  4 files changed, 325 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>  create mode 100644 drivers/mmc/host/sdhci-cadence.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> new file mode 100644
> index 0000000..750374f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -0,0 +1,30 @@
> +* Cadence SD/SDIO/eMMC Host Controller
> +
> +Required properties:
> +- compatible: should be "cdns,sd4hc".

Needs SoC specific compatible strings too.

> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: phandle to the input clock.
> +
> +Optional properties:
> +For eMMC configuration, supported speed modes are not indicated by the SDHCI
> +Capabilities Register.  Instead, the following properties should be specified
> +if supported.  See mmc.txt for details.
> +- mmc-ddr-1_8v
> +- mmc-ddr-1_2v
> +- mmc-hs200-1_8v
> +- mmc-hs200-1_2v
> +- mmc-hs400-1_8v
> +- mmc-hs400-1_2v

There's now a property to override SDHCI capabilities register. Maybe 
you should use that instead? I'll defer to Ulf.

> +
> +Example:
> +	emmc: sdhci@5a000000 {
> +		compatible = "cdns,sd4hc";
> +		reg = <0x5a000000 0x400>;
> +		interrupts = <0 78 4>;
> +		clocks = <&clk 4>;
> +		bus-width = <8>;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		mmc-hs400-1_8v;
> +	};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
