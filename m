From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Subject: [PATCH v7 8/8] ARM: sunxi: Add documentation for driver
 for SD/MMC hosts found on Allwinner sunxi SoCs
Date: Mon, 17 Feb 2014 11:03:02 +0100
Message-ID: <20140217100302.15040.56273.stgit@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD2JL37LXEKRBL55Q6MAKGQEBIFFB2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140217095907.15040.81893.stgit-pgFh0Jf6HD9Xzn/AsuzBOg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?utf-8?b?TMOzcGV6?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
---
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   32 ++++++++++++++++=
++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Document=
ation/devicetree/bindings/mmc/sunxi-mmc.txt
new file mode 100644
index 0000000..5ce8c5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -0,0 +1,32 @@
+* Allwinner sunxi MMC controller
+
+The highspeed MMC host controller on Allwinner SoCs provides an interface
+for MMC, SD and SDIO types of memory cards.
+
+Supported maximum speeds are the ones of the eMMC standard 4.5 as well
+as the speed of SD standard 3.0.
+Absolute maximum transfer rate is 200MB/s
+
+Required properties:
+- compatible: Should be "allwinner,<revision>-<chip>-mmc".
+  The supported chips include a10, a10s, 13, a20 and a31.
+- base registers are 0x1000 appart, so the base of mmc1
+  would be 0x01c0f000+0x1000=3D0x01c10000(see example)
+  and so on.
+- clocks requires the reference at the ahb clock gate
+  with the correct index (mmc0 -> 8, mmc1 -> 9, and so on)
+  as well as the reference to the correct mod0 clock.
+- interrupts requires the correct IRQ line
+  (mmc0 -> 32, mmc1 -> 33, and so on)
+
+Examples:
+
+mmc0: mmc@01c0f000 {
+	compatible =3D "allwinner,sun5i-a13-mmc";
+	reg =3D <0x01c0f000 0x1000>;
+	clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
+	clock-names =3D "ahb", "mod";
+	interrupts =3D <0 32 4>;
+	bus-width =3D <4>;
+	status =3D "disabled";
+};

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
