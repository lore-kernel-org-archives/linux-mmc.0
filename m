Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264998;
	b=WReU/b5ggVXhynrNl14t1E/stI5jw9GCcd2QTN47p+UjqWG3PAp3PVYsvQYz2I46q26n
	 fx8gl85KVMHCAvGS2agdScCES0GWO4zD6i4UaJYgftsFHrIzxzL+ZobmUkPH400EoZq0N
	 f/WautIYJutizDtOjgXE2R/vbaeV/1hvuGKIbnKHqgO8AkJsV1gYVHIxRMBHQyXG5mC0u
	 LNPIQFjSwMXiKrv+FrjACRMQxQXzUVGCoMXHo59p+UZSi/gbntDqmZ0LdkNqW9HUAkaKq
	 fgYUBfW7p4ATwqkRqZxXzjj36z1eKrA6Ngky3JKXx7LDIdwBVYqgQkMiNPo4Ll2VXiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264998;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Quxwx4D/9ZX9paKFYNgMPeoMu4HkYbSDyCF+yKWZHwU=;
	b=zjefxq7bC3PUUnVB/SyvPjBK9wRnguiCnAiaRJ2RBVomS04dbT9x8gkSMEXNTl28qOOW
	 K0keT2TfOIMCFt86ZLKLHOlve33UawmfWebmCyuC4Tjc/t/5GAp8sBb254CPK5uRMDgpD
	 f/aZpTJMBpE8jnFqchoxn/8C4WSEKcDUGgganuCSrOR5Vlvsd53ygFwdL/UjU4QzIWXaC
	 5n8w2QXcrfL61rPKo2sjHKXxFF5qWkoXpSxAxGxmFGz3u9/lH4ZBRImJbV4nRNhlSUu1Z
	 Yj/HNFSPBEKNbwKwIkdQRvBiVJB193dJQsHrq8SKvf8hWhdm+8nGIqPkr6kTQgb0Wsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAQ44gTl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0260A2615;
	Sat, 21 Nov 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAQ44gTl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264998;
	b=OQzNz2nZuUQKdf2tdvCyfHtj/8UOM/+x8qaR14jF8kXUOXr/E/0n0RZP2rdXB+KBKwYg
	 ya0Avm8JiEGP1aGQjDLwRiHE6HHhh5AJAGPh0BECbGLo9hQo0YNnNcuUYKqib5+fNMxub
	 uwEyX7OVilkoWuvLF/HaLslOn1ZJuBHnlyhACJWweo602hNx4vmMmAMtfevGGgLs+jURF
	 8D9k9scYvKJJiPHImmHJUsYh+rnQNNLvpIFdupO3Tzspp4RbNYbXWBFo6FgjxnXlT8ZX7
	 +TdQLexzo4u3Y0hDk9LYoFo16wA2fWDYnpwsur6eAJRXgKJb7VEnkkKVZNs6+sUaW4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264998;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Quxwx4D/9ZX9paKFYNgMPeoMu4HkYbSDyCF+yKWZHwU=;
	b=vWQX+ZDOKSjuvMavWQ7Byc3tpijjhwcA/Cb3kgd7dkrmAbvbCEgmJ1Q4YOQMoHtulOQ2
	 t5Rc4/cNBRGIEKJqx1Tg+OJD2HcdqqteNQ/MaV0sxUY8CK/01cDhxjQ5z5owIKRqF1NzL
	 ahhm2C0+Xs73MDSj3NSKEh7FmgfL+TYrF16u3g9PRDUcJMx9SbrBHziI0Lx+jGRTCFZ0B
	 0PdK/NzK9BnCKFmjHr7kpUhDcDhbh9jnXn2kir3wKST7YmjGaGAN4sjkNMrR+Omlc+XKy
	 enUKeW8w4hQ6FQjHnC1zKh6XGY385T3Wzahjx0eW0STHytX2hLgSVIOMoIUYeE30nuQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 82EAC1F000EB;
	Sat, 21 Nov 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264998;
	bh=Quxwx4D/9ZX9paKFYNgMPeoMu4HkYbSDyCF+yKWZHwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JAQ44gTl9bp8R1zRr90izKdOjR1by8/9dUva0Pfu0xN2jbuZayhyiPg8FJlFmsF1P
	 G8/9X5SVMO8io3UkNDXaCe79D5S5TTcL9o4JF0jSQLyQLabblYDjCOJyuxHG8HCyY2
	 t2q7huco+TBgOncXpoOJEvdwS/74ODJtyUABK0dHGCVt1ha4DBBED3clvdRZChtZ7Z
	 Ace9s6H4oOMtIdqJKiLaVic4X2lK2OvMtOC2WUxEOYDk0AsOaaj6uQpdbPQLI622z/
	 8KYlHVgq7OIMRXDbcL1V5L92zP4p65+waw6XAGjLxxdPZcDGSklANH6cgCa1Urasu0
	 S9CyrnOVRACbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 105734BC5E;
	Sat, 21 Nov 2026 12:43:14 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:21 +0900
