From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 07/11] sdio_uart: Fix termios handling
Date: Tue, 03 Nov 2009 14:18:21 +0000
Message-ID: <20091103141817.31032.2378.stgit@localhost.localdomain>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55421 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753216AbZKCObp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 09:31:45 -0500
In-Reply-To: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org

Switching between two non standard baud rates fails because of the cflag
test. Do as we did elsewhere and just kill the "optimisation".

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 3e2ae66..d41aa35 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -901,12 +901,6 @@ static void sdio_uart_set_termios(struct tty_struct *tty, struct ktermios *old_t
 	struct sdio_uart_port *port = tty->driver_data;
 	unsigned int cflag = tty->termios->c_cflag;
 
-#define RELEVANT_IFLAG(iflag)	((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
-	if ((cflag ^ old_termios->c_cflag) == 0 &&
-	    RELEVANT_IFLAG(tty->termios->c_iflag ^ old_termios->c_iflag) == 0)
-		return;
-
 	if (sdio_uart_claim_func(port) != 0)
 		return;
 

