From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v2] ls1021aqds: enable esdhc controller
Date: Tue, 26 Feb 2019 08:40:22 +0000
Message-ID: <20190226084121.41499-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>
Cc: Yinbo Zhu <yinbo.zhu@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch is to enable esdhc controller in ls1021aqds

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Add patch code after &enet2 to keep them sort alphabetically.

 arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-=
qds.dts
index dac61e7..ae26f8b 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -160,6 +160,10 @@
 	status =3D "okay";
 };
=20
+&esdhc {
+	status =3D "okay";
+};
+
 &i2c0 {
 	status =3D "okay";
=20
--=20
1.7.1
