From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Mon, 28 Oct 2013 18:20:41 -0500
Message-ID: <526EF149.8060304@gmail.com>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-doc-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/15/2013 02:08 PM, Soren Brinkmann wrote:
> Add a driver for Arasan's SDHCI controller core.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 224 +++++++++++++++++++++
>  5 files changed, 261 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-arasan.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> new file mode 100644
> index 000000000000..20f0fc25e270
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -0,0 +1,23 @@
> +Device Tree Bindings for the Arasan SDCHI Controller
> +
> +  The bindings follow the mmc[1] and the clock bindings[2]. Only deviations are
> +  documented here.
> +
> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required Properties:
> +  - compatible: Compatibility string. Must be 'arasan,sdhci'

This string is a bit non-specific. Vendor IP typically has configurable
options, different revs of IP with fixes/differences, and the
possibility of integration wierdness or bugs. So it is better to be as
specific as possible in case the kernel needs to know exactly what
version of h/w this is.

Rob

