From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
Date: Fri, 02 Dec 2016 09:48:45 +0900
Message-ID: <054a65d8-8606-eeb0-e028-1b85dbf1c8ba@samsung.com>
References: <1480637665-6325-1-git-send-email-sergio.prado@e-labworks.com>
 <CGME20161202001621epcas3p2fcc946ce070dfcc594e4b89729e149d7@epcas3p2.samsung.com>
 <1480637665-6325-2-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53785 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbcLBAss (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 19:48:48 -0500
In-reply-to: <1480637665-6325-2-git-send-email-sergio.prado@e-labworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergio Prado <sergio.prado@e-labworks.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On 12/02/2016 09:14 AM, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C24XX
> MMC/SD/SDIO controller, used as a connectivity interface with external
> MMC, SD and SDIO storage mediums.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> new file mode 100644
> index 000000000000..3f044076e69a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> @@ -0,0 +1,38 @@
> +* Samsung's S3C24XX MMC/SD/SDIO controller device tree bindings
> +
> +Samsung's S3C24XX MMC/SD/SDIO controller is used as a connectivity interface
> +with external MMC, SD and SDIO storage mediums.
> +
> +This file documents differences between the core mmc properties described by
> +mmc.txt and the properties used by the Samsung S3C24XX MMC/SD/SDIO controller
> +implementation.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> +  - "samsung,s3c2410-sdi": for controllers compatible with s3c2410
> +  - "samsung,s3c2412-sdi": for controllers compatible with s3c2412
> +  - "samsung,s3c2440-sdi": for controllers compatible with s3c2440
> +- clocks: Should reference the controller clock
> +- clock-names: Should contain "sdi"
> +
> +Required Board Specific Properties:
> +- pinctrl-0: Should specify pin control groups used for this controller.
> +- pinctrl-names: Should contain only one value - "default".

I'm not sure but i think this description doesn't need at here.

> +
> +Example:
> +	sdi: sdi@5a000000 {

I think it needs to use "mmc0: sdi@5a000000" instead of "sdi: sdi@5a000000"
Because mmc is more clear than sdi.

> +		compatible = "samsung,s3c2440-sdi";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdi_pins>;
> +		reg = <0x5a000000 0x100000>;
> +		interrupts = <0 0 21 3>;
> +		clocks = <&clocks PCLK_SDI>;
> +		clock-names = "sdi";
> +		bus-width = <4>;
> +		cd-gpios = <&gpg 8 GPIO_ACTIVE_LOW>;
> +		wp-gpios = <&gph 8 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	Note: This example shows both SoC specific and board specific properties
> +	in a single device node. The properties can be actually be separated
> +	into SoC specific node and board specific node.
> 

