From: Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle from
 Device Tree
Date: Wed, 01 Jun 2016 01:57:23 -0700
Message-ID: <146477144362.1485.3331887341591876278@sboyd-linaro>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464768141-25420-10-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TaqPxH82wqD4g@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> device.  The pwrseq device will be used by USB hub to cycle the power
> before activating ports.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Drive by review comment.

I was hoping this would help me with a problem I'm having where I have a
hub (smsc4604) that needs to be taken out of reset before my HSIC
controller sends a USB reset to it, but it seems this is more about
doing some sort of power on sequence after enumeration?

> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 460c855be0d0..89b9bdfc7061 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -18,6 +18,8 @@
>  
>  #include <linux/slab.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq.h>
> +#include <linux/usb/of.h>
>  
>  #include "hub.h"
>  
> @@ -526,6 +528,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>                 return retval;
>         }
>  
> +       port_dev->dev.of_node = usb_of_get_child_node(hdev->dev.parent->of_node,
> +                                                     port1);
> +       port_dev->pwrseq = pwrseq_alloc(&port_dev->dev, "usb-pwrseq");
> +       if (IS_ERR(port_dev->pwrseq)) {
> +               device_unregister(&port_dev->dev);
> +               return PTR_ERR(port_dev->pwrseq);

Are we certain that port_dev hasn't been freed at this point? We just
called device_unregister() on it, so it seems safer to save away the
return value before calling device_unregister() here.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