Subject: [PATCH RFC v2 11/13] ARM: at550: add SiRF AT550 platform support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-at550-rfc-v1-v2-11-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
In-Reply-To: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=7327;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=TMVN798mJJ3rMR1jYweJbb0iwGiP7A9/jXlQP0XI6K4=;
 b=k9T5AXKOfnRl0xWMoYosBZkHR19mlayrpQGvVtbjZtWrnnK6S/79+MapEQ+WMCK3vIqDrjqGO
 85uJGsh21NdDEkRajfMmOrCwnaWVTWtOistwMZwcv8HgsRP1AMZzfLF
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add minimal Devicetree machine support for the SiRF AT550 SoC, selecting
CPU_ARM1136R1 (matching MIDR 0x4117b365) alongside ARM_ERRATA_411920,
AT550_IRQ, and CLKSRC_AT550.

Document the RAM-boot firmware handoff contract and initial platform
limits in Documentation/arch/arm/at550.rst.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 Documentation/arch/arm/at550.rst | 56 ++++++++++++++++++++++++++++++++++++++++
 Documentation/arch/arm/index.rst |  1 +
 MAINTAINERS                      |  2 ++
 arch/arm/Kconfig                 |  1 +
 arch/arm/Makefile                |  1 +
 arch/arm/mach-at550/Kconfig      | 13 ++++++++++
 arch/arm/mach-at550/Makefile     |  2 ++
 arch/arm/mach-at550/at550.c      | 11 ++++++++
 8 files changed, 87 insertions(+)

diff --git a/Documentation/arch/arm/at550.rst b/Documentation/arch/arm/at550.rst
new file mode 100644
index 000000000..3d1d8a77c
--- /dev/null
+++ b/Documentation/arch/arm/at550.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+SiRF AT550 and Yupiteru YPL514si
+================================
+
+The initial AT550 port supports the ARM1136 CPU, the 64-source interrupt
+controller, the low 32 bits of the system counter and match channel zero,
+polled resistive touch input, and SDHCI programmed I/O. The YPL514si board
+can use a firmware-configured 480 by 272 RGB565 simple framebuffer.
+
+Firmware handoff
+----------------
+
+Use the standard ARM boot protocol and a flattened device tree. Firmware must
+initialize SDRAM, peripheral clocks, and pin multiplexing before entering the
+kernel. No firmware-specific virtual mappings or page-table inspection are
+used by the Linux drivers.
+
+The bootloader must update the following parts of the board device tree:
+
+* Supply the actual Linux-owned region in the memory node. The zero size in
+  the source DTS is a placeholder, not a description of all installed memory.
+  RAM still owned by another operating system must not be advertised to Linux.
+* Set the fixed counter clock frequency to the rate after the programmed
+  hardware divider. The driver deliberately does not reset the counter or
+  change the divider. A zero rate is rejected.
+* Disable the timer watchdog before handing the timer block to Linux.
+* Enable the simple framebuffer only when its physical address, dimensions,
+  stride, and format have been verified. Reserve its memory with a no-map
+  reserved-memory node so simplefb does not alias the ARM linear mapping.
+* Enable the touch and SD nodes only for peripherals actually handed to Linux.
+  The touchscreen driver rejects an active streaming/AUX configuration.
+
+A Windows CE RAM loader is one possible bootloader. Its allocation checks,
+volatile driver registration, MMU transition, and DT fixups are outside the
+kernel port. The Linux Image and all its runtime memory must fit inside the
+region returned to the kernel; a static firmware RAM mapping is insufficient
+proof that memory is available.
+
+Initial limits
+--------------
+
+The port depends on firmware clock and pin setup; cold reset initialization
+and clock-tree programming are not implemented. Board suspend is disabled in
+the defconfig because firmware state restoration has not been established.
+
+DMA address translation has not been validated, so the SDHCI driver uses PIO.
+The YPL514si DT disables MMC and SDIO discovery and limits SD to 25 MHz and
+3.3 V. Filesystem write support, card removal, and suspend/resume require
+separate hardware validation. No flash or bootloader update is required to
+use the RAM boot path.
+
+The touchscreen exports raw coordinates. Initial five-point affine calibration
+is performed in userspace, rather than placing a board-specific transform in
+the input driver. GPS/baseband, USB, UART, and native LCD modesetting are not
+part of the initial support.
diff --git a/Documentation/arch/arm/index.rst b/Documentation/arch/arm/index.rst
index b15621093..9cf1fb834 100644
--- a/Documentation/arch/arm/index.rst
+++ b/Documentation/arch/arm/index.rst
@@ -62,6 +62,7 @@ SoC-specific documents
    stm32/stm32mp157-overview
    stm32/stm32-dma-mdma-chaining
 
