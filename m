Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774431;
	b=vmFdZa3tIRLu18LfTBRCRVa+S63Eyw0olRazjbkfZqOWBrqzWGOK1x4G7rnWBfx9slgY
	 NZfhq7FKR8xRBB5y6xOhkphPf0lV8ABSwCvFohUrm1gc451h4xIgIc3JGdasMFJ54a9h+
	 +q0XMrOYOW8mwFMjHoMmsiStDfH2tkLHy6vbygatdZj74SPoobb+tqOSA7iHFVbt6DiCu
	 bCUO0OHyjsv3JHKQiQtjLyajp9dAssYfu5Zmo8nLWtsGyppOE/+itaM/6rZWl42hWL3iI
	 Urg+xIGtVwQdW8VnX/Nlz6E+s+D8MPton/GE/Tldw/myu1x+LvcBMhFH4PlkNx58hHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774431;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f9mgcZbewi17F/DkkZQzJOfToRNVOdacCwJ/qYZc/Eg=;
	b=LgEMrEuO5qWiUyEut7Q5GrICOZxtfSELokOmG0fuHrKu85xbjRy9AkeF8bjLAPevfxdD
	 VD47n5ABBZTlrEnl03BTfugeVSE4fVtWgrDR5X1rdjU4Jxuxlzub1Nh/4Ma9zvFmMg+V+
	 X7+/GV4Tq9dokTpO+Lp+AoOqP6K7i0jAUb2njapOBa82yhMkZr09qH1nQNAJxJN2qAbWK
	 Ryb5HJZo2Hvi/aCJvC5c0Kk6n/TarkbOEyIKOXWK99m5VH70x0Pq3tBLJxF+h6TUgc4bi
	 +mNPecTcNFrrNsbakxJ9cbatNCe4c7wxdrjpTbEyW7+2zWHtDCeGfPCHYHvv1tlG2rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7LQi5HX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1E60A3806;
	Fri, 27 Nov 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7LQi5HX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774431;
	b=WS4RgWJXTG6nUy7rNqsQAD2zd7t+3wXgazRY9008KsNjoWBi9gAcIM9F0A6gcpmlRVhP
	 67lwzBvwkitPZehfqEj3OQmDJrRPK/v3I+2DxDv8khT2tJGmbXw/aWFhL0vetyqAPnCBs
	 d5psFvU3+bUA016QnfcbNlGhKyroQJM92GAdyWsWJp1ilBjLm9cT1/6g0C9qWsD774Y3V
	 MdqSjwwvy7znlv/fsTGrzqNBg7xAqjc4uprG5TsH1bzgZEXVzce6knCJ6vWOpWQzg5Gt7
	 Zqtl7DTRA9NUvRH55P81asaBGDqPNQs/PsYyD9nFoePTOu5mmR9gQ5Vkflku/lAIApA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774431;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f9mgcZbewi17F/DkkZQzJOfToRNVOdacCwJ/qYZc/Eg=;
	b=Vi3SEdVG/eV44XYxHCZlfSWpzHARxFJ5BEQCtn/GfxZ+DPotXtDfKE+AmIs5P+JpbQG4
	 UR9LoPxyge9VRn1e7fDDLz1sPA4UVxfHvGR66kEr6yGd9as+KWdmH8zdAsYETPqHaaLqV
	 9KBFEH/3AOyIO0nUmMaOxylA98gjU2EKWDV1kNZ8fg4sI+rdTEwVvQ0313s1fWn6fd+J4
	 JTjaSNxJXkWVOJh8sPfE0apxwRNe4cA/A65DMckV12kopiGhMKL7EGWde23sInGCf6o1o
	 I6oh+piXD8IJET/xEdbKNCE1QtESXVtJWbbHVV+FIKV/La5DOB3csm8dpWfVuRx8T0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC1C31F00929;
	Fri, 27 Nov 2026 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774431;
	bh=f9mgcZbewi17F/DkkZQzJOfToRNVOdacCwJ/qYZc/Eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Y7LQi5HXlOwYz1mHvxofLnTTQ/hExEL+deR3sfsr075FCUDAgzBxWE8owNUo0E3qK
	 HBZ9nTK6DwThbHtuI6uEpyV8VsQzrls+WEbEFyCWjuz4AVvUyij+Cgc39aHAPxPPqV
	 F3NLLQ3GUBS/ewiGJbYUmZiJiCjR54IltvdeBcrZU1NrBR8Qs/l7DbKeS/850EXs90
	 O1rT6O5Fx/9ECHfgnXFrNQd6IZ1qwySbDzKcIg3WwcozCgHg8UzwRq7zJ+R1uYQQkI
	 LJNkdT6XgHbLl0LEV6hm7m7KNBONugapic7klann0XXrvJMBcV9M4lJnJ+oL7KSki5
	 oLt+M94tVAUjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 319914B717;
	Fri, 27 Nov 2026 10:13:23 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:12 +0900
Subject: [PATCH RFC v3 11/13] ARM: at550: add SiRF AT550 platform support
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
Message-Id: <20261127-at550-rfc-v1-v3-11-f2221008912b@gmail.com>
References: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
In-Reply-To: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
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
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev, 
 Yuugo Yoneda <yogo.0917.sabu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=7327;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=g6ge5X6XsBt04lxoEmM1xnac5neJbBmEIx9wfufwKCc=;
 b=gvOi66DNwjQKRfZfXuximtEHecPUwujgnREea5IVZRhDPtf3mJ7OwvM4xJaXqEXUFPnYAsyxv
 WMjldKJsMdQAHPk5Dlx3IJ2RVVhED2b/4Q7bbWFMobofhFLhkRv6Pt8
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
2.56.1


