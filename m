Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB45443AB8
	for <linux-mmc@vger.kernel.org>; Fri,  2 Oct 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926472; cv=none; b=BIgM4Koq1a4shAwoMz3w4XAHnsPe5tPHSD7ymY+4MUSI9lpSj3mcVnFiF5DIlG9HjoSmgLiNdGItTNnloHuMkQnVTh5jmboZhESlgE+nXrHRvBMHTGgFeBVNDKtoXt4ngBRZKta8RI03xP7/CVnNHXlOoyhbB1aA4kCh7NUzs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926472; c=relaxed/simple;
	bh=QHML5Zhv+1R8FTRLLASlT0CV/dCj/9/8aX/gbN1oYDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSHHD7LqtVTfzN4DDb+Bd/1zwyIluRNAieq29vAAb8UP9iS8YnFiIWME86CVy7g3yRJbGouTByJuVg3ph7keE+Onl1wLY9pZF370N/mkDDQupBJr5T8uEXWoTyzMLsSfvib9TtWR9GjPGPSFCdmdfGJCm+vryVtTJVgi5kMenAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH2XwFcL; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH2XwFcL"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so35525135ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2026 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790926469; x=1791531269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xrt7g6w/Ummkxum6PAeOCQocc8OhRUaZM9PinMQCcrk=;
        b=OH2XwFcLepEm50oSh6VwwqxzigrapmXyq4LUEzMZ4HXlmj0FfYn9Q/u75OJDG78Pmp
         WzkDgr01YTYzjVy9gVXfDvLlcxoeIHb6ZJ8Ca93trGLSaUmlmu/8wLNyzXvjgrJVPCOA
         +2HZwsilQQSkB9LKeNrvTJOSSEoArpxWUOqvvRAi7qkXlF7CSc+SzrknwG3Bj6/Sl79+
         Qcuq1/1Gp8HIzy/Pgh0teZycirCIiB+PM7u5rCrWw7PY2P1WF+R1PYQvhMSpgdbGJmbs
         FmHhvCVn9znwxW/jZig6zzdO1IdviacvbGDbp5Vpg9qdtFUy4tXwqCbfW6gr7EQAUj1h
         sapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926469; x=1791531269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xrt7g6w/Ummkxum6PAeOCQocc8OhRUaZM9PinMQCcrk=;
        b=PicwE5k2/F2KblvZIU9rR6brCX2T9pn12ZkUNEDil1etj7alqtc7nZ3Sh+HwVm5yHG
         4J/P3cX4RdC657X8e22DiDx/3KnHkmuHPo9sWrdOaR5h53bhzTSyQrlry3rleUuN3f2u
         hRlXfG/4MNpmXFqVM08jtfU+VK/WbqEebglbMfKoZKEJyBS4LEQGf6FZiK+Hv18dkY61
         A2jVukYvGWAzyp0hhG/5QR8NJvz9/wkvBc21SvZBk/NFyl/BnsDVJAa554Jau6Wy5oVS
         rRo9N/PZL+H+XQTiSeUzLA2sT2/vly+Mw3es3FRd4HEsAaWv9XXUAn2Kh10WMIdg7Dak
         nIzQ==
X-Gm-Message-State: AFq9FYKfOg7KIdJC8C4FuodRBFRUDR1jeZw58kyIUSRtMdY8ElI+n1eO
	HaWuCJSnwK8LWXdkWc4fbksLwpVxjlIoEL0/7P3lpre3pVGZmjQAwUJ9E8LOteIi
X-Gm-Gg: AYBFou1I6qpl3CeMra878B9aoT9mS/JcKDOIr1onwbI576YUjek5kbUXuQ0iz340kx7
	igDoRfhQK+i3nIaJzA7/7439MyJghfzuF6Bz8BfLK8ykkTViYeWeOHYhMOECcTV+LPTZslR1hv3
	MvIGYI6k4h6mnwsiHuAjMUhuyduP3YTn5WBeoy1jck+ucK30n5FMy3CKMxKj+QqSTR/SWgHMkya
	hX9ifL37Pl0WJszmQWPoX+M6VOcvk+RUhKwLm2lKuICe3dKGKTzvP2kv/o3rV9BcPL2zZSBeemk
	/gaw3FOVbPpeoyETLab/KT0IDjfd9XTLsnJcaTt/zdoq0YdTTfPyCgZDcBM8iDaTZL6RWkJEt7u
	QezLVBUghqfuLilMiM4PTDPaV7WmypY4LutO2ZpfbzeUmpqP2INqgjGd/IgtadQib38VZQ+OtwJ
	9Cg+5ra768SzOPR5O0eqYt91OHEcvouyPlDRhk2v/kNZdZ6NZvVG58hWdcq8rXVwYd5YXuarbXV
	mxzyFuoqN76bddzYNljI3FCbtI5CxH6eF9UWURAf3dR7NXJlQ==
X-Received: by 2002:a17:90b:2885:b0:3a4:adea:50c3 with SMTP id 98e67ed59e1d1-3a6ce82b564mr1641607a91.49.1790926469056;
        Fri, 02 Oct 2026 00:34:29 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net ([2401:7400:c804:b668:a144:150d:733a:5ba2])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc96ac0sm2874741a91.2.2026.10.02.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:34:28 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH] memstick: Add Broadcom BCM57765/BCM57785 host driver
Date: Fri,  2 Oct 2026 15:34:10 +0800
Message-ID: <20261002073419.36768-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MemoryStick function of Broadcom BCM57765 and BCM57785
PCI card readers (14e4:16be).

The driver is written by inspecting MMIO traces from the windows driver
and experimentally probing the device registers. Note that there is
a register that can read the card pin state, used it as a logic
analyzer.

It was found that the controller exposes an SDHCI-like interface with
TPC command handling. DMA mode was then inferred using the positions
of the bits in sdhci.h.

