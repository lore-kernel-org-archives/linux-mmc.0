From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: Don't reference Linux-specific OF_GPIO_ACTIVE_LOW
 flag in DT binding
Date: Tue, 26 Dec 2017 16:53:05 -0600
Message-ID: <20171226225305.qyd5yfmxomxgvf7x@rob-hp-laptop>
References: <20171223003412.13688-1-tuomas@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171223003412.13688-1-tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tuomas Tynkkynen <tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Dec 23, 2017 at 02:34:12AM +0200, Tuomas Tynkkynen wrote:
> OF_GPIO_ACTIVE_LOW is a Linux implementation detail. The binding
> document should be referring to GPIO_ACTIVE_LOW found in
> include/dt-bindings/gpio/gpio.h.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas-yrGDUoBaLx3QT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
