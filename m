From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 1/6] mmc: pwrseq: Document that simple sequence support more than one GPIO
Date: Thu, 29 Jan 2015 16:00:03 +0100
Message-ID: <1422543608-24704-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arend van Spriel <arend@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Many SDIO/MMC attached WLAN chips need more than one ping for their reset
sequence. Extend the pwrseq_simple binding to support more than one pin.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2: None.

Changes since v1:
 - Make the explanation clearer by adding an explicit "they".
   Suggested by Srinivas Kandagatla.
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index da333d9ed94c..eaae652213ae 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -8,9 +8,10 @@ Required properties:
 - compatible : contains "mmc-pwrseq-simple".
 
 Optional properties:
-- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
-	initialization and prior we start the power up procedure of the card. It
-	will be de-asserted right after the power has been provided to the card.
+- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
+	at initialization and prior we start the power up procedure of the card.
+	They will be de-asserted right after the power has been provided to the
+	card.
 
 Example:
 
-- 
2.1.3
