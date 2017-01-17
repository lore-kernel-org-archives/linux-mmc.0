From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] [linux-next] Docs: DT: MMC: Fix typo in mmc
Date: Tue, 17 Jan 2017 16:07:29 +0100
Message-ID: <CAPDyKFoij-en9ntD-7pkXcZvFXYSvQGZ+YBBkyLbETY+hRSEwg@mail.gmail.com>
References: <20170106145043.4859-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36122 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdAQPHb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:07:31 -0500
Received: by mail-io0-f175.google.com with SMTP id j13so116429585iod.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:07:31 -0800 (PST)
In-Reply-To: <20170106145043.4859-1-standby24x7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 6 January 2017 at 15:50, Masanari Iida <standby24x7@gmail.com> wrote:
> This patch fix some spelling typo found in devicetree/bindings/mmc.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Thanks, applied for next with a change in commit message prefix.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 +-
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt         | 2 +-
>  Documentation/devicetree/bindings/mmc/sdhci.txt            | 2 +-
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 7f95ec400863..50bf611a4d2c 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -17,7 +17,7 @@ Required properties:
>         "core" - Main peripheral bus clock
>         "clkin0" - Parent clock of internal mux
>         "clkin1" - Other parent clock of internal mux
> -  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
> +  The driver has an internal mux clock which switches between clkin0 and clkin1 depending on the
>    clock rate requested by the MMC core.
>
>  Example:
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> index 3cd4c43a3260..230fd696eb92 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> @@ -38,7 +38,7 @@ Optional properties:
>  - bus-width:           Number of data lines.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> -- max-frequency:       Can be 200MHz, 100Mz or 50MHz (default) and used for
> +- max-frequency:       Can be 200MHz, 100MHz or 50MHz (default) and used for
>                         configuring the CCONFIG3 in the mmcss.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
> index 1c95a1a555c3..0e9923a64024 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci.txt
> @@ -5,7 +5,7 @@ host controllers refer to the mmc[1] bindings.
>
>  Optional properties:
>  - sdhci-caps-mask: The sdhci capabilities register is incorrect. This 64bit
> -  property corresponds to the bits in the sdhci capabilty register. If the bit
> +  property corresponds to the bits in the sdhci capability register. If the bit
>    is on in the mask then the bit is incorrect in the register and should be
>    turned off, before applying sdhci-caps.
>  - sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 7fd17c3da116..40b94a5369a1 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -16,7 +16,7 @@ Required Properties:
>    each child-node representing a supported slot. There should be atleast one
>    child node representing a card slot. The name of the child node representing
>    the slot is recommended to be slot@n where n is the unique number of the slot
> -  connnected to the controller. The following are optional properties which
> +  connected to the controller. The following are optional properties which
>    can be included in the slot child node.
>
>         * reg: specifies the physical slot number. The valid values of this
> --
> 2.11.0.161.g6610af872f64
>
