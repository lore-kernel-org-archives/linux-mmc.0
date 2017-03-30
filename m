From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5 2/4] dt-bindings: mmc: add description of PHY delays for sdhci-cadence
Date: Thu, 30 Mar 2017 21:31:00 +0200
Message-ID: <CAPDyKFqdEvTHYeLXjD0dsfpNn_jR4DVWYxSNE7KYCPnCdCzTXQ@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35730 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934858AbdC3TbD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:31:03 -0400
Received: by mail-vk0-f51.google.com with SMTP id r69so67060354vke.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:31:01 -0700 (PDT)
In-Reply-To: <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 21 March 2017 at 15:33, Piotr Sroka <piotrs@cadence.com> wrote:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different chips/boards.
> Add description of new DLL PHY delays.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
> Changes for v2:
> - file was created in v2. It was a part of driver source file patch.
> - most delays were moved from dts file
>   to data associated with an SoC specific compatible
> - description of delays was updated to be more clearly
> ---
> Changes for v3:
> - move all delays back to dts because they are also boards dependent
> - prefix all of the Cadence-specific properties with cdns prefix
> ---
> Changes for v4:
> - change the beginning of the commit subject
> ---
> Changes for v5:
> - change name of property to be consistent with timing modes
>   available in Linux
> ---
>  .../devicetree/bindings/mmc/sdhci-cadence.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> index c0f37cb..fa423c2 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -19,6 +19,53 @@ if supported.  See mmc.txt for details.
>  - mmc-hs400-1_8v
>  - mmc-hs400-1_2v
>
> +Some PHY delays can be configured by following properties.
> +PHY DLL input delays:
> +They are used to delay the data valid window, and align the window
> +to sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
> +and it is increased by 2.5ns in each step.
> +- cdns,phy-input-delay-sd-highspeed:
> +  Value of the delay in the input path for SD high-speed timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-legacy:
> +  Value of the delay in the input path for legacy timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-sd-uhs-sdr12:
> +  Value of the delay in the input path for SD UHS SDR12 timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-sd-uhs-sdr25:
> +  Value of the delay in the input path for SD UHS SDR25 timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-sd-uhs-sdr50:
> +  Value of the delay in the input path for SD UHS SDR50 timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-sd-uhs-ddr50:
> +  Value of the delay in the input path for SD UHS DDR50 timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-mmc-highspeed:
> +  Value of the delay in the input path for MMC high-speed timing
> +  Valid range = [0:0x1F].
> +- cdns,phy-input-delay-mmc-ddr:
> +  Value of the delay in the input path for eMMC high-speed DDR timing
> +  Valid range = [0:0x1F].
> +
> +PHY DLL clock delays:
> +Each delay property represents the fraction of the clock period.
> +The approximate delay value will be
> +(<delay property value>/128)*sdmclk_clock_period.
> +- cdns,phy-dll-delay-sdclk:
> +  Value of the delay introduced on the sdclk output
> +  for all modes except HS200, HS400 and HS400_ES.
> +  Valid range = [0:0x7F].
> +- cdns,phy-dll-delay-sdclk-hsmmc:
> +  Value of the delay introduced on the sdclk output
> +  for HS200, HS400 and HS400_ES speed modes.
> +  Valid range = [0:0x7F].
> +- cdns,phy-dll-delay-strobe:
> +  Value of the delay introduced on the dat_strobe input
> +  used in HS400 / HS400_ES speed modes.
> +  Valid range = [0:0x7F].
> +
>  Example:
>         emmc: sdhci@5a000000 {
>                 compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> @@ -29,4 +76,5 @@ Example:
>                 mmc-ddr-1_8v;
>                 mmc-hs200-1_8v;
>                 mmc-hs400-1_8v;
> +               cdns,phy-dll-delay-sdclk = <0>;
>         };
> --
> 2.2.2
>
