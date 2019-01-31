From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V11 2/4] arm64: dts: tegra: Add CQE Support for SDMMC4
Date: Thu, 31 Jan 2019 08:27:59 +0100
Message-ID: <CAPDyKFqth+VYZgx3iHGWaUFe=RyiOwoQwy2jEEtLnGXqvsPn-w@mail.gmail.com>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com> <1548271854-1765-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548271854-1765-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Jan 2019 at 20:30, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add CQE Support for Tegra186 and Tegra194 SDMMC4 controller
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

To be clear, I am not picking this one as this should go via arm-soc.

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 22815db4a3ed..3dfdc4701934 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -319,6 +319,7 @@
>                 nvidia,default-trim = <0x9>;
>                 nvidia,dqs-trim = <63>;
>                 mmc-hs400-1_8v;
> +               supports-cqe;
>                 status = "disabled";
>         };
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6dfa1ca0b851..9ce1c91d4596 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -325,6 +325,7 @@
>                         clock-names = "sdhci";
>                         resets = <&bpmp TEGRA194_RESET_SDMMC4>;
>                         reset-names = "sdhci";
> +                       supports-cqe;
>                         status = "disabled";
>                 };
>
> --
> 2.7.4
>
