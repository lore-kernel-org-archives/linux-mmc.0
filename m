From: Matt Porter <matt.porter@linaro.org>
Subject: Re: [PATCH V2 2/2] ARM: mmc: bcm281xx SDHCI driver (dt mods)
Date: Wed, 22 May 2013 14:01:14 -0400
Message-ID: <20130522180114.GA8235@beef>
References: <1368200883-15668-1-git-send-email-csd@broadcom.com>
 <1368200883-15668-2-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368200883-15668-2-git-send-email-csd@broadcom.com>
Sender: linux-doc-owner@vger.kernel.org
To: Christian Daudt <csd@broadcom.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, Arnd Bergmann <arnd@arndb.de>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, csd_b@daudt.org
List-Id: linux-mmc@vger.kernel.org

Hi Christian,

On Fri, May 10, 2013 at 08:48:03AM -0700, Christian Daudt wrote:
> Add SDHCI driver for the Broadcom 281xx SoCs. Also
> add bindings for it into bcm281xx dts files.

Since this is independent of the driver, the description should probably
be updated to reflect that this is just the DT support for the bcm281xx
(or kona) SDHCI hw.

> Changes from V1:
>  - split original patch into 2, one for driver and this one for dt
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> 
> diff --git a/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
> new file mode 100644
> index 0000000..ad1c4bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bcm,kona-sdhci.txt
> @@ -0,0 +1,16 @@
> +Broadcom BCM281xx SDHCI driver

s/driver//

> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties in the bcm281xx driver.

The hardware binding should not mention the supporting driver. Borrowing
from other examples, you'd want something more like:

"
This file documents differences between the core properties described
by mmc.txt and the properties that represent the bcm281xx [kona?] SDHCI.
"

-Matt
