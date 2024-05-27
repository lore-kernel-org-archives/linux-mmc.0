Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30515E5B9
	for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812081; cv=none; b=UN/Hpvlv/RZn+25GfIOqdlG1RftksnO9DRtNyUdEBgMVqNB1jGpaZsW6Z94Mr/e0ohnyBk30NEvtY8RqX0AwolltXOjn4ZtH2ZYhsdtzC7ss25XsmeonJuGyfBp/qCEJMw+/4et4yfI48caqyLx/s06OxR0F3K38G9yA3EhIQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812081; c=relaxed/simple;
	bh=7VmazO7bnwyBKzQBdOOzNJpuCsoK5YgtAfEQDEL9W/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWEnnYLG1a035K7tLALvA4GWgOdkLbgiEG1VqX+cVvGlaLCAMSx47AW8HmsiJw6hbS+zu2dzliuNRXPIcty7360bs4x0TE09K2M5BhTT9UEVle2o6QchX1Ej9j75VzjdEims39rDdFDSCp5FRaTfNg8G1Pb0CsN4M4q9Wvnkgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/JihZ9k; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/JihZ9k"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a6267639e86so362072266b.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2024 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716812078; x=1717416878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrgPnKBBv+BUaZqoRnff5gH7xS3FqnddUk3UhQHcZus=;
        b=Z/JihZ9k0TR/lVZ0BjS0cX+K8sAuExfhG34eJswFxyY/7nLsdDaa4GvhAjlF2RdCXy
         AbenthOY6ROdcm16i7u9jRF5PIj8/VcZGsiQqIb1qtlgP9cERA7bBuPOvjYRA4G20V7E
         E6uTwNYFa9d+n0xiv4Y8L2ppV34uD+uTbP1lIGxriG2gVaFVMsZRCC5QjYwUwFTJUy7g
         04Cd76jAbE86w1q8DEcXJ7YHKwW4plWkjd3Y+5Z/Ow+LRVmJAL4ToT1p1QSW1PYgmtIf
         MLWEvCLah9ssZ8JYzFtgXQgf8GDhV77zQlJAFqf6IRHs5TntRMuhEmplssiApdm64Yq/
         MxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812078; x=1717416878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrgPnKBBv+BUaZqoRnff5gH7xS3FqnddUk3UhQHcZus=;
        b=KB93UWU6TwcoR1H03I2OzkHI1HOXG3IL1LgBtQ8IRBWmiNqAQWJtdUw4PWYfOxYTbg
         aJS794/OeK2eWe2mIzyiqsLJbKhQ9f6SFlU2TiypqT+rJZpzyIbl+6R0v6jAzt8Bvgxv
         c5MkW5REj6LPNMQ4RiCIEbKBYvKnBiv5yd8Hhb57m8tPLBQpEf/U5Se+EW7C3zyguynD
         OKQzshGVbvCSvK+1+u0940+WUeQsbRdJ5oR+5TIy+Am6J58tClQi21OOFrjy0ljXXNfU
         i+1hZXx5qI/YSdAFBow1hYh/DM4WV49sUt02ifbiv53JYNWi08FvbbJebZTNj7QXqH8z
         Ii7g==
X-Forwarded-Encrypted: i=1; AJvYcCV20wDeth4TP/T1EOK3IOhwyDxoMSRh4aKqHe9jUCyHa0Cck5G71dZAB7UBRve4xgLSWhuLqGtWZ/ulDqhlrcOc4WtYJSAB4MQp
X-Gm-Message-State: AOJu0YzJYgmBHTLIlvXAPktwkQkZE7xBADXRiO/r9P0wLpT9+0X13JH5
	HgpzYXP/mH6MIWlGGphXrnNTmqjKEZrXjUpyN2A1XKeIeBQOa/rEr2hP0+IQI/Y=
X-Google-Smtp-Source: AGHT+IGiEWsSuQuBHe/443UJSVgM0UxwtUlUkfRxSh6GhDm2zPVBq6AkIs9cC9ia2KBhDVbTBAZ9gQ==
X-Received: by 2002:a17:906:2c4e:b0:a5a:84f9:df73 with SMTP id a640c23a62f3a-a62649be0dfmr533849466b.38.1716812077813;
        Mon, 27 May 2024 05:14:37 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c2a8sm484100866b.165.2024.05.27.05.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:14:37 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 3/4] tee: add tee_device_set_dev_groups()
