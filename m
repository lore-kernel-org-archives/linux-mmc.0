From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: tegra: Reformat compatible string list
Date: Thu, 16 Mar 2017 15:46:31 +0100
Message-ID: <CAPDyKFo1__Ye8+4AN6U8yp_QToESmyPg+pb1i-gNFPzq2nrYOQ@mail.gmail.com>
References: <20170314190152.9167-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170314190152.9167-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 14 March 2017 at 20:01, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> The list of compatible strings is somewhat difficult to read and extend.
> Reformat it into a list to make it more easily extensible.
>
> While at it, also remove the "plus one of the above" clause because it
> isn't actually valid.
>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt          | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 15b8368ee1f2..c15aa22d4570 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -7,11 +7,12 @@ This file documents differences between the core properties described
>  by mmc.txt and the properties used by the sdhci-tegra driver.
>
>  Required properties:
> -- compatible : For Tegra20, must contain "nvidia,tegra20-sdhci".
> -  For Tegra30, must contain "nvidia,tegra30-sdhci".  For Tegra114,
> -  must contain "nvidia,tegra114-sdhci".  For Tegra124, must contain
> -  "nvidia,tegra124-sdhci".  Otherwise, must contain "nvidia,<chip>-sdhci",
> -  plus one of the above, where <chip> is tegra132 or tegra210.
> +- compatible : should be one of:
> +  - "nvidia,tegra20-sdhci": for Tegra20
> +  - "nvidia,tegra30-sdhci": for Tegra30
> +  - "nvidia,tegra114-sdhci": for Tegra114
> +  - "nvidia,tegra124-sdhci": for Tegra124 and Tegra132
> +  - "nvidia,tegra210-sdhci": for Tegra210
>  - clocks : Must contain one entry, for the module clock.
>    See ../clocks/clock-bindings.txt for details.
>  - resets : Must contain an entry for each entry in reset-names.
> --
> 2.12.0
>
