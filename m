From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
Date: Fri, 03 Mar 2017 11:07:09 +0900
Message-ID: <6564ee3f-c274-eb42-3588-f8584745ba98@samsung.com>
References: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
 <CGME20170302012903epcas2p3f1ec4bbf556e97c9b650861412ebe22c@epcas2p3.samsung.com>
 <1488417536-15110-2-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1488417536-15110-2-git-send-email-sergio.prado@e-labworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergio Prado <sergio.prado@e-labworks.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 03/02/2017 10:18 AM, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C24XX
> MMC/SD/SDIO controller, used as a connectivity interface with external
> MMC, SD and SDIO storage mediums.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> new file mode 100644
> index 000000000000..5f68feb9f9d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
> @@ -0,0 +1,42 @@
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
> +- reg: register location and length
> +- interrupts: mmc controller interrupt
> +- clocks: Should reference the controller clock
> +- clock-names: Should contain "sdi"
> +
> +Required Board Specific Properties:
> +- pinctrl-0: Should specify pin control groups used for this controller.
> +- pinctrl-names: Should contain only one value - "default".
> +
> +Optional Properties:
> +- bus-width: number of data lines (see mmc.txt)
> +- cd-gpios: gpio for card detection (see mmc.txt)
> +- wp-gpios: gpio for write protection (see mmc.txt)

I think these properties don't need to describe at here.
It's common properties.

Best Regards,
Jaehoon Chung

> +
> +Example:
> +
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
> 
