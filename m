From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/6] sdio_uart: refcount the tty objects
Date: Mon, 02 Nov 2009 16:45:35 +0000
Message-ID: <20091102164424.11877.88313.stgit@localhost.localdomain>
References: <20091102164039.11877.88825.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756187AbZKBQ7B@vger.kernel.org>
In-Reply-To: <20091102164039.11877.88825.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, nico@cam.org
List-Id: linux-mmc@vger.kernel.org

The tty can go away underneath us, so we must refcount it. Do the na=C3=
=AFve
implementation initially. We will worry about startup shortly.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/card/sdio_uart.c |   58 ++++++++++++++++++++++++++++++----=
--------
 1 files changed, 41 insertions(+), 17 deletions(-)


diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.=
c
index c2759db..8a4564a 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -172,8 +172,13 @@ static void sdio_uart_port_remove(struct sdio_uart=
_port *port)
 	sdio_claim_host(func);
 	port->func =3D NULL;
 	mutex_unlock(&port->func_lock);
-	if (port->opened)
-		tty_hangup(port->port.tty);
+	if (port->opened) {
+		struct tty_struct *tty =3D tty_port_tty_get(&port->port);
+		/* tty_hangup is async so is this safe as is ?? */
+		if (tty)
+			tty_hangup(tty);
+		tty_kref_put(tty);
+	}
 	mutex_unlock(&port->open_lock);
 	sdio_release_irq(func);
 	sdio_disable_func(func);
