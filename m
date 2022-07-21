Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E251C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jul 2022 05:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiGUF03 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiGUF02 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2022 01:26:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F230F4F
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 22:26:25 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220721052620epoutp04c6d8ba209bd236c57aa35e75d58ca340~DwOW3_5uH1453014530epoutp04b
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 05:26:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220721052620epoutp04c6d8ba209bd236c57aa35e75d58ca340~DwOW3_5uH1453014530epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658381180;
        bh=y9OZaqd9ptnN5gpSgaj4wyizxw1XFfylOWNK+Rxs/Ww=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lv046gS0wLONdMQ7z4slEU5li5FW9JKJr9V3XyS2kEWYWGJH8qiuzFFwT6uSf66Qt
         8YGljKo7ywBXYZFQyFbNY2ziR6G3qg2zB23mxZYuYptMpPEOC2pGA8i8geijgHtAIO
         LbCsnRikVmrDyYNBdl+jERN3tmywGQqjzZM0JSPk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220721052620epcas1p4dc50f66037f3d765b43666970fbabe2c~DwOWlNwXw0195501955epcas1p47;
        Thu, 21 Jul 2022 05:26:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LpLdm0821z4x9QJ; Thu, 21 Jul
        2022 05:26:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.84.09657.A73E8D26; Thu, 21 Jul 2022 14:26:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc~DwOUDQN070214602146epcas1p4W;
        Thu, 21 Jul 2022 05:26:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220721052617epsmtrp2f43f9389af229bff9c8e802053892f0f~DwOUCujU92755127551epsmtrp23;
        Thu, 21 Jul 2022 05:26:17 +0000 (GMT)
X-AuditID: b6c32a35-71dff700000025b9-17-62d8e37a2d56
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.B4.08905.973E8D26; Thu, 21 Jul 2022 14:26:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220721052617epsmtip2f0d6b89240b075a868d2fd27ba53b6be~DwOT2L8tZ0379303793epsmtip23;
        Thu, 21 Jul 2022 05:26:17 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com
Cc:     Seunghui Lee <sh043.lee@samsung.com>,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH] mmc: sd: Remove the patch that fix signal voltage when
 there is no power cycle
Date:   Thu, 21 Jul 2022 14:59:24 +0900
Message-Id: <20220721055924.9043-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmvm7V4xtJBnNusVqcfLKGzWLftZPs
        Fkf+9zNaNP3Zx2JxfG24A6vH4j0vmTzuXNvD5tG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGVu/zmQs+GpVcX71KqYG
        xt0GXYycHBICJhK3Fy1kArGFBHYwSqz5nNPFyAVkf2KUmLRmPyOE841R4t7lnewwHRfnrmKG
        SOxllFi8bgc7hPOZUWLR7gOMIFVsAloS0zdtAZsrIhAgsaH7JmsXIwcHs0CIxM1p5SBhYYFE
        iXu3vjCD2CwCqhJrfr1hBbF5BSwlbm7ZDbVMXuLP/R5miLigxMmZT1hAbGagePPW2WBHSAjs
        Y5f482sBC0SDi0Tjk+OsELawxKvjW6AGSUl8freXDcIulmj7948Zwq6QONj3Bco2lvj0+TMj
        xJ2aEut36UOEFSV2/p7LCLGXT+Ld1x6wVyQEeCU62oQgSpQlXj5axgRhS0osab8FNdFD4uaF
        JcyQ0I2VuDz9PeMERvlZSL6ZheSbWQiLFzAyr2IUSy0ozk1PLTYsMITHaXJ+7iZGcMLTMt3B
        OPHtB71DjEwcjIcYJTiYlUR4nxZeTxLiTUmsrEotyo8vKs1JLT7EaAoM34nMUqLJ+cCUm1cS
        b2hiaWBiZmRiYWxpbKYkzrtq2ulEIYH0xJLU7NTUgtQimD4mDk6pBibh+POvzzfdnxheucrh
        48z4CS1p56UN765bxz/Xg5WrYCNPFOfy6evCpxxiKMxIOfRv3x6u6VxxbCu3GvTUSAoKXby8
        VVT05YRTUhe7I04d2DZJIdR86gaFjmzxH+K/FB7sPWGcPudM6LeHP/dnJHx56q4oePtVpDan
        rZAYly7/g9/3FvOKu+1o2VleLjv/8xLfe5orWf1vtf+wy1A5/D6aS3X/+w99pSYC2XNvM4R+
        OWJu6BG/Z8H5fdpf7i18cYZd9Mz7MzfYPnk8mGZp2r02V3x3kswMw1kzi2fv/pF6sX6WxKL+
        BZOV44+1nb3QeTnB8sahZx1ZimVRezSeT/8vwpsUNv2sSM8+1emH1tm1KrEUZyQaajEXFScC
        AInToLIBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvG7l4xtJBq/2ylmcfLKGzWLftZPs
        Fkf+9zNaNP3Zx2JxfG24A6vH4j0vmTzuXNvD5tG3ZRWjx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        W7/OZCz4alVxfvUqpgbG3QZdjJwcEgImEhfnrmLuYuTiEBLYzShxsucVE0RCUmLxo4dsXYwc
        QLawxOHDxRA1HxklzjXMZAGpYRPQkpi+aQtYvYhAkMSma4tZQeqZBUIkHj/OAwkLC8RLND79
        ywxiswioSqz59YYVxOYVsJS4uWU3O8QqeYk/93uYIeKCEidnPgEbzwwUb946m3kCI98sJKlZ
        SFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh6CW5g7G7as+6B1iZOJgPMQo
        wcGsJML7tPB6khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTByc
        Ug1MKz89KhI2l/JINFBfdF13R2zt7qU3NzAXyGTtDz7MLXru+dYiqcQa5x+1Z59M0b9bXTep
        sejN7m2J+feWvZjpvJLNWTuq9OCbhjLx81859i2bkVs29d6beRe/PtHlMjosf+qmHt+9PV7v
        FHsv8i6Q23dnQ/cl8Rsnnr57cOziJWPe4rUvbz7K25Nvs5bx1FHhnTNOtdmr/dDcUDGTO+oa
        x/5zJ94opl98o/j2isiTav4zdsHpOsfifqRP/X6VT+Gbg9PaTdsKXU4d7pr48V8qm79NjOFC
        lqwzGofPZkxjkzTT2u/Q71y6rOGexXLFwOjiv7UrnnmYbZjvqsmrl/ky9qPyVInG1nN5fLuX
        Gk3XPqPEUpyRaKjFXFScCAAEZh0FsAIAAA==
