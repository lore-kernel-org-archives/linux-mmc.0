Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264997;
	b=X/m0nzf3c/9eSV5DxXwfAOG5GNcJe8r1hj7EEUbdNT8fQE0KeBKjekJEyMVbiYOB2Bmk
	 JZ/qViu009MHcSKefVoKWK4BLLalj9VcvY4cvUgfBxOYyE7BO7C9c6zcXgCdakeuqo584
	 75wQGT4U3+Ox5FlI8HyfWPP9VkmpvWBMLwfN7iG9TxWyxYMCP6b+r947OcGnWvBmdkf+o
	 bfG+OOvDaSpJ21ULOYm5UMBPZgil0SyWCjAUtNYijQuIv/+j743PI9vdDVQimVY4cJpYE
	 w8f8aqwKqP3ib/waURXshD40/IxTmW+lprVkE/YxeG0k71VTaARglwyP/wziMLwr7Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264997;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GXTMjUX/kSVM3WvK+gyyuLh1Y23hZHEMD0umbg/nAYw=;
	b=nb8ZfF3g9QcHTGoJ4SXryzQxBKxui+F4jhUMntOGnxUmTNnd4spnb4dlDTJ3fUPNMxF/
	 e7a7xQ5/w9sH/tFyDkDCnTpTcUun9196YySOxGSYRbhpndFuu+viZ/IGLzModJ2P77DA1
	 jEzsjpeLdJEJsqGSBP0Y61tMFexf9F8/+HPBBxoq5R+aZa4KeVcGcoxckbsd3Cq1n2HDN
	 HI4FrSQTCQgpe9RJ7UuGtzmfXZCGsKonhQoXwuA2GyfYf3t5guyNrgOzOTtQn0XvOQMUL
	 Cq802iwQk1ThAFQmVgfscfgADzcj0x6ddF2uAPOMu6rekOggmhdDCe2Zbpf8iERZ5cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIME9Hcw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC504606A699;
	Sat, 21 Nov 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIME9Hcw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264997;
	b=PiDwiv/B5ikVhfD5iCGpe7kXfFSUW7uVgUEDjQitJcDIsIfxb5T++znXIy0de0D3Wj5Q
	 Rgj8IvS+xc7Lcb+bqxpZMV3hefqx1Xh7UevsUD/v+Y7yu1N++ZfV592bmXK/9mLdJuz0P
	 0jR6bw1YRrSqfA7pVjlpGtfPZ2l2lEIlRuxTgTBBLQSbt2V+o5DDvLUkEh7ljyWiZ5jHz
	 tFBt7WiJcqnjF+xSpW+JfQWOSFpqm1E2fkEb15NPIRBjny/Qhe+PGrFWacFC8DuT29GJr
	 Wl+KXUTqDC9I87gXxcNl3KuGMRebpHt/T+bkV9240eJ/34qjrH7tiHpAJPJMElzNI8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264997;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GXTMjUX/kSVM3WvK+gyyuLh1Y23hZHEMD0umbg/nAYw=;
	b=hdAwu0W5et2AGqj0Krbw4+Uaq6i8grRDf2pnWpxmLDn5zeCV4DA4MiNfePH7rycTYh3t
	 lSBluWKFnCjg/kNBUw7KB2g72bdIrFcw+U6CJsOTi2JpSQEaCAw/5xo0gennoO0d7mXc7
	 oXuuAlT1wx2eLj9DUXiNBgfbtXjNOKDme0n3mFo1uT+qbrkKUIL22fTOItx9+sBdUcIcl
	 3mV63Hl0UnVuJEyrNiLyTWtNE6FdJfJH96Iwby1thBsRFEs5pQzM8q7fjKkfrxVkqeGgu
	 qLtN65li3ISh95xv51szr1y3qJ1JMIK41UsUiVny6tvXey9rDeHS4sAH+PQWNcp+4uA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 18E881F000ED;
	Sat, 21 Nov 2026 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264997;
	bh=GXTMjUX/kSVM3WvK+gyyuLh1Y23hZHEMD0umbg/nAYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oIME9HcwQE9CHCrjfuPZ5lw9g+cPAGQszG2J2/DzmTJVPBd/GFRAA3aOysp0TxDvj
	 BXJlC8h07VfoLzlG8sCYMA3gqe0opca1axikRHD9DZaqL1Uj8y0W9Qg9uUK98LtnQg
	 SSqo+aHvO1LFJcUY+De641B0gJepnG+GrbKI6yoXmYAlSHRYKiWVvNAgXcs5tg6v+5
	 Gj064xtOJXJHKULDw8xdI+KmzWXfat5GM4HANT/Tlh12c9awK4v3nEkYQE/H7ve5Tq
	 LEE1jxboUablp6taITT5HeFDbkTqARggc67QRXz4SdhjNy4SPjT4pvmNFLBm86Mq5z
	 HXAGbrpOFr4EA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 505EC4BC66;
	Sat, 21 Nov 2026 12:43:14 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:43:23 +0900
Subject: [PATCH RFC v2 13/13] ARM: configs: add at550_defconfig
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
Message-Id: <20261121-at550-rfc-v1-v2-13-b0309d0789b2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=2043;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=8LBKoQ+PfGaRCaYqglevUyFClxgdubOafzov9/zMk8s=;
 b=ib5oCO9+EUkoK/CU3U7XdrXetXXaoF0PcKZUuYBCNy+cT1iyLEirYJy+AYms6RhhWwZDl2Anv
 +ZskrknhvcEAtc7gFu5q5OdcPOzTTLtzfR6xIH0PPbBwHb8uH8Il1hU
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add a minimal defconfig for the SiRF AT550 / YPL514si enabling
ARCH_MULTI_V6, ARCH_AT550, FB_SIMPLE, TOUCHSCREEN_AT550,
MMC_SDHCI_AT550, and VFAT/initramfs support while disabling
ARCH_MULTI_V7 and unvalidated SUSPEND.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                      |  1 +
 arch/arm/configs/at550_defconfig | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6f0f3fb6..d5a7e78ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25857,6 +25857,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
 F:	arch/arm/boot/dts/sirf/at550*
+F:	arch/arm/configs/at550_defconfig
 F:	arch/arm/mach-at550/
 F:	drivers/clocksource/timer-at550.c
 F:	drivers/input/touchscreen/at550-ts.c
diff --git a/arch/arm/configs/at550_defconfig b/arch/arm/configs/at550_defconfig
new file mode 100644
index 000000000..95d32f2c9
--- /dev/null
+++ b/arch/arm/configs/at550_defconfig
@@ -0,0 +1,35 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_ARCH_MULTI_V6=y
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_AT550=y
+# CONFIG_SUSPEND is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_AT550=y
+CONFIG_FB=y
+CONFIG_FB_SIMPLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_AT550=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y

-- 
2.56.0


