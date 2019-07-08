From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
Date: Mon,  8 Jul 2019 12:56:13 -0700
Message-ID: <20190708195613.205729-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, mka@chromium.org, groeck@chromium.org, sonnyrao@chromium.org, Douglas Anderson <dianders@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
response errors.") we fixed a tuning-induced hang that I saw when
stress testing tuning on certain SD cards.  I won't re-hash that whole
commit, but the summary is that as a normal part of tuning you need to
deal with transfer errors and there were cases where these transfer
errors was putting my system into a bad state causing all future
transfers to fail.  That commit fixed handling of the transfer errors
for me.

In downstream Chrome OS my fix landed and had the same behavior for
all SD/MMC commands.  However, it looks like when the commit landed
upstream we limited it to only SD tuning commands.  Presumably this
was to try to get around problems that Alim Akhtar reported on exynos
[1].

Unfortunately while stress testing reboots (and suspend/resume) on
some rk3288-based Chromebooks I found the same problem on the eMMC on
some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
same situation.

I'm hoping that whatever problems exynos was having in the past are
somehow magically fixed now and we can make the behavior the same for
all commands.

[1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com

Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Marek (or anyone else using exynos): is it easy for you to test this
and check if things are still broken when we land this patch?  If so,
I guess we could have a quirk to have different behavior for just
Rockchip SoCs but I'd rather avoid that if possible.

NOTE: I'm not hoping totally in vain here.  It is possible that some
of the CTO/DTO timers that landed could be the magic that would get
exynos unstuck.

 drivers/mmc/host/dw_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b53b6b7d4dd4..60c3a06e3469 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2034,8 +2034,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				 * delayed. Allowing the transfer to take place
 				 * avoids races and keeps things simple.
 				 */
-				if ((err != -ETIMEDOUT) &&
-				    (cmd->opcode == MMC_SEND_TUNING_BLOCK)) {
+				if (err != -ETIMEDOUT) {
 					state = STATE_SENDING_DATA;
 					continue;
 				}
-- 
2.22.0.410.gd8fdbe21b5-goog
