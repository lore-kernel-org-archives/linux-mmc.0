From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [RFC PATCH 7/7] ARM: shmobile: r8a7790-lager.dts: Assert UHS-I
 SDR-50 capability
Date: Thu, 30 Apr 2015 13:33:04 +0100
Message-ID: <1430397184.5802.46.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430396995.5802.39.camel-2NU49sBE5Aze9VDwLV8dzJPsBRI6B4nW9dF7HbQ/qKg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, William Towle <william.towle-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: William Towle <william.towle-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

[bwh: Also enable the 'regulators' on the pfc that we need]
Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 343ec0ccc8df..8bb4507f3112 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -384,6 +384,14 @@
 		renesas,groups = "audio_clk_a";
 		renesas,function = "audio_clk";
 	};
+
+	sd-regulator@0 {
+		status = "ok";
+	};
+
+	sd-regulator@2 {
+		status = "ok";
+	};
 };
 
 &ether {
@@ -499,6 +507,7 @@
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
@@ -512,6 +521,7 @@
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
1.7.10.4



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
