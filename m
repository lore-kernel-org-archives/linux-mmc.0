From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH v2] tty: Change tty_{port|standard}_install() return type to
 void
Date: Wed,  5 Sep 2018 11:50:31 +0900
Message-ID: <1536115855-25744-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Potapenko <glider@google.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:SPARC SERIAL DRIVERS" <sparclinux@vger.kernel.org>, Thomas Meyer <thomas@m3y3r.de>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:S390" <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, David Lin <dtwlin@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Guenter Roeck <linux@roeck-us.net>, Adam Borowski <kilobyte@angband.pl>, Kees Cook <keescook@chromium.org>, Mathias Nyman <mathias.nyman@intel.c>
List-Id: linux-mmc@vger.kernel.org

Many drivers with tty use the tty_stand_install(). But, there is no
need to handle the error, since it always returns 0. So, change the
return type of tty_standard_install() and tty_port_install() to void
type and remove unnecessary exception handling where we use these
functions.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
Changes in v2:
- Update commit title
- Squash other patches into one
  https://lkml.org/lkml/2018/9/4/70

 arch/um/drivers/line.c              |  7 +------
 drivers/isdn/capi/capi.c            | 10 ++++------
 drivers/isdn/i4l/isdn_tty.c         |  3 ++-
 drivers/misc/pti.c                  | 28 +++++++++++++---------------
 drivers/mmc/core/sdio_uart.c        | 11 ++++-------
 drivers/s390/char/con3215.c         |  3 ++-
 drivers/s390/char/tty3270.c         |  7 +------
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 drivers/staging/gdm724x/gdm_tty.c   | 11 +++--------
 drivers/staging/greybus/uart.c      | 10 ++--------
 drivers/tty/hvc/hvc_console.c       |  7 ++-----
 drivers/tty/hvc/hvcs.c              | 10 ++--------
 drivers/tty/mips_ejtag_fdc.c        |  4 +++-
 drivers/tty/n_gsm.c                 |  9 +--------
 drivers/tty/nozomi.c                |  8 +++-----
 drivers/tty/serial/kgdb_nmi.c       | 11 +----------
 drivers/tty/synclink.c              |  3 ++-
 drivers/tty/synclinkmp.c            |  3 ++-
 drivers/tty/tty_io.c                | 10 ++++++----
 drivers/tty/tty_port.c              |  4 ++--
 drivers/tty/vcc.c                   |  5 +----
 drivers/tty/vt/vt.c                 |  5 +----
 drivers/usb/class/cdc-acm.c         | 10 +---------
 drivers/usb/host/xhci-dbgtty.c      |  3 ++-
 drivers/usb/serial/usb-serial.c     |  6 +-----
 include/linux/tty.h                 |  4 ++--
 net/bluetooth/rfcomm/tty.c          |  7 +------
 27 files changed, 73 insertions(+), 148 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8d80b27..47058cf 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file *filp)
 int line_install(struct tty_driver *driver, struct tty_struct *tty,
 		 struct line *line)
 {
-	int ret;
-
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = line;
 
 	return 0;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b..08daf3a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -999,13 +999,11 @@ static int
 capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct capiminor *mp = capiminor_get(tty->index);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		tty->driver_data = mp;
-	else
-		capiminor_put(mp);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = mp;
+
+	return 0;
 }
 
 static void capinc_tty_cleanup(struct tty_struct *tty)
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index b730037..3d6b24e 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1481,8 +1481,9 @@ static int isdn_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /*
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f..5c885a1 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct pti_tty *pti_tty_data;
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0) {
-		pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
-		if (pti_tty_data == NULL)
-			return -ENOMEM;
+	tty_standard_install(driver, tty);
+	pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
+	if (pti_tty_data == NULL)
+		return -ENOMEM;
 
-		if (idx == PTITTY_MINOR_START)
-			pti_tty_data->mc = pti_request_masterchannel(0, NULL);
-		else
-			pti_tty_data->mc = pti_request_masterchannel(2, NULL);
+	if (idx == PTITTY_MINOR_START)
+		pti_tty_data->mc = pti_request_masterchannel(0, NULL);
+	else
+		pti_tty_data->mc = pti_request_masterchannel(2, NULL);
 
-		if (pti_tty_data->mc == NULL) {
-			kfree(pti_tty_data);
-			return -ENXIO;
-		}
-		tty->driver_data = pti_tty_data;
+	if (pti_tty_data->mc == NULL) {
+		kfree(pti_tty_data);
+		return -ENXIO;
 	}
+	tty->driver_data = pti_tty_data;
 
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 25e1130..b727186 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -731,14 +731,11 @@ static int sdio_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct sdio_uart_port *port = sdio_uart_port_get(idx);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		/* This is the ref sdio_uart_port get provided */
-		tty->driver_data = port;
-	else
-		sdio_uart_port_put(port);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 /**
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 8c9d412..6a9f6d9 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -965,8 +965,9 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = raw;
+	tty_port_install(&raw->port, driver, tty);
 
-	return tty_port_install(&raw->port, driver, tty);
+	return 0;
 }
 
 /*
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5b8af27..2915f95 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1017,12 +1017,7 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 	raw3270_activate_view(&tp->view);
 
 port_install:
-	rc = tty_port_install(&tp->port, driver, tty);
-	if (rc) {
-		raw3270_put_view(&tp->view);
-		return rc;
-	}
-
+	tty_port_install(&tp->port, driver, tty);
 	tty->driver_data = tp;
 
 	return 0;
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index fa0dd42..5134019 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)
 static int fwtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(tty->index);
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwloop_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwtty_write(struct tty_struct *tty, const unsigned char *buf, int c)
diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e81369..d6348df 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -62,6 +62,7 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	mutex_lock(&gdm_table_lock);
+
 	gdm = gdm_table[ret][tty->index];
 	if (!gdm) {
 		mutex_unlock(&gdm_table_lock);
@@ -69,15 +70,9 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 
 	tty_port_get(&gdm->port);
-
-	ret = tty_standard_install(driver, tty);
-	if (ret) {
-		tty_port_put(&gdm->port);
-		mutex_unlock(&gdm_table_lock);
-		return ret;
-	}
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = gdm;
+
 	mutex_unlock(&gdm_table_lock);
 
 	return 0;
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 8a00632..182155b 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -393,21 +393,15 @@ static void release_minor(struct gb_tty *gb_tty)
 static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct gb_tty *gb_tty;
-	int retval;
 
 	gb_tty = get_gb_by_minor(tty->index);
 	if (!gb_tty)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = gb_tty;
+
 	return 0;
-error:
-	tty_port_put(&gb_tty->port);
-	return retval;
 }
 
 static int gb_tty_open(struct tty_struct *tty, struct file *file)
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a..13fad62 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -329,7 +329,6 @@ static void hvc_unthrottle(struct tty_struct *tty)
 static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct hvc_struct *hp;
-	int rc;
 
 	/* Auto increments kref reference if found. */
 	hp = hvc_get_by_index(tty->index);
