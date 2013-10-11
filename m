From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Runtime: Respect autosuspend when idle triggers suspend
Date: Fri, 11 Oct 2013 11:23:40 +0200
Message-ID: <1381483420-18864-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

For devices which don't have a .runtime_idle callback or if it returns
0, rpm_idle will end up in triggering a call to rpm_suspend, thus
trying to carry out a runtime_suspend directly from runtime_idle.

In the above situation we want to respect devices which has enabled
autosuspend, we therfore append the flag sent to rpm_suspend with
RPM_AUTO.

Do note that driver's still needs to update the device last busy mark,
to control the delay for this circumstance.

Updated runtime PM documentation accordingly.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rob Landley <rob@landley.net>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/runtime_pm.txt |    9 ++++-----
 drivers/base/power/runtime.c       |    6 ++++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 71d8fe4..80df87a 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -145,11 +145,10 @@ The action performed by the idle callback is totally dependent on the subsystem
 if the device can be suspended (i.e. if all of the conditions necessary for
 suspending the device are satisfied) and to queue up a suspend request for the
 device in that case.  If there is no idle callback, or if the callback returns
-0, then the PM core will attempt to carry out a runtime suspend of the device;
-in essence, it will call pm_runtime_suspend() directly.  To prevent this (for
-example, if the callback routine has started a delayed suspend), the routine
-should return a non-zero value.  Negative error return codes are ignored by the
-PM core.
+0, then the PM core will attempt to carry out a runtime suspend of the device,
+also respecting devices configured for autosuspend. In essence it means a call
+to pm_runtime_autosuspend(). To prevent this, the routine must return a non-zero
+value. Negative error return codes are ignored by the PM core.
 
 The helper functions provided by the PM core, described in Section 4, guarantee
 that the following constraints are met with respect to runtime PM callbacks for
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 268a350..4edb2a0 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -258,7 +258,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
  * Check if the device's runtime PM status allows it to be suspended.  If
  * another idle notification has been started earlier, return immediately.  If
  * the RPM_ASYNC flag is set then queue an idle-notification request; otherwise
- * run the ->runtime_idle() callback directly.
+ * run the ->runtime_idle() callback directly. If the ->runtime_idle callback
+ * does'nt exist or if it returns 0, run rpm_suspend with RPM_AUTO flag to
+ * respect drivers using autosuspend.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -331,7 +333,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
  out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
-	return retval ? retval : rpm_suspend(dev, rpmflags);
+	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
 /**
-- 
1.7.9.5

