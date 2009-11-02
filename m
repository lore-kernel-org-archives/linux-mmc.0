From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 6/6] sdio_uart: Style fixes
Date: Mon, 02 Nov 2009 16:46:24 +0000
Message-ID: <20091102164621.11877.25315.stgit@localhost.localdomain>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756376AbZKBRAH@vger.kernel.org>
In-Reply-To: <20091102164039.11877.88825.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

Running the current code through checkpatch shows a few bits of noise
mostly but not entirely from before the changes.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index c4fc27d..ff93f47 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -462,7 +462,8 @@ static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
 
 	tty = tty_port_tty_get(&port->port);
 
-	if (tty == NULL || !kfifo_len(xmit) || tty->stopped || tty->hw_stopped) {
+	if (tty == NULL || !kfifo_len(xmit)
+				|| tty->stopped || tty->hw_stopped) {
 		sdio_uart_stop_tx(port);
 		return;
 	}
@@ -590,7 +591,6 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 {
 	struct sdio_uart_port *port =
 			container_of(tport, struct sdio_uart_port, port);
-	unsigned long page;
 	int ret;
 
 	/*
@@ -633,7 +633,7 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 	 */
 	sdio_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	port->ier = UART_IER_RLSI | UART_IER_RDI | UART_IER_RTOIE | UART_IER_UUE;
+	port->ier = UART_IER_RLSI|UART_IER_RDI|UART_IER_RTOIE|UART_IER_UUE;
 	port->mctrl = TIOCM_OUT2;
 
 	sdio_uart_change_speed(port, tty->termios, NULL);
@@ -660,7 +660,6 @@ err1:
 	return ret;
 }
 
-	
 /**
  *	sdio_uart_shutdown	-	stop hardware
  *	@tport: tty port to shut down
@@ -675,11 +674,8 @@ static void sdio_uart_shutdown(struct tty_port *tport)
 {
 	struct sdio_uart_port *port =
 			container_of(tport, struct sdio_uart_port, port);
-	int ret;
-
-	ret = sdio_uart_claim_func(port);
-	if (ret)
-		return ret;
+	if (sdio_uart_claim_func(port))
+		return;
 
 	sdio_uart_stop_rx(port);
 
@@ -727,7 +723,6 @@ static int sdio_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 	} else
 		sdio_uart_port_put(port);
 	return ret;
-		
 }
 
 /**
@@ -767,7 +762,7 @@ static void sdio_uart_hangup(struct tty_struct *tty)
 	tty_port_hangup(&port->port);
 }
 
-static int sdio_uart_write(struct tty_struct * tty, const unsigned char *buf,
+static int sdio_uart_write(struct tty_struct *tty, const unsigned char *buf,
 			   int count)
 {
 	struct sdio_uart_port *port = tty->driver_data;
@@ -778,7 +773,7 @@ static int sdio_uart_write(struct tty_struct * tty, const unsigned char *buf,
 
 	ret = kfifo_put(port->xmit_fifo, buf, count);
 
-	if ( !(port->ier & UART_IER_THRI)) {
+	if (!(port->ier & UART_IER_THRI)) {
 		int err = sdio_uart_claim_func(port);
 		if (!err) {
 			sdio_uart_start_tx(port);
@@ -865,7 +860,8 @@ static void sdio_uart_unthrottle(struct tty_struct *tty)
 	sdio_uart_release_func(port);
 }
 
-static void sdio_uart_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
+static void sdio_uart_set_termios(struct tty_struct *tty,
+						struct ktermios *old_termios)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 	unsigned int cflag = tty->termios->c_cflag;
@@ -944,7 +940,7 @@ static int sdio_uart_tiocmset(struct tty_struct *tty, struct file *file,
 	int result;
 
 	result = sdio_uart_claim_func(port);
-	if(!result) {
+	if (!result) {
 		sdio_uart_update_mctrl(port, set, clear);
 		sdio_uart_release_func(port);
 	}
@@ -962,7 +958,7 @@ static int sdio_uart_proc_show(struct seq_file *m, void *v)
 		struct sdio_uart_port *port = sdio_uart_port_get(i);
 		if (port) {
 			seq_printf(m, "%d: uart:SDIO", i);
-			if(capable(CAP_SYS_ADMIN)) {
+			if (capable(CAP_SYS_ADMIN)) {
 				seq_printf(m, " tx:%d rx:%d",
 					      port->icount.tx, port->icount.rx);
 				if (port->icount.frame)
@@ -1015,7 +1011,7 @@ static const struct tty_port_operations sdio_uart_port_ops = {
 	.shutdown = sdio_uart_shutdown,
 	.activate = sdio_uart_activate,
 };
-	
+
 static const struct tty_operations sdio_uart_ops = {
 	.open			= sdio_uart_open,
 	.close			= sdio_uart_close,
@@ -1068,7 +1064,7 @@ static int sdio_uart_probe(struct sdio_func *func,
 		}
 		if (!tpl) {
 			printk(KERN_WARNING
-			       "%s: can't find tuple 0x91 subtuple 0 (SUBTPL_SIOREG) for GPS class\n",
+       "%s: can't find tuple 0x91 subtuple 0 (SUBTPL_SIOREG) for GPS class\n",
 			       sdio_func_id(func));
 			kfree(port);
 			return -EINVAL;
@@ -1101,7 +1097,8 @@ static int sdio_uart_probe(struct sdio_func *func,
 		kfree(port);
 	} else {
 		struct device *dev;
-		dev = tty_register_device(sdio_uart_tty_driver, port->index, &func->dev);
+		dev = tty_register_device(sdio_uart_tty_driver,
+						port->index, &func->dev);
 		if (IS_ERR(dev)) {
 			sdio_uart_port_remove(port);
 			ret = PTR_ERR(dev);
