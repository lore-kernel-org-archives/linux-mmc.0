From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 10/12] usb: core: add power sequence handling for USB
 devices
Date: Fri, 17 Jun 2016 12:12:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606171209310.1589-100000@iolanthe.rowland.org>
References: <1466158165-9380-11-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466158165-9380-11-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 17 Jun 2016, Peter Chen wrote:

> Some hard-wired USB devices need to do power sequence to let the
> device work normally, the typical power sequence like: enable USB
> PHY clock, toggle reset pin, etc. But current Linux USB driver
> lacks of such code to do it, it may cause some hard-wired USB devices
> works abnormal or can't be recognized by controller at all.
> 
> In this patch, it will do power on sequence at hub's probe for all
> devices under this hub (includes root hub) if this device is described
> at dts and there is a phandle "usb-pwrseq" for it.
> 
> At hub_disconnect, it will do power off sequence which is at powered on
> list.
> 
> Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/usb/core/hub.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/usb/core/hub.h |  1 +
>  include/linux/pwrseq.h |  6 +++++
>  3 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bee1351..cc0f942 100644
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
> @@ -1684,6 +1685,66 @@ static void hub_release(struct kref *kref)
>  
>  static unsigned highspeed_hubs;
>  
> +static void hub_of_pwrseq_off(struct usb_interface *intf)
> +{
> +	struct usb_hub *hub = usb_get_intfdata(intf);

It would be easier to pass hub as the argument instead of intf.

Otherwise this looks okay to me.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
