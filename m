From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 10/11] sdio_uart: Fix the locking on "func" for new code
Date: Tue, 03 Nov 2009 14:18:58 +0000
Message-ID: <20091103141846.31032.81142.stgit@localhost.localdomain>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753786AbZKCOcZ@vger.kernel.org>
In-Reply-To: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

The new dtr_rts function didn't take the port->func lock as it should
so add use of the lock there.


Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index ebb5d4b..0a3acfb 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -565,10 +565,14 @@ static void uart_dtr_rts(struct tty_port *tport, int onoff)
 {
 	struct sdio_uart_port *port =
 			container_of(tport, struct sdio_uart_port, port);
+	int ret = sdio_uart_claim_func(port);
+	if (ret)
+		return;
 	if (onoff == 0)
 		sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	else
 		sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	sdio_uart_release_func(port);
 }
 
 /**
