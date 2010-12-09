From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: subtle pm_runtime_put_sync race and sdio functions
Date: Fri, 10 Dec 2010 01:37:02 +0200
Message-ID: <AANLkTi=6fUeDAJut5tZmB+h9qmEt7gZ13UaOqhAW3XE1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:64097 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab0LIXhX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 18:37:23 -0500
Received: by iwn40 with SMTP id 40so4257575iwn.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Dec 2010 15:37:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

When pm_runtime_put_sync() returns, the _put operation is completed,
and if needed (zero usage_count, children are ignored or their count
is zero, ->runtime_idle() called pm_runtime_suspend(), no
runtime_error, no disable_depth, etc...) the device is powered down.

This behavior is sometimes desirable and even required: drivers may
call pm_runtime_put_sync() and rely on PM core to synchronously power
down the device.

This is usually all good, but when we combine this requirement with
logical sub-devices that cannot be power-managed on their own (e.g.
SDIO functions), things get a bit racy, since their parent is not
suspended synchronously (the sub-device is rpm_suspend()'ed
synchronously, but its parent is pm_request_idle()ed, which is
asynchronous in nature).

Since drivers might rely on pm_runtime_put_sync() to synchronously
power down the device, if that doesn't happen, a rapid subsequent
pm_runtime_get{_sync} might cancel the suspend. This can lead the
driver, e.g., to reinitialize a device that wasn't powered down, and
the results can be fatal.

One possible solution is to call pm_runtime_idle(parent), instead of
pm_request_idle(parent), when a no_callbacks device is suspended:

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 02c652b..d7659d3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -407,7 +407,10 @@ static int rpm_suspend(struct device *dev, int rpmflags)
        if (parent && !parent->power.ignore_children) {
                spin_unlock_irq(&dev->power.lock);

-               pm_request_idle(parent);
+               if (dev->power.no_callbacks)
+                       pm_runtime_idle(parent);
+               else
+                       pm_request_idle(parent);

                spin_lock_irq(&dev->power.lock);
        }

This solution assumes that such sub-devices don't really need to have
callbacks of their own. It would work for SDIO, since we are
effectively no_callbacks devices anyway, and it only seems reasonable
to set SDIO functions as no_callbacks devices.

A different, bolder solution, will always call pm_runtime_idle instead
of pm_request_idle (see below): when a device is runtime suspended, it
can't be too bad to immediately send idle notification to its parent,
too. I'm aware this might not always be desirable, but I'm bringing
this up even just for the sake of discussion:

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 02c652b..9719811 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -407,7 +407,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
        if (parent && !parent->power.ignore_children) {
                spin_unlock_irq(&dev->power.lock);

-               pm_request_idle(parent);
+               pm_runtime_idle(parent);

                spin_lock_irq(&dev->power.lock);
        }
