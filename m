From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string
Date: Tue, 5 Nov 2019 10:23:36 +0000
Message-ID: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Abel Vesa <abel.vesa@nxp.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
List-Id: linux-mmc@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add imx8mq/m/n compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 imx8mq/m/n.dtsi already use this compatible string,
 but not listed in binding doc, so add it.

 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Docu=
mentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index f707b8bee304..2fb466ca2a9d 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -18,6 +18,9 @@ Required properties:
 	       "fsl,imx6ull-usdhc"
 	       "fsl,imx7d-usdhc"
 	       "fsl,imx7ulp-usdhc"
+	       "fsl,imx8mq-usdhc"
+	       "fsl,imx8mm-usdhc"
+	       "fsl,imx8mn-usdhc"
 	       "fsl,imx8qxp-usdhc"
=20
 Optional properties:
--=20
2.16.4
