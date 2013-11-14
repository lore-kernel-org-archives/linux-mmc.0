From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/17] ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
Date: Thu, 14 Nov 2013 14:38:14 +0100
Message-ID: <1544136.LulG1Fkhjm@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87bo1nz3c9.wl%kuninori.morimoto.gx@renesas.com> <87a9h7z3b3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87a9h7z3b3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:27:16 Kuninori Morimoto wrote:
> WP pin is not implemented on Marzen
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> b/arch/arm/boot/dts/r8a7779-marzen-reference.dts index ce3fe9e..cd063cd
> 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> @@ -93,8 +93,7 @@
>  	};
> 
>  	sdhi0_pins: sd0 {
> -		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
> -				 "sdhi0_wp";
> +		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
>  		renesas,function = "sdhi0";
>  	};
>  };
-- 
Regards,

Laurent Pinchart

