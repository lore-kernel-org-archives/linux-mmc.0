From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl interaction
Date: Sun, 19 Feb 2012 23:27:42 -0700
Message-ID: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>
Cc: Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Update gpio.txt based on recent discussions regarding interaction with the
pinctrl subsystem.

Previously, gpio_request() was described as explicitly not performing any
required mux setup operations etc.

Now, gpio_request() is explicitly as explicitly performing any required mux
setup operations where possible. In the case it isn't, platform code is
required to have set up any required muxing or other configuration prior to
gpio_request() being called, in order to maintain the same semantics.

This is achieved by gpiolib drivers calling e.g. pinctrl_request_gpio() in
their .request() operation.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 Documentation/gpio.txt |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpio.txt b/Documentation/gpio.txt
index 792faa3..3c4a702 100644
--- a/Documentation/gpio.txt
+++ b/Documentation/gpio.txt
@@ -271,9 +271,25 @@ Some platforms may also use knowledge about what GPIOs are active for
 power management, such as by powering down unused chip sectors and, more
 easily, gating off unused clocks.
 
-Note that requesting a GPIO does NOT cause it to be configured in any
-way; it just marks that GPIO as in use.  Separate code must handle any
-pin setup (e.g. controlling which pin the GPIO uses, pullup/pulldown).
+Requesting a GPIO should cause any pin multiplexing hardware to be programmed
+to route the GPIO signal to the appropriate pin. In some cases, this requires
+programming separate pin multiplexing hardware outside the GPIO controller.
+Equally, for GPIOs that use pins known to the pinctrl subsystem, that
+subsystem should be informed of their use. These requirements may be satisfied
+by having a gpiolib driver's .request() operation call pinctrl_request_gpio().
+Similarly, a gpiolib driver's .free() operation may call pinctrl_free_gpio().
+
+Some platforms allow some or all GPIO signals to be routed to different pins.
+Similarly, other aspects of the GPIO or pin may need to be configured, such as
+pullup/pulldown. Platform software should arrange that any such details are
+configured priored to gpio_request() being called for those GPIOs, such that
+GPIO users need not be aware of these details.
+
+gpiolib drivers may need to call additional pinctrl APIs to implement certain
+operations. This would be the case if e.g. GPIO input/output value is
+controlled by a GPIO HW module, whereas GPIO direction is controlled by a
+separate pin controller HW module. Functions pinctrl_gpio_direction_input()
+and pinctrl_gpio_direction_output() may be used to implement this.
 
 Also note that it's your responsibility to have stopped using a GPIO
 before you free it.
-- 
1.7.5.4

