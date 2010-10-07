From: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/11] SDIO Runtime PM Support
Date: Thu, 07 Oct 2010 15:32:16 +0300
Message-ID: <1286454736.27371.37.camel@chilepepper>
References: <1286020455-28946-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286020455-28946-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, 2010-10-02 at 13:54 +0200, ext Ohad Ben-Cohen wrote:
> Introduce SDIO runtime PM support:
> 
> 1. Power to SDIO cards is kept low until one of its functions is bound
>    (i.e. a matching driver is successfully probed)
> 
> 2. If the matching driver supports runtime PM, power to the card is
>    dropped soon after probe() returns. It is then up to the driver
>    to request power to its function, using runtime PM API (the get/put
>    variants). This is demonstrated with the wl1271 driver, in which
>    the power of the card power is coupled with the state of the wlan
>    interface (interface up -> power is up, interface down -> power is down)
> 
> 3. If a matching driver does not support runtime PM, power to the card
>    is kept high during the whole lifetime of the driver
> 
> 4. When the driver is removed, power to the card is immediately dropped
> 
> 5. If there are multiple drivers for the same card (several SDIO functions),
>    power will be pulled high before the first driver probes, and dropped
>    down after the last driver is removed. In between, power will be
>    maintained accrording to the accumulated usage count of the complete
>    drivers group
> 
> 6. SDIO suspend/resume semantics are unchanged. In addition, when the system
>    comes out of suspend, it is guaranteed that the power state of the
>    SDIO card will reflect its runtime PM usage count.
> 
> 7. What was NOT changed:
>    - Interface: drivers can still assume that the card is powered
>      when probe/remove/suspend/resume are called
>    - Existing behavior: drivers that do not support runtime PM
>      are unchanged
> 
> Changes since v1:
> - Interaction with system suspend/resume
> - Better commentary
> 
> Dependencies:
> - SDIO patches are against mmc-next, and have a runtime dependency on
>   commit "PM / Runtime: Lenient generic runtime pm callbacks"
>   (patch is in linux-next now)
> - WLAN patches depend on recent wl1271 activity, and they are here
>   just to demonstrate the usage of the SDIO patchset (will be
>   resubmitted separately)
> 
> The full patchset, together with all its dependencies, is also available at:
> git://wizery.com/pub/mmc.git runtime-pm-v2

I have tested this on my beagle board with the wl1271 patches that Ohad
provided and it seems to be working fine.  I've also created a small
script to stress test the implementation a little bit and didn't see any
problems.

Tested-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

This is quite an important fix in the wl1271 point-of-view.  Chris, do
you think there is any chance that this could make it to 2.6.37?


-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
