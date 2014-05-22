From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] of: Add helper for getting the maximum alias index for a stem
Date: Thu, 22 May 2014 17:30:22 +0200
Message-ID: <1400772623-8390-2-git-send-email-s.hauer@pengutronix.de>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaEVPan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:30:43 -0400
In-Reply-To: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>

of_alias_max_index will return the maximum number for which an
alias of a given stem exists. This is useful for frameworks
whishing to reserve a number of device slots from dynamic
allocation.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/of/base.c  | 29 +++++++++++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f807d0e..f953b9d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1758,6 +1758,35 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 		 ap->alias, ap->stem, ap->id, of_node_full_name(np));
 }
 
+/*
+ * of_alias_max_index() - get the maximum index for a given alias stem
+ * @stem:   The alias stem for which the maximum index is searched for
+ *
+ * Given an alias stem (the alias without the number) this function
+ * returns the maximum number for which an alias exists.
+ *
+ * Return: The maximum existing alias index or -ENODEV if no alias
+ *         exists for this stem.
+ */
+int of_alias_max_index(const char *stem)
+{
+	struct alias_prop *app;
+	int max = -ENODEV;
+
+	mutex_lock(&of_aliases_mutex);
+
+	list_for_each_entry(app, &aliases_lookup, link) {
+		if (strcmp(app->stem, stem))
+			continue;
+		if (app->id > max)
+			max = app->id;
+	}
+
+	mutex_unlock(&of_aliases_mutex);
+
+	return max;
+}
+
 /**
  * of_alias_scan - Scan all properties of 'aliases' node
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 276c546..963e295 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -305,6 +305,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
+extern int of_alias_max_index(const char *stem);
 
 extern int of_machine_is_compatible(const char *compat);
 
@@ -532,6 +533,11 @@ static inline int of_alias_get_id(struct device_node *np, const char *stem)
 	return -ENOSYS;
 }
 
+static inline int of_alias_max_index(const char *stem)
+{
+	return -ENODEV;
+}
+
 static inline int of_machine_is_compatible(const char *compat)
 {
 	return 0;
-- 
2.0.0.rc0

