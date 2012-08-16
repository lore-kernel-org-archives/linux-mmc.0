From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 12:29:56 -0400
Message-ID: <87k3wydcl7.fsf@octavius.laptop.org>
References: <CAJuYYwQjN9UtXcfjNXf1Ezw3igfUSQDNEP8X038L4=br6EROUA@mail.gmail.com>
	<1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53067 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab2HPQaV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Aug 2012 12:30:21 -0400
In-Reply-To: <1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
	(Thomas Abraham's message of "Thu, 16 Aug 2012 22:05:14 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

Hi,

On Thu, Aug 16 2012, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's sdhci controller
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Changes since v3:
>
> The patch series that adds device tree support for Samsung sdhci controller
> had six patches in total, of which, the first five patches have been accepted.
> The sixth patch in the series was dropped since it was using custom Samsung
> properties for descrbing the bus-width and card-detect gpio, but had otherwise
> addressed all the comments.
>
> This patch reworks the sixth patch in v3 of the sdhci device tree support
> patch series. The only change in this patch from the v3 version is the use of
> generic mmc bindings for descrbing the bus-width and card-detect gpio.
>
>  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   51 +++++++
>  drivers/mmc/host/sdhci-s3c.c                       |  146 +++++++++++++++++++-
>  2 files changed, 191 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> new file mode 100644
> index 0000000..398540b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
> @@ -0,0 +1,51 @@
> +* Samsung's SDHCI Controller device tree bindings
> +
> +Samsung's SDHCI controller is used as a connectivity interface with external
> +MMC, SD and eMMC storage mediums. This file documents differences between the
> +core mmc properties described by mmc.txt and the properties used by the
> +Samsung implmentation of the SDHCI controller.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> +  - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
> +    controller.
> +  - "samsung,exynos4210-sdhci": For controllers compatible with Exynos4 sdhci
> +    controller.
> +
> +Required Board Specific Properties:
> +- gpios: Should specify the gpios used for clock, command and data lines. The
> +  gpio specifier format depends on the gpio controller.
> +
> +Optional Board Specific Properties:
> +- One of the following properties for card detect type.
> +  - samsung,sdhci-cd-internal: Card detect line from the card slot  is
> +    connected to the card detect pad of the sdhci controller. A gpio is
> +    used for this connection (with possible pin function settings).
> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
> +    is used a card detect line. This gpio line is not connected to card detect
> +    pad of the sdhci controller.
> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
> +    detect the presence of the card. (DEFAULT, if no card detect property
> +    is specified).
> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
> +    permanently connected to the sdhci controller.
> +
> +Example:
> +	sdhci@12530000 {
> +		compatible = "samsung,exynos4210-sdhci";
> +		reg = <0x12530000 0x100>;
> +		interrupts = <<0 75 0>;
> +		bus-width = <4>;
> +		samsung,sdhci-cd-internal;
> +		cd-gpios = <&gpk2 2 2 3 3>;
> +		gpios = <&gpk2 0 2 0 3>,  /* clock line */
> +			<&gpk2 1 2 0 3>,  /* command line */
> +			<&gpk2 3 2 3 3>,  /* data line 0 */
> +			<&gpk2 4 2 3 3>,  /* data line 1 */
> +			<&gpk2 5 2 3 3>,  /* data line 2 */
> +			<&gpk2 6 2 3 3>;  /* data line 3 */
> +	};
> +
> +	Note: This example shows both SoC specific and board specific properties
> +	in a single device node. The properties can be actually be seperated
> +	into SoC specific node and board specific node.

Looks good, except the text file doesn't mention anywhere that it describes
the bindings used by sdhci-s3c.c -- that could be useful information to
someone reading the binding and trying to discover which driver uses it.

Maybe we can call the text file "sdhci-s3c.txt"?  Or "samsung,sdhci-s3c.txt"
if you prefer.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