X-CMS-MailID: 20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc
References: <CGME20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

At first, all error flow of mmc_set_uhs_voltage() has power cycle
except R1_ERROR and no start_signal_voltage_switch() func pointer.

There is the performance regression issue of SDR104 SD card from
the market VOC. Normally, once a SDR104 SD card fails to switch voltage,
it works HS mode.
And then it initializes SDR104 mode after system resume or error handling.

However, with below patch,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core/sd.c?id=6a11fc47f175c8d87018e89cb58e2d36c66534cb
Once a SD card does, it initializes SDR25 mode forever
after system resume or error handling(re-initialized).
Host updates sd3_bus_mode by calling mmc_read_switch(),
the value of sd3_bus_mode doesn't set for SDR104, SDR50 and DDR50 mode.

So, if host doesn't update sd3_bus_mode,
the SD card works SDR104 mode after system resume or error-handling.

Here is an example.

AS-IS : test log
// normal case : sd3_bus_mode = 0x1F, sd_bus_speed = SDR104, clock 208MHz
[  111.907789] [1:    kworker/1:3:  772] [TEST] mmc_sd_init_card: 1119: caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false, signal_voltage =0x1.
[  111.907824] [1:    kworker/1:3:  772] [TEST] mmc_sd_init_card: 1149: rocr 0xc1ff8000, S18A, uhs.
[  111.908707] [1:    kworker/1:3:  772] [TEST] sd_update_bus_speed_mode: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr = 0x40000.
[  111.912484] [1:    kworker/1:3:  772] [TEST] sd_set_bus_speed_mode: sd_bus_speed=3, timing=6, uhs_max_dtr=208000000, card->ocr=0x40000.
// resume : issue occurs : SDcard doesn't release busy for checking 10 times
[  112.096550] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1040: card->ocr 0x40000.
[  112.096560] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr 0x40000(pocr 0x40000), retries 10.
...
[  114.531129] [5:    kworker/5:2:  207] [TEST] mmc_power_cycle.
[  114.579500] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr 0x41040000(pocr 0x40000), retries 0.
[  114.579506] [5:    kworker/5:2:  207] mmc0: Skipping voltage switch
[  114.757575] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1119: caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false, signal_voltage =0x0.
[  114.757583] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1128: switch with oldcard.
[  114.759742] [5:    kworker/5:2:  207] [TEST] mmc_read_switch: sd_switch ret 0, sd3_bus_mode=3.
// sd3_bus_mode = 0x3 supports HS, SDR25 and SDR12
[  114.759750] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1157: switch hs.
// next resume : the SDcard initializes to SDR25(HS) mode(sd_bus_speed = 1) by sd3_bus_mode setting with clk 50MHz
[  114.968346] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1040: card->ocr 0x40000.
[  114.968359] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr 0x40000(pocr 0x40000), retries 10.
[  115.167346] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1119: caps=0x407f020f, sd3_bus_mode=0x3, v18_fixup_failed false, signal_voltage =0x1.
[  115.167366] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1149: rocr 0xc1ff8000, S18A, uhs.
[  115.168041] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_uhs_card: before update: caps 0x407f020f, sd3_bus_mode = 3, sd_bus_speed = 3, card->ocr = 0x40000.
[  115.168051] [5:    kworker/5:2:  207] [TEST] sd_update_bus_speed_mode: caps 0x407f020f, sd3_bus_mode = 3, sd_bus_speed = 1, card->ocr = 0x40000.
[  115.169176] [5:    kworker/5:2:  207] [TEST] sd_set_bus_speed_mode: sd_bus_speed=1, timing=4, uhs_max_dtr=50000000, card->ocr=0x40000.