@@ -392,7 +397,7 @@ static void sdio_uart_stop_rx(struct sdio_uart_port=
 *port)
 static void sdio_uart_receive_chars(struct sdio_uart_port *port,
 				    unsigned int *status)
 {
-	struct tty_struct *tty =3D port->port.tty;
+	struct tty_struct *tty =3D tty_port_tty_get(&port->port);
 	unsigned int ch, flag;
 	int max_count =3D 256;
=20
@@ -429,25 +434,30 @@ static void sdio_uart_receive_chars(struct sdio_u=
art_port *port,
 		}
=20
 		if ((*status & port->ignore_status_mask & ~UART_LSR_OE) =3D=3D 0)
-			tty_insert_flip_char(tty, ch, flag);
+			if (tty)
+				tty_insert_flip_char(tty, ch, flag);
=20
 		/*
 		 * Overrun is special.  Since it's reported immediately,
 		 * it doesn't affect the current character.
 		 */
 		if (*status & ~port->ignore_status_mask & UART_LSR_OE)
-			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+			if (tty)
+				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
=20
 		*status =3D sdio_in(port, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
-	tty_flip_buffer_push(tty);
+	if (tty) {
+		tty_flip_buffer_push(tty);
+		tty_kref_put(tty);
+	}
 }
=20
 static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
 {
 	struct circ_buf *xmit =3D &port->xmit;
 	int count;
-	struct tty_struct *tty =3D port->port.tty;
+	struct tty_struct *tty;
=20
 	if (port->x_char) {
 		sdio_out(port, UART_TX, port->x_char);
@@ -455,7 +465,10 @@ static void sdio_uart_transmit_chars(struct sdio_u=
art_port *port)
 		port->x_char =3D 0;
 		return;
 	}
-	if (circ_empty(xmit) || tty->stopped || tty->hw_stopped) {
+
+	tty =3D tty_port_tty_get(&port->port);
+
+	if (tty =3D=3D NULL || circ_empty(xmit) || tty->stopped || tty->hw_st=
opped) {
 		sdio_uart_stop_tx(port);
 		return;
 	}
@@ -474,12 +487,13 @@ static void sdio_uart_transmit_chars(struct sdio_=
uart_port *port)
=20
 	if (circ_empty(xmit))
 		sdio_uart_stop_tx(port);
+	tty_kref_put(tty);
 }
=20
 static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 {
 	int status;
-	struct tty_struct *tty =3D port->port.tty;
+	struct tty_struct *tty;
=20
 	status =3D sdio_in(port, UART_MSR);
=20
@@ -494,7 +508,8 @@ static void sdio_uart_check_modem_status(struct sdi=
o_uart_port *port)
 		port->icount.dcd++;
 	if (status & UART_MSR_DCTS) {
 		port->icount.cts++;
-		if (tty->termios->c_cflag & CRTSCTS) {
+		tty =3D tty_port_tty_get(&port->port);
+		if (tty && (tty->termios->c_cflag & CRTSCTS)) {
 			int cts =3D (status & UART_MSR_CTS);
 			if (tty->hw_stopped) {
 				if (cts) {
@@ -509,6 +524,7 @@ static void sdio_uart_check_modem_status(struct sdi=
o_uart_port *port)
 				}
 			}
 		}
+		tty_kref_put(tty);
 	}
 }
=20
@@ -548,8 +564,10 @@ static void sdio_uart_irq(struct sdio_func *func)
 static int sdio_uart_startup(struct sdio_uart_port *port)
 {
 	unsigned long page;
-	int ret;
-	struct tty_struct *tty =3D port->port.tty;
+	int ret =3D -ENOMEM;
+	struct tty_struct *tty =3D tty_port_tty_get(&port->port);
+
+	/* FIXME: What if it is NULL ?? */
=20
 	/*
 	 * Set the TTY IO error marker - we will only clear this
@@ -560,7 +578,7 @@ static int sdio_uart_startup(struct sdio_uart_port =
*port)
 	/* Initialise and allocate the transmit buffer. */
 	page =3D __get_free_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto err0;
 	port->xmit.buf =3D (unsigned char *)page;
 	circ_clear(&port->xmit);
=20
@@ -614,6 +632,7 @@ static int sdio_uart_startup(struct sdio_uart_port =
*port)
 	sdio_uart_irq(port->func);
=20
 	sdio_uart_release_func(port);
+	tty_kref_put(tty);
 	return 0;
=20
 err3:
@@ -622,12 +641,15 @@ err2:
 	sdio_uart_release_func(port);
 err1:
 	free_page((unsigned long)port->xmit.buf);
+err0:
+	tty_kref_put(tty);
 	return ret;
 }
=20
 static void sdio_uart_shutdown(struct sdio_uart_port *port)
 {
 	int ret;
+	struct tty_struct *tty;
=20
 	ret =3D sdio_uart_claim_func(port);
 	if (ret)
@@ -637,9 +659,11 @@ static void sdio_uart_shutdown(struct sdio_uart_po=
rt *port)
=20
 	/* TODO: wait here for TX FIFO to drain */
=20
+	tty =3D tty_port_tty_get(&port->port);
 	/* Turn off DTR and RTS early. */
-	if (port->port.tty->termios->c_cflag & HUPCL)
+	if (tty && (tty->termios->c_cflag & HUPCL))
 		sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+	tty_kref_put(tty);
=20
 	/* Disable interrupts from this port */
 	sdio_release_irq(port->func);
@@ -688,11 +712,11 @@ static int sdio_uart_open(struct tty_struct *tty,=
 struct file *filp)
=20
 	if (!port->opened) {
 		tty->driver_data =3D port;
-		port->port.tty =3D tty;
+		tty_port_tty_set(&port->port, tty);
 		ret =3D sdio_uart_startup(port);
 		if (ret) {
 			tty->driver_data =3D NULL;
-			port->port.tty =3D NULL;
+			tty_port_tty_set(&port->port, NULL);
 			mutex_unlock(&port->open_lock);
 			sdio_uart_port_put(port);
 			return ret;
@@ -727,7 +751,7 @@ static void sdio_uart_close(struct tty_struct *tty,=
 struct file * filp)
 		tty->closing =3D 1;
 		sdio_uart_shutdown(port);
 		tty_ldisc_flush(tty);
-		port->port.tty =3D NULL;
+		tty_port_tty_set(&port->port, NULL);
 		tty->driver_data =3D NULL;
 		tty->closing =3D 0;
 	}
