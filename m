From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/6] sdio_uart: Fix termios handling
Date: Mon, 02 Nov 2009 16:46:05 +0000
Message-ID: <20091102164602.11877.79945.stgit@localhost.localdomain>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756238AbZKBQ70@vger.kernel.org>
In-Reply-To: <20091102164039.11877.88825.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

Switching between two non standard baud rates fails because of the cflag
test. Do as we did elsewhere and just kill the "optimisation".

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index fd00453..e611bc6 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -902,12 +902,6 @@ static void sdio_uart_set_termios(struct tty_struct *tty, struct ktermios *old_t
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
 
