From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC v2 10/13] usb: hub: Power sequence the ports on activation
Date: Thu, 5 May 2016 10:09:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1605051007040.2008-100000@iolanthe.rowland.org>
References: <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462451666-17945-11-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 5 May 2016, Krzysztof Kozlowski wrote:

> The autodetection of attached USB device might not work on certain
> boards where the power is delivered externally. These devices also might
> require a hard reset. Use pwrseq for that in USB hub.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/core/hub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 1c82fcc448f5..0fddaacc62bf 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/random.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
> @@ -1661,7 +1662,17 @@ static int hub_configure(struct usb_hub *hub,
>  
>  	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
>  
> +	/* FIXME: When do the pre-power-on? */

It's hard to answer this without knowing what pre-power-on involves.

Why not create a pwrseq_power_on() routine that does pre_power_on 
followed by post_power_on?

> +	/*
> +	for (i = 0; i < maxchild; i++)
> +		pwrseq_pre_power_on(hub->ports[i]->pwrseq);
> +	*/
> +
> +	for (i = 0; i < maxchild; i++)
> +		pwrseq_post_power_on(hub->ports[i]->pwrseq);

This is patch 10/13.  hub->ports[i]->pwrseq doesn't get added until 
11/13.  Obviously you never tried compiling each patch in the series.

> +
>  	hub_activate(hub, HUB_INIT);
> +

Unnecessary blank line added.

>  	return 0;
>  
>  fail:

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
