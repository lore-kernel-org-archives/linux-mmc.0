From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 10/12] usb: core: add power sequence handling for USB devices
Date: Fri, 17 Jun 2016 18:09:23 +0800
Message-ID: <1466158165-9380-11-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some hard-wired USB devices need to do power sequence to let the
device work normally, the typical power sequence like: enable USB
PHY clock, toggle reset pin, etc. But current Linux USB driver
lacks of such code to do it, it may cause some hard-wired USB devices
works abnormal or can't be recognized by controller at all.

In this patch, it will do power on sequence at hub's probe for all
devices under this hub (includes root hub) if this device is described
at dts and there is a phandle "usb-pwrseq" for it.

At hub_disconnect, it will do power off sequence which is at powered on
list.

Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
---
 drivers/usb/core/hub.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/usb/core/hub.h |  1 +
 include/linux/pwrseq.h |  6 +++++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bee1351..cc0f942 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1684,6 +1685,66 @@ static void hub_release(struct kref *kref)
 
 static unsigned highspeed_hubs;
 
+static void hub_of_pwrseq_off(struct usb_interface *intf)
+{
+	struct usb_hub *hub = usb_get_intfdata(intf);
+	struct pwrseq *hdev_pwrseq;
+	struct pwrseq_node_powered_on *pwrseq_node, *tmp_node;
+
+	list_for_each_entry_safe(pwrseq_node, tmp_node,
+			&hub->pwrseq_list, list) {
+		hdev_pwrseq = pwrseq_node->pwrseq_on;
+		pwrseq_power_off(hdev_pwrseq);
+		list_del(&pwrseq_node->list);
+		pwrseq_free(hdev_pwrseq);
+		kfree(pwrseq_node);
+	}
+}
+
+static int hub_of_pwrseq_on(struct usb_interface *intf)
+{
+	struct device *parent;
+	struct device_node *node;
+	struct pwrseq *hdev_pwrseq;
+	struct usb_device *hdev = interface_to_usbdev(intf);
+	struct usb_hub *hub = usb_get_intfdata(intf);
+	struct pwrseq_node_powered_on *pwrseq_node;
+	int ret = 0;
+
+	if (hdev->parent)
+		parent = &hdev->dev;
+	else
+		parent = bus_to_hcd(hdev->bus)->self.controller;
+
+	for_each_child_of_node(parent->of_node, node) {
+		hdev_pwrseq = pwrseq_alloc(node, "usb-pwrseq");
+		if (!IS_ERR_OR_NULL(hdev_pwrseq)) {
+			pwrseq_node = kzalloc(sizeof(pwrseq_node), GFP_KERNEL);
+			if (!pwrseq_node) {
+				ret = -ENOMEM;
+				goto err1;
+			}
+			/* power on sequence */
+			ret = pwrseq_pre_power_on(hdev_pwrseq);
+			if (ret)
+				goto err2;
+
+			pwrseq_node->pwrseq_on = hdev_pwrseq;
+			list_add(&pwrseq_node->list, &hub->pwrseq_list);
+		} else if (IS_ERR(hdev_pwrseq)) {
+			return PTR_ERR(hdev_pwrseq);
+		}
+	}
+
+	return ret;
+
+err2:
+	kfree(pwrseq_node);
+err1:
+	pwrseq_free(hdev_pwrseq);
+	return ret;
+}
+
 static void hub_disconnect(struct usb_interface *intf)
 {
 	struct usb_hub *hub = usb_get_intfdata(intf);
@@ -1700,6 +1761,7 @@ static void hub_disconnect(struct usb_interface *intf)
 	hub->error = 0;
 	hub_quiesce(hub, HUB_DISCONNECT);
 
+	hub_of_pwrseq_off(intf);
 	mutex_lock(&usb_port_peer_mutex);
 
 	/* Avoid races with recursively_mark_NOTATTACHED() */
@@ -1733,6 +1795,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret = -ENODEV;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1839,6 +1902,7 @@ descriptor_error:
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
 	INIT_WORK(&hub->events, hub_event);
+	INIT_LIST_HEAD(&hub->pwrseq_list);
 	usb_get_intf(intf);
 	usb_get_dev(hdev);
 
@@ -1852,11 +1916,14 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
-	if (hub_configure(hub, endpoint) >= 0)
-		return 0;
+	if (hub_configure(hub, endpoint) >= 0) {
+		ret = hub_of_pwrseq_on(intf);
+		if (!ret)
+			return 0;
+	}
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 34c1a7e..f52169c 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -78,6 +78,7 @@ struct usb_hub {
 	struct delayed_work	init_work;
 	struct work_struct      events;
 	struct usb_port		**ports;
+	struct list_head	pwrseq_list; /* powered on pwrseq node list */
 };
 
 /**
diff --git a/include/linux/pwrseq.h b/include/linux/pwrseq.h
index f726e7e..36dde42 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -15,6 +15,12 @@ struct pwrseq {
 	struct module *owner;
 };
 
+/* This structure is used for recording powered on pwrseq node */
+struct pwrseq_node_powered_on {
+	struct pwrseq *pwrseq_on;
+	struct list_head list;
+};
+
 struct pwrseq_ops {
 	int (*pre_power_on)(struct pwrseq *pwrseq);
 	void (*post_power_on)(struct pwrseq *pwrseq);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
