From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Fix Marvell WiFi reset by adding SDIO
 API to replug card
Date: Tue, 30 Jul 2019 10:46:56 +0200
Message-ID: <CALtMJEB871Redpzx1u6G5GVEXz-kAP=vT6Wt98=X=xm4SEMeAQ@mail.gmail.com>
References: <20190722193939.125578-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722193939.125578-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, linux-mmc <linux-mmc@vger.kernel.org>, David Miller <davem@davemloft.net>, Xinming Hu <huxinming820@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi Douglas,

Am Mo., 22. Juli 2019 um 21:41 Uhr schrieb Douglas Anderson
<dianders@chromium.org>:
>
> As talked about in the thread at:
>
> http://lkml.kernel.org/r/CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com
>
> ...when the Marvell WiFi card tries to reset itself it kills
> Bluetooth.  It was observed that we could re-init the card properly by
> unbinding / rebinding the host controller.  It was also observed that
> in the downstream Chrome OS codebase the solution used was
> mmc_remove_host() / mmc_add_host(), which is similar to the solution
> in this series.
>
> So far I've only done testing of this series using the reset test
> source that can be simulated via sysfs.  Specifically I ran this test:
>
> for i in $(seq 1000); do
>   echo "LOOP $i --------"
>   echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
>
>   while true; do
>     if ! ping -w15 -c1 "${GW}" >/dev/null 2>&1; then
>       fail=$(( fail + 1 ))
>       echo "Fail WiFi ${fail}"
>       if [[ ${fail} == 3 ]]; then
>         exit 1
>       fi
>     else
>       fail=0
>       break
>     fi
>   done
>
>   hciconfig hci0 down
>   sleep 1
>   if ! hciconfig hci0 up; then
>     echo "Fail BT"
>     exit 1
>   fi
> done
>
> I ran this several times and got several hundred iterations each
> before a failure.  When I saw failures:
>
> * Once I saw a "Fail BT"; manually resetting the card again fixed it.
>   I didn't give it time to see if it would have detected this
>   automatically.
> * Once I saw the ping fail because (for some reason) my device only
>   got an IPv6 address from my router and the IPv4 ping failed.  I
>   changed my script to use 'ping6' to see if that would help.
> * Once I saw the ping fail because the higher level network stack
>   ("shill" in my case) seemed to crash.  A few minutes later the
>   system recovered itself automatically.  https://crbug.com/984593 if
>   you want more details.
> * Sometimes while I was testing I saw "Fail WiFi 1" indicating a
>   transitory failure.  Usually this was an association failure, but in
>   one case I saw the device do "Firmware wakeup failed" after I
>   triggered the reset.  This caused the driver to trigger a re-reset
>   of itself which eventually recovered things.  This was good because
>   it was an actual test of the normal reset flow (not the one
>   triggered via sysfs).

This error triggers something. I remember that when I was working on
suspend-to-ram feature, we had problems to wake up the firmware
reliable. I found this patch in one of my old 3.13 tree

    the missing bit -- ugly hack to force cmd52 before cmd53.
---
 drivers/mmc/host/omap_hsmmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fb24a006080f..710d0bdf39e5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2372,6 +2372,12 @@ static int omap_hsmmc_suspend(struct device *dev)
        if (host->flags & HSMMC_SWAKEUP_QUIRK)
                disable_irq(host->gpio_sdio_irq);

+       /*
+        * force a polling cycle after resume.
+        * will issue cmd52, not cmd53 straight away
+        */
+       omap_hsmmc_enable_sdio_irq(host->mmc, false);
+
        if (host->dbclk)
                clk_disable_unprepare(host->dbclk);

>
> Changes in v2:
> - s/routnine/routine (Brian Norris, Matthias Kaehlcke).
> - s/contining/containing (Matthias Kaehlcke).
> - Add Matthias Reviewed-by tag.
> - Removed clear_bit() calls and old comment (Brian Norris).
> - Explicit CC of Andreas Fenkart.
> - Explicit CC of Brian Norris.
> - Add "Fixes" pointing at the commit Brian talked about.
> - Add Brian's Reviewed-by tag.
>
> Douglas Anderson (2):
>   mmc: core: Add sdio_trigger_replug() API
>   mwifiex: Make use of the new sdio_trigger_replug() API to reset
>
>  drivers/mmc/core/core.c                     | 28 +++++++++++++++++++--
>  drivers/mmc/core/sdio_io.c                  | 20 +++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 16 +-----------
>  include/linux/mmc/host.h                    | 15 ++++++++++-
>  include/linux/mmc/sdio_func.h               |  2 ++
>  5 files changed, 63 insertions(+), 18 deletions(-)
>
> --
> 2.22.0.657.g960e92d24f-goog
>