Tested on MS/MS Pro/MS Pro HG cards.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
Changes since RFC:
- Fix the issuing of consecutive read/write commands.
- DMA uses dma_alloc_coherent
- Use debugfs for DMA/PIO path selection
- Various PIO/DMA transfer fixes.

 MAINTAINERS                         |   6 +
 drivers/memstick/host/Kconfig       |  10 +
 drivers/memstick/host/Makefile      |   1 +
 drivers/memstick/host/bcm577x5_ms.c | 880 ++++++++++++++++++++++++++++
 drivers/memstick/host/bcm577x5_ms.h | 157 +++++
 5 files changed, 1054 insertions(+)
 create mode 100644 drivers/memstick/host/bcm577x5_ms.c
 create mode 100644 drivers/memstick/host/bcm577x5_ms.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5576f7d5f0a57..9ccd8084073ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5234,6 +5234,12 @@ S:	Maintained
 F:	arch/arm/boot/dts/broadcom/bcm47189*
 F:	arch/arm/boot/dts/broadcom/bcm53573*
 
+BROADCOM BCM57765/BCM57785 MEMORYSTICK DRIVER
+M:	Ho Jie Feng <hjf3108@gmail.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/memstick/host/bcm577x5_ms.*
+
 BROADCOM BCM63XX/BCM33XX UDC DRIVER
 M:	Kevin Cernekee <cernekee@gmail.com>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
index fcd2c2cc3cb47..f9b18f0d85513 100644
--- a/drivers/memstick/host/Kconfig
+++ b/drivers/memstick/host/Kconfig
@@ -53,3 +53,13 @@ config MEMSTICK_REALTEK_USB
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called rts5139_ms.
+
+config MEMSTICK_BCM577X5
+	tristate "Broadcom BCM57765/BCM57785 MemoryStick interface support"
+	depends on PCI
+	help
+	  Say Y here if you want to access MemoryStick cards with the
+	  Broadcom BCM57765/BCM57785 PCI card reader (14e4:16be).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called bcm577x5_ms.
diff --git a/drivers/memstick/host/Makefile b/drivers/memstick/host/Makefile
index 0c90df33165de..8eafb70b26706 100644
--- a/drivers/memstick/host/Makefile
+++ b/drivers/memstick/host/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MEMSTICK_TIFM_MS)		+= tifm_ms.o
 obj-$(CONFIG_MEMSTICK_JMICRON_38X)	+= jmb38x_ms.o
 obj-$(CONFIG_MEMSTICK_R592)		+= r592.o
 obj-$(CONFIG_MEMSTICK_REALTEK_USB)	+= rtsx_usb_ms.o
