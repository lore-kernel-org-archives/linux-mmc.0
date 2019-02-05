From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h5:
 libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V capable
Date: Tue,  5 Feb 2019 23:42:25 +0800
Message-ID: <20190205154225.14264-4-wens@csie.org>
References: <20190205154225.14264-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZW543RAKGQEBTLYQ7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190205154225.14264-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Blake <chrisrblake93-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The Libre Computer ALL-H3-CC H5 is one of the few boards that can have
its eMMC run at HS-DDR speed mode. Mark it as such.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index 95e113ce8699..d68bdfea2271 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -12,3 +12,7 @@
 	model = "Libre Computer Board ALL-H3-CC H5";
 	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
 };
+
+&mmc2 {
+	mmc-ddr-3_3v;
+};
-- 
2.20.1
