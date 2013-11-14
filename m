From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 08/17] ARM: shmobile: sh73a0: fixup sdhi compatible name
Date: Thu, 14 Nov 2013 14:39:19 +0100
Message-ID: <2711716.VTEgd2Lufa@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87bo1nz3c9.wl%kuninori.morimoto.gx@renesas.com> <877gcbz3a5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <877gcbz3a5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:27:50 Kuninori Morimoto wrote:
> sh73a0 != r8a7740
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/sh73a0.dtsi |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index 78f7201a..6e23fb4 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -201,7 +201,7 @@
>  	};
> 
>  	sdhi0: sd@ee100000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee100000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 83 4
> @@ -213,7 +213,7 @@
> 
>  	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
>  	sdhi1: sd@ee120000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee120000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 88 4
> @@ -224,7 +224,7 @@
>  	};
> 
>  	sdhi2: sd@ee140000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee140000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 104 4
-- 
Regards,

Laurent Pinchart

