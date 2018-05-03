From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 00/14] dra7: mmc: Update mmc dt node to use sdhci-omap
Date: Thu, 3 May 2018 10:40:19 -0700
Message-ID: <20180503174019.GX98604@atomide.com>
References: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180427 05:11]:
> Changes from v3:
> *) Added dra7-mmc-iodelay.dtsi to add a new pinctrl group for clk line
>    without pullup to be used for dra71-evm and am57xx-idk.
> *) Rename wlcore node name to wifi
> 
> This series should be merged only after [1].
> [1] -> https://marc.info/?l=linux-omap&m=152482966225758&w=2
> 
> This series:
>  *) Adds wilink wlan support (Now all MMC instances in DRA7 will use
>     sdhci-omap)
>  *) Add a new pinctrl group for clk line without pullup required for
>     UHS cards to work reliably.
>  *) Update README to make sure users update .config file from 4.18
>     kernel.
>  *) Use sdhci-omap programming model.

Applying this series into omap-for-v4.18/dt-sdhci on top of the
immutable branch from Ulf.

> In the "Use sdhci-omap programming model" patch, "ti,omap4-hsmmc"
> compatible is removed. This is because if both "ti,dra7-sdhci" and
> "ti,omap4-hsmmc" is added and if there is probe deferral in sdhci_omap
> driver, the device is binding to omap_hsmmc driver.
> 
> Once omap_hsmmc and sdhci_omap driver are feature identical,
> sdhci_omap driver will be made to support omap_hsmmc binding
> (including "ti,omap4-hsmmc" compatible) and omap_hsmmc driver will
> be removed. Till then dt nodes with "ti,omap4-hsmmc" compatible
> will use omap_hsmmc driver and "ti,dra7-sdhci" compatible will
> use sdhci_omap driver.

Great that sounds good to me :) This way we can test and enable
it one SoC at a time.

Regards,

Tony
