From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 01/11] Documentation: dt: wireless: update wl1251 for sdio
Date: Sat, 19 Oct 2019 20:41:16 +0200
Message-ID: <741828f69eca2a9c9a0a7e80973c91f50cc71f9b.1571510481.git.hns@goldelico.com>
References: <cover.1571510481.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1571510481.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-mmc@vger.kernel.org, kernel@pyra-handheld.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The standard method for sdio devices connected to
an sdio interface is to define them as a child node
like we can see with wlcore.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
---
 .../bindings/net/wireless/ti,wl1251.txt       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
index bb2fcde6f7ff..88612ff29f2d 100644
--- a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
@@ -35,3 +35,29 @@ Examples:
 		ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
 	};
 };
+
+&mmc3 {
+	vmmc-supply = <&wlan_en>;
+
+	bus-width = <4>;
+	non-removable;
+	ti,non-removable;
+	cap-power-off-card;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wlan: wl1251@1 {
+		compatible = "ti,wl1251";
+
+		reg = <1>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;	/* GPIO_21 */
+
+		ti,wl1251-has-eeprom;
+	};
+};
-- 
2.19.1
