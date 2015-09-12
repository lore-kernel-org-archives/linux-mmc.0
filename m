From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: pxamci: fix card detect threaded interrupt
Date: Sat, 12 Sep 2015 11:03:31 +0200
Message-ID: <1442048611-23314-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Petr Cvek <petr.cvek@tul.cz>
List-Id: linux-mmc@vger.kernel.org

Change the interrupt flavor of the card detection, from a hard interrupt
to a threaded interrupt. There is no strong requirement for a hard
interrupt.

It fixes the case where the card detection is on a gpio expander, on I2C
for example on zylonite board. In this case, the card detect netsted
interrupt is called from a threaded interrupt. The request_irq() fails,
because a hard irq cannot be a nested interrupt from a threaded
interrupt (set __setup_irq()).

This was tested on zylonite and mioa701 boards.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 1420f29628c7..67c9d1443597 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -814,8 +814,10 @@ static int pxamci_probe(struct platform_device *pdev)
 		}
 		gpio_direction_input(gpio_cd);
 
-		ret = request_irq(gpio_to_irq(gpio_cd), pxamci_detect_irq,
-				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+		ret = request_threaded_irq(gpio_to_irq(gpio_cd), NULL,
+				  pxamci_detect_irq,
+				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				  IRQF_ONESHOT,
 				  "mmc card detect", mmc);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request card detect IRQ\n");
-- 
2.1.4
