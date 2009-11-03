From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 05/11] sdio_uart: Move the open lock
Date: Tue, 03 Nov 2009 14:18:04 +0000
Message-ID: <20091103141758.31032.70695.stgit@localhost.localdomain>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752891AbZKCObc@vger.kernel.org>
In-Reply-To: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

When we move to the tty_port logic the port mutex will protect open v close
v hangup. Move to this first in the existing open code so we have a bisection
point.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index 51aeaf6..f76741d 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -78,7 +78,6 @@ struct sdio_uart_port {
 	struct tty_struct	*tty;
 	unsigned int		index;
 	unsigned int		opened;
-	struct mutex		open_lock;
 	struct sdio_func	*func;
 	struct mutex		func_lock;
 	struct task_struct	*in_sdio_uart_irq;
@@ -103,7 +102,6 @@ static int sdio_uart_add_port(struct sdio_uart_port *port)
 	int index, ret = -EBUSY;
 
 	kref_init(&port->kref);
-	mutex_init(&port->open_lock);
 	mutex_init(&port->func_lock);
 	spin_lock_init(&port->write_lock);
 
@@ -166,7 +164,7 @@ static void sdio_uart_port_remove(struct sdio_uart_port *port)
 	 * give up on that port ASAP.
 	 * Beware: the lock ordering is critical.
 	 */
-	mutex_lock(&port->open_lock);
+	mutex_lock(&port->port.mutex);
 	mutex_lock(&port->func_lock);
 	func = port->func;
 	sdio_claim_host(func);
@@ -179,7 +177,7 @@ static void sdio_uart_port_remove(struct sdio_uart_port *port)
 			tty_hangup(tty);
 		tty_kref_put(tty);
 	}
-	mutex_unlock(&port->open_lock);
+	mutex_unlock(&port->port.mutex);
 	sdio_release_irq(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
@@ -698,14 +696,14 @@ static int sdio_uart_open(struct tty_struct *tty, struct file *filp)
 	if (!port)
 		return -ENODEV;
 
-	mutex_lock(&port->open_lock);
+	mutex_lock(&port->port.mutex);
 
 	/*
 	 * Make sure not to mess up with a dead port
 	 * which has not been closed yet.
 	 */
 	if (tty->driver_data && tty->driver_data != port) {
-		mutex_unlock(&port->open_lock);
+		mutex_unlock(&port->port.mutex);
 		sdio_uart_port_put(port);
 		return -EBUSY;
 	}
@@ -717,13 +715,13 @@ static int sdio_uart_open(struct tty_struct *tty, struct file *filp)
 		if (ret) {
 			tty->driver_data = NULL;
 			tty_port_tty_set(&port->port, NULL);
-			mutex_unlock(&port->open_lock);
+			mutex_unlock(&port->port.mutex);
 			sdio_uart_port_put(port);
 			return ret;
 		}
 	}
 	port->opened++;
-	mutex_unlock(&port->open_lock);
+	mutex_unlock(&port->port.mutex);
 	return 0;
 }
 
@@ -734,7 +732,7 @@ static void sdio_uart_close(struct tty_struct *tty, struct file * filp)
 	if (!port)
 		return;
 
-	mutex_lock(&port->open_lock);
+	mutex_lock(&port->port.mutex);
 	BUG_ON(!port->opened);
 
 	/*
@@ -743,7 +741,7 @@ static void sdio_uart_close(struct tty_struct *tty, struct file * filp)
 	 * is larger than port->count.
 	 */
 	if (tty->count > port->opened) {
-		mutex_unlock(&port->open_lock);
+		mutex_unlock(&port->port.mutex);
 		return;
 	}
 
@@ -755,7 +753,7 @@ static void sdio_uart_close(struct tty_struct *tty, struct file * filp)
 		tty->driver_data = NULL;
 		tty->closing = 0;
 	}
-	mutex_unlock(&port->open_lock);
+	mutex_unlock(&port->port.mutex);
 	sdio_uart_port_put(port);
 }
 
