From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 8/8] ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
Date: Thu, 5 Sep 2013 14:43:13 +0800
Message-ID: <20130905064311.GE775@shlinux1.ap.freescale.net>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
 <1378299257-2980-9-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:8965
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753833Ab3IEGoW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 02:44:22 -0400
Content-Disposition: inline
In-Reply-To: <1378299257-2980-9-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, anton@enomsg.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

On Wed, Sep 04, 2013 at 08:54:17PM +0800, Dong Aisheng wrote:
> This is needed for supporting ultra high speed cards like SD3.0 cards.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi            |   33 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi             |   33 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    4 ++-
>  3 files changed, 69 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 2b3ecd6..e983b81 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -203,6 +203,39 @@
>  							MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x17059
>  						>;
>  					};
> +
> +                                       pinctrl_usdhc3_3: usdhc3grp-3 { /* 100Mhz */
> +                                               fsl,pins = <
> +                                                       MX6DL_PAD_SD3_CMD__SD3_CMD 0x170B9
> +                                                       MX6DL_PAD_SD3_CLK__SD3_CLK 0x100B9
> +                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x170B9
> +                                                       MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x170B9
> +                                                       MX6DL_PAD_GPIO_18__SD3_VSELECT 0x17059

The patch needs to be rebased on my for-next, or linux-next or v3.12-rc1
(to be available).  Also please use lowercase for hex values.

Shawn

> +                                               >;
> +                                       };
> +
> +                                       pinctrl_usdhc3_4: usdhc3grp-4 { /* 200Mhz */
> +                                               fsl,pins = <
> +                                                       MX6DL_PAD_SD3_CMD__SD3_CMD 0x170F9
> +                                                       MX6DL_PAD_SD3_CLK__SD3_CLK 0x100F9
> +                                                       MX6DL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT4__SD3_DATA4 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT5__SD3_DATA5 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT6__SD3_DATA6 0x170F9
> +                                                       MX6DL_PAD_SD3_DAT7__SD3_DATA7 0x170F9
> +                                                       MX6DL_PAD_GPIO_18__SD3_VSELECT 0x17059
> +                                               >;
> +                                       };
> +
>  				};
>  
>  				weim {
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index ba09dc3..a63b623 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -337,6 +337,39 @@
>  							MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x17059
>  						>;
>  					};
> +
> +                                       pinctrl_usdhc3_3: usdhc3grp-3 { /* 100Mhz */
> +                                               fsl,pins = <
> +                                                       MX6Q_PAD_SD3_CMD__SD3_CMD 0x170B9
> +                                                       MX6Q_PAD_SD3_CLK__SD3_CLK 0x100B9
> +                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT4__SD3_DATA4 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT5__SD3_DATA5 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT6__SD3_DATA6 0x170B9
> +                                                       MX6Q_PAD_SD3_DAT7__SD3_DATA7 0x170B9
> +                                                       MX6Q_PAD_GPIO_18__SD3_VSELECT 0x17059
> +                                               >;
> +                                       };
> +
> +                                       pinctrl_usdhc3_4: usdhc3grp-4 { /* 200Mhz */
> +                                               fsl,pins = <
> +                                                       MX6Q_PAD_SD3_CMD__SD3_CMD 0x170F9
> +                                                       MX6Q_PAD_SD3_CLK__SD3_CLK 0x100F9
> +                                                       MX6Q_PAD_SD3_DAT0__SD3_DATA0 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT1__SD3_DATA1 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT2__SD3_DATA2 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT3__SD3_DATA3 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT4__SD3_DATA4 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT5__SD3_DATA5 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT6__SD3_DATA6 0x170F9
> +                                                       MX6Q_PAD_SD3_DAT7__SD3_DATA7 0x170F9
> +                                                       MX6Q_PAD_GPIO_18__SD3_VSELECT 0x17059
> +                                               >;
> +                                       };
> +
>  				};
>  
>  				usdhc4 {
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index e994011..c2c4d85 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -52,8 +52,10 @@
>  };
>  
>  &usdhc3 {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc3_1>;
> +	pinctrl-1 = <&pinctrl_usdhc3_3>;
> +	pinctrl-2 = <&pinctrl_usdhc3_4>;
>  	cd-gpios = <&gpio6 15 0>;
>  	wp-gpios = <&gpio1 13 0>;
>  	status = "okay";
> -- 
> 1.7.1
> 
> 

