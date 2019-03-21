From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Date: Thu, 21 Mar 2019 11:32:54 +0100
Message-ID: <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com> <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Harjani Ritesh <riteshh@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, anrao@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Mar 2019 at 22:45, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Default tap and trim values are incorrect for Tegra186 SDMMC4.
> This patch fixes it.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Is this a fix and/or for stable?

In either case, I am leaving this for arm-soc.

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 97aeb946ed5e..472f55fe9488 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -317,8 +317,8 @@
>                 nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
>                 nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
>                 nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
> -               nvidia,default-tap = <0x5>;
> -               nvidia,default-trim = <0x9>;
> +               nvidia,default-tap = <0x9>;
> +               nvidia,default-trim = <0x5>;
>                 nvidia,dqs-trim = <63>;
>                 mmc-hs400-1_8v;
>                 status = "disabled";
> --
> 2.7.4
>
