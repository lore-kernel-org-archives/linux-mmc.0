From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/5] mmc: pwrseq: Document that simple sequence support more
 than one GPIO
Date: Wed, 28 Jan 2015 11:10:15 +0100
Message-ID: <1422439819-29854-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Many SDIO/MMC attached WLAN chips need more than one ping for their reset
sequence. Extend the pwrseq_simple binding to support more than one pin.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index da333d9ed94c..9a77deb164c7 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -8,9 +8,9 @@ Required properties:
 - compatible : contains "mmc-pwrseq-simple".
 
 Optional properties:
-- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
-	initialization and prior we start the power up procedure of the card. It
-	will be de-asserted right after the power has been provided to the card.
+- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
+	at initialization and prior we start the power up procedure of the card.
+	Will be de-asserted right after the power has been provided to the card.
 
 Example:
 
-- 
2.1.3
