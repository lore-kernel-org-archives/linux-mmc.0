From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: Subject: [PATCH] mmc: dw_mmc: fix fifo access for 64-bit
Date: Fri, 22 Mar 2013 19:30:20 +0900
Message-ID: <000d01ce26e8$411079b0$c3316d10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65110 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab3CVKaW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 06:30:22 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK2001F256IIFJ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Mar 2013 19:30:20 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Subject: [PATCH] mmc: dw_mmc: fix fifo access for 64-bit

mci_writew causes a failure of fifo access for 64-bit.
mci_writeq is correct.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
This patch depends on [PATCH 3/3] dw_mmc: Handle unaligned data submission correctly.

 drivers/mmc/host/dw_mmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index aab5473..0d8fb78 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1373,8 +1373,9 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 		int len = dw_mci_push_part_bytes(host, buf, cnt);
 		buf += len;
 		cnt -= len;
+
 		if (host->part_buf_count == 8) {
-			mci_writew(host, DATA(host->data_offset),
+			mci_writeq(host, DATA(host->data_offset),
 					host->part_buf);
 			host->part_buf_count = 0;
 		}
-- 
1.7.0.4


