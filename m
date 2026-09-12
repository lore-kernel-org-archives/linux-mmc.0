Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32C2882DE
	for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789231105; cv=none; b=FDWU4GNxoMrVvwofUxInN9VL9fHISpr1jY6G2DPzc9/adlNJEpWPnE5QFcgq7NzpaDQyCMtxKAXH7uBefxkVVuFb2maSXWlX7e6P1M/BbrVTwcM9cRt1qEBcTMtxMh/afvblLqCF805gj4lh6Li4r9lKuPw3QMp01gVliICQ2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789231105; c=relaxed/simple;
	bh=3+lh5RjZ7tOaP8CbV5BJMGNh2Y5B+Oc6Zl0p+rJcV7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiZISUaS0ePZdnEoKh5iGsQOhkmG7KrmTgNaDDcVMW/Lr+yepdUA4cuJsHKEtnM5E/6TMbTtQIAdbU4sNvyQz1VgRVdKSCVhYu/zVC06PmYVBdAk4gH+XdDKA3uMBbifNnc5gEvbiyuxBzt8W6gPAEnGWSNF4YgIpmGYKnlvZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alTOh5Hr; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alTOh5Hr"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so505503a91.1
        for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789231101; x=1789835901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5X4kWTsuMrz6BSFbYThkfZrrh4aALMnD/3PI7euwkGE=;
        b=alTOh5HrXaoVUZnE1Xe52OeL1+GK3Ci/paC/pGX2agw2kQ7li0AXsvSHfTR8AeOe43
         WZxGFPgskGBRRsO6UtnqX+CdqrRQWDuGoVpFLlyLpbeMwLRcrVc0AXoXYWwW+Ux3/wVe
         ZZnCEdSodpXNJemvF9li8AMgWzzwaKuDiRujT1hcSw1IhJmr2ISEVuk6Oi/UtLazydrZ
         TkM7fZauS2ndKkM0qbpKqNtwXvlHClz7rIbviqzLN8T7G/8MCJU/ZZp62ivOd0VCdKLu
         noMfdbSbJANY5GPsbte0jpa3DiB2SV+lwHGb9ovyYAZILdX3bJmSfcDYxzNvWZciITLg
         ZNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789231101; x=1789835901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X4kWTsuMrz6BSFbYThkfZrrh4aALMnD/3PI7euwkGE=;
        b=MEQexXhdkdbUCpLadU/C/wMYloa76iVj9s1QUALnqmPwNY5oCT2yhOC4AFxI3ULavp
         b1MC9usZVVy8eWWzZVNP+SEJZfpCz4ugkRCYvZWWfJm2l8VNCg9XwWzMXMJ7xenQ65C4
         Wo7wouvIDCX157ilNQbXpGNeXI7cLzrXbUobbQQxqjBXeiTacDThc9YZZcUlV1NCDUgQ
         Vfmob0F7Xl5EWTWGvO3wSzoIgWi3my5JZWE7ysFCieOzxKmjG/zjBZvai/tJvB1vEF8t
         fg/hi8Xjm47aJUyCIHAYHLc+dlc7+IMDZSkhcyOqDjzUBUxZN2SMHnk3L3xHzCFH9Yxh
         wqvA==
X-Gm-Message-State: AFuF++kRoHhv2f3tz4vanFQiVEGogtylUc8vQN5pvAV+xAtX5wk/nnH3
	BuZTme5ztmd7ctJRu6a22uP1Mg61iPJLTf5wWIEXRPo0YC1GLQmFshFJEtD9NN/Z
