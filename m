From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 11/12] usb: chipidea: host: let the hcd know's parent device node
Date: Fri, 17 Jun 2016 18:09:24 +0800
Message-ID: <1466158165-9380-12-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, javier@osg.samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Peter Chen <peter.chen@freescale.com>
List-Id: linux-mmc@vger.kernel.org

From: Peter Chen <peter.chen@freescale.com>

Since the hcd (chipidea core device) has no device node, so
if we want to describe the child node under the hcd, we had
to put it under its parent's node (glue layer device), and
in the code, we need to let the hcd knows glue layer's code,
then the USB core can handle this node.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/usb/chipidea/host.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 053bac9..55120ef 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
 	struct ehci_hcd *ehci;
 	struct ehci_ci_priv *priv;
 	int ret;
+	struct device *dev = ci->dev;
 
-	if (usb_disabled())
+	if (usb_disabled() || !dev)
 		return -ENODEV;
 
-	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
+	/*
+	 * USB Core will try to get child node under roothub,
+	 * but chipidea core has no of_node, and the child node
+	 * for controller is located at glue layer's node which
+	 * is chipidea core's parent.
+	 */
+	if (dev->parent && dev->parent->of_node)
+		dev->of_node = dev->parent->of_node;
+
+	hcd = usb_create_hcd(&ci_ehci_hc_driver, dev, dev_name(dev));
 	if (!hcd)
 		return -ENOMEM;
 
-	dev_set_drvdata(ci->dev, ci);
+	dev_set_drvdata(dev, ci);
 	hcd->rsrc_start = ci->hw_bank.phys;
 	hcd->rsrc_len = ci->hw_bank.size;
 	hcd->regs = ci->hw_bank.abs;
@@ -143,7 +153,7 @@ static int host_start(struct ci_hdrc *ci)
 		if (ci->platdata->flags & CI_HDRC_TURN_VBUS_EARLY_ON) {
 			ret = regulator_enable(ci->platdata->reg_vbus);
 			if (ret) {
-				dev_err(ci->dev,
+				dev_err(dev,
 				"Failed to enable vbus regulator, ret=%d\n",
 									ret);
 				goto put_hcd;
-- 
1.9.1

