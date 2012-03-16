From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Commit "mmc: tmio_mmc: do not enable card hotplug interrupts,
 if unused" breaks linux-next
Date: Fri, 16 Mar 2012 22:02:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203162201270.13465@axis700.grange>
References: <4F6381B3.1010806@windriver.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4F6381B3.1010806@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Chris Ball <cjb@laptop.org>, linux-next@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 16 Mar 2012, Paul Gortmaker wrote:

> Just a heads up that the commit below is causing build failures in linux-next:
> 
> drivers/mmc/host/tmio_mmc_pio.c:343:11: error: 'struct tmio_mmc_host' has no member named 'native_hotplug'
> drivers/mmc/host/tmio_mmc_pio.c:969:12: error: 'struct tmio_mmc_host' has no member named 'native_hotplug'
> make[4]: *** [drivers/mmc/host/tmio_mmc_pio.o] Error 1

Looks like the merge order wasn't quite correct somewhere. This field is 
defined in

http://www.spinics.net/lists/linux-sh/msg10170.html

and it is now in mmc-next, but doesn't seem to be in next yet. So, AFAIU, 
it will be fixed with the next merge of mmc-next into next.

Thanks
Guennadi

> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/5878512/
> 
> Paul.
> --
> 
> commit 6c34d289dcc6675da8c130c5d5cdc5e8f15ec7d7
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date:   Wed Feb 22 13:16:09 2012 +0100
> 
>     mmc: tmio_mmc: do not enable card hotplug interrupts, if unused
>     
>     If TMIO MMC is used in polling mode, or the card is non-removable, or
>     card-detection is performed, using an external interrupt, there is no
>     need to enable controller native card hotplug interrupts.
>     
>     Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
