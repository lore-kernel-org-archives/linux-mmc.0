From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 6/8] mmc: sdio_uart: remove meaningless BUG_ON
Date: Tue, 18 Oct 2016 20:04:26 +0800
Message-ID: <1476792266-6513-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:38037 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759425AbcJRL6l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:58:41 -0400
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

The code seems quite simple to maintain the sdio_uart_table,
and the insert/remove port from the table are symmetric. If
the BUG_ON occurs, which means serial_core modify the index
or mess up the port sequence anyway.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/card/sdio_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 5af6fb9..491c187 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -135,8 +135,6 @@ static void sdio_uart_port_remove(struct sdio_uart_port *port)
 {
 	struct sdio_func *func;
 
-	BUG_ON(sdio_uart_table[port->index] != port);
-
 	spin_lock(&sdio_uart_table_lock);
 	sdio_uart_table[port->index] = NULL;
 	spin_unlock(&sdio_uart_table_lock);
-- 
2.3.7


