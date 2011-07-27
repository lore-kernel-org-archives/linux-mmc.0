From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct scatterlist
Date: Wed, 27 Jul 2011 17:47:01 -0400
Message-ID: <m2pqkvl7l6.fsf@bob.laptop.org>
References: <201107262049.15333.rjw@sisk.pl> <201107262050.23379.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201107262050.23379.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 26 Jul 2011 20:50:23 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Rafael,

On Tue, Jul 26 2011, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Fix build issue caused by undefined struct scatterlist in
> drivers/mmc/host/tmio_mmc.c.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
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

I'm not able to reproduce the build failure here.

drivers/mmc/host/tmio_mmc.c already performs "#include <linux/scatterlist.h>"
itself (and always has done), so I'm confused about why this is necessary.
Do you have a copy of your build log with the error?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