+   at550
    sunxi
 
    samsung/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d02a79a2..1f9c8c08b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25850,11 +25850,13 @@ F:	include/trace/events/siox.h
 SIRF AT550 PLATFORM
 M:	Yuugo Yoneda <yogo.0917.sabu@gmail.com>
 S:	Odd Fixes
+F:	Documentation/arch/arm/at550.rst
 F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
+F:	arch/arm/mach-at550/
 F:	drivers/clocksource/timer-at550.c
 F:	drivers/input/touchscreen/at550-ts.c
 F:	drivers/irqchip/irq-at550.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0cc289a71..7fcf2a28f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -367,6 +367,7 @@ source "arch/arm/mach-artpec/Kconfig"
 
 source "arch/arm/mach-aspeed/Kconfig"
 
+source "arch/arm/mach-at550/Kconfig"
 source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-axxia/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 573813ef5..508cbad8b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -176,6 +176,7 @@ machine-$(CONFIG_ARCH_ACTIONS)		+= actions
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_ASPEED)           += aspeed
+machine-$(CONFIG_ARCH_AT550)		+= at550
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
diff --git a/arch/arm/mach-at550/Kconfig b/arch/arm/mach-at550/Kconfig
new file mode 100644
index 000000000..b3a0c1874
--- /dev/null
+++ b/arch/arm/mach-at550/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config ARCH_AT550
+	bool "SiRF AT550 platforms"
+	depends on ARCH_MULTI_V6
+	select ARM_ERRATA_411920
+	select AT550_IRQ
+	select CLKSRC_AT550
+	select CPU_ARM1136R1
+	help
+	  Support SiRF AT550 systems, including the Yupiteru YPL514si.
+	  The initial support uses firmware-configured peripheral clocks,
+	  pin multiplexing and SDRAM. A bootloader-supplied device tree must
+	  describe the usable RAM region and the divided counter clock rate.
diff --git a/arch/arm/mach-at550/Makefile b/arch/arm/mach-at550/Makefile
new file mode 100644
index 000000000..98a51d234
--- /dev/null
+++ b/arch/arm/mach-at550/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += at550.o
diff --git a/arch/arm/mach-at550/at550.c b/arch/arm/mach-at550/at550.c
new file mode 100644
index 000000000..affcc9eb3
--- /dev/null
+++ b/arch/arm/mach-at550/at550.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <asm/mach/arch.h>
+
+static const char *const at550_dt_compat[] __initconst = {
+	"sirf,at550",
+	NULL,
+};
+
+DT_MACHINE_START(AT550_DT, "SiRF AT550")
+	.dt_compat = at550_dt_compat,
+MACHINE_END

-- 
2.56.0


