From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] mmc: sdhci-pci: Stop calling
 sdhci_enable_irq_wakeups()
Date: Mon, 8 Jan 2018 16:49:26 +0200
Message-ID: <c2d38388-93a0-61c0-e323-74851c08c1fd@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
 <1513757933-11232-2-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoHPdYaorR38LaS5Hzs8CC99Smki8uZW8aDanboLRV3QA@mail.gmail.com>
 <b9801ecc-eaf4-7efc-fff0-3cbd40f29c9a@intel.com>
 <CAPDyKFrZjTvYdT8BGKadTdTBsaAeoC3YOQBBPOvqpv1JpaOUoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46240 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932200AbeAHOuA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jan 2018 09:50:00 -0500
In-Reply-To: <CAPDyKFrZjTvYdT8BGKadTdTBsaAeoC3YOQBBPOvqpv1JpaOUoQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On 21/12/17 17:33, Ulf Hansson wrote:
> + linux-pm, Rafael, Geert
> 
> On 21 December 2017 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 21/12/17 16:15, Ulf Hansson wrote:
>>> On 20 December 2017 at 09:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> sdhci_enable_irq_wakeups() is already called by sdhci_suspend_host() so
>>>> sdhci-pci should not need to call it. However sdhci_suspend_host() only
>>>> calls it if wakeups are enabled, and sdhci-pci does not enable them until
>>>> after calling sdhci_suspend_host(). So move the calls to
>>>> sdhci_pci_init_wakeup() before calling sdhci_suspend_host(), and
>>>> stop calling sdhci_enable_irq_wakeups(). That results in some
>>>> simplification because sdhci_pci_suspend_host() and
>>>> __sdhci_pci_suspend_host() no longer need to be separate functions.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
>>>>  1 file changed, 21 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>>> index 110c634cfb43..2ffc09f088ee 100644
>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>>> @@ -39,10 +39,29 @@
>>>>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>>>>
>>>>  #ifdef CONFIG_PM_SLEEP
>>>> -static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>>>> +static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>>>> +{
>>>> +       mmc_pm_flag_t pm_flags = 0;
>>>> +       int i;
>>>> +
>>>> +       for (i = 0; i < chip->num_slots; i++) {
>>>> +               struct sdhci_pci_slot *slot = chip->slots[i];
>>>> +
>>>> +               if (slot)
>>>> +                       pm_flags |= slot->host->mmc->pm_flags;
>>>> +       }
>>>> +
>>>> +       return device_init_wakeup(&chip->pdev->dev,
>>>> +                                 (pm_flags & MMC_PM_KEEP_POWER) &&
>>>> +                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
>>>
>>> A couple of comments here.
>>>
>>> Wakeup settings shouldn't be changed during system suspend. That means
>>> we shouldn't call device_init_wakeup() (or device_set_wakeup_enable()
>>> for that matter) here.
>>>
>>> Instead, device_init_wakeup() should be called during ->probe(), while
>>> device_set_wakeup_enable() should normally *not* have to be called at
>>> all by drivers. There are a exceptions for device_set_wakeup_enable(),
>>> however it should not have to be called during system suspend, at
>>> least.
>>>
>>> Of course, I realize that you are not changing the behavior in this
>>> regards in this patch, so I am fine this anyway.
>>>
>>> My point is, that the end result while doing this improvements in this
>>> series, should strive to that device_init_wakeup() and
>>> device_set_wakeup_enable() becomes used correctly. I don't think that
>>> is the case, or is it?
>>
>> Unfortunately we don't find out what the SDIO driver wants to do (i.e
>> pm_flags & MMC_PM_WAKE_SDIO_IRQ) until suspend.
> 
> That's true! Of course, we need to be able to act on this, somehow.
> 
>>
>> I considered enabling wakeups by default but wasn't sure that would not
>> increase power consumption in devices not expecting it.
> 
> I understand the problem, believe me. However, I would rather like to
> try to find a generic solution to these problems, else we will keep
> abusing existing wakeups APIs.
> 
> For your information, I have been working on several issues on how to
> handle the "wakeup path" correctly, which is linked to this problem.
> See a few quite small series for this below [1], [2].
> 
> I think the general problems can be described liked this:
> 
> 1) The dev->power.wakeup_path flag doesn't get set for the device by
> the PM core, in case device_set_wakeup_enable() is called from a
> ->suspend() callback. That also means, that the parent device don't
> get its >power.wakeup_path flag set in __device_suspend() by the PM
> core, while this may be expected by upper layers (PM domains, middle
> layers).
> 
> 2) device_may_wakeup() doesn't tell us the hole story about the
> wakeup. Only that is *may* be configured. :-)
> So in cases when device_may_wakeup() returns true, we still have these
> three conditions to consider, which we currently can't distinguish
> between:
> 
> *) The wakeup is configured and enabled, so the device should be
> enabled in the wakeup path.
> 
> **) The wakeup is configured and enabled, but as an out-band-wakeup
> signal (like a GPIO IRQ). This means the device shouldn't be enabled
> in the wakeup path.

So what about just adding can_oob_wakeup and oob_wakeup i.e.


diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 0f651efc58a1..162a511286b7 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -323,23 +323,32 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "%s\n", device_can_wakeup(dev)
-		? (device_may_wakeup(dev) ? _enabled : _disabled)
-		: "");
+	return sprintf(buf, "%s\n", device_may_wakeup(dev) ||
+				    device_may_oob_wakeup(dev) ? _enabled :
+				    device_can_wakeup(dev) ||
+				    device_can_oob_wakeup(dev) ? _disabled :
+				    "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t n)
 {
-	if (!device_can_wakeup(dev))
+	bool enable = false;
+
+	if (!device_can_wakeup(dev) && !device_can_oob_wakeup(dev))
 		return -EINVAL;
 
 	if (sysfs_streq(buf, _enabled))
-		device_set_wakeup_enable(dev, 1);
-	else if (sysfs_streq(buf, _disabled))
-		device_set_wakeup_enable(dev, 0);
-	else
+		enable = true;
+	else if (!sysfs_streq(buf, _disabled))
 		return -EINVAL;
+
+	if (device_can_wakeup(dev))
+		device_set_wakeup_enable(dev, enable);
+
+	if (device_can_oob_wakeup(dev))
+		device_set_oob_wakeup_enable(dev, enable);
+
 	return n;
 }
 
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index e73a081c6397..13e176edc3d7 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -392,6 +392,20 @@ int device_wakeup_disable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_wakeup_disable);
 
+static void wakeup_sysfs_add_remove(struct device *dev, bool capable)
+{
+	if (device_is_registered(dev) && !list_empty(&dev->power.entry)) {
+		if (capable) {
+			int ret = wakeup_sysfs_add(dev);
+
+			if (ret)
+				dev_info(dev, "Wakeup sysfs attributes not added\n");
+		} else {
+			wakeup_sysfs_remove(dev);
+		}
+	}
+}
+
 /**
  * device_set_wakeup_capable - Set/reset device wakeup capability flag.
  * @dev: Device to handle.
@@ -410,20 +424,35 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
 		return;
 
 	dev->power.can_wakeup = capable;
-	if (device_is_registered(dev) && !list_empty(&dev->power.entry)) {
-		if (capable) {
-			int ret = wakeup_sysfs_add(dev);
-
-			if (ret)
-				dev_info(dev, "Wakeup sysfs attributes not added\n");
-		} else {
-			wakeup_sysfs_remove(dev);
-		}
-	}
+	wakeup_sysfs_add_remove(dev, capable);
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
 
 /**
+ * device_set_oob_wakeup_capable - Set/reset device oob wakeup capability flag.
+ * @dev: Device to handle.
+ * @capable: Whether or not @dev is capable of out-of-band wake up of the system
+ * from sleep.
+ *
+ * If @capable is set, set the @dev's power.can_oob_wakeup flag and add its
+ * wakeup-related attributes to sysfs.  Otherwise, unset the @dev's
+ * power.can_oob_wakeup flag and remove its wakeup-related attributes from
+ * sysfs.
+ *
+ * This function may sleep and it can't be called from any context where
+ * sleeping is not allowed.
+ */
+void device_set_oob_wakeup_capable(struct device *dev, bool capable)
+{
+	if (!!dev->power.can_oob_wakeup == !!capable)
+		return;
+
+	dev->power.can_oob_wakeup = capable;
+	wakeup_sysfs_add_remove(dev, capable);
+}
+EXPORT_SYMBOL_GPL(device_set_oob_wakeup_capable);
+
+/**
  * device_init_wakeup - Device wakeup initialization.
  * @dev: Device to handle.
  * @enable: Whether or not to enable @dev as a wakeup device.
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..22cfcacc0095 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -585,6 +585,8 @@ struct pm_subsys_data {
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
+	unsigned int		can_oob_wakeup:1;
+	unsigned int		oob_wakeup:1;
 	unsigned int		async_suspend:1;
 	bool			in_dpm_list:1;	/* Owned by the PM core */
 	bool			is_prepared:1;	/* Owned by the PM core */
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 4238dde0aaf0..64252cb0f97a 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -83,11 +83,30 @@ static inline bool device_can_wakeup(struct device *dev)
 	return dev->power.can_wakeup;
 }
 
+static inline bool device_can_oob_wakeup(struct device *dev)
+{
+	return dev->power.can_oob_wakeup;
+}
+
 static inline bool device_may_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup && !!dev->power.wakeup;
 }
 
+static inline bool device_may_oob_wakeup(struct device *dev)
+{
+	return dev->power.can_oob_wakeup && dev->power.oob_wakeup;
+}
+
+static inline int device_set_oob_wakeup_enable(struct device *dev, bool enable)
+{
+	if (!dev->power.can_oob_wakeup)
+		return -EINVAL;
+
+	dev->power.oob_wakeup = enable;
+	return 0;
+}
+
 static inline void device_set_wakeup_path(struct device *dev)
 {
 	dev->power.wakeup_path = true;


> 
> ***) The wakeup isn't configured, thus disabled, because there are no
> consumers of the wakeup IRQ registered (as may be the case for SDIO
> IRQ). This also means the device shouldn't be enabled in the wakeup
> path.
> 
> Potentially, one could consider **) and ***) being treated in the same
> way, via using an opt-out method, avoiding the wakeup path to be
> enabled. Currently I have been thinking of adding an "OUT_BAND_WAKEUP"
> driver PM flag, to deal with this, however there may be other
> preferred options.
> 
> Kind regards
> Uffe
> 
> [1]
> https://www.spinics.net/lists/linux-renesas-soc/msg21421.html
> [2]
> https://www.spinics.net/lists/linux-renesas-soc/msg20122.html
> (Actually the discussions there concluded that we may need an
> "OUT_BAND_WAKEUP" flag instead)
> 

