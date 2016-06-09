From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 11/14] EXAMPLE CODE: usb: port: Parse pwrseq phandle from
 Device Tree
Date: Thu, 09 Jun 2016 11:44:28 +0200
Message-ID: <1465465471-28740-12-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@v
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
device.  The pwrseq device will be used by USB hub to cycle the power
before activating ports.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/core/hub.h  |  3 +++
 drivers/usb/core/port.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 34c1a7e22aae..68ca89780d26 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -24,6 +24,8 @@
 #include <linux/usb/hcd.h>
 #include "usb.h"
 
+struct pwrseq;
+
 struct usb_hub {
 	struct device		*intfdev;	/* the "interface" device */
 	struct usb_device	*hdev;
@@ -101,6 +103,7 @@ struct usb_port {
 	struct usb_dev_state *port_owner;
 	struct usb_port *peer;
 	struct dev_pm_qos_request *req;
+	struct pwrseq *pwrseq;
 	enum usb_port_connect_type connect_type;
 	usb_port_location_t location;
 	struct mutex status_lock;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 460c855be0d0..4fce0250179c 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -18,6 +18,8 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
+#include <linux/usb/of.h>
 
 #include "hub.h"
 
@@ -526,6 +528,15 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		return retval;
 	}
 
+	port_dev->dev.of_node = usb_of_get_child_node(hdev->dev.parent->of_node,
+						      port1);
+	port_dev->pwrseq = pwrseq_alloc(&port_dev->dev, "usb-pwrseq");
+	if (IS_ERR(port_dev->pwrseq)) {
+		retval = PTR_ERR(port_dev->pwrseq);
+		device_unregister(&port_dev->dev);
+		return retval;
+	}
+
 	find_and_link_peer(hub, port1);
 
 	/*
@@ -567,8 +578,13 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_port *peer;
 
+	pwrseq_power_off(port_dev->pwrseq);
+
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+
+	pwrseq_free(port_dev->pwrseq);
+	port_dev->pwrseq = NULL;
 	device_unregister(&port_dev->dev);
 }
-- 
1.9.1
