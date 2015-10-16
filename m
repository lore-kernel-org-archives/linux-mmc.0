From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Fri, 16 Oct 2015 15:07:17 +0200
Message-ID: <CAPDyKFpFXd82VvutZzud+VVzxEbk6+tzeH9ef65oWgmaSJGyHA@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
	<2188985.g7lrY44qCa@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2188985.g7lrY44qCa-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16 October 2015 at 00:39, Sergei Shtylyov
<sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> wrote:
> The "compatible" property text contradicts even the example given in the MMCIF
> binding document itself;  moreover, the Renesas MMCIF driver only matches  on
> the generic "compatible" string and doesn't look for the SoC specific strings
> at all. Thus describe "renesas,sh-mmcif" as a fallback value.
>
> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

Thanks, applied for next.

Kind regards
Uffe

>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' or 'next' branches.
>
> Changes in version 3:
> - reworded the "compatible" property description to look like the majority of
>   the Renesas bindings.
>
> Changes in version 2:
> - kept the SoC specific "compatible" property values mandatory and made the
>   generic string a fallback.
>
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> ===================================================================
> --- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
>
>  Required properties:
>
> -- compatible: must contain one of the following
> +- compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
> +  fallback. Examples with <soctype> are:
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> -       - "renesas,sh-mmcif" for the generic MMCIF
>
>  - clocks: reference to the functional clock
>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
