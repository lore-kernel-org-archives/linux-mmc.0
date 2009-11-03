From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 01/11] tty_port: Move hupcl handling
Date: Tue, 03 Nov 2009 14:17:23 +0000
Message-ID: <20091103141713.31032.3246.stgit@localhost.localdomain>
References: <20091103141525.31032.45206.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751682AbZKCOas@vger.kernel.org>
In-Reply-To: <20091103141525.31032.45206.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

Move the HUCPL handling from the end of close_port_start to the beginning
of close_port_end. What this actually does is change the ordering from

	port shutdown
	port->dtr_rts

to

	port->dtr_rts
	port shutdown

Some hardware drops the physical connection on shutdown so we must perform
the port operations before the shutdown.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/tty_port.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index da12fae..cf4b16a 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -357,6 +357,14 @@ int tty_port_close_start(struct tty_port *port,
 			timeout = 2 * HZ;
 		schedule_timeout_interruptible(timeout);
 	}
+	/* Flush the ldisc buffering */
+	tty_ldisc_flush(tty);
+
+	/* Drop DTR/RTS if HUPCL is set. This causes any attached modem to
+	   hang up the line */
+	if (tty->termios->c_cflag & HUPCL)
+		tty_port_lower_dtr_rts(port);
+
 	/* Don't call port->drop for the last reference. Callers will want
 	   to drop the last active reference in ->shutdown() or the tty
 	   shutdown path */
@@ -368,11 +376,6 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	tty_ldisc_flush(tty);
-
-	if (tty->termios->c_cflag & HUPCL)
-		tty_port_lower_dtr_rts(port);
-
 	spin_lock_irqsave(&port->lock, flags);
 	tty->closing = 0;
 
