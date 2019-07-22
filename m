From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 14/18] dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT
 schema
Date: Mon, 22 Jul 2019 19:07:33 +0200
Message-ID: <1563815257-2648-2-git-send-email-wahrenst@gmx.net>
References: <1563815257-2648-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563815257-2648-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

Add new Raspberry Pi 4 to DT schema.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 1a4be26..8c3bbad 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -15,6 +15,11 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: BCM2711 based Boards
+        items:
+          - enum:
+              - raspberrypi,4-model-b
+
       - description: BCM2835 based Boards
         items:
           - enum:
--
2.7.4
