From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] mmc: sdhci-st: STMicroelectronics SDHCI binding
 documentation.
Date: Thu, 22 May 2014 17:06:43 +0100
Message-ID: <20140522160643.GI19747@lee--X1>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400771902-26553-3-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

> This patch adds the device tree binding documentation for ST
> SDHCI driver. It contains the differences between the core properties
> in mmc.txt and the properties used by the sdhci-st driver.
>=20
> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 26 ++++++++++++=
++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-st.tx=
t
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Doc=
umentation/devicetree/bindings/mmc/sdhci-st.txt
> new file mode 100644
> index 0000000..ae3dae0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> @@ -0,0 +1,26 @@
> +* STMicroelectronics sdhci-st MMC/SD controller
> +
> +This file documents differences between the core properties in mmc.t=
xt

Where is mmc.txt?

> +and the properties used by the sdhci-st driver
> +
> +Required properties:
> +- compatible: "st,sdhci"
> +- clocks: card clock, must be "mmc".

This isn't correct.  I think you mean it must be a phandle to the
'mmc' clock.  It's also worth referencing the clock DT documentation
here.

> +Optional properties:
> +- reset: to provide a reset to the HC.

What is it; integer, string, phandle, something else?

> +- non-removable: non-removable slot (bindings/mmc/mmc.txt).

This however, _is_ a string, so you need to put it in "'s like you did
with "mmc" above and/or reference the file which documents it.

> +
> +Example:
> +
> +mmc0: sdhci@fe81e000 {
> +	compatible	=3D "st,sdhci";
> +	status		=3D "disabled";
> +	reg		=3D <0xfe81e000 0x1000>;
> +	interrupts	=3D <GIC_SPI 127 IRQ_TYPE_NONE>;
> +	interrupt-names	=3D "mmcirq";
> +	pinctrl-names	=3D "default";
> +	pinctrl-0	=3D <&pinctrl_mmc0>;
> +	clock-names	=3D "mmc";

I don't think you need clock-names if you only have one clock.

> +	clocks		=3D <&clk_s_a1_ls 1>;
> +};

Once fixed you can add my Ack for the next submission:

  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
