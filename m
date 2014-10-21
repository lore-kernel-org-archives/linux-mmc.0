From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 11/12] ARM: dts: berlin: Enable WiFi on Google Chromecast
Date: Tue, 21 Oct 2014 11:22:43 +0200
Message-ID: <1413883364-681-12-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

With SDHCI for BG2CD, we can now enable the port and allow to access
AzureWave WiFi/BT module on Google Chromecast.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/a=
rm/boot/dts/berlin2cd-google-chromecast.dts
index bcd81ffc495d..8c26a2dfd4a3 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -26,4 +26,13 @@
 	};
 };
=20
+/*
+ * AzureWave AW-NH387 (Marvell 88W8787)
+ * 802.11b/g/n + Bluetooth 2.1
+ */
+&sdhci0 {
+	non-removable;
+	status =3D "okay";
+};
+
 &uart0 { status =3D "okay"; };
--=20
2.1.1