@@ -337,11 +336,9 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = hp;
+	tty_port_install(&hp->port, driver, tty);
 
-	rc = tty_port_install(&hp->port, driver, tty);
-	if (rc)
-		tty_port_put(&hp->port);
-	return rc;
+	return 0;
 }
 
 /*
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b..4dfa70c 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1140,16 +1140,10 @@ static int hvcs_install(struct tty_driver *driver, struct tty_struct *tty)
 		goto err_put;
 	}
 
-	retval = tty_port_install(&hvcsd->port, driver, tty);
-	if (retval)
-		goto err_irq;
+	tty_port_install(&hvcsd->port, driver, tty);
 
 	return 0;
-err_irq:
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	vio_disable_interrupts(hvcsd->vdev);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	free_irq(irq, hvcsd);
+
 err_put:
 	tty_port_put(&hvcsd->port);
 
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 4c1cd49..33e06b4 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -763,7 +763,9 @@ static int mips_ejtag_fdc_tty_install(struct tty_driver *driver,
 	struct mips_ejtag_fdc_tty *priv = driver->driver_state;
 
 	tty->driver_data = &priv->ports[tty->index];
-	return tty_port_install(&priv->ports[tty->index].port, driver, tty);
+	tty_port_install(&priv->ports[tty->index].port, driver, tty);
+
+	return 0;
 }
 
 static int mips_ejtag_fdc_tty_open(struct tty_struct *tty, struct file *filp)
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86b7e20..c52fa2d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2917,7 +2917,6 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	unsigned int line = tty->index;
 	unsigned int mux = line >> 6;
 	bool alloc = false;
-	int ret;
 
 	line = line & 0x3F;
 
@@ -2949,14 +2948,8 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 		mutex_unlock(&gsm->mutex);
 		return -ENOMEM;
 	}
-	ret = tty_port_install(&dlci->port, driver, tty);
-	if (ret) {
-		if (alloc)
-			dlci_put(dlci);
-		mutex_unlock(&gsm->mutex);
-		return ret;
-	}
 
+	tty_port_install(&dlci->port, driver, tty);
 	dlci_get(dlci);
 	dlci_get(gsm->dlci[0]);
 	mux_get(gsm);
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index fed820e..479583d 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1555,13 +1555,11 @@ static int ntty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct port *port = get_port_by_tty(tty);
 	struct nozomi *dc = get_dc_by_tty(tty);
-	int ret;
 	if (!port || !dc || dc->state != NOZOMI_STATE_READY)
 		return -ENODEV;
-	ret = tty_standard_install(driver, tty);
-	if (ret == 0)
-		tty->driver_data = port;
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+	return 0;
 }
 
 static void ntty_cleanup(struct tty_struct *tty)
diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272..ed8f806 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -234,7 +234,6 @@ static const struct tty_port_operations kgdb_nmi_tty_port_ops = {
 static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 {
 	struct kgdb_nmi_tty_priv *priv;
-	int ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -245,17 +244,9 @@ static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 	tty_port_init(&priv->port);
 	priv->port.ops = &kgdb_nmi_tty_port_ops;
 	tty->driver_data = priv;
+	tty_port_install(&priv->port, drv, tty);
 
-	ret = tty_port_install(&priv->port, drv, tty);
-	if (ret) {
-		pr_err("%s: can't install tty port: %d\n", __func__, ret);
-		goto err;
-	}
 	return 0;
-err:
-	tty_port_destroy(&priv->port);
-	kfree(priv);
-	return ret;
 }
 
 static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index fbdf4d0..6e7e4d6 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3355,8 +3355,9 @@ static int mgsl_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_open"))
 		return -ENODEV;
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /* mgsl_open()
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 1e4d5b9..2d99a5b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -734,8 +734,9 @@ static int install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /* Called when a port is opened.  Init and enable port.
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3..b01cec8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1196,13 +1196,12 @@ void tty_init_termios(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(tty_init_termios);
 
-int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
+void tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	tty_init_termios(tty);
 	tty_driver_kref_get(driver);
 	tty->count++;
 	driver->ttys[tty->index] = tty;
-	return 0;
 }
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
@@ -1221,8 +1220,11 @@ EXPORT_SYMBOL_GPL(tty_standard_install);
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
 {
-	return driver->ops->install ? driver->ops->install(driver, tty) :
-		tty_standard_install(driver, tty);
+	if (driver->ops->install)
+		return driver->ops->install(driver, tty);
+
+	tty_standard_install(driver, tty);
+	return 0;
 }
 
 /**
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d7368..fd8d40d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -656,11 +656,11 @@ EXPORT_SYMBOL(tty_port_close);
  * to a concrete tty specified by @tty. Use this or tty_port_register_device
  * (or both). Call tty_port_link_device as a last resort.
  */
