From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
Date: Mon, 10 Apr 2017 15:52:35 +0200
Message-ID: <CAPDyKFqOBA5-UeDM0emn8XFO4HE81OhpBoNnMv3=e6J-H+V3UA@mail.gmail.com>
References: <1491004256-13969-1-git-send-email-sergio.prado@e-labworks.com> <1491004256-13969-2-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491004256-13969-2-git-send-email-sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 1 April 2017 at 01:50, Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org> wrote:
> Adds the device tree bindings description for Samsung S3C24XX
> MMC/SD/SDIO controller, used as a connectivity interface with external
> MMC, SD and SDIO storage mediums.
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Sergio Prado <sergio.prado-1e4yhPs3/ABSwrhanM7KvQ@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

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
> +
> +Example:
> +
> +       mmc0: mmc@5a000000 {
> +               compatible = "samsung,s3c2440-sdi";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&sdi_pins>;
> +               reg = <0x5a000000 0x100000>;
> +               interrupts = <0 0 21 3>;
> +               clocks = <&clocks PCLK_SDI>;
> +               clock-names = "sdi";
> +               bus-width = <4>;
> +               cd-gpios = <&gpg 8 GPIO_ACTIVE_LOW>;
> +               wp-gpios = <&gph 8 GPIO_ACTIVE_LOW>;
> +       };
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
