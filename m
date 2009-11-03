From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 03/11] sdio_uart: Fix oops caused by the previous changeset
Date: Tue, 03 Nov 2009 14:17:42 +0000
Message-ID: <20091103141739.31032.36525.stgit@localhost.localdomain>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55405 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750850AbZKCObF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 09:31:05 -0500
In-Reply-To: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org

From: Nicolas Pitre <nico@fluxnic.net>

Now... testing reveals that the very first patch "sdio_uart: use
tty_port" causes a segmentation fault in sdio_uart_open():

Unable to handle kernel NULL pointer dereference at virtual address 00000084
pgd = dfb44000 [00000084] *pgd=1fb99031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT
last sysfs file:
/sys/devices/platform/mvsdio/mmc_host/mmc0/mmc0:f111/uevent
Modules linked in:
CPU: 0    Not tainted  (2.6.32-rc5-next-20091102-00001-gb36eae9 #10)
PC is at sdio_uart_open+0x204/0x2cc
[...]

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index c2759db..671fe5e 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -608,7 +608,7 @@ static int sdio_uart_startup(struct sdio_uart_port *port)
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
 			tty->hw_stopped = 1;
 
-	clear_bit(TTY_IO_ERROR, &port->tty->flags);
+	clear_bit(TTY_IO_ERROR, &tty->flags);
 
 	/* Kick the IRQ handler once while we're still holding the host lock */
 	sdio_uart_irq(port->func);

