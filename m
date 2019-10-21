From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/7] debugfs: Add and use debugfs_create_xul()
Date: Mon, 21 Oct 2019 16:37:35 +0200
Message-ID: <20191021143742.14487-1-geert+renesas@glider.be>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

	Hi all,

The existing debugfs_create_ulong() function supports objects of
type "unsigned long", which are 32-bit or 64-bit depending on the
platform, in decimal form.  To format objects in hexadecimal, various
debugfs_create_x*() functions exist, but all of them take fixed-size
types.

To work around this, some drivers call one of debugfs_create_x{32,64}(),
depending on the size of unsigned long.
Other driver just cast the value pointer to "u32 *" or "u64 *",
introducing portability bugs or data leaks in the process.

Hence this patch series adds a debugfs helper for "unsigned long"
objects in hexadecimal format, and converts drivers to make use of it.
It also contains two cleanups removing superfluous casts, which I added
to this series to avoid conflicts.

Thanks for your comments!

Geert Uytterhoeven (7):
  debugfs: Add debugfs_create_xul() for hexadecimal unsigned long
  mac80211: Use debugfs_create_xul() helper
  net: caif: Fix debugfs on 64-bit platforms
  mmc: atmel-mci: Fix debugfs on 64-bit platforms
  mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
  mmc: dw_mmc: Fix debugfs on 64-bit platforms
  mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call

 drivers/mmc/host/atmel-mci.c   | 10 +++++-----
 drivers/mmc/host/dw_mmc.c      | 10 +++++-----
 drivers/net/caif/caif_serial.c |  4 ++--
 include/linux/debugfs.h        | 10 ++++++++++
 net/mac80211/debugfs_sta.c     | 17 +++--------------
 5 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
