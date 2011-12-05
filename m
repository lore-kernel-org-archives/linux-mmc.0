From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 03/14] mmc: mmci: Increase max_segs from 16 to 128
Date: Mon, 5 Dec 2011 18:35:49 +0100
Message-ID: <1323106560-5218-4-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:45327 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932592Ab1LERg0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:36:26 -0500
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>

A significant increase (10-20%) in performance throughput for
USB mass storage is the reason for incrementing the value.
By some reason the USB driver allocates buffers which requires
a scattergather list to contain a lot more than 16 elements to
get optimal performance. This change sets the maximum elements
to 128.

Tests with large reads and large writes (100 MiB) show that the
throughput increase is significant for write (10% for this test)
but not for read. Tests are run on a Linux host with ext4 FS on
the gadget mass storage device. The sg-len still exceeds 16 for
the read tests but the performance gain is low or nothing.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79e4143..49f153e 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -160,7 +160,7 @@
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
-#define NR_SG		16
+#define NR_SG		128
 
 struct clk;
 struct variant_data;
-- 
1.7.5.4