X-Gm-Gg: AYBFou0nHtMRyQhkT8q7oo/hGJ6EArscSeL/R/b6rjWHHOp7tiV9hzQuL9x58QycJgu
	lmYjRhmps5GgI4A0s9wsgU5Vev4Hoi5W7pfvkkrMJYIc+ICziENRTuAnPQg980iWuQbeU/JHwB8
	OoG5ILrnILpsd9MsCYp0EsQvkMaK0GI5S06uH/rr1sixJf6wTHBOQ3IcfVVp1dH7nBNUOk5/fvu
	DC50yPDE+f7vWKtLgAOfByo9KLfDVLymyUuc/G+I7qCPIJpRxfdzyPPKo0HarbOTEKJ+DaJ8Ldf
	IQBJAipt9Dln3CVyiKKyG63HSGRq35uITrpPtoCc3ALbw1iOpKwtFnOk+AuYu5I8VZ//lt6hYA3
	QQvsoD7gJMpoHm0Av/fyv1vWQjphQH5OPQW9ykDaKpypQ5s8BLTj1ZP7fbphyURYBrWUErBXAWd
	w3/ro5a8IrrPmYZzZEfYesKojmYRoRxylVZCKINnZn67GLDQymjH+0UM09pS/K0X/JzXdOE1DFf
	LDvgeKf1vVtXd2BkmXVfWwZ2bv/BeMh9vjGCFaJHD8VSC6wYSs=
X-Received: by 2002:a17:90b:5243:b0:398:c724:1bb1 with SMTP id 98e67ed59e1d1-39dbc0c3777mr7159628a91.8.1789231100984;
        Sat, 12 Sep 2026 09:38:20 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net ([2401:7400:c804:63d1:a611:b433:d4e7:c402])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39d98e60484sm10783448a91.4.2026.09.12.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 09:38:20 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] memstick: Add Broadcom BCM57765/BCM57785 host driver
Date: Sun, 13 Sep 2026 00:38:01 +0800
Message-ID: <20260912163810.848989-1-hjf3108@gmail.com>
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
and experimentally probing the device registers.

