From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple MMC power sequence
Date: Wed, 14 Jan 2015 14:02:08 +0100
Message-ID: <1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39325 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbANNCX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jan 2015 08:02:23 -0500
Received: by mail-wi0-f178.google.com with SMTP id z2so5192916wiv.5
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2015 05:02:22 -0800 (PST)
In-Reply-To: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>

The simple MMC power sequence provider, intends to supports a set of
common properties between SOC designs. It thus enables us to re-use the
same provider for several SOCs.

In this initial step, let's add the top level description of the MMC
power sequence and describe the compatible string for the simple MMC
power sequence provider.

Following patches will step by step add support for new properties to
the simple MMC power sequence provider.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt      | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/mmc/mmc.txt          |  5 +++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
new file mode 100644
index 0000000..e1b7f9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
@@ -0,0 +1,18 @@
+* The simple MMC power sequence provider
+
+System on chip designs may specify a specific MMC power sequence. To
+successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
+maintained while initializing the card.
+
+The simple MMC power sequence provider, intends to supports a set of common
+properties between SOC designs. It thus enables us to re-use the same provider
+for several SOC designs.
+
+Required properties:
+- compatible : contains "mmc,pwrseq-simple".
+
+Example:
+
+	sdhci0_pwrseq {
+		compatible = "mmc,pwrseq-simple";
+	}
diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index bac1311..b12de1e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -64,6 +64,10 @@ Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
+Optional MMC power sequence:
+- mmc-pwrseq: phandle to the MMC power sequence node. See "mmc,pwrseq-*"
+	for documentation of MMC power sequence bindings.
+
 
 Use of Function subnodes
 ------------------------
@@ -101,6 +105,7 @@ sdhci@ab000000 {
 	max-frequency = <50000000>;
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
+	mmc-pwrseq = <&sdhci0_pwrseq>
 }
 
 Example with sdio function subnode:
-- 
1.9.1

