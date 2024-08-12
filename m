Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8F17F4F2
	for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469507; cv=none; b=SHSDQ/bGP9we3b9RbBAHOMPye4kitUnoRMkuHWYfmuepjNlytGK7Ety30G9IyQCbNxDVcYUHRgDgMy3tbJFzs+asIVJBvHQXZBqLpgmI+n6b8W4r9VNVV/T8j1zQHXKP4f628lsmYQ+o2LtsCtqKd6fO6i97liMRYsGcHl2gxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469507; c=relaxed/simple;
	bh=3RO6h8altifqHOxGqmdtLMj8r/h8LJEY16LJOYXqSyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3wnrbiSJT4SNdGyS2913GtQOmtLmbzxRJxsRXAtoJgzifsC18L2xWxs7Dns7IIg5PtfaIs9yhB1QdWJpf0rqPgoEJbI0hVhFVi8kSN9l1syS4q7gY1P0YQMkEXyRmjHF+Zl9eDlCzgT9oCgSf4P1nxryqN59M+UiCayxOJDeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2fEIngz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2fEIngz"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso387388966b.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2024 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469503; x=1724074303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUfnkxY96IC/DwgqpiaGi88derAZvbCAx38BA+X5/Y4=;
        b=V2fEIngzmjk0+H/NJe473yo4GyZ6zu1IAtMcqEbVOO43S8hxf/Mp1Vq5tAynqqauB9
         eJyqqfV0Hb5zCMNRD5HaEn+oYk60DAqtcUqBnlXQmdyks5jrOpHChT7T9UMFzJChVUGk
         bBIgPlJ5e+ucoi5N6uW+JCZIs7757AAiSE1yLYIlSjJFbTLlsn4Yc0jy9pIwHcfNAyMs
         nlN3/v6DerCtQhz6FAQ4kju36Dkj+UyMRz57Xq4aCPicx1nzv7zgstPMeO4LAp/VTmkq
         AoddUUxI8gC6nfdWrgnnLmcn8AG5aR6Wt1I9KanPX5lDVYK6bhyyGL5LbWm7fdfHZdve
         RQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469503; x=1724074303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUfnkxY96IC/DwgqpiaGi88derAZvbCAx38BA+X5/Y4=;
        b=GaathVrvlZg+IFIUAd9C3+GqiD3gu5rXqV53i0FDPg+Oo8kgtc2FQvLVpCigtm51XL
         XOz9cFwpeFUWhX39aSy1k74JJSPUCioqLm5ajnrgM/zFtzUjHGbPcUXXwukbUUurkAau
         8pYf0ixHfGdwz1GVbQPxz0yOT4CWEPNzB+khD12l1tLGXJ2+5qjjMwpusaXzMfdoH3MS
         dNJ2IVod/Tnkz+X7GIidpkA/W1Qa9JyvNUa5G01YFdSNRkjsb4s1iXHJBICL9cNXhziw
         ztNYSKCYAy9EuhXpi19AFmfc9fb1mAMwhY0RstJWx3fCM+sjorVRe4/9P7HykgACN9qX
         PhFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZsgoQY+4gLlLkCuisT1LVyUnYcCu+JGEqb35Vb792ljscMQH2Z3TL6Cv06pokhcHzmoKFqGiUkymhaYuLQ+A4FOL0zdyMbmh9
X-Gm-Message-State: AOJu0YxbMR/BOhqqn/VTgTwA84JYUOzB23+qa3tml08GiwdPlaIPTgNM
	KZ12kADRwv+VkXlqB90hnYhMBrCRogsCXTS5N9k+WGvlvJ3JX3l4qZX5J49lY/Q=
X-Google-Smtp-Source: AGHT+IHc67QtavIuRdrI4TELS3jl9aAK/uFKNgJQ7xSp0dYJRIDRd+lCAaQN2uAqQNBW6vZr6tcmBw==
X-Received: by 2002:a17:906:6a0b:b0:a7d:3de1:4abd with SMTP id a640c23a62f3a-a80ed24cb2cmr21597666b.39.1723469502840;
        Mon, 12 Aug 2024 06:31:42 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1ccd9csm232461966b.100.2024.08.12.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:31:42 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 3/4] tee: add tee_device_set_dev_groups()
Date: Mon, 12 Aug 2024 15:31:26 +0200
Message-Id: <20240812133127.865879-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812133127.865879-1-jens.wiklander@linaro.org>
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
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
 include/linux/tee_core.h |  12 +++
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
index d52e879b204e..d113679b1e2d 100644
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
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index efd16ed52315..a38494d6b5f4 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -154,6 +154,18 @@ int tee_device_register(struct tee_device *teedev);
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

