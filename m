From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v2 11/13] usb: port: Parse pwrseq phandle from Device Tree
Date: Thu, 05 May 2016 14:34:24 +0200
Message-ID: <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
device. The pwrseq device will be used by USB hub to cycle the power
before activating ports.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/core/hub.h  |  3 +++
 drivers/usb/core/port.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

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
index 14718a9ffcfb..a875bd342452 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -18,6 +18,8 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
+#include <linux/usb/of.h>
 
 #include "hub.h"
 
@@ -532,6 +534,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		return retval;
 	}
 
+	port_dev->dev.of_node = usb_of_get_child_node(hub->hdev->dev.of_node, port1);
+	port_dev->pwrseq = pwrseq_alloc(&port_dev->dev);
+	if (IS_ERR(port_dev->pwrseq)) {
+		device_unregister(&port_dev->dev);
+		/* TODO: what about EPROBE_DEFER? */
+		return PTR_ERR(port_dev->pwrseq);
+	}
+
 	find_and_link_peer(hub, port1);
 
 	/*
@@ -573,8 +583,13 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
