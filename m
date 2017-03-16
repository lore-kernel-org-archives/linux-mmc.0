From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: tegra: Document Tegra186 compatible string
Date: Thu, 16 Mar 2017 15:46:37 +0100
Message-ID: <CAPDyKFpfa0k35r0kS6C+Px_Tu4McUQKTJv7UMuRAvCzoaXnaKA@mail.gmail.com>
References: <20170314190152.9167-1-thierry.reding@gmail.com> <20170314190152.9167-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:36022 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbdCPOqo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2017 10:46:44 -0400
Received: by mail-ua0-f169.google.com with SMTP id 72so27534474uaf.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 07:46:43 -0700 (PDT)
In-Reply-To: <20170314190152.9167-2-thierry.reding@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 14 March 2017 at 20:01, Thierry Reding <thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The SDHCI controller found on Tegra186 in very similar to the controller
> found on earlier generations of Tegra.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index c15aa22d4570..9bce57862ed6 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -13,6 +13,7 @@ Required properties:
>    - "nvidia,tegra114-sdhci": for Tegra114
>    - "nvidia,tegra124-sdhci": for Tegra124 and Tegra132
>    - "nvidia,tegra210-sdhci": for Tegra210
> +  - "nvidia,tegra186-sdhci": for Tegra186
>  - clocks : Must contain one entry, for the module clock.
>    See ../clocks/clock-bindings.txt for details.
>  - resets : Must contain an entry for each entry in reset-names.
> --
> 2.12.0
>
