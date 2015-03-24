From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 1/4] PM / QoS: Add pm_qos_cancel_request_lazy() that doesn't sleep
Date: Tue, 24 Mar 2015 15:40:37 +0200
Message-ID: <1427204440-3533-2-git-send-email-adrian.hunter@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add pm_qos_cancel_request_lazy() which is convenient for
contexts that may not sleep.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/pm_qos.h |  2 ++
 kernel/power/qos.c     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 7b3ae0c..f44d353 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -126,6 +126,8 @@ void pm_qos_update_request(struct pm_qos_request *req,
 			   s32 new_value);
 void pm_qos_update_request_timeout(struct pm_qos_request *req,
 				   s32 new_value, unsigned long timeout_us);
+void pm_qos_cancel_request_lazy(struct pm_qos_request *req,
+				unsigned int timeout_us);
 void pm_qos_remove_request(struct pm_qos_request *req);
 
 int pm_qos_request(int pm_qos_class);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 97b0df7..ac131cb 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -517,6 +517,26 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
 }
 
 /**
+ * pm_qos_cancel_request_lazy - cancels an existing qos request lazily.
+ * @req : handle to list element holding a pm_qos request to use
+ * @timeout_us: the delay before cancelling this qos request in usecs.
+ *
+ * After timeout_us, this qos request is cancelled.
+ */
+void pm_qos_cancel_request_lazy(struct pm_qos_request *req,
+				unsigned int timeout_us)
+{
+	if (!req)
+		return;
+	if (WARN(!pm_qos_request_active(req),
+		 "%s called for unknown object.", __func__))
+		return;
+
+	schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
+}
+EXPORT_SYMBOL_GPL(pm_qos_cancel_request_lazy);
+
+/**
  * pm_qos_remove_request - modifies an existing qos request
  * @req: handle to request list element
  *
-- 
1.9.1
