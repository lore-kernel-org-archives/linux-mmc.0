From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 2/4] mmc: pwrseq: Document DT bindings for the simple MMC power sequence
Date: Mon, 19 Jan 2015 10:13:02 +0100
Message-ID: <1421658784-11980-3-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421658784-11980-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

To support SOCs which specifies specific MMC power sequences, document
some MMC DT bindings to be able to describe these hardwares.

Let's also document bindings for a simple MMC power sequence provider,
which purpose is to support a set of common properties between various
SOCs.

In this initial step, let's also document a top level description of
the MMC power sequence and describe the compatible string used for the
simple MMC power sequence provider.

The simple MMC power sequence provider will initially support a reset
GPIO. From several earlier posted patches, it's clear that such
hardware exists. Especially some WLAN chips which are attached to an
SDIO interface may use a GPIO reset.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Changed in v4:
	- None.

---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt    | 20 ++++++++++++++++++++
 Documentation/devicetree/bindings/mmc/mmc.txt        | 14 ++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
new file mode 100644
index 0000000..da333d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -0,0 +1,20 @@
+* The simple MMC power sequence provider
+
+The purpose of the simple MMC power sequence provider is to supports a set of
+common properties between various SOC designs. It thus enables us to use the
+same provider for several SOC designs.
+
+Required properties:
+- compatible : contains "mmc-pwrseq-simple".
+
+Optional properties:
+- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
+	initialization and prior we start the power up procedure of the card. It
+	will be de-asserted right after the power has been provided to the card.
+
+Example:
+
+	sdhci0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio1 12 0>;
+	}
diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index bac1311..438899e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -65,6 +65,18 @@ Optional SDIO properties:
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
 
+MMC power sequences:
+--------------------
+
+System on chip designs may specify a specific MMC power sequence. To
+successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
+maintained while initializing the card.
+
+Optional property:
+- mmc-pwrseq: phandle to the MMC power sequence node. See "mmc-pwrseq-*"
+	for documentation of MMC power sequence bindings.
+
+
 Use of Function subnodes
 ------------------------
 
@@ -101,6 +113,7 @@ sdhci@ab000000 {
 	max-frequency = <50000000>;
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
+	mmc-pwrseq = <&sdhci0_pwrseq>
 }
 
 Example with sdio function subnode:
@@ -114,6 +127,7 @@ mmc3: mmc@01c12000 {
 	vmmc-supply = <&reg_vmmc3>;
 	bus-width = <4>;
 	non-removable;
+	mmc-pwrseq = <&sdhci0_pwrseq>
 	status = "okay";
 
 	brcmf: bcrmf@1 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
