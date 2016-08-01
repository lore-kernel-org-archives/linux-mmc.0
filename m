From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Mon, 1 Aug 2016 16:30:19 +0100
Message-ID: <20160801153016.GB17146@leverpostej>
References: <E1bUDNG-0000pR-Fv@bombadil.infradead.org>
Reply-To: mark.rutland-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRMFBMIXEGBBFOW7W6AKGQEQTWAZDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <E1bUDNG-0000pR-Fv-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 01, 2016 at 03:10:29PM +0200, Jean-Francois Moine wrote:
> Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> a 'New Timings' mode.
> Set this capacity in the DT and use it when possible.

What exactly is this "New Timings" mode?

Why do we wnat to set it? Improved performance, power?

Is it *necessary* to use it?

> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
> I don't know if this mode works or is needed at 25MHz.
> ---
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
>  drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 4bf41d8..a541bf4 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - reset-names : must contain "ahb"
>   - for cd, bus-width and additional generic mmc parameters
>     please refer to mmc.txt within this directory
> + - allwinner,new-timings: the controller may accept the "New Timings" mode

It's not at all clear to me what this means. This needs a better
description.

Which devices have this? Can we determine this based on compatible
string?

Mark.
