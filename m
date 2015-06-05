From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 1/8] mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
Date: Fri, 5 Jun 2015 13:42:20 -0400
Message-ID: <1433526147-25941-2-git-send-email-alcooperx@gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:64682 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbbFESB1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 14:01:27 -0400
In-Reply-To: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Al Cooper <alcooperx@gmail.com>

Use the kernel "KEYS" subsystem to get a password for a card based on
the card's CID. This code was based on a patch set submitted by
Anderson Briglia in 2006.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/Kconfig |  8 ++++
 drivers/mmc/core/core.c  | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  | 10 ++++-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 9ebee72..1d073cd 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -11,3 +11,11 @@ config MMC_CLKGATE
 	  support handling this in order for it to be of any use.
 
 	  If unsure, say N.
+
+config MMC_LOCK
+	bool "MMC/SD password based card lock/unlock"
+	select KEYS
+	help
+	  This will add the ability to lock/unlock SD and MMC cards.
+
+	  If unsure, say N.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 92e7671..f7d7ad9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/key-type.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -2707,6 +2708,96 @@ void mmc_init_context_info(struct mmc_host *host)
 	init_waitqueue_head(&host->context_info.wait);
 }
 
+#ifdef CONFIG_MMC_LOCK
+
+static int mmc_key_instantiate(struct key *key,
+			       struct key_preparsed_payload *prep)
+{
+	char *payload;
+
+	if (prep->datalen <= 0 || prep->datalen > MMC_PASSWORD_MAX ||
+	    !prep->data) {
+		pr_warn("Invalid data\n");
+		return  -EINVAL;
+	}
+
+	payload = kmalloc(prep->datalen, GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+	memcpy(payload, prep->data, prep->datalen);
+	key->payload.data = payload;
+	key->datalen = prep->datalen;
+	return 0;
+}
+
+/*
+ * dispose of the data dangling from the corpse of a mmc key
+ */
+static void mmc_key_destroy(struct key *key)
+{
+	kfree(key->payload.data);
+}
+
+struct key_type key_type_mmc = {
+	.name		= "mmc",
+	.instantiate	= mmc_key_instantiate,
+	.destroy	= mmc_key_destroy,
+};
+
+int mmc_get_password(struct mmc_card *card, struct mmc_password *password)
+{
+	struct key *mmc_key;
+	char key_desc[(sizeof(card->raw_cid) * 2) + 1];
+
+	/* Use the CID to uniquely identify the card */
+	snprintf(key_desc, sizeof(key_desc), "%08x%08x%08x%08x",
+		 card->raw_cid[0], card->raw_cid[1],
+		 card->raw_cid[2], card->raw_cid[3]);
+
+	mmc_key = request_key(&key_type_mmc, key_desc,
+			      "password");
+	if (IS_ERR(mmc_key)) {
+		dev_warn(&card->dev, "Error, request_key %ld\n",
+			 PTR_ERR(mmc_key));
+		return PTR_ERR(mmc_key);
+	}
+	dev_dbg(&card->dev, "Found matching key\n");
+	memcpy(&password->password, mmc_key->payload.data,
+	       mmc_key->datalen);
+	password->length = mmc_key->datalen;
+	key_put(mmc_key);
+
+	return 0;
+}
+
+static inline int mmc_register_key_type(void)
+{
+	return register_key_type(&key_type_mmc);
+}
+
+static inline void mmc_unregister_key_type(void)
+{
+	unregister_key_type(&key_type_mmc);
+}
+
+#else /* CONFIG_MMC_LOCK */
+
+int mmc_get_password(struct mmc_card *card, struct mmc_password *password)
+{
+	return -ENOKEY;
+}
+
+static inline int mmc_register_key_type(void)
+{
+	return 0;
+}
+
+static inline void mmc_unregister_key_type(void)
+{
+}
+
+#endif /* CONFIG_MMC_LOCK */
+
 static int __init mmc_init(void)
 {
 	int ret;
@@ -2727,8 +2818,13 @@ static int __init mmc_init(void)
 	if (ret)
 		goto unregister_host_class;
 
+	ret = mmc_register_key_type();
+	if (ret)
+		goto unregister_sdio_bus;
 	return 0;
 
+unregister_sdio_bus:
+	sdio_unregister_bus();
 unregister_host_class:
 	mmc_unregister_host_class();
 unregister_bus:
@@ -2741,6 +2837,7 @@ destroy_workqueue:
 
 static void __exit mmc_exit(void)
 {
+	mmc_unregister_key_type();
 	sdio_unregister_bus();
 	mmc_unregister_host_class();
 	mmc_unregister_bus();
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index cfba3c0..b91bc3e 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -89,5 +89,13 @@ void mmc_init_context_info(struct mmc_host *host);
 
 int mmc_execute_tuning(struct mmc_card *card);
 
-#endif
+/* Lock/Unlock functionality */
+#define MMC_PASSWORD_MAX 16
+struct mmc_password {
+	char password[MMC_PASSWORD_MAX];
+	int length;
+};
+int mmc_unlock_card(struct mmc_card *card);
+int mmc_get_password(struct mmc_card *card, struct mmc_password *password);
 
+#endif
-- 
1.9.0.138.g2de3478

