From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for vqmmc
Date: Tue, 11 Nov 2014 12:02:53 +0800
Message-ID: <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415109789-7046-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lintao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenfen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SD2.0 cards need vqmmc and vmmc to be the same.
But vqmmc call regulator_set_voltage to set min_uv(2.7v) as far as possible.
So if we set vmmc 3.3V in dt table, we will get error information as follows:

[   17.785398] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req
50000000Hz, actual 50000000HZ div = 0)
[   17.795175] mmc1: new high speed SDHC card at address e624
[   17.801283] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[   17.816033]  mmcblk1: p1
[   17.839318] mmcblk1: error -110 sending status command, retrying
[   17.845363] mmcblk1: error -115 sending stop command, original cmd
response 0x900, card status 0x800b00
[   17.854758] mmcblk1: error -84 transferring data, sector 32, nr 24,
cmd response 0x900, card status 0xb00
[   17.864328] mmcblk1: retrying using single block read
[   17.873647] mmcblk1: error -110 sending status command, retrying
[   17.879660] mmcblk1: error -84 transferring data, sector 44, nr 12,
cmd response 0x900, card status 0x0
[   17.889051] end_request: I/O error, dev mmcblk1, sector 44
[   17.895594] Buffer I/O error on device mmcblk1, logical block 5
[   17.902484] mmcblk1: error -110 sending status command, retrying
[   17.908498] mmcblk1: error -84 transferring data, sector 50, nr 6,
cmd response 0x900, card status 0x0
[   17.917802] end_request: I/O error, dev mmcblk1, sector 50
[   17.924984] Buffer I/O error on device mmcblk1, logical block 6
[   18.431258] mmc_host mmc1: Timeout sending command (cmd 0x200000 arg
0x0 status 0x80200000)

Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b4c3044..a8b70b5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1163,8 +1163,14 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	uhs = mci_readl(host, UHS_REG);
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		min_uv = 2700000;
-		max_uv = 3600000;
+		/* try pick the exact same voltage as vmmc for vqmmc */
+		if (!IS_ERR(mmc->supply.vmmc)) {
+			min_uv = regulator_get_voltage(mmc->supply.vmmc);
+			max_uv = min_uv;
+		} else {
+			min_uv = 2700000;
+			max_uv = 3600000;
+		}
 		uhs &= ~v18;
 	} else {
 		min_uv = 1700000;
-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
