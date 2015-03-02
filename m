From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-iproc: add device tree bindings
Date: Mon, 02 Mar 2015 15:50:34 -0800
Message-ID: <54F4F74A.7050909@gmail.com>
References: <Scott Branden <sbranden@broadcom.com> <1423526791-29453-1-git-send-email-sbranden@broadcom.com> <1423526791-29453-5-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423526791-29453-5-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, Corneliu Doban <cdoban@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, Anatol Pomazao <anatol@google.com>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dtor@google.com>
List-Id: linux-mmc@vger.kernel.org

On 09/02/15 16:06, Scott Branden wrote:
> Add device tree binding documentation for IPROC SDHCI driver.
> 
> Acked-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Corneliu Doban <cdoban@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> ---
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> new file mode 100644
> index 0000000..72cc9cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> @@ -0,0 +1,23 @@
> +Broadcom IPROC SDHCI controller
> +
> +This file documents differences between the core properties described
> +by mmc.txt and the properties that represent the IPROC SDHCI controller.
> +
> +Required properties:
> +- compatible : Should be "brcm,sdhci-iproc-cygnus".
> +- clocks : The clock feeding the SDHCI controller.
> +
> +Optional properties:
> +  - sdhci,auto-cmd12: specifies that controller should use auto CMD12.

Formatting is a little different here, there is one too many space to
begin the line.

> +
> +Example:
> +
> +sdhci0: sdhci@0x18041000 {

0x is typically dropped from this part, to only appear in the "reg"
property.

> +	compatible = "brcm,sdhci-iproc-cygnus";
> +	reg = <0x18041000 0x100>;
> +	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
> +	bus-width = <4>;
> +	sdhci,auto-cmd12;
> +	no-1-8-v;
> +};
> 

Unless there is a re-spin, I will fix this myself while applying this
patch to devicetree/next.

Thanks
-- 
Florian
