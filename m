From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] PM: Remove the SET_PM_RUNTIME_PM_OPS() macro
Date: Thu, 11 Dec 2014 11:20:36 +0100
Message-ID: <1418293236-28411-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

There're now no users left of the SET_PM_RUNTIME_PM_OPS() macro, since
all have converted to use the SET_RUNTIME_PM_OPS() macro instead, so
let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

I suggest we takes this through my mmc tree, thus I request an ack from Rafael.
Also, I intend to send this as a fix for 3.19 rc1, together with the mmc parts
in Patch 1/2.

---
 include/linux/pm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 66a656e..8b59763 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -351,8 +351,6 @@ struct dev_pm_ops {
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
 
-#define SET_PM_RUNTIME_PM_OPS	SET_RUNTIME_PM_OPS
-
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
-- 
1.9.1