TO-BE : TEST log with this commit
// resume : issue occurs : SDcard doesn't release busy for checking 10 times
[ 1843.594805] [4:    kworker/4:5:21512] [TEST] mmc_sd_get_cid: ocr 0x41040000(pocr 0x40000), retries 0.
[ 1843.594812] [4:    kworker/4:5:21512] mmc0: Skipping voltage switch
[ 1843.772555] [4:    kworker/4:5:21512] [TEST] mmc_sd_init_card: 1122: caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false, signal_voltage =0x0.
// no update sd3_bus_mode value
[ 1843.772563] [4:    kworker/4:5:21512] [TEST] mmc_sd_init_card: 1164: switch hs.
// next resume : the SDcard initializes to SDR104
[ 1844.191295] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_card: 1122: caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false, signal_voltage =0x1.
[ 1844.191315] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_card: 1154: rocr 0xc1ff8000, S18A, uhs.
[ 1844.192175] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_uhs_card: before update: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr = 0x40000.
[ 1844.192187] [5:   kworker/5:93: 2282] [TEST] sd_update_bus_speed_mode: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr = 0x40000.
[ 1844.198697] [5:   kworker/5:93: 2282] [TEST] sd_set_bus_speed_mode: sd_bus_speed=3, timing=6, uhs_max_dtr=208000000, card->ocr=0x40000.

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
Tested-by: DooHyun Hwang <dh0421.hwang@samsung.com>
---
 drivers/mmc/core/sd.c | 47 ++-----------------------------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cee4c0b59f43..4e3d39956185 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1001,18 +1001,6 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 	return max_dtr;
 }
 
-static bool mmc_sd_card_using_v18(struct mmc_card *card)
-{
-	/*
-	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
-	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
-	 * they can be used to determine if the card has already switched to
-	 * 1.8V signaling.
-	 */
-	return card->sw_caps.sd3_bus_mode &
-	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
-}
-
 static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8 page, u16 offset,
 			    u8 reg_data)
 {
@@ -1400,10 +1388,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
-	bool v18_fixup_failed = false;
 
 	WARN_ON(!host->claimed);
-retry:
+
 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
 	if (err)
 		return err;
@@ -1472,36 +1459,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
-	/*
-	 * If the card has not been power cycled, it may still be using 1.8V
-	 * signaling. Detect that situation and try to initialize a UHS-I (1.8V)
-	 * transfer mode.
-	 */
-	if (!v18_fixup_failed && !mmc_host_is_spi(host) && mmc_host_uhs(host) &&
-	    mmc_sd_card_using_v18(card) &&
-	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
-		/*
-		 * Re-read switch information in case it has changed since
-		 * oldcard was initialized.
-		 */
-		if (oldcard) {
-			err = mmc_read_switch(card);
-			if (err)
-				goto free_card;
-		}
-		if (mmc_sd_card_using_v18(card)) {
-			if (mmc_host_set_uhs_voltage(host) ||
-			    mmc_sd_init_uhs_card(card)) {
-				v18_fixup_failed = true;
-				mmc_power_cycle(host, ocr);
-				if (!oldcard)
-					mmc_remove_card(card);
-				goto retry;
-			}
-			goto done;
-		}
-	}
-
 	/* Initialization sequence for UHS-I cards */
 	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
 		err = mmc_sd_init_uhs_card(card);
@@ -1566,7 +1523,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = -EINVAL;
 		goto free_card;
 	}
-done:
+
 	host->card = card;
 	return 0;
 
-- 
2.29.0