+obj-$(CONFIG_MEMSTICK_BCM577X5)		+= bcm577x5_ms.o
diff --git a/drivers/memstick/host/bcm577x5_ms.c b/drivers/memstick/host/bcm577x5_ms.c
new file mode 100644
index 0000000000000..a08cabe2c9b85
--- /dev/null
+++ b/drivers/memstick/host/bcm577x5_ms.c
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/align.h>
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/memstick.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/pm.h>
+#include <linux/scatterlist.h>
+#include <linux/time64.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#include "bcm577x5_ms.h"
+
+#define DRV_NAME "bcm577x5_ms"
+
+static const struct pci_device_id bcm577x5_pci_id_tbl[] = {
+	{
+		PCI_VDEVICE(BROADCOM, 0x16be),
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, bcm577x5_pci_id_tbl);
+
+static inline u32 bcm577x5_reg_readl(struct bcm577x5_device *dev, int address)
+{
+	return readl(dev->mmio + address);
+}
+
+static inline u16 bcm577x5_reg_readw(struct bcm577x5_device *dev, int address)
+{
+	return readw(dev->mmio + address);
+}
+
+static inline u8 bcm577x5_reg_readb(struct bcm577x5_device *dev, int address)
+{
+	return readb(dev->mmio + address);
+}
+
+static inline void bcm577x5_reg_writel(struct bcm577x5_device *dev, int address,
+				       u32 value)
+{
+	writel(value, dev->mmio + address);
+}
+
+static inline void bcm577x5_reg_writew(struct bcm577x5_device *dev, int address,
+				       u16 value)
+{
+	writew(value, dev->mmio + address);
+}
+
+static inline void bcm577x5_reg_writeb(struct bcm577x5_device *dev, int address,
+				       u8 value)
+{
+	writeb(value, dev->mmio + address);
+}
+
+static int bcm577x5_reg_waitb(struct bcm577x5_device *dev, int address, u8 mask,
+			      u8 value, unsigned int timeout_ms)
+{
+	u8 reg;
+
+	return readb_poll_timeout(dev->mmio + address, reg,
+				  (reg & mask) == value,
+				  BCM577x5_MS_POLL_DELAY_US,
+				  timeout_ms * USEC_PER_MSEC);
+}
+
+static int bcm577x5_ms_reset(struct bcm577x5_device *dev, u8 reset)
+{
+	bcm577x5_reg_writeb(dev, BCM577x5_MS_SOFTWARE_RESET, reset);
+
+	return bcm577x5_reg_waitb(dev, BCM577x5_MS_SOFTWARE_RESET, reset, 0,
+				  1000);
+}
+
+static int bcm577x5_ms_power(struct bcm577x5_device *dev, int power)
+{
+	int err;
+
+	switch (power) {
+	case MEMSTICK_POWER_ON:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
+				    BCM577x5_MS_POWER_330);
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
+				    BCM577x5_MS_POWER_330 |
+					    BCM577x5_MS_POWER_ON);
+		err = bcm577x5_reg_waitb(dev, BCM577x5_MS_POWER_CONTROL,
+					 BCM577x5_MS_POWER_ON,
+					 BCM577x5_MS_POWER_ON, 1000);
+		if (err)
+			return err;
+
+		msleep(20);
+
+		bcm577x5_reg_writel(dev, BCM577x5_MS_STATUS_MUX_CONTROL,
+				    bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS_MUX_CONTROL) |
+					    BCM577x5_MS_CLOCK_SOURCE_62_5MHZ);
+		return 0;
+	case MEMSTICK_POWER_OFF:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL, 0);
+		bcm577x5_reg_writel(dev, BCM577x5_MS_STATUS_MUX_CONTROL,
+				    bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS_MUX_CONTROL) &
+					    ~BCM577x5_MS_CLOCK_SOURCE_62_5MHZ);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bcm577x5_ms_clock(struct bcm577x5_device *dev, int clock_hz)
+{
+	int err;
+	u16 divisor, divisor_lo, divisor_hi, clock_reg;
+
+	divisor = DIV_ROUND_UP(dev->base_clock, 2 * clock_hz);
+	divisor_lo = divisor & BCM577x5_MS_DIV_MASK;
+	divisor_hi = (divisor & BCM577x5_MS_DIV_HI_MASK) >> 8;
+	clock_reg = (divisor_lo << BCM577x5_MS_DIVIDER_SHIFT) |
+		    (divisor_hi << BCM577x5_MS_DIVIDER_HI_SHIFT);
+
+	bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL, clock_reg);
+	bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL,
+			    clock_reg | BCM577x5_MS_CLOCK_INT_EN);
+	err = bcm577x5_reg_waitb(dev, BCM577x5_MS_CLOCK_CONTROL,
+				 BCM577x5_MS_CLOCK_INT_STABLE,
+				 BCM577x5_MS_CLOCK_INT_STABLE, 1000);
+	if (err)
+		return err;
+	bcm577x5_reg_writew(dev, BCM577x5_MS_CLOCK_CONTROL,
+			    clock_reg | BCM577x5_MS_CLOCK_INT_EN |
+				    BCM577x5_MS_CLOCK_CARD_EN);
+	return 0;
+}
+
+static int bcm577x5_ms_mode(struct bcm577x5_device *dev, int mode)
+{
+	u8 host_control = bcm577x5_reg_readb(dev, BCM577x5_MS_HOST_CONTROL);
+	u32 bridge_mode = bcm577x5_reg_readl(dev, BCM577x5_MS_BRIDGE_MODE);
+
+	switch (mode) {
+	case MEMSTICK_SERIAL:
+		bcm577x5_reg_writel(dev, BCM577x5_MS_BRIDGE_MODE,
+				    bridge_mode & ~BCM577x5_MS_BRIDGE_MODE_PARALLEL);
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
+				    host_control & ~BCM577x5_MS_CTRL_4BITBUS);
+		break;
+	case MEMSTICK_PAR4:
+		bcm577x5_reg_writel(dev, BCM577x5_MS_BRIDGE_MODE,
+				    bridge_mode | BCM577x5_MS_BRIDGE_MODE_PARALLEL);
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
+				    host_control | BCM577x5_MS_CTRL_4BITBUS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev->mode = mode;
+	return 0;
+}
+
+static int bcm577x5_ms_init(struct bcm577x5_device *dev)
+{
+	int error;
+
+	dev->prev_tpc = 0;
+
+	/* Reset the controller */
+	error = bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_ALL);
+	if (error)
+		return error;
+
+	/* Power cycle the controller */
+	error = bcm577x5_ms_power(dev, MEMSTICK_POWER_OFF);
+	if (error)
+		return error;
+	error = bcm577x5_ms_power(dev, MEMSTICK_POWER_ON);
+	if (error)
+		return error;
+
+	/* Set clock divider to 2 */
+	error = bcm577x5_ms_clock(dev, 20000000);
+	if (error)
+		return error;
+
+	/* Set timeout */
+	bcm577x5_reg_writeb(dev, BCM577x5_MS_TIMEOUT_CONTROL, 0xE);
+
+	/* Set mode */
+	error = bcm577x5_ms_mode(dev, dev->mode);
+	if (error)
+		return error;
+
+	error = bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_CMD);
+	if (error)
+		return error;
+	error = bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA);
+	if (error)
+		return error;
+
+	/* Re-enable interrupts */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE,
+			    BCM577x5_MS_INT_DEFAULT);
+
+	/* Avoid retriggering a card insert interrupt */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_STATUS,
+			    BCM577x5_MS_INT_CARD_INSERT);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE,
+			    BCM577x5_MS_INT_DEFAULT);
+
+	return 0;
+}
+
+static irqreturn_t bcm577x5_irq(int irq, void *data)
+{
+	struct bcm577x5_device *dev = data;
+	irqreturn_t ret = IRQ_NONE;
+	u32 val, status;
+	int i;
+
+	val = bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS);
+	if (val & BCM577x5_MS_STATUS_INT_ASSERTED) {
+		status = bcm577x5_reg_readl(dev, BCM577x5_MS_INT_STATUS);
+		atomic_or(status, &dev->int_seen);
+
+		if (status & 0x100) {
+			bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE,
+					    bcm577x5_reg_readl(dev,
+							       BCM577x5_MS_INT_ENABLE) &
+					~0x100);
+		}
+
+		/* Each individual bit needs to be acknowledged separately */
+		for (i = 0; i < 32; i++) {
+			if (status & BIT(i)) {
+				bcm577x5_reg_writel(dev, BCM577x5_MS_INT_STATUS,
+						    BIT(i));
+			}
+		}
+
+		/* Signal the command or TPC is done */
+		if (status & BCM577x5_MS_INT_RESPONSE)
+			complete(&dev->cmd_done);
+
+		/* Signal the FIFO is ready */
+		if (status & (BCM577x5_MS_INT_DATA_AVAIL |
+			      BCM577x5_MS_INT_SPACE_AVAIL))
+			complete(&dev->fifo_done);
+
+		if (status & BCM577x5_MS_INT_DATA_TIMEOUT)
+			dev_warn(&dev->pci_dev->dev, "Timeout!\n");
+
+		/* Signal data block transferred */
+		if (status & BCM577x5_MS_INT_DMA_END)
+			complete(&dev->dma_done);
+
+		/* Signal end of the read/write phase */
+		if (status & BCM577x5_MS_INT_DATA_END)
+			complete(&dev->data_done);
+
+		/* Immediately stop all ongoing requests */
+		if (status & BCM577x5_MS_INT_CARD_REMOVE) {
+			complete(&dev->cmd_done);
+			complete(&dev->fifo_done);
+			complete(&dev->dma_done);
+			complete(&dev->data_done);
+		}
+
+		if (status & (BCM577x5_MS_INT_CARD_INSERT |
+			      BCM577x5_MS_INT_CARD_REMOVE)) {
+			if (status & BCM577x5_MS_INT_CARD_INSERT)
+				dev_info(&dev->pci_dev->dev, "Card inserted\n");
+			else
+				dev_info(&dev->pci_dev->dev, "Card removed\n");
+			memstick_detect_change(dev->host);
+		}
+
+		ret = IRQ_HANDLED;
+	}
+	return ret;
+}
+
+/* External interface: set settings */
+static int bcm577x5_ms_set_param(struct memstick_host *host,
+				 enum memstick_param param, int value)
+{
+	struct bcm577x5_device *dev = memstick_priv(host);
+
+	switch (param) {
+	case MEMSTICK_POWER:
+		return bcm577x5_ms_power(dev, value);
+	case MEMSTICK_INTERFACE:
+		return bcm577x5_ms_mode(dev, value);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bcm577x5_ms_prepare_dma(struct bcm577x5_device *dev)
+{
+	int len = dev->req->sg.length;
+	void *dma_copy_buffer;
+	dma_addr_t dma_address;
+
+	if (len > 4096)
+		return -EOPNOTSUPP;
+
+	reinit_completion(&dev->dma_done);
+
+	if (dev->req->data_dir == WRITE) {
+		dma_copy_buffer = dev->dma_buffer + 4096 - len;
+		sg_copy_to_buffer(&dev->req->sg,
+				  sg_nents_for_len(&dev->req->sg, len),
+				  dma_copy_buffer, len);
+	}
+	/*
+	 * The last byte should cause an overflow interrupt on the 4096 byte
+	 * boundary
+	 */
+	dma_address = dev->dma_handle + 4096 - len;
+
+	bcm577x5_reg_writel(dev, BCM577x5_MS_DMA_ADDRESS, dma_address);
+	return 0;
+}
+
+static int bcm577x5_ms_finish_dma(struct bcm577x5_device *dev)
+{
+	int len = dev->req->sg.length;
+	void *dma_copy_buffer;
+
+	if (!wait_for_completion_timeout(&dev->dma_done,
+					 msecs_to_jiffies(BCM577x5_MS_REQ_TIMEOUT_MS)))
+		return -ETIMEDOUT;
+
+	if (dev->req->data_dir == READ) {
+		dma_copy_buffer = dev->dma_buffer + 4096 - len;
+		sg_copy_from_buffer(&dev->req->sg,
+				    sg_nents_for_len(&dev->req->sg, len),
+				    dma_copy_buffer, len);
+	}
+
+	return 0;
+}
+
+static int bcm577x5_ms_prepare_fifo(struct bcm577x5_device *dev)
+{
+	if (dev->prev_tpc != MS_TPC_READ_LONG_DATA &&
+	    dev->prev_tpc != MS_TPC_WRITE_LONG_DATA)
+		reinit_completion(&dev->fifo_done);
+
+	return 0;
+}
+
+static int bcm577x5_ms_finish_fifo(struct bcm577x5_device *dev)
+{
+	struct sg_mapping_iter miter;
+
+	if (!wait_for_completion_timeout(&dev->fifo_done,
+					 msecs_to_jiffies(BCM577x5_MS_REQ_TIMEOUT_MS)))
+		return -ETIMEDOUT;
+
+	sg_miter_start(&miter, &dev->req->sg, 1,
+		       dev->req->data_dir == READ ? SG_MITER_TO_SG :
+						    SG_MITER_FROM_SG);
+	while (sg_miter_next(&miter)) {
+		if (WARN_ON_ONCE(!IS_ALIGNED(miter.length, 4))) {
+			sg_miter_stop(&miter);
+			return -EINVAL;
+		}
+		if (dev->req->data_dir == READ)
+			ioread32_rep(dev->mmio + BCM577x5_MS_BUFFER,
+				     miter.addr, miter.length / 4);
+		else if (dev->req->data_dir == WRITE)
+			iowrite32_rep(dev->mmio + BCM577x5_MS_BUFFER,
+				      miter.addr, miter.length / 4);
+	}
+	sg_miter_stop(&miter);
+
+	return 0;
+}
+
+static int bcm577x5_ms_execute_cmd_short(struct bcm577x5_device *dev, u32 cmd)
+{
+	unsigned int len = dev->req->data_len;
+	u8 *data = dev->req->data;
+	u32 response, val;
+	int err;
+
+	/* Write the data into the controller */
+	if (dev->req->data_dir == WRITE) {
+		bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT,
+				    get_unaligned_le32(data));
+		if (len > 4)
+			bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT2,
+					    get_unaligned_le32(data + 4));
+	}
+
+	reinit_completion(&dev->cmd_done);
+	if (dev->req->tpc == MS_TPC_SET_CMD)
+		reinit_completion(&dev->data_done);
+
+	response = bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
+
+	if (!wait_for_completion_timeout(&dev->cmd_done,
+					 msecs_to_jiffies(100)))
+		return -ETIMEDOUT;
+
+	if (dev->req->tpc == MS_TPC_SET_CMD) {
+		/*
+		 * The controller will execute a GET_INT command, wait for it.
+		 * Sometimes, the second interrupt will coalesce with the first,
+		 * or arrive after the response changed, so wait for the response.
+		 */
+		readl_poll_timeout(dev->mmio + BCM577x5_MS_RESPONSE, val,
+				   val != response, BCM577x5_MS_POLL_DELAY_US,
+				   100 * USEC_PER_MSEC);
+		/* A second interrupt should come within this time */
+		usleep_range(20, 30);
+		if (bcm577x5_reg_readl(dev, BCM577x5_MS_INT_STATUS) &
+		    BCM577x5_MS_INT_RESPONSE)
+			wait_for_completion_timeout(&dev->cmd_done,
+						    msecs_to_jiffies(5));
+
+		/* The int reg is placed in the response register */
+		dev->auto_int =
+			bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0xFF;
+		dev->req->int_reg = dev->auto_int;
+
+		/*
+		 * On legacy MS cards, the controller doesn't automatically issue a
+		 * GET_INT after the command is done, but it still requires one to
+		 * keep working without getting stuck
+		 */
+		dev->get_int_after_done = dev->auto_int ==
+				    (MEMSTICK_INT_CED | MEMSTICK_INT_BREQ);
+
+		/*
+		 * Reset is needed because the controller will expect certain commands
+		 * to follow the SET_CMD command, which the block driver may not
+		 * necessarily issue.
+		 */
+		if (!(dev->auto_int & MEMSTICK_INT_BREQ) || dev->get_int_after_done) {
+			err = bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA);
+			if (err)
+				return err;
+		}
+	}
+
+	/* Read the data back */
+	if (dev->req->data_dir == READ) {
+		put_unaligned_le32(bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE),
+				   data);
+		if (len > 4)
+			put_unaligned_le32(bcm577x5_reg_readl(dev,
+							      BCM577x5_MS_RESPONSE2),
+					   data + 4);
+	}
+
+	return 0;
+}
+
+static int bcm577x5_ms_execute_cmd_long(struct bcm577x5_device *dev, u32 cmd, bool use_dma)
+{
+	int err;
+
+	if (use_dma) {
+		err = bcm577x5_ms_prepare_dma(dev);
+		if (err)
+			use_dma = false;
+	}
+	if (!use_dma)
+		err = bcm577x5_ms_prepare_fifo(dev);
+
+	if (use_dma)
+		cmd |= BCM577x5_MS_TRNS_DMA;
+
+	if (dev->req->data_dir == WRITE ||
+	    (!use_dma && !dev->get_int_after_done)) {
+		/* PIO or DMA write has to be multi-block */
+		bcm577x5_reg_writew(dev, BCM577x5_MS_BLOCK_COUNT, 0xFFFF);
+		cmd |= BCM577x5_MS_TRNS_MULTI | BCM577x5_MS_TRNS_BLK_CNT_EN;
+	}
+
+	/* Execute the TPC */
+	if (dev->prev_tpc == MS_TPC_READ_LONG_DATA ||
+	    dev->prev_tpc == MS_TPC_WRITE_LONG_DATA)
+		/*
+		 * The controller will hang if another TPC is written,
+		 * this is a kind of continue with the last TPC command
+		 */
+		bcm577x5_reg_writew(dev, BCM577x5_MS_TPC_REG, cmd & 0xFFFF);
+	else
+		bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
+
+	if (use_dma)
+		err = bcm577x5_ms_finish_dma(dev);
+	else
+		err = bcm577x5_ms_finish_fifo(dev);
+
+	if (!err && dev->get_int_after_done) {
+		/*
+		 * On legacy MS cards, we need to manually issue a GET_INT.
+		 * This GET_INT is special because it interrupts with
+		 * data_done, not cmd_done
+		 */
+		dev->get_int_after_done = false;
+		reinit_completion(&dev->data_done);
+		bcm577x5_reg_writew(dev, BCM577x5_MS_BLOCK_SIZE, 1);
+		bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG,
+				    BCM577x5_MS_MAKE_TPC(MS_TPC_GET_INT) |
+					    BCM577x5_MS_TRNS_READ);
+		if (!wait_for_completion_timeout(&dev->data_done,
+						 msecs_to_jiffies(100)))
+			err = -ETIMEDOUT;
+	}
+
+	dev->auto_int = bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0xFF;
+	dev->req->int_reg = dev->auto_int;
+
+	return err;
+}
+
+static int bcm577x5_ms_execute_cmd(struct bcm577x5_device *dev)
+{
+	int len =
+		dev->req->long_data ? dev->req->sg.length : dev->req->data_len;
+	bool use_dma = READ_ONCE(dev->enable_dma);
+	unsigned long timeout;
+	int err;
+	u32 cmd;
+
+	/* Immediately return if there is no card inserted */
+	if (!(bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS) &
+	      BCM577x5_MS_STATUS_MS_DETECT))
+		return -ENODEV;
+
+	if (dev->req->tpc == MS_TPC_GET_INT && dev->auto_int &&
+	    (dev->prev_tpc == MS_TPC_SET_CMD ||
+	     dev->prev_tpc == MS_TPC_READ_LONG_DATA ||
+	     dev->prev_tpc == MS_TPC_WRITE_LONG_DATA)) {
+		dev->req->data[0] = dev->auto_int;
+		dev->req->int_reg = dev->auto_int;
+		dev->auto_int = 0;
+		return 0;
+	}
+
+	if (dev->req->tpc == MS_TPC_GET_INT &&
+	    dev->prev_tpc == MS_TPC_READ_LONG_DATA && use_dma) {
+		/*
+		 * The controller doesn't respond to any command until DATA_END
+		 * is completed.
+		 */
+		if (!wait_for_completion_timeout(&dev->data_done,
+						 msecs_to_jiffies(BCM577x5_MS_REQ_TIMEOUT_MS)))
+			return -ETIMEDOUT;
+
+		err = bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA);
+		if (err)
+			return err;
+	}
+
+	/* PIO has no DATA_END but needs the same treatment */
+	if (dev->req->tpc == MS_TPC_GET_INT &&
+	    (dev->prev_tpc == MS_TPC_WRITE_LONG_DATA ||
+	     (dev->prev_tpc == MS_TPC_READ_LONG_DATA && !use_dma))) {
+		/*
+		 * There seems to be no way to wait for the command to actually finish,
+		 * since DMA_END only signals the data is in the controller, but may not
+		 * be fully written into the card. Instead, the controller ignores any
+		 * commands until it is done, so keep issuing GET_INT until it
+		 * goes through
+		 */
+		bcm577x5_reg_writel(dev, BCM577x5_MS_BLOCK_SIZE, len);
+		cmd = BCM577x5_MS_MAKE_TPC(MS_TPC_GET_INT) | BCM577x5_MS_TRNS_READ;
+		timeout = jiffies + msecs_to_jiffies(BCM577x5_MS_REQ_TIMEOUT_MS);
+		/* A small wait is needed for the write data to be fully written */
+		if (dev->prev_tpc == MS_TPC_WRITE_LONG_DATA)
+			usleep_range(150, 300);
+		while (!time_after(jiffies, timeout)) {
+			reinit_completion(&dev->cmd_done);
+			bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
+			/* 1 jiffy is too coarse */
+			usleep_range(200, 220);
+			if (completion_done(&dev->cmd_done))
+				break;
+		}
+		if (!completion_done(&dev->cmd_done))
+			return -ETIMEDOUT;
+
+		dev->req->data[0] =
+			bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0xFF;
+		dev->req->int_reg = dev->req->data[0];
+		if (!(dev->req->data[0] & MEMSTICK_INT_CED))
+			return 0;
+
+		dev->prev_tpc = dev->req->tpc;
+		return bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_CMD |
+					      BCM577x5_MS_RESET_DATA);
+	}
+
+	/* Same for the next page of a write */
+	if (dev->req->tpc == MS_TPC_WRITE_LONG_DATA &&
+	    dev->prev_tpc == MS_TPC_WRITE_LONG_DATA)
+		usleep_range(100, 120);
+
+	/* Write the length of the transfer */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_BLOCK_SIZE, len);
+
+	/* Create the execution command */
+	cmd = BCM577x5_MS_MAKE_TPC(dev->req->tpc);
+	if (dev->req->data_dir == READ)
+		cmd |= BCM577x5_MS_TRNS_READ;
+
+	/*
+	 * Two types of transfers have very different flow,
+	 * so split them into functions
+	 */
+	if (dev->req->long_data)
+		err = bcm577x5_ms_execute_cmd_long(dev, cmd, use_dma);
+	else
+		err = bcm577x5_ms_execute_cmd_short(dev, cmd);
+
+	dev->prev_tpc = dev->req->tpc;
+	return err;
+}
+
+static void bcm577x5_ms_req_process(struct work_struct *data)
+{
+	struct bcm577x5_device *dev =
+		container_of(data, struct bcm577x5_device, req_work);
+	int err, cmderr = 0;
+
+	/* Already processing requests */
+	if (dev->req)
+		return;
+
+	mutex_lock(&dev->req_lock);
+	do {
+		err = memstick_next_req(dev->host, &dev->req);
+
+		if (!err && completion_done(&dev->host->card->mrq_complete)) {
+			dev->req = NULL;
+			break;
+		}
+
+		if (!err) {
+			atomic_set(&dev->int_seen, 0);
+			cmderr = bcm577x5_ms_execute_cmd(dev);
+			if (atomic_read(&dev->int_seen) &
+			    BCM577x5_MS_INT_CARD_REMOVE)
+				cmderr = -ENODEV;
+			dev->req->error = cmderr;
+		}
+	} while (!err && !cmderr);
+
+	if (cmderr) {
+		/* Reset the controller so it accepts new commands */
+		bcm577x5_ms_init(dev);
+
+		/* Controller will not respond to any more commands anyway */
+		while (!err && dev->req) {
+			dev->req->error = cmderr;
+			err = memstick_next_req(dev->host, &dev->req);
+		}
+	}
+	mutex_unlock(&dev->req_lock);
+}
+
+static void bcm577x5_ms_submit_req(struct memstick_host *host)
+{
+	struct bcm577x5_device *dev = memstick_priv(host);
+
+	schedule_work(&dev->req_work);
+}
+
+static int bcm577x5_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int error;
+	struct memstick_host *host;
+	struct bcm577x5_device *dev;
+	u32 val;
+
+	host = memstick_alloc_host(sizeof(struct bcm577x5_device), &pdev->dev);
+	if (!host)
+		return -ENOMEM;
+
+	dev = memstick_priv(host);
+	dev->host = host;
+	dev->pci_dev = pdev;
+	pci_set_drvdata(pdev, dev);
+
+	error = pci_enable_device(pdev);
+	if (error)
+		goto err_free_host;
+
+	pci_set_master(pdev);
+
+	error = pci_request_regions(pdev, DRV_NAME);
+	if (error)
+		goto err_disable_device;
+
+	dev->mmio = pci_ioremap_bar(pdev, 0);
+	if (!dev->mmio) {
+		error = -EIO;
+		goto err_release_regions;
+	}
+
+	INIT_WORK(&dev->req_work, bcm577x5_ms_req_process);
+
+	host->caps = MEMSTICK_CAP_PAR4 | MEMSTICK_CAP_AUTO_GET_INT;
+	host->request = bcm577x5_ms_submit_req;
+	host->set_param = bcm577x5_ms_set_param;
+
+	val = bcm577x5_reg_readl(dev, BCM577x5_MS_CAPABILITY_SLOT2);
+
+	/* An alternate clock source is found that gives higher write reliability */
+	dev->base_clock = 62500000;
+
+	if (val & BCM577x5_MS_CAPABILITY_SDMA) {
+		dev->enable_dma = true;
+		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+			dev_warn(&pdev->dev, "No suitable DMA available\n");
+			dev->enable_dma = false;
+		}
+	}
+
+	if (dev->enable_dma) {
+		/*
+		 * This needs to be 4096 aligned since the hardware does
+		 * not seem to issue a dma complete interrupt, so we have
+		 * to rely on address line overflows to detect completion.
+		 */
+		dev->dma_buffer = dma_alloc_coherent(&pdev->dev, 4096,
+						     &dev->dma_handle,
+						     GFP_KERNEL);
+		if (!dev->dma_buffer) {
+			dev_warn(&pdev->dev,
+				 "DMA memory alloc failed, disabling\n");
+			dev->enable_dma = false;
+		}
+	}
+
+	/* Disable interrupts */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
+
+	dev->irq = pdev->irq;
+	dev_info(&pdev->dev, "Rev %c%c dma=%d clock=%dHz irq=%d\n",
+		 (pdev->revision >> 3) + 'A', (pdev->revision & 0b111) + '0',
+		 dev->enable_dma, dev->base_clock, dev->irq);
+
+	mutex_init(&dev->req_lock);
+	init_completion(&dev->cmd_done);
+	init_completion(&dev->fifo_done);
+	init_completion(&dev->dma_done);
+	init_completion(&dev->data_done);
+	error = request_irq(dev->irq, &bcm577x5_irq, IRQF_SHARED, DRV_NAME, dev);
+	if (error)
+		goto err_iounmap;
+
+	error = bcm577x5_ms_init(dev);
+	if (error)
+		goto err_free_irq;
+
+	error = memstick_add_host(host);
+	if (error)
+		goto err_free_irq;
+
+	/* Switch between the DMA and PIO paths at runtime */
+	if (dev->enable_dma) {
+		dev->debugfs = debugfs_create_dir(dev_name(&pdev->dev), NULL);
+		debugfs_create_bool("enable_dma", 0644, dev->debugfs,
+				    &dev->enable_dma);
+	}
+
+	return 0;
+err_free_irq:
+	bcm577x5_ms_power(dev, MEMSTICK_POWER_OFF);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
+	free_irq(dev->irq, dev);
+err_iounmap:
+	iounmap(dev->mmio);
+	if (dev->dma_buffer) {
+		dma_free_coherent(&dev->pci_dev->dev, 4096, dev->dma_buffer,
+				  dev->dma_handle);
+	}
+err_release_regions:
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+err_free_host:
+	memstick_free_host(host);
+	return error;
+}
+
+static void bcm577x5_remove(struct pci_dev *pdev)
+{
+	struct bcm577x5_device *dev = pci_get_drvdata(pdev);
+
+	debugfs_remove(dev->debugfs);
+
+	dev->host->removing = true;
+	memstick_remove_host(dev->host);
+
+	/* Cancel the work before interrupts are disabled */
+	cancel_work_sync(&dev->req_work);
+
+	/* Clear interrupts */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
+
+	if (dev->dma_buffer) {
+		dma_free_coherent(&dev->pci_dev->dev, 4096, dev->dma_buffer,
+				  dev->dma_handle);
+	}
+
+	free_irq(dev->irq, dev);
+	iounmap(dev->mmio);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	memstick_free_host(dev->host);
+}
+
+static int bcm577x5_ms_suspend(struct device *pdev)
+{
+	struct bcm577x5_device *dev = dev_get_drvdata(pdev);
+
+	memstick_suspend_host(dev->host);
+	return 0;
+}
+
+static int bcm577x5_ms_resume(struct device *pdev)
+{
+	struct bcm577x5_device *dev = dev_get_drvdata(pdev);
+	int error;
+
+	error = bcm577x5_ms_init(dev);
+	if (error)
+		return error;
+
+	memstick_resume_host(dev->host);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm577x5_ms_pm_ops, bcm577x5_ms_suspend,
+				bcm577x5_ms_resume);
+
+static struct pci_driver bcm577x5_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = bcm577x5_pci_id_tbl,
+	.probe = bcm577x5_probe,
+	.remove = bcm577x5_remove,
+	.driver.pm = pm_sleep_ptr(&bcm577x5_ms_pm_ops),
+};
+
+module_pci_driver(bcm577x5_pci_driver);
+
+MODULE_AUTHOR("Ho Jie Feng <hjf3108@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("BCM577x5 MS/MSPro card reader driver");
diff --git a/drivers/memstick/host/bcm577x5_ms.h b/drivers/memstick/host/bcm577x5_ms.h
new file mode 100644
index 0000000000000..80b0703a43b3a
--- /dev/null
+++ b/drivers/memstick/host/bcm577x5_ms.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BCM577X5_MS_H
+#define BCM577X5_MS_H
+
+#include <linux/compiler_types.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct memstick_host;
+struct memstick_request;
+struct pci_dev;
+struct dentry;
+
+struct bcm577x5_device {
+	struct pci_dev *pci_dev;
+	struct memstick_host	*host;		/* host backpointer */
+	struct memstick_request *req;		/* current request */
+
+	/* Registers, IRQ */
+	void __iomem *mmio;
+	int irq;
+
+	/* Command execution */
+	struct work_struct req_work;
+	struct mutex req_lock;		/* prevent concurrent requests */
+	struct completion cmd_done;
+	struct completion fifo_done;
+	atomic_t int_seen;
+	unsigned char prev_tpc;
+	u8 auto_int;
+	bool get_int_after_done;
+	int mode;
+
+	/* DMA execution */
+	bool enable_dma;
+	struct dentry *debugfs;
+	struct completion dma_done;
+	struct completion data_done;
+	void *dma_buffer;
+	dma_addr_t dma_handle;
+
+	/* Device properties */
+	int base_clock;
+};
+
+#define BCM577x5_MS_POLL_DELAY_US 10
+#define BCM577x5_MS_REQ_TIMEOUT_MS 450
+
+/*
+ * Controller registers (from sdhci.h)
+ * Registers are almost exactly the same as sdhci registers, reuse them
+ */
+
+#define BCM577x5_MS_DMA_ADDRESS		0x00
+#define BCM577x5_MS_BLOCK_SIZE		0x04
+#define BCM577x5_MS_BLOCK_COUNT		0x06
+#define BCM577x5_MS_ARGUMENT		0x08
+
+#define BCM577x5_MS_TPC_REG		0x0C
+#define BCM577x5_MS_MAKE_TPC(c) ((((c) << 4) | ((c) ^ 0xF)) << 24)
+#define  BCM577x5_MS_TRNS_DMA		0x01
+#define  BCM577x5_MS_TRNS_BLK_CNT_EN	0x02
+#define  BCM577x5_MS_TRNS_READ		0x10
+#define  BCM577x5_MS_TRNS_MULTI		0x20
+
+#define BCM577x5_MS_RESPONSE		0x10
+#define BCM577x5_MS_RESPONSE2		0x14
+#define BCM577x5_MS_BUFFER		0x20
+
+/* This can be used as a logic analyzer */
+#define BCM577x5_MS_PRESENT_STATE	0x24
+#define  BCM577x5_MS_DATA_LVL_MASK	0x00F00000
+#define  BCM577x5_MS_CMD_LVL		0x01000000
+
+#define BCM577x5_MS_HOST_CONTROL	0x28
+#define  BCM577x5_MS_CTRL_4BITBUS	0x02
+#define  BCM577x5_MS_CTRL_8BITBUS	0x20
+
+#define BCM577x5_MS_POWER_CONTROL	0x29
+#define  BCM577x5_MS_POWER_ON		0x01
+#define  BCM577x5_MS_POWER_330		0x0E
+
+#define BCM577x5_MS_CLOCK_CONTROL	0x2C
+#define  BCM577x5_MS_DIVIDER_SHIFT	8
+#define  BCM577x5_MS_DIVIDER_HI_SHIFT	6
+#define  BCM577x5_MS_DIV_MASK		0xFF
+#define  BCM577x5_MS_DIV_HI_MASK	0x300
+#define  BCM577x5_MS_CLOCK_CARD_EN	0x0004
+#define  BCM577x5_MS_CLOCK_INT_STABLE	0x0002
+#define  BCM577x5_MS_CLOCK_INT_EN	0x0001
+
+#define BCM577x5_MS_TIMEOUT_CONTROL	0x2E
+
+#define BCM577x5_MS_SOFTWARE_RESET	0x2F
+#define  BCM577x5_MS_RESET_ALL		0x01
+#define  BCM577x5_MS_RESET_CMD		0x02
+#define  BCM577x5_MS_RESET_DATA		0x04
+
+#define BCM577x5_MS_INT_STATUS		0x30
+#define BCM577x5_MS_INT_ENABLE		0x34
+#define BCM577x5_MS_SIGNAL_ENABLE	0x38
+#define  BCM577x5_MS_INT_RESPONSE	0x00000001
+#define  BCM577x5_MS_INT_DATA_END	0x00000002
+#define  BCM577x5_MS_INT_BLK_GAP	0x00000004
+#define  BCM577x5_MS_INT_DMA_END	0x00000008
+#define  BCM577x5_MS_INT_SPACE_AVAIL	0x00000010
+#define  BCM577x5_MS_INT_DATA_AVAIL	0x00000020
+#define  BCM577x5_MS_INT_CARD_INSERT_2	0x00000040
+#define  BCM577x5_MS_INT_CARD_REMOVE	0x00000080
+#define  BCM577x5_MS_INT_CARD_INT	0x00000100
+#define  BCM577x5_MS_INT_RETUNE		0x00001000
+#define  BCM577x5_MS_INT_CQE		0x00004000
+#define  BCM577x5_MS_INT_ERROR		0x00008000
+#define  BCM577x5_MS_INT_TIMEOUT	0x00010000
+#define  BCM577x5_MS_INT_CRC		0x00020000
+#define  BCM577x5_MS_INT_END_BIT	0x00040000
+#define  BCM577x5_MS_INT_INDEX		0x00080000
+#define  BCM577x5_MS_INT_DATA_TIMEOUT	0x00100000
+#define  BCM577x5_MS_INT_DATA_CRC	0x00200000
+#define  BCM577x5_MS_INT_DATA_END_BIT	0x00400000
+#define  BCM577x5_MS_INT_BUS_POWER	0x00800000
+#define  BCM577x5_MS_INT_AUTO_CMD_ERR	0x01000000
+#define  BCM577x5_MS_INT_ADMA_ERROR	0x02000000
+#define  BCM577x5_MS_INT_CARD_INSERT	0x40000000
+
+#define BCM577x5_MS_INT_DEFAULT                                                \
+	(BCM577x5_MS_INT_RESPONSE | BCM577x5_MS_INT_DATA_END |                 \
+	 BCM577x5_MS_INT_DMA_END | BCM577x5_MS_INT_SPACE_AVAIL |               \
+	 BCM577x5_MS_INT_DATA_AVAIL | BCM577x5_MS_INT_CARD_INSERT_2 |          \
+	 BCM577x5_MS_INT_CARD_REMOVE | BCM577x5_MS_INT_TIMEOUT |               \
+	 BCM577x5_MS_INT_CRC | BCM577x5_MS_INT_END_BIT |                       \
+	 BCM577x5_MS_INT_INDEX | BCM577x5_MS_INT_DATA_TIMEOUT |                \
+	 BCM577x5_MS_INT_DATA_CRC | BCM577x5_MS_INT_DATA_END_BIT |             \
+	 BCM577x5_MS_INT_BUS_POWER | BCM577x5_MS_INT_ADMA_ERROR |              \
+	 BCM577x5_MS_INT_CARD_INSERT)
+
+#define BCM577x5_MS_ARGUMENT2	0xF4
+
+#define BCM577x5_MS_BRIDGE_MODE				0x180
+#define  BCM577x5_MS_BRIDGE_MODE_PARALLEL		0x02000000
+
+#define BCM577x5_MS_STATUS				0x190
+#define  BCM577x5_MS_STATUS_INT_ASSERTED		0x00000002
+#define  BCM577x5_MS_STATUS_MS_DETECT			0x00004000
+
+#define BCM577x5_MS_STATUS_MUX_CONTROL			0x198
+#define  BCM577x5_MS_CLOCK_SOURCE_62_5MHZ		0x00003000
+
+#define BCM577x5_MS_CAPABILITY_SLOT2			0x1A8
+#define  BCM577x5_MS_CAPABILITY_SDMA			0x00100000
+#define BCM577x5_MS_CAPABILITY_BASE_CLOCK_MASK		0x00007F80
+#define  BCM577x5_MS_CAPABILITY_BASE_CLOCK_SHIFT	7
+#define BCM577x5_MS_CAPABILITY_TIMEOUT_CLOCK_MASK	0x0000003F
+
+#endif /* BCM577X5_MS_H */

base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
-- 
2.55.0

