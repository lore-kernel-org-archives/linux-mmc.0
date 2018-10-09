From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/6] dt-bindings: mmc: sdhci-of-arasan: Add new compatible
 for AM654 MMC PHY
Date: Tue, 9 Oct 2018 09:30:15 +0200
Message-ID: <CAPDyKFqBTFAu7M-KBnsUWbLSJYPh5ecLF2md96Pr-jZiNYKs0g@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-4-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Add a new compatible to use the host controller driver with the
> MMC PHY on TI's AM654 SOCs
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index f6ddba31cb73..e2effe17f05e 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -15,6 +15,7 @@ Required Properties:
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> --
> 2.18.0
>
