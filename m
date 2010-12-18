From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 15:29:10 +0200
Message-ID: <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com> <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58110 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0LRN3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Dec 2010 08:29:31 -0500
Received: by iyi12 with SMTP id 12so1067585iyi.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2010 05:29:31 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

Hi Alan,

Sorry for the belated response,

On Sat, Dec 11, 2010 at 4:50 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>> Think of a device which you have no way to reset other than powering
>> it down and up again.
>>
>> If that device is managed by runtime PM, the only way to do that is =
by
>> using put_sync() followed by a get_sync(). Sure, if someone else
>> increased the usage_count of that device this won't work, but then o=
f
>> course it means that the driver is not using runtime PM correctly.
>
> Not so. =A0Even if a driver uses runtime PM correctly, there will sti=
ll
> be times when someone else has increased the usage_count. =A0This hap=
pens
> during probing and during system resume, for example.

I'm aware of these two examples; normally we're good with them since
during probing we're not toggling the power, and during suspend/resume
the SDIO core is responsible for manipulating the power (and it does
so directly). Are there (or do you think there will be) additional
examples where this can happen ?

But this leads me to a real problem which we have encountered.

During system suspend, our driver is asked (by mac80211's suspend
handler) to power off its device. When this happens, the driver has no
idea that the system is suspending - regular driver code (responsible
to remove the wlan interface and stop the device) is being called.
Obviously pm_runtime_put_sync() won't power off the device at this
point, but later during suspend, when the SDIO core will suspend, the
device will be powered off and things would work as expected.

That breaks when the suspend transition is cancelled (e.g. due to an
error) before SDIO core gets the chance to power off the device: the
driver will be asked (by mac80211's resume handler) to power up the
device and reinitialize it, but since the device was never powered
off, the driver will fail doing so because the device is quiescent (a
power cycle should have put him into a communicable state, but that
never happened in this scenario).

At that resume point the device is always on - whether the system
suspended successfully or not - and the driver can't tell whether the
device was indeed powered off beforehand or not. In addition, the
driver code that is going to fail is not a resume handler - it's just
regular driver code responsible for powering on the device and
reinitializing it (which is being called by mac80211's resume
handler).

One way to solve this is by allowing certain type of devices to keep
using runtime PM during system suspend transitions. Obviously this is
generally unsafe, but for certain drivers/devices, that use runtime PM
very accurately, synchronously and without being affected by children
devices, this may be helpful (and those drivers should be responsible
to make sure they are not racing with system suspend).

Something like:

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 31b5266..84e9263 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -694,7 +694,8 @@ static void dpm_complete(pm_message_t state)
 			mutex_unlock(&dpm_list_mtx);

 			device_complete(dev, state);
-			pm_runtime_put_sync(dev);
+			if (!dev->power.autonomous_pm)
+				pm_runtime_put_sync(dev);

 			mutex_lock(&dpm_list_mtx);
 		}
@@ -1025,8 +1026,10 @@ static int dpm_prepare(pm_message_t state)
 		dev->power.status =3D DPM_PREPARING;
 		mutex_unlock(&dpm_list_mtx);

-		pm_runtime_get_noresume(dev);
-		if (pm_runtime_barrier(dev) && device_may_wakeup(dev)) {
+		if (!dev->power.autonomous_pm)
+			pm_runtime_get_noresume(dev);
+		if (!dev->power.autonomous_pm && pm_runtime_barrier(dev) &&
+						device_may_wakeup(dev)) {
 			/* Wake-up requested during system sleep transition. */
 			pm_runtime_put_sync(dev);
 			error =3D -EBUSY;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
index 9719811..1efd528 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1078,6 +1078,23 @@ void pm_runtime_no_callbacks(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);

 /**
+ * pm_runtime_autonomous_pm - Don't mask runtime PM calls during syste=
m suspend
+ * @dev: Device to handle.
+ *
+ * Set the power.autonomous_pm flag, which tells PM core not to mask
+ * runtime PM calls for this device during system suspend/resume. This=
 is
+ * generally unsafe, so it should be set only if a driver is using run=
time PM
+ * very accurately, synchronously and usually with ignore_children set=
=2E
+ */
+void pm_runtime_autonomous_pm(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+	dev->power.autonomous_pm =3D 1;
+	spin_unlock_irq(&dev->power.lock);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_autonomous_pm);
+
+/**
  * update_autosuspend - Handle a change to a device's autosuspend sett=
ings.
  * @dev: Device to handle.
  * @old_delay: The former autosuspend_delay value.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 40f3f45..e550775 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -488,6 +488,7 @@ struct dev_pm_info {
 	unsigned int		no_callbacks:1;
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
+	unsigned int		autonomous_pm:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 3ec2358..4130e54 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -43,6 +43,7 @@ extern void pm_runtime_no_callbacks(struct device *de=
v);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use)=
;
 extern void pm_runtime_set_autosuspend_delay(struct device *dev, int d=
elay);
 extern unsigned long pm_runtime_autosuspend_expiration(struct device *=
dev);
+extern void pm_runtime_autonomous_pm(struct device *dev);

 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -123,6 +124,7 @@ static inline int pm_generic_runtime_idle(struct
device *dev) { return 0; }
 static inline int pm_generic_runtime_suspend(struct device *dev) { ret=
urn 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { retu=
rn 0; }
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
+static inline void pm_runtime_autonomous_pm(struct device *dev) {}

 static inline void pm_runtime_mark_last_busy(struct device *dev) {}
 static inline void __pm_runtime_use_autosuspend(struct device *dev,



What do you think ?

Otherwise, the driver will need to use some combination of both
runtime PM API and direct calls to the ->runtime_suspend() handler.
The end result will be the same, but it won't be pretty.
In addition, others with a similar problem might eventually show up,
so supporting this within the runtime PM framework itself will help
them too.


>> =A0if a context is willing to
>> synchronously suspend a device (either a driver using put_sync() or
>> the PM worker), what do we gain by deferring the idling of the paren=
t
>> and not synchronously suspending as much ancestors as possible in th=
e
>> same context ?
>
> We gain stack space (by not having a potentially lengthy sequence of
> nested calls), which is relatively unimportant

Agree, if that was a problem, resume wouldn't work too, since it is
completely symmetric.

>, and we gain latency.
> The latency may help in some situations; if the device is resumed aga=
in
> quickly enough then we may avoid suspending the parent entirely.

I guess it depends on the implementation, but if that parent cares
about wake-up latency, couldn't it set its ->runtime_idle() handler to
call pm_runtime_autosuspend() (and set autosuspend appropriately of
course) instead of pm_runtime_suspend() ?

This way it'd be both possible to suspend devices as fast as possible,
in a symmetric fashion to the way resume works, and also, if
subsystems care, they could use autosuspend to explicitly indicate the
period of inactivity that suits them and completely change this
behavior.

They would also gain deterministic and controllable behavior that we
can't guarantee when we rely on a context switch, because obviously
the latter yields different results for different platforms and
workloads (for the exact same subsystem).

Thanks,
Ohad.