It was found that the controller exposes an SDHCI-like interface with
TPC command handling. DMA mode was then inferred using the positions
of the bits in sdhci.h.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 MAINTAINERS                         |   6 +
 drivers/memstick/host/Kconfig       |  10 +
 drivers/memstick/host/Makefile      |   1 +
 drivers/memstick/host/bcm577x5_ms.c | 754 ++++++++++++++++++++++++++++
 drivers/memstick/host/bcm577x5_ms.h | 138 +++++
 5 files changed, 909 insertions(+)
 create mode 100644 drivers/memstick/host/bcm577x5_ms.c
 create mode 100644 drivers/memstick/host/bcm577x5_ms.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 978fe6999d3b3..20faa8c2b1bcc 100644
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
index 0000000000000..81824fb4e9a82
--- /dev/null
+++ b/drivers/memstick/host/bcm577x5_ms.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/align.h>
+#include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/memstick.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/pm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "bcm577x5_ms.h"
+
+#define DRV_NAME "bcm577x5_ms"
+
+static int enable_dma = 2;
+module_param(enable_dma, int, 0444);
+MODULE_PARM_DESC(enable_dma,
+		 "Enable usage of the DMA (0 = no, 1 = yes, 2 = auto,default)");
+
+static const struct pci_device_id bcm577x5_pci_id_tbl[] = {
+	{
+		PCI_VDEVICE(BROADCOM, 0x16be),
+	},
+	{},
+};
+
+static inline u32 bcm577x5_reg_readl(struct bcm577x5_device *dev, int address)
+{
+	u32 value = readl(dev->mmio + address);
+	return value;
+}
+
+static inline u16 bcm577x5_reg_readw(struct bcm577x5_device *dev, int address)
+{
+	u32 value = readw(dev->mmio + address);
+	return value;
+}
+
+static inline u8 bcm577x5_reg_readb(struct bcm577x5_device *dev, int address)
+{
+	u32 value = readb(dev->mmio + address);
+	return value;
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
+			      u8 value, int timeout)
+{
+	unsigned long wait_time = jiffies + msecs_to_jiffies(timeout);
+	u8 reg;
+
+	do {
+		reg = bcm577x5_reg_readb(dev, address);
+		if ((reg & mask) == value)
+			return 0;
+
+		cpu_relax();
+
+	} while (time_before(jiffies, wait_time));
+
+	return -ETIME;
+}
+
+static int bcm577x5_reg_waitl_different(struct bcm577x5_device *dev,
+					int address, u32 value, int timeout)
+{
+	unsigned long wait_time = jiffies + msecs_to_jiffies(timeout);
+	u32 reg;
+
+	do {
+		reg = bcm577x5_reg_readl(dev, address);
+		if (reg != value)
+			return 0;
+
+		cpu_relax();
+
+	} while (time_before(jiffies, wait_time));
+
+	return -ETIMEDOUT;
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
+	switch (power) {
+	case MEMSTICK_POWER_ON:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
+				    BCM577x5_MS_POWER_330);
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL,
+				    BCM577x5_MS_POWER_330 |
+					    BCM577x5_MS_POWER_ON);
+		return bcm577x5_reg_waitb(dev, BCM577x5_MS_POWER_CONTROL,
+					  BCM577x5_MS_POWER_ON,
+					  BCM577x5_MS_POWER_ON, 1000);
+	case MEMSTICK_POWER_OFF:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_POWER_CONTROL, 0);
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
+	divisor = dev->base_clock / clock_hz / 2;
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
+static int bcm577x5_ms_init(struct bcm577x5_device *dev)
+{
+	int error;
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
+	error = bcm577x5_ms_clock(dev, 24000000);
+	if (error)
+		return error;
+
+	/* Set timeout */
+	bcm577x5_reg_writeb(dev, BCM577x5_MS_TIMEOUT_CONTROL, 0xE);
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
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE,
+			    BCM577x5_MS_INT_DEFAULT);
+
+	return 0;
+}
+
+static irqreturn_t bcm577x5_irq(int irq, void *data)
+{
+	struct bcm577x5_device *dev = (struct bcm577x5_device *)data;
+	irqreturn_t ret = IRQ_NONE;
+	u32 val, status;
+	int i;
+
+	val = bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS);
+	if (val & BCM577x5_MS_STATUS_INT_ASSERTED) {
+		status = bcm577x5_reg_readl(dev, BCM577x5_MS_INT_STATUS);
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
+		if (status & BCM577x5_MS_INT_DATA_AVAIL)
+			complete(&dev->fifo_done);
+
+		if (status & BCM577x5_MS_INT_DATA_TIMEOUT)
+			dev_warn(&dev->pci_dev->dev, "Timeout!");
+
+		if (status &
+		    (BCM577x5_MS_INT_DATA_END | BCM577x5_MS_INT_DMA_END))
+			complete(&dev->dma_done);
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
+static int bcm577x5_ms_mode(struct bcm577x5_device *dev, int mode)
+{
+	u8 host_control = bcm577x5_reg_readb(dev, BCM577x5_MS_HOST_CONTROL);
+
+	switch (mode) {
+	case MEMSTICK_SERIAL:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
+				    host_control & ~BCM577x5_MS_CTRL_4BITBUS);
+		return 0;
+	case MEMSTICK_PAR4:
+		bcm577x5_reg_writeb(dev, BCM577x5_MS_HOST_CONTROL,
+				    host_control | BCM577x5_MS_CTRL_4BITBUS);
+		return 0;
+	default:
+		return -EINVAL;
+	}
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
+	if (!dev->enable_dma)
+		return -EOPNOTSUPP;
+
+	if (len > 4096)
+		return -EOPNOTSUPP;
+
+	reinit_completion(&dev->dma_done);
+
+	if (dev->req->data_dir == WRITE) {
+		dma_copy_buffer = dev->dma_buffer_aligned + 4096 - len;
+		sg_copy_to_buffer(&dev->req->sg,
+				  sg_nents_for_len(&dev->req->sg, len),
+				  dma_copy_buffer, len);
+		dma_sync_single_for_device(&dev->pci_dev->dev, dev->dma_handle,
+					   4096, DMA_TO_DEVICE);
+	}
+	/* The last byte should cause an overflow interrupt on the 4096 byte boundary */
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
+	if (!dev->enable_dma)
+		return -EINVAL;
+
+	if (!wait_for_completion_timeout(&dev->dma_done,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	if (dev->req->data_dir == READ) {
+		dma_copy_buffer = dev->dma_buffer_aligned + 4096 - len;
+		dma_sync_single_for_cpu(&dev->pci_dev->dev, dev->dma_handle,
+					4096, DMA_FROM_DEVICE);
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
+	struct sg_mapping_iter miter;
+	int i;
+
+	reinit_completion(&dev->fifo_done);
+
+	if (dev->req->data_dir == WRITE) {
+		sg_miter_start(&miter, &dev->req->sg, 1,
+			       SG_MITER_ATOMIC | SG_MITER_FROM_SG);
+		while (sg_miter_next(&miter)) {
+			u32 *buf = miter.addr;
+
+			for (i = 0; i < miter.length / 4; i++) {
+				bcm577x5_reg_writel(dev, BCM577x5_MS_BUFFER,
+						    buf[i]);
+			}
+		}
+		sg_miter_stop(&miter);
+	}
+
+	return 0;
+}
+
+static int bcm577x5_ms_finish_fifo(struct bcm577x5_device *dev)
+{
+	struct sg_mapping_iter miter;
+	int i;
+
+	if (!wait_for_completion_timeout(&dev->fifo_done, msecs_to_jiffies(10)))
+		return -ETIMEDOUT;
+
+	if (dev->req->data_dir == READ) {
+		sg_miter_start(&miter, &dev->req->sg, 1,
+			       SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		while (sg_miter_next(&miter)) {
+			u32 *buf = miter.addr;
+
+			for (i = 0; i < miter.length / 4; i++) {
+				buf[i] = bcm577x5_reg_readl(dev,
+							    BCM577x5_MS_BUFFER);
+			}
+		}
+		sg_miter_stop(&miter);
+	}
+
+	return 0;
+}
+
+static int bcm577x5_ms_execute_cmd_short(struct bcm577x5_device *dev, u32 cmd)
+{
+	int len = dev->req->data_len;
+	u32 *data = (u32 *)dev->req->data;
+	u32 response;
+
+	/* Write the data into the controller */
+	if (dev->req->data_dir == WRITE) {
+		bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT, data[0]);
+		if (len > 4)
+			bcm577x5_reg_writel(dev, BCM577x5_MS_ARGUMENT2,
+					    data[1]);
+	}
+
+	reinit_completion(&dev->cmd_done);
+
+	response = bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
+
+	if (!wait_for_completion_timeout(&dev->cmd_done,
+					 msecs_to_jiffies(100))) {
+		return -ETIME;
+	}
+
+	if (dev->req->tpc == MS_TPC_SET_CMD) {
+		/*
+		 * The controller will execute a GET_INT command, wait for it.
+		 * Sometimes, the second interrupt with coalesce with the first,
+		 * so detecting when it is completed is a bit tricky.
+		 *
+		 * The GET_INT command changes the response register,
+		 * so we can detect when it is completed by checking whether
+		 * the response register has changed.
+		 *
+		 * This may not be completely reliable if the data is the same,
+		 * just assume the command completed if it takes too long.
+		 */
+		bcm577x5_reg_waitl_different(dev, BCM577x5_MS_RESPONSE,
+					     response, 10);
+
+		/* The int reg is placed in the response register */
+		dev->req->int_reg =
+			bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE) & 0xFF;
+
+		/*
+		 * Reset is needed because the controller will expect certain commands
+		 * to follow the SET_CMD command, which the block driver may not
+		 * necessarily issue.
+		 */
+		if (bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA))
+			return -ETIME;
+	}
+
+	/* Read the data back */
+	if (dev->req->data_dir == READ) {
+		data[0] = bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE);
+		if (len > 4)
+			data[1] =
+				bcm577x5_reg_readl(dev, BCM577x5_MS_RESPONSE2);
+	}
+
+	return 0;
+}
+
+static int bcm577x5_ms_execute_cmd_long(struct bcm577x5_device *dev, u32 cmd)
+{
+	int err;
+	bool use_dma = dev->enable_dma;
+
+	/* Debug: readonly */
+	if (dev->req->tpc != MS_TPC_READ_LONG_DATA)
+		return 0;
+
+	err = bcm577x5_ms_prepare_dma(dev);
+	if (err) {
+		use_dma = false;
+		err = bcm577x5_ms_prepare_fifo(dev);
+	}
+
+	if (use_dma)
+		cmd |= BCM577x5_MS_TRNS_DMA;
+
+	/* Execute the TPC */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_TPC_REG, cmd);
+
+	if (use_dma)
+		err = bcm577x5_ms_finish_dma(dev);
+	else
+		err = bcm577x5_ms_finish_fifo(dev);
+
+	/* A reset is needed or else the next command will not execute */
+	if (bcm577x5_ms_reset(dev, BCM577x5_MS_RESET_DATA))
+		return -ETIME;
+	return err;
+}
+
+static int bcm577x5_ms_execute_cmd(struct bcm577x5_device *dev)
+{
+	int len =
+		dev->req->long_data ? dev->req->sg.length : dev->req->data_len;
+	int err;
+	u32 cmd;
+
+	/* Immediately return if there is no card inserted */
+	if (!(bcm577x5_reg_readl(dev, BCM577x5_MS_STATUS) &
+	      BCM577x5_MS_STATUS_MS_DETECT))
+		return -ENODEV;
+
+	/* Write the length of the transfer */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_BLOCK_SIZE, len);
+
+	/* Create the execution command */
+	cmd = BCM577x5_MS_MAKE_TPC(dev->req->tpc);
+	if (dev->req->data_dir == READ)
+		cmd |= BCM577x5_MS_TRNS_READ;
+
+	/* Two types of transfers have very different flow,
+	 * so split them into functions
+	 */
+	if (dev->req->long_data)
+		err = bcm577x5_ms_execute_cmd_long(dev, cmd);
+	else
+		err = bcm577x5_ms_execute_cmd_short(dev, cmd);
+
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
+		if (!err) {
+			cmderr = bcm577x5_ms_execute_cmd(dev);
+			dev->req->error = cmderr;
+		}
+	} while (!err && !cmderr);
+
+	if (cmderr) {
+		/* Controller will not respond to any more commands anyway */
+		while (!err && dev->req) {
+			dev->req->error = -ETIME;
+			err = memstick_next_req(dev->host, &dev->req);
+		}
+
+		/* Reset the controller so it accepts new commands */
+		bcm577x5_ms_init(dev);
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
+	int error = -ENOMEM;
+	struct memstick_host *host;
+	struct bcm577x5_device *dev;
+	u32 val;
+
+	host = memstick_alloc_host(sizeof(struct bcm577x5_device), &pdev->dev);
+	if (!host)
+		goto error1;
+
+	dev = memstick_priv(host);
+	dev->host = host;
+	dev->pci_dev = pdev;
+	pci_set_drvdata(pdev, dev);
+
+	error = pci_enable_device(pdev);
+	if (error)
+		goto error2;
+
+	pci_set_master(pdev);
+
+	error = pci_request_regions(pdev, DRV_NAME);
+	if (error)
+		goto error3;
+
+	dev->mmio = pci_ioremap_bar(pdev, 0);
+	if (!dev->mmio) {
+		error = -EIO;
+		goto error4;
+	}
+
+	INIT_WORK(&dev->req_work, bcm577x5_ms_req_process);
+
+	host->caps = MEMSTICK_CAP_PAR4;
+	host->request = bcm577x5_ms_submit_req;
+	host->set_param = bcm577x5_ms_set_param;
+
+	val = bcm577x5_reg_readl(dev, BCM577x5_MS_CAPABILITY_SLOT2);
+
+	dev->base_clock = ((val & BCM577x5_MS_CAPABILITY_BASE_CLOCK_MASK) >>
+			   BCM577x5_MS_CAPABILITY_BASE_CLOCK_SHIFT) *
+			  1000000;
+
+	if (enable_dma < 2) {
+		dev_info(&pdev->dev, "DMA set by module parameter\n");
+		dev->enable_dma = enable_dma;
+	} else if (val & BCM577x5_MS_CAPABILITY_SDMA) {
+		dev->enable_dma = 1;
+		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+			dev_warn(&pdev->dev, "No suitable DMA available\n");
+			dev->enable_dma = 0;
+		}
+	} else {
+		dev->enable_dma = 0;
+	}
+
+	if (dev->enable_dma) {
+		dev->dma_buffer = kzalloc(8192, GFP_DMA32 | GFP_KERNEL);
+		if (dev->dma_buffer) {
+			/* This needs to be 4096 aligned since the hardware does not seem to
+			 * issue a dma complete interrupt, so we have to rely on
+			 * address line overflows to detect completion.
+			 */
+			dev->dma_buffer_aligned = PTR_ALIGN(dev->dma_buffer, 4096);
+
+			dev->dma_handle =
+				dma_map_single(&pdev->dev, dev->dma_buffer_aligned,
+					       4096, DMA_BIDIRECTIONAL);
+			if (dma_mapping_error(&pdev->dev, dev->dma_handle)) {
+				dev_warn(&pdev->dev,
+					 "bcm577x5_ms: DMA Mapping Failed, disabling\n");
+				dev->enable_dma = 0;
+			}
+		} else {
+			dev_warn(&pdev->dev,
+				 "bcm577x5_ms: DMA memory alloc Failed, disabling\n");
+			dev->enable_dma = 0;
+		}
+	}
+
+	/* Disable interrupts */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
+
+	pci_read_config_dword(pdev, 0x8, &val);
+	dev->irq = pdev->irq;
+	dev_info(&pdev->dev, "Rev %c%c dma=%d clock=%dHz irq=%d\n",
+		 ((val & 0xFF) >> 3) + 'A', ((val & 0xFF) & 0b111) + '0',
+		 dev->enable_dma, dev->base_clock, dev->irq);
+
+	mutex_init(&dev->req_lock);
+	init_completion(&dev->cmd_done);
+	init_completion(&dev->fifo_done);
+	init_completion(&dev->dma_done);
+	error = request_irq(dev->irq, &bcm577x5_irq, IRQF_SHARED, DRV_NAME, dev);
+	if (error)
+		goto error5;
+
+	error = bcm577x5_ms_init(dev);
+	if (error)
+		goto error6;
+
+	error = memstick_add_host(host);
+	if (error)
+		goto error6;
+
+	return 0;
+error6:
+	free_irq(dev->irq, dev);
+error5:
+	iounmap(dev->mmio);
+	if (dev->enable_dma) {
+		dma_unmap_single(&dev->pci_dev->dev, dev->dma_handle, 4096,
+				 DMA_BIDIRECTIONAL);
+	}
+	kfree(dev->dma_buffer);
+error4:
+	pci_release_regions(pdev);
+error3:
+	pci_disable_device(pdev);
+error2:
+	memstick_free_host(host);
+error1:
+	return error;
+}
+
+static void bcm577x5_remove(struct pci_dev *pdev)
+{
+	int error = 0;
+	struct bcm577x5_device *dev = pci_get_drvdata(pdev);
+
+	/* Cancel the work before interrupts are disabled */
+	cancel_work_sync(&dev->req_work);
+
+	/* Clear interrupts */
+	bcm577x5_reg_writel(dev, BCM577x5_MS_INT_ENABLE, 0);
+	bcm577x5_reg_writel(dev, BCM577x5_MS_SIGNAL_ENABLE, 0);
+
+	/* Invalidate all outstanding requests */
+	while (!error && dev->req) {
+		dev->req->error = -ENODEV;
+		error = memstick_next_req(dev->host, &dev->req);
+	}
+
+	memstick_remove_host(dev->host);
+
+	if (dev->enable_dma) {
+		dma_unmap_single(&dev->pci_dev->dev, dev->dma_handle, 4096,
+				 DMA_BIDIRECTIONAL);
+	}
+	kfree(dev->dma_buffer);
+
+	free_irq(dev->irq, dev);
+	iounmap(dev->mmio);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	memstick_free_host(dev->host);
+}
+
+static int __maybe_unused bcm577x5_ms_suspend(struct device *pdev)
+{
+	struct bcm577x5_device *dev = dev_get_drvdata(pdev);
+
+	memstick_suspend_host(dev->host);
+	return 0;
+}
+
+static int __maybe_unused bcm577x5_ms_resume(struct device *pdev)
+{
+	struct bcm577x5_device *dev = dev_get_drvdata(pdev);
+
+	memstick_resume_host(dev->host);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(bcm577x5_ms_pm_ops, bcm577x5_ms_suspend,
+			 bcm577x5_ms_resume);
+
+MODULE_DEVICE_TABLE(pci, bcm577x5_pci_id_tbl);
+
+static struct pci_driver bcm577x5_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = bcm577x5_pci_id_tbl,
+	.probe = bcm577x5_probe,
+	.remove = bcm577x5_remove,
+	.driver.pm = &bcm577x5_ms_pm_ops,
+};
+
+module_pci_driver(bcm577x5_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("BCM577x5 MS/MSPro card reader driver");
diff --git a/drivers/memstick/host/bcm577x5_ms.h b/drivers/memstick/host/bcm577x5_ms.h
new file mode 100644
index 0000000000000..02e69582d05fb
--- /dev/null
+++ b/drivers/memstick/host/bcm577x5_ms.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BCM577X5_MS_H
+#define BCM577X5_MS_H
+
+#include <linux/compiler.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct memstick_host;
+struct memstick_request;
+struct pci_dev;
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
+
+	/* DMA execution */
+	int enable_dma;
+	struct completion dma_done;
+	void *dma_buffer;
+	void *dma_buffer_aligned;
+	dma_addr_t dma_handle;
+
+	/* Device properties */
+	int base_clock;
+};
+
+/*
+ * Controller registers (from sdhci.h)
+ * Registers are almost exactly the same as sdhci registers, reuse them
+ */
+
+#define BCM577x5_MS_DMA_ADDRESS		0x00
+#define BCM577x5_MS_BLOCK_SIZE		0x04
+#define BCM577x5_MS_ARGUMENT		0x08
+
+#define BCM577x5_MS_TPC_REG		0x0C
+#define BCM577x5_MS_MAKE_TPC(c) ((((c) << 4) | ((c) ^ 0xF)) << 24)
+#define  BCM577x5_MS_TRNS_DMA		0x01
+#define  BCM577x5_MS_TRNS_READ		0x10
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
+#define BCM577x5_MS_STATUS				0x190
+#define  BCM577x5_MS_STATUS_INT_ASSERTED		0x00000002
+#define  BCM577x5_MS_STATUS_MS_DETECT			0x00004000
+
+#define BCM577x5_MS_CAPABILITY_SLOT2			0x1A8
+#define  BCM577x5_MS_CAPABILITY_SDMA			0x00100000
+#define BCM577x5_MS_CAPABILITY_BASE_CLOCK_MASK		0x00007F80
+#define  BCM577x5_MS_CAPABILITY_BASE_CLOCK_SHIFT	7
+#define BCM577x5_MS_CAPABILITY_TIMEOUT_CLOCK_MASK	0x0000003F
+
+#endif /* BCM577X5_MS_H */

base-commit: 155f6759c2529d273b6b204c92bd51e3e3989232
-- 
2.55.0