Date: Mon, 27 May 2024 14:13:39 +0200
Message-Id: <20240527121340.3931987-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527121340.3931987-1-jens.wiklander@linaro.org>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
attribute groups. The class specific attributes are from now on added
via the tee_class, which currently only consist of implementation_id.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------
 drivers/tee/tee_core.c   |  19 +++--
 include/linux/rpmb.h     |  53 +++++--------
 include/linux/tee_drv.h  |  12 +++
 4 files changed, 122 insertions(+), 117 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index e42a45debc76..691d7de247f6 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -12,10 +12,8 @@
 #include <linux/rpmb.h>
 #include <linux/slab.h>
 
-static struct list_head rpmb_dev_list;
+static DEFINE_IDA(rpmb_ida);
 static DEFINE_MUTEX(rpmb_mutex);
-static struct blocking_notifier_head rpmb_interface =
-	BLOCKING_NOTIFIER_INIT(rpmb_interface);
 
 /**
  * rpmb_dev_get() - increase rpmb device ref counter
@@ -24,7 +22,7 @@ static struct blocking_notifier_head rpmb_interface =
 struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
 {
 	if (rdev)
-		get_device(rdev->parent_dev);
+		get_device(&rdev->dev);
 	return rdev;
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_get);
@@ -36,7 +34,7 @@ EXPORT_SYMBOL_GPL(rpmb_dev_get);
 void rpmb_dev_put(struct rpmb_dev *rdev)
 {
 	if (rdev)
-		put_device(rdev->parent_dev);
+		put_device(&rdev->dev);
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_put);
 
@@ -56,11 +54,27 @@ int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 	if (!req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
 
-	return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
+	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
 					rsp, rsp_len);
 }
 EXPORT_SYMBOL_GPL(rpmb_route_frames);
 
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->descr.dev_id);
+	kfree(rdev);
+}
+
+static struct class rpmb_class = {
+	.name = "rpmb",
+	.dev_release = rpmb_dev_release,
+};
+
 /**
  * rpmb_dev_find_device() - return first matching rpmb device
  * @data: data for the match function
@@ -79,35 +93,34 @@ EXPORT_SYMBOL_GPL(rpmb_route_frames);
  */
 struct rpmb_dev *rpmb_dev_find_device(const void *data,
 				      const struct rpmb_dev *start,
-				      int (*match)(struct rpmb_dev *rdev,
+				      int (*match)(struct device *dev,
 						   const void *data))
 {
-	struct rpmb_dev *rdev;
-	struct list_head *pos;
+	struct device *dev;
+	const struct device *start_dev = NULL;
 
-	mutex_lock(&rpmb_mutex);
 	if (start)
-		pos = start->list_node.next;
-	else
-		pos = rpmb_dev_list.next;
-
-	while (pos != &rpmb_dev_list) {
-		rdev = container_of(pos, struct rpmb_dev, list_node);
-		if (match(rdev, data)) {
-			rpmb_dev_get(rdev);
-			goto out;
-		}
-		pos = pos->next;
-	}
-	rdev = NULL;
-
-out:
-	mutex_unlock(&rpmb_mutex);
+		start_dev = &start->dev;
+	dev = class_find_device(&rpmb_class, start_dev, data, match);
 
-	return rdev;
+	return dev ? to_rpmb_dev(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
 
+int rpmb_interface_register(struct class_interface *intf)
+{
+	intf->class = &rpmb_class;
+
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+void rpmb_interface_unregister(struct class_interface *intf)
+{
+	class_interface_unregister(intf);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+
 /**
  * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
  * @rdev: the rpmb device to unregister
@@ -122,11 +135,9 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
 
-	mutex_lock(&rpmb_mutex);
-	list_del(&rdev->list_node);
-	mutex_unlock(&rpmb_mutex);
-	kfree(rdev->descr.dev_id);
-	kfree(rdev);
+	device_del(&rdev->dev);
+
+	rpmb_dev_put(rdev);
 
 	return 0;
 }
@@ -146,6 +157,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 				   struct rpmb_descr *descr)
 {
 	struct rpmb_dev *rdev;
+	int ret;
 
 	if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
 	    !descr->dev_id_len)
@@ -158,71 +170,58 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
 				     GFP_KERNEL);
 	if (!rdev->descr.dev_id) {
-		kfree(rdev);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto err_free_rdev;
 	}
 
-	rdev->parent_dev = dev;
-
-	dev_dbg(rdev->parent_dev, "registered device\n");
-
 	mutex_lock(&rpmb_mutex);
-	list_add_tail(&rdev->list_node, &rpmb_dev_list);
-	blocking_notifier_call_chain(&rpmb_interface, RPMB_NOTIFY_ADD_DEVICE,
-				     rdev);
+	ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
 	mutex_unlock(&rpmb_mutex);
+	if (ret < 0)
+		goto err_free_dev_id;
+	rdev->id = ret;
 
-	return rdev;
-}
-EXPORT_SYMBOL_GPL(rpmb_dev_register);
+	dev_set_name(&rdev->dev, "rpmb%d", rdev->id);
+	rdev->dev.class = &rpmb_class;
+	rdev->dev.parent = dev;
 
-/**
- * rpmb_interface_register() - register for new device notifications
- *
- * @nb : New entry in notifier chain
- *
- * Returns: 0 on success  -EEXIST on error.
- */
-int rpmb_interface_register(struct notifier_block *nb)
-{
-	struct rpmb_dev *rdev;
-	int ret;
-
-	ret = blocking_notifier_chain_register(&rpmb_interface, nb);
+	ret = device_register(&rdev->dev);
 	if (ret)
-		return ret;
+		goto err_id_remove;
 
-	mutex_lock(&rpmb_mutex);
-	list_for_each_entry(rdev, &rpmb_dev_list, list_node)
-		nb->notifier_call(nb, RPMB_NOTIFY_ADD_DEVICE, rdev);
-	mutex_unlock(&rpmb_mutex);
+	dev_dbg(&rdev->dev, "registered device\n");
 
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rpmb_interface_register);
+	return rdev;
 
-/**
- * rpmb_interface_unregister() - unregister from new device notifications
- *
- * @nb : Entry to remove from notifier chain
- *
- * Returns: 0 on success or -ENOENT on failure.
- */
-int rpmb_interface_unregister(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&rpmb_interface, nb);
+err_id_remove:
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+err_free_dev_id:
+	kfree(rdev->descr.dev_id);
+err_free_rdev:
+	kfree(rdev);
+	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
 
 static int __init rpmb_init(void)
 {
-	INIT_LIST_HEAD(&rpmb_dev_list);
+	int ret;
+
+	ret = class_register(&rpmb_class);
+	if (ret) {
+		pr_err("couldn't create class\n");
+		return ret;
+	}
+	ida_init(&rpmb_ida);
 	return 0;
 }
 
 static void __exit rpmb_exit(void)
 {
-	mutex_destroy(&rpmb_mutex);
+	ida_destroy(&rpmb_ida);
+	class_unregister(&rpmb_class);
 }
 
 subsys_initcall(rpmb_init);
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index e59c20d74b36..437d00fa6d4c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -40,10 +40,7 @@ static const uuid_t tee_client_uuid_ns = UUID_INIT(0x58ac9ca0, 0x2086, 0x4683,
 static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
 static DEFINE_SPINLOCK(driver_lock);
 
-static const struct class tee_class = {
-	.name = "tee",
-};
-
+static const struct class tee_class;
 static dev_t tee_devt;
 
 struct tee_context *teedev_open(struct tee_device *teedev)
@@ -965,6 +962,13 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 }
 EXPORT_SYMBOL_GPL(tee_device_alloc);
 
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups)
+{
+	teedev->dev.groups = dev_groups;
+}
+EXPORT_SYMBOL_GPL(tee_device_set_dev_groups);
+
 static ssize_t implementation_id_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
@@ -983,6 +987,11 @@ static struct attribute *tee_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(tee_dev);
 
+static const struct class tee_class = {
+	.name = "tee",
+	.dev_groups = tee_dev_groups,
+};
+
 /**
  * tee_device_register() - Registers a TEE device
  * @teedev:	Device to register
@@ -1001,8 +1010,6 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
 
-	teedev->dev.groups = tee_dev_groups;
-
 	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index 3ced206fdc17..8fb672ab7b9f 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -6,9 +6,8 @@
 #ifndef __RPMB_H__
 #define __RPMB_H__
 
-#include <linux/types.h>
 #include <linux/device.h>
-#include <linux/notifier.h>
+#include <linux/types.h>
 
 /**
  * enum rpmb_type - type of underlying storage technology
@@ -48,38 +47,29 @@ struct rpmb_descr {
 /**
  * struct rpmb_dev - device which can support RPMB partition
  *
- * @parent_dev       : parent device
+ * @dev              : device
+ * @id               : device_id
  * @list_node        : linked list node
  * @descr            : RPMB description
  */
 struct rpmb_dev {
-	struct device *parent_dev;
+	struct device dev;
+	int id;
 	struct list_head list_node;
 	struct rpmb_descr descr;
 };
 
-enum rpmb_interface_action {
-	RPMB_NOTIFY_ADD_DEVICE,
-};
-
-/**
- * struct rpmb_interface - subscribe to new RPMB devices
- *
- * @list_node     : linked list node
- * @add_rdev      : notifies that a new RPMB device has been found
- */
-struct rpmb_interface {
-	struct list_head list_node;
-	void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *rdev);
-};
+#define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
 
 #if IS_ENABLED(CONFIG_RPMB)
 struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
 void rpmb_dev_put(struct rpmb_dev *rdev);
 struct rpmb_dev *rpmb_dev_find_device(const void *data,
 				      const struct rpmb_dev *start,
-				      int (*match)(struct rpmb_dev *rdev,
+				      int (*match)(struct device *dev,
 						   const void *data));
+int rpmb_interface_register(struct class_interface *intf);
+void rpmb_interface_unregister(struct class_interface *intf);
 struct rpmb_dev *rpmb_dev_register(struct device *dev,
 				   struct rpmb_descr *descr);
 int rpmb_dev_unregister(struct rpmb_dev *rdev);
@@ -87,8 +77,6 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev);
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *resp, unsigned int resp_len);
 
-int rpmb_interface_register(struct notifier_block *nb);
-int rpmb_interface_unregister(struct notifier_block *nb);
 #else
 static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
 {
@@ -99,13 +87,22 @@ static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
 
 static inline struct rpmb_dev *
 rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
-		     int (*match)(struct rpmb_dev *rdev, const void *data))
+		     int (*match)(struct device *dev, const void *data))
 {
 	return NULL;
 }
 
+static inline int rpmb_interface_register(struct class_interface *intf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rpmb_interface_unregister(struct class_interface *intf)
+{
+}
+
 static inline struct rpmb_dev *
-rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
+rpmb_dev_register(struct device *dev, struct rpmb_descr *descr)
 {
 	return NULL;
 }
@@ -121,16 +118,6 @@ static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 {
 	return -EOPNOTSUPP;
 }
-
-static inline int rpmb_interface_register(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int rpmb_interface_unregister(struct notifier_block *nb)
-{
-	return -EOPNOTSUPP;
-}
 #endif /* CONFIG_RPMB */
 
 #endif /* __RPMB_H__ */
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 71632e3c5f18..c668e51ae939 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -169,6 +169,18 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
+/**
+ * tee_device_set_dev_groups() - Set device attribute groups
+ * @teedev:	Device to register
+ * @dev_groups: Attribute groups
+ *
+ * Assigns the provided @dev_groups to the @teedev to be registered later
+ * with tee_device_register(). Calling this function is optional, but if
+ * it's called it must be called before tee_device_register().
+ */
+void tee_device_set_dev_groups(struct tee_device *teedev,
+			       const struct attribute_group **dev_groups);
+
 /**
  * tee_session_calc_client_uuid() - Calculates client UUID for session
  * @uuid:		Resulting UUID
-- 
2.34.1

