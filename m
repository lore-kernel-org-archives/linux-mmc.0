Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C610C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4A22082E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLQHSe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:18:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbfLQHSe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 02:18:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5987277BDFB3752D7BC2;
        Tue, 17 Dec 2019 15:18:32 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 15:18:23 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <zhangpan26@huawei.com>, <hushiyuan@huawei.com>,
        <ulf.hansson@linaro.org>, <allison@lohutok.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: host: use kzalloc instead of kmalloc and memset
Date:   Tue, 17 Dec 2019 15:18:06 +0800
Message-ID: <1576567086-11469-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 drivers/mmc/host/vub300.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6ced1b7..e18931d 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1227,12 +1227,10 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 	size -= 1;
 	if (interrupt_size < size) {
 		u16 xfer_length = roundup_to_multiple_of_64(interrupt_size);
-		u8 *xfer_buffer = kmalloc(xfer_length, GFP_KERNEL);
+		u8 *xfer_buffer = kzalloc(xfer_length, GFP_KERNEL);
 		if (xfer_buffer) {
 			int retval;
 			memcpy(xfer_buffer, data, interrupt_size);
-			memset(xfer_buffer + interrupt_size, 0,
-			       xfer_length - interrupt_size);
 			size -= interrupt_size;
 			data += interrupt_size;
 			retval =
@@ -1270,12 +1268,10 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 	size -= 1;
 	if (ts < size) {
 		u16 xfer_length = roundup_to_multiple_of_64(ts);
-		u8 *xfer_buffer = kmalloc(xfer_length, GFP_KERNEL);
+		u8 *xfer_buffer = kzalloc(xfer_length, GFP_KERNEL);
 		if (xfer_buffer) {
 			int retval;
 			memcpy(xfer_buffer, data, ts);
-			memset(xfer_buffer + ts, 0,
-			       xfer_length - ts);
 			size -= ts;
 			data += ts;
 			retval =
@@ -1465,7 +1461,7 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 			}
 		}
 	} else {
-		u8 *buf = kmalloc(padded_length, GFP_KERNEL);
+		u8 *buf = kzalloc(padded_length, GFP_KERNEL);
 		if (buf) {
 			int result;
 			unsigned pipe = usb_rcvbulkpipe(vub300->udev,
@@ -2024,7 +2020,7 @@ static void vub300_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		msleep(600);
 		vub300->card_powered = 1;
 	} else if (ios->power_mode == MMC_POWER_ON) {
-		u8 *buf = kmalloc(8, GFP_KERNEL);
+		u8 *buf = kzalloc(8, GFP_KERNEL);
 		if (buf) {
 			__set_clock_speed(vub300, buf, ios);
 			kfree(buf);
-- 
2.7.4

