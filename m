From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
Date: Wed, 18 Jan 2017 16:38:16 -0600
Message-ID: <20170118223816.nccyc7aoa7succsi@rob-hp-laptop>
References: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
 <1484319953-6479-2-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484319953-6479-2-git-send-email-sergio.prado@e-labworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 13, 2017 at 01:05:52PM -0200, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C24XX
> MMC/SD/SDIO controller, used as a connectivity interface with external
> MMC, SD and SDIO storage mediums.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> new file mode 100644
> index 000000000000..d09dbf4b3824
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> @@ -0,0 +1,34 @@
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

You are missing things from the example.

> +
> +Example:
> +	mmc0: mmc@5a000000 {
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

The source structure is not relavent to the binding.

Rob