-int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 		struct tty_struct *tty)
 {
 	tty->port = port;
-	return tty_standard_install(driver, tty);
+	tty_standard_install(driver, tty);
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c..ce32631 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct vcc_port *port_vcc;
 	struct tty_port *port_tty;
-	int ret;
 
 	if (unlikely(!tty)) {
 		pr_err("VCC: install: Invalid TTY handle\n");
@@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (tty->index >= VCC_MAX_PORTS)
 		return -EINVAL;
 
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
+	tty_standard_install(driver, tty);
 
 	port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
 	if (!port_tty)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b..cc72254 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3222,10 +3222,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 		goto unlock;
 	}
 
-	ret = tty_port_install(&vc->port, driver, tty);
-	if (ret)
-		goto unlock;
-
+	tty_port_install(&vc->port, driver, tty);
 	tty->driver_data = vc;
 	vc->port.tty = tty;
 
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d6..de6a27e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)
 static int acm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct acm *acm;
-	int retval;
 
 	acm = acm_get_by_minor(tty->index);
 	if (!acm)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = acm;
 
 	return 0;
-
-error_init_termios:
-	tty_port_put(&acm->port);
-	return retval;
 }
 
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index aff79ff..18d661c 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -174,8 +174,9 @@ static int dbc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct dbc_port		*port = driver->driver_state;
 
 	tty->driver_data = port;
+	tty_port_install(&port->port, driver, tty);
 
-	return tty_port_install(&port->port, driver, tty);
+	return 0;
 }
 
 static int dbc_tty_open(struct tty_struct *tty, struct file *file)
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f7aaa7f..5cfc2ca 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -192,9 +192,7 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (retval)
 		goto error_get_interface;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
+	tty_standard_install(driver, tty);
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -206,8 +204,6 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
-	usb_autopm_put_interface(serial->interface);
  error_get_interface:
 	module_put(serial->type->driver.owner);
  error_module_get:
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e397..63cdac1 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
-extern int tty_standard_install(struct tty_driver *driver,
+extern void tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 
 extern struct mutex tty_mutex;
@@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
 extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
 extern void tty_port_close(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
-extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+extern void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 				struct tty_struct *tty);
 extern int tty_port_open(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 5e44d84..b654420 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -710,7 +710,6 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
-	int err;
 
 	dev = rfcomm_dev_get(tty->index);
 	if (!dev)
@@ -725,11 +724,7 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	/* install the tty_port */
-	err = tty_port_install(&dev->port, driver, tty);
-	if (err) {
-		rfcomm_tty_cleanup(tty);
-		return err;
-	}
+	tty_port_install(&dev->port, driver, tty);
 
 	/* take over the tty_port reference if the port was created with the
 	 * flag RFCOMM_RELEASE_ONHUP. This will force the release of the port
-- 
2.7.4
