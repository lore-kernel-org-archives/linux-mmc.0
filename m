From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 0/2] mmc: improve power-on for sdio wifi card.
Date: Sat, 08 Nov 2014 11:14:11 +1100
Message-ID: <20141108000919.5629.55381.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

These two patches improve power-on management for my 'libertas'
wifi card.

On my board the card shares a regulator with a bluetooth device, so
turning off the regulator may not powercycle the card.  To get it to a
clean state it is necessary to hold the reset line down while enabling
the regulator.

So the first patch add a reset-gpio function for all sdio cards
which is configured through devicetree.

The sequence of commands sent to the sdio device for power-up differs
between runtime power resume (which works nicely) and system-suspend
resume (which doesn't).
The second patch add to calls to make these sequences the same and
allowed my device to work reliably after system suspend (though the
libertas driver needs a bit of work before it is completely reliable).

Thanks,
NeilBrown
---

NeilBrown (2):
      mmc: core: allow a reset gpio to be configured.
      mmc: core: reset sdio card properly on resume.


 Documentation/devicetree/bindings/mmc/mmc.txt |    3 +
 drivers/mmc/core/core.c                       |    3 +
 drivers/mmc/core/host.c                       |   12 ++++
 drivers/mmc/core/sdio.c                       |    8 ++-
 drivers/mmc/core/slot-gpio.c                  |   70 +++++++++++++++++++++++++
 include/linux/mmc/slot-gpio.h                 |    4 +
 6 files changed, 97 insertions(+), 3 deletions(-)

--
Signature

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
