From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: return -EILSEQ for EBE and SBE error
Date: Mon, 22 Aug 2016 10:57:16 +0800
Message-ID: <1471834636-21057-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51476 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbcHVDBv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2016 23:01:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

The following log we found indicate the fact that dw_mmc
didn't treat EBE or SBE as a similar problem as CRC error.
-EIO is quite not informative as it may indicate that the device
is broken rather than that of tuning stuff.

...
[ 89.057226] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
[ 89.058811] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
[ 89.059415] bcmsdh_sdmmc: Failed to Read byte F1:@0x1000e=ff, Err: -84
[ 89.254248] dwmmc_rockchip fe310000.dwmmc: Successfully tuned phase to 199
[ 89.273912] dhd_set_suspend: Remove extra suspend setting
[ 89.274478] dhd_enable_packet_filter: enter, value = 0
64 bytes from 112.90.83.112: icmp_seq=24 ttl=53 time=1321 ms
64 bytes from 112.90.83.112: icmp_seq=25 ttl=53 time=319 ms
64 bytes from 112.90.83.112: icmp_seq=26 ttl=53 time=69.8 ms
64 bytes from 112.90.83.112: icmp_seq=27 ttl=53 time=37.5 ms
...

For the host, when failing to sample cmd's response due to
tuning stuff, we still return -EIO as it's quite vague to figure
out whether it related to signal or just the broken devices, especially
for the card type detection when booting kernel as all things go well
but the cmd set used.

But for the data phase, if receiving the cmd's response which
carriess data transfer, we should have more confidence that it
is very probably related to the tuning stuff.

Just as the log shown above, we sometimes suffer too much
this kind of pain as the dw_mmc return -EIO for the case, so
mmc-core will not do retune and caller drivers like bcm's wifi
driver, still retry the failure more and more until dw_mmc
finally generate CRC.

Adrian suggested that drivers who care the specific cases should
call mmc_retune_needed rather than doing it in mmc core. It makes
sense but I'm considering that -EILSEQ actually means illegal sequence
, so we use it for CRC cases. Meanwhile, SBE/EBE indicate the illegal
sequence of start bit or end bit for data0~7. So I realize that we should
use -EILSEQ for them both as well CRC cases.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix some typos found by Jaehoon

 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..b36a4f5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1691,11 +1691,11 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 				data->error = -ETIMEDOUT;
 			} else if (host->dir_status ==
 					DW_MCI_RECV_STATUS) {
-				data->error = -EIO;
+				data->error = -EILSEQ;
 			}
 		} else {
 			/* SDMMC_INT_SBE is included */
-			data->error = -EIO;
+			data->error = -EILSEQ;
 		}
 
 		dev_dbg(host->dev, "data error, status 0x%08x\n", status);
-- 
2.3.7


