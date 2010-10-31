From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: regression: b43-sdio: probe of mmc0:0001:1 failed with error
	-16
Date: Sun, 31 Oct 2010 17:25:12 +0000
Message-ID: <20101031172512.GA20710@void.printf.net>
References: <4CCDA454.708@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CCDA454.708-BCMAnToX5e2ELgA04lAiVw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Hannemann <arnd-BCMAnToX5e2ELgA04lAiVw@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Sun, Oct 31, 2010 at 06:16:04PM +0100, Arnd Hannemann wrote:
> on todays Linus' git (v2.6.36-9871-g3985c7c) b43 sdio stopped working.
> It was working on (v2.6.36-6794-g12ba8d1).
> 
> b43-sdio: probe of mmc0:0001:1 failed with error -16
> 
> The error seems to originate from the following code in drivers/mmc/core/sdio_bus.c:sdio_bus_probe()
> 
> 135         ret = pm_runtime_get_sync(dev);
> 136         if (ret < 0)
> 137                 goto out;
> 
> so I suspect this has something to do with the following commit: 
> 
> commit 40bba0c1ca83a370f749c8bc9afda71cf79ebd91
> Author: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> Date:   Sat Oct 2 13:54:11 2010 +0200
> 
>     mmc: sdio: enable runtime PM for SDIO functions
> 
> However, simply reverting 40bba0c1ca83a370f749c8bc9afda71cf79ebd91 does not work because then
> modprobe hangs.
> 
> Tested on AP4EVB (arm) with tmio_mmc. Any ideas?

We've been discussing this on the linux-mmc@ list:

   http://thread.gmane.org/gmane.linux.kernel.mmc/4342

Until we have a fix, you should be able to get SDIO working again by 
reverting all nine commits between 1978fda85d..ed2a978594.

Thanks,

-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
