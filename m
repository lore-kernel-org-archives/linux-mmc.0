From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct
 scatterlist
Date: Wed, 27 Jul 2011 22:40:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107272236510.7435@axis700.grange>
References: <201107262049.15333.rjw@sisk.pl> <201107262050.23379.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107262050.23379.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

(added MMC maintainer to CC:)

On Tue, 26 Jul 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Fix build issue caused by undefined struct scatterlist in
> drivers/mmc/host/tmio_mmc.c.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

A nitpick, if I may: sCatterlist comes before sPinlock in my versions of 
most popular alphabets;-) Please, fix (or maybe Chris can fix it himself), 
after which:

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc.h      |    1 +
>  drivers/usb/renesas_usbhs/fifo.c |    1 +
>  2 files changed, 2 insertions(+)
> 
> Index: linux-2.6/drivers/mmc/host/tmio_mmc.h
> ===================================================================
> --- linux-2.6.orig/drivers/mmc/host/tmio_mmc.h
> +++ linux-2.6/drivers/mmc/host/tmio_mmc.h
> @@ -21,6 +21,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
>  #include <linux/spinlock.h>
> +#include <linux/scatterlist.h>
>  
>  /* Definitions for values the CTRL_SDIO_STATUS register can take. */
>  #define TMIO_SDIO_STAT_IOIRQ	0x0001
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
