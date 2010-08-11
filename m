From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [RFC 0/6] adding SDIO Runtime PM support
Date: Wed, 11 Aug 2010 16:19:24 +0300
Message-ID: <1281532770-27545-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SDIO function drivers should be able to power down/up
their cards (e.g. a WLAN SDIO driver might want to
power down its card whenever wlan0 is down).

In the past few weeks we've been discussing how this
could be achieved, and I'd like to present a new approach,
which is based on runtime pm API.

The following few patches add runtime pm support for SDIO
devices, and demonstrate it with the wl1271_sdio driver.
Basic functionality is provided: The power state of the
device is now coupled with the state of the wlan0 interface.

The nice thing about this approach is how small it is,
as the runtime PM core is already taking care of everything
needed (usage counts, device hierarchy, established set of API,
synchronization, ...).

Having said that, I'd like to stress that these patches
are early submitted for RFC purposes only, as they
are still in a preliminary state and only lightly tested.

Please note that I will soon be leaving for the rest of August and
am going to have a very limited email access, so it might
take me some time to respond.

Appreciate your feedback,

Thank you,

Ohad Ben-Cohen (6):
  mmc: sdio: fully reconfigure oldcard on resume
  sdio: add power_restore support
  mmc: add general runtime PM support
  sdio: add general runtime PM support
  sdio: enable Runtime PM for SDIO cards
  wireless: wl1271_sdio: enable Runtime PM

 drivers/mmc/core/bus.c                    |   35 +++++++++++++++++++++++++++
 drivers/mmc/core/sdio.c                   |   24 +++++++++++++++---
 drivers/mmc/core/sdio_bus.c               |   10 ++++++++
 drivers/net/wireless/wl12xx/wl1271_sdio.c |   37 ++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 5 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
