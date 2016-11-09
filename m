From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for
 reset-names
Date: Wed, 9 Nov 2016 12:24:24 -0600
Message-ID: <20161109182424.5eais27okcsdmdzx@rob-hp-laptop>
References: <20161031024942.4415-1-jh80.chung@samsung.com>
 <20161031024942.4415-2-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161031024942.4415-2-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 31, 2016 at 11:49:41AM +0900, Jaehoon Chung wrote:
> Add reset-names property for binding dw-mmc controller.
> It might be used together with "reset" property.
> -  Note: It must be "reset" as name.
> 
> Fixes: d6786fefe816 ("mmc: dw_mmc: add reset support to dwmmc host controller")
> 
> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 4e00e85..bfa461a 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -43,6 +43,9 @@ Optional properties:
>    reset signal present internally in some host controller IC designs.
>    See Documentation/devicetree/bindings/reset/reset.txt for details.
>  
> +* reset-names: request name for using "resets" property. Must be "reset".
> +	(It will be used together with "resets" property.)

There is no point in having names for a single reset. This should be 
fixed in the kernel only if this causes a problem.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
