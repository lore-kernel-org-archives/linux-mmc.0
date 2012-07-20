From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Fri, 20 Jul 2012 14:58:10 +0530
Message-ID: <CANfBPZ_rS230ziPFTDVUdad_oCHNapLKpdrKst_6RxLDqixm4A@mail.gmail.com>
References: <20120718065951.GH6522@atomide.com> <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
 <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com>
 <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
 <CAMQu2gxLwGACAT-r6=L9DKB=3fTNaEJ4woZOb4zttJ8qTTJmFA@mail.gmail.com>
 <CAAwP0s2apfBHLKHtzvwqb2KPCMNhEXMe5R9792bO7FhfY5Y+uQ@mail.gmail.com>
 <CANfBPZ_N4ZK5PgFQLHWMwsG60tb-FPTjeieTJ92rBUNgONAxAw@mail.gmail.com>
 <CAMQu2gy+uXJFfmOwLX=YH41pr-N+T28-1wLo5rXEaj9MGffHPw@mail.gmail.com> <20120719113246.GN6522@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47619 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227Ab2GTJ2d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jul 2012 05:28:33 -0400
Received: by bkwj10 with SMTP id j10so3165798bkw.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jul 2012 02:28:30 -0700 (PDT)
In-Reply-To: <20120719113246.GN6522@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Jul 19, 2012 at 5:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 02:49]:
>>
>> "The patch simply make them depend on DMA_OMAP since DMA_OMAP
>> will select DMA_ENGINE automatically"
>>
>> This won't be true if the DMA selection are not done
>> at ARCH_OMAP level as discussed in this thread.
>>
>> Having said that, I think Russell and Tony need to
>> take call on how this needs to be handled.
>
> As the DMA channels can run out, drivers should also work
> without DMA. And building everything as modules should be
> possible for the distro kernels.
>
> So I'd rather not have either select or depends and have
> the drivers fixed.
>

Ok - I'll work on getting polling mode to work, but as you know it's
not the mode to get the best performance out of the device.
I see that you've also merged the changes to omap2plus_defconfig, which should
get MMC working as before DMA Engine conversion.

There's a small patch needed to omap_hsmmc to return a non-zero error code
during the probe error path. This will atleast make probe failure
explicit when DMA
is not available.

Let me know if you want me to post it separately as a patch..

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2338703..892a046 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1773,7 +1773,7 @@ static int __devinit omap_hsmmc_probe(struct
platform_device *pdev)
        struct mmc_host *mmc;
        struct omap_hsmmc_host *host = NULL;
        struct resource *res;
-       int ret, irq;
+       int ret = -ENXIO, irq;
        const struct of_device_id *match;
        dma_cap_mask_t mask;
        unsigned tx_req, rx_req;
