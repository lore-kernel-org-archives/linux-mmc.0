From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Fri, 3 Apr 2015 13:59:28 +1100
Message-ID: <20150403135928.51079611@notabene.brown>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
	<551BDAEA.20405@intel.com>
	<551C0A4C.9020602@broadcom.com>
	<CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>
	<551D1A59.5060803@broadcom.com>
	<CAPDyKFqdwQVEoKWH-Et32PZxVrcOabt7rek=Xq01yLmebgXuOA@mail.gmail.com>
	<551D3391.8040508@intel.com>
	<CAPDyKFrFoiKFC+i_TF_NR9Mg6b9JxzqRHyyN72z331s+0Gge2A@mail.gmail.com>
	<551D35C6.7070605@broadcom.com>
	<551D396F.1020301@intel.com>
	<CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/EwtDsLpWzKpVJ9g.qUmroOK"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59065 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbbDCC7m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Apr 2015 22:59:42 -0400
In-Reply-To: <CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>

--Sig_/EwtDsLpWzKpVJ9g.qUmroOK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Apr 2015 16:00:52 +0200 Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:

> [...]
>=20
> >>>>>>>>> Also SDIO cards can have a custom sleep state where tuning won'=
t work.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Our SDIO wifi device has such a state and it can only come out o=
f it
> >>>>>>>> upon
> >>>>>>>> CMD52 write or CMD14 (ExitSleep).
> >>>>>>>
> >>>>>>>
> >>>>>>> So how will the mmc core know about these states? I guess we will
> >>>>>>> require SDIO func drivers to deal with enable/disable or hold/rel=
ease
> >>>>>>> of re-tuning then?
> >>>>>>
> >>>>>>
> >>>>>> This is actually why in the past we tried to only kick off retuning
> >>>>>> before a
> >>>>>> request that requires use of data line(s) so mmc core (or sdhci) w=
ould not
> >>>>>> do re-tuning when SDIO func used CMD52 to wakeup the device. I nev=
er tried
> >>>>>> CMD14 approach and not even sure from which spec it comes (maybe e=
MMC).
> >>>>>
> >>>>> That's an interesting idea. It would eliminate the need for SDIO fu=
nc
> >>>>> drivers to care about holding/releasing re-tuning.
> >>>>>
> >>>>> Would be nice to hear about Adrian's thoughts around this as well.
> >>>>
> >>>> I don't see how it would work because re-tuning is needed after the =
host
> >>>> controller runtime resumes. i.e. once the SDIO wifi card stops being=
 active
> >>>> the host controller will runtime suspend.
> >>>
> >>> Why do we always need to re-tune from this phase?
> >>>
> >>> What Arend points out is that we could "delay" the re-tune until we
> >>> know there is a DATA request. Wouldn't that work for SDHCI as well?
> >>
> >> You beat me to it, but that is indeed what I meant.
> >
> > The CMD line needs tuning too, so delaying tuning on every command will
> > cause errors. It is better to hold tuning for the specific command used=
 to
> > wake-up.
>=20
> Hmm.
>=20
> This touches the discussion where Neil Brown also was involved, around
> how to handle "idle operations" for SDIO.

Does it?  I'm not at all sure that I follow all the issues with re-tuning.

It *seems* that there are two sorts of events:
 1/ those that indicate that a retune will be needed.  This includes
    power cycling of some device, and time passing.
 2/ those that need to have retuning done (if needed) before they are
    performed.

Did I over-simplify there?

If I didn't, then do we just need a "retune needed" flag which type-1 events
can set asynchronously, and which type-2 events check before they are
performed.
The code I looked at seems to contain those ideas, but it seems more
complicated so I must have missed something.

For my purposes, "idle" it exactly "not mmc_claimed for a while".

I cannot quite see where "idle" fits in to retuning.... unless maybe you wa=
nt
to retune proactively *before* a type-2 event comes along.  Is that the iss=
ue?

>=20
> How does SDIO func drivers detects "request inactivity", which
> triggers them to send its device to "sleep mode"? That answer should
> be runtime PM.

"should be" :-)
I just had a look at libertas/if_sdio because that is  the driver that I us=
e.
It has an "auto_deepsleep_timer" which works a lot like runtime_pm
autosuspend.   However it doesn't appear that auto_deepsleep mode is ever
enabled :-( so there isn't much point converting it to use runtime_pm.


>=20
> So, from mmc core perspective we should be able to get notifications
> through runtime PM callbacks (from mmc or sdio bus) to understand
> whether we need to hold of re-tune.

I'm having trouble getting to grips with this idea of "holding off re-tune".
Is it not sufficient to only allow a re-tune to happen when the host is
claimed by the retuner?
In generally if you want to cause something to "hold off", you use a lock of
some sort.  Can we not just create a lock (if no present lock is sufficient)
- which may just be a flag - and take it whenever re-tune is not allowed?


>=20
> I know, it's a bit of a vague idea so I will give it some more
> thinking during the Easter holidays.

To give you something more concrete to work with, below is how I want to do
idle detection.  I'm defining "idle" as "mmc_host hasn't been claimed for
100ms".  I do it by enabling runtime-pm on the mmc_host.
I have a follow-on patch which adds an idle handler for the 4-bit->1-bit
transition.

One issue that I haven't quite resolved to my own satisfaction is whether t=
he
mmc host devices (parents of the mmc_host class device) should have
ignore_children set.  Several already do, but this is currently completely
pointless as the child (the mmc_host) doesn't do power management, so there
is nothing to ignore.

I think I'd like to remove all the pm_suspend_ignore_children() calls from
drivers/mmc/host/*.c and from mmc_alloc_host()  in this patch.  Then whenev=
er
the mmc_host was pm_runtime active - i.e. when the mmc_host was claimed - t=
he
host device would be held active.  Then we could revert

mmc: core: Enable runtime PM management of host devices

as it would no longer be needed.

Happy Easter!

NeilBrown




From: NeilBrown <neil@brown.name>
Date: Tue, 24 Mar 2015 17:18:15 +1100
Subject: [PATCH] mmc/core: add pm_runtime tracking to mmc_host devices.

Enable runtime pm for mmc_host devices, and take a
reference while the host is claimed.

Use an autosuspend timeout so that the device isn't
put to sleep until we have been idle for a while.

Set the parent to ignore children, so the PM status of
the host does not affect the controller at all.

This functionality will be used in a future patch to allow
commands to be sent to the device when the host is idle.

Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f6faa18edf7b..39e2c781e382 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -901,6 +901,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *a=
bort)
=20
 	might_sleep();
=20
+	pm_runtime_get_sync(mmc_classdev(host));
 	add_wait_queue(&host->wq, &wait);
 	spin_lock_irqsave(&host->lock, flags);
 	while (1) {
@@ -924,6 +925,8 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *a=
bort)
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
=20
+	if (stop)
+		pm_runtime_put(mmc_classdev(host));
 	if (pm)
 		pm_runtime_get_sync(mmc_dev(host));
=20
@@ -956,6 +959,8 @@ void mmc_release_host(struct mmc_host *host)
 		pm_runtime_mark_last_busy(mmc_dev(host));
 		pm_runtime_put_autosuspend(mmc_dev(host));
 	}
+	pm_runtime_mark_last_busy(mmc_classdev(host));
+	pm_runtime_put_autosuspend(mmc_classdev(host));
 }
 EXPORT_SYMBOL(mmc_release_host);
=20
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df758e68..86692b427301 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/pm_runtime.h>
=20
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -46,9 +47,39 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
=20
+static int mmc_host_runtime_suspend(struct device *dev)
+{
+	struct mmc_host *host =3D cls_dev_to_mmc_host(dev);
+
+	BUG_ON(host->claimed);
+	host->claimed =3D 1;
+	/* idle handling happens here */
+
+	host->claimed =3D 0;
+	return 0;
+}
+
+static int mmc_host_runtime_resume(struct device *dev)
+{
+	struct mmc_host *host =3D cls_dev_to_mmc_host(dev);
+
+	BUG_ON(host->claimed);
+	host->claimed =3D 1;
+	/* undo any idle handling here */
+
+	host->claimed =3D 0;
+	return 0;
+}
+
+static struct dev_pm_ops mmc_host_dev_pm_ops =3D {
+	.runtime_suspend =3D mmc_host_runtime_suspend,
+	.runtime_resume =3D mmc_host_runtime_resume,
+};
+
 static struct class mmc_host_class =3D {
 	.name		=3D "mmc_host",
 	.dev_release	=3D mmc_host_classdev_release,
+	.pm		=3D &mmc_host_dev_pm_ops,
 };
=20
 int mmc_register_host_class(void)
@@ -490,6 +521,11 @@ struct mmc_host *mmc_alloc_host(int extra, struct devi=
ce *dev)
 	host->class_dev.parent =3D dev;
 	host->class_dev.class =3D &mmc_host_class;
 	device_initialize(&host->class_dev);
+	if (dev)
+		/*
+		 * The device can sleep even when host is claimed.
+		 */
+		pm_suspend_ignore_children(dev, true);
=20
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
@@ -532,15 +568,25 @@ EXPORT_SYMBOL(mmc_alloc_host);
 int mmc_add_host(struct mmc_host *host)
 {
 	int err;
+	struct device *dev =3D mmc_classdev(host);
=20
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
=20
-	err =3D device_add(&host->class_dev);
+	err =3D device_add(dev);
 	if (err)
 		return err;
+	pm_runtime_enable(dev);
+	/*
+	 * The host should be able to suspend while the attached card
+	 * stays awake.
+	 */
+	pm_suspend_ignore_children(dev, true);
+	pm_runtime_get_sync(dev);
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
=20
-	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
+	led_trigger_register_simple(dev_name(dev), &host->led);
=20
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
@@ -550,6 +596,9 @@ int mmc_add_host(struct mmc_host *host)
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
=20
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
=20

--Sig_/EwtDsLpWzKpVJ9g.qUmroOK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVR4CETnsnt1WYoG5AQL2cg//co6rnJv+5V9NOvomqCfye3bubRqO0ksV
hWehgrcrzLuQZ59+S9cIK+4IhDaTbY+u1HCPPJT9sCwhFRNUn8EoAL9N5Tfn8qIW
wJJU811SIUtGHnEmju0dduTP6DTeandb144fvyajAoUFAo4tvp0ZYwwRX0SnSVhc
VAT6GJE7+GxNuEW0iKnO4trqBuA9YTH4dyzcdOAsuIqt3VKt3+3gYpW4wwDYlC7C
i03W8goxYY3R/TNdJPhLEaaEFGrVcMOjDZoqK7twDWy8IbJHtG/HkRHlej3tRTyx
cggwzbjzEpOiXEvvfONX6PEcP7ANyKEwS6azwv8xP1PdYh8NIHgDvjeDLXPqektl
len/1H428HKDJpeGvkWGGfGixusoCNW2Zk6PUC6LlluuuZjhTOVxv9YlJiaBKtIx
jjZMLaVE4QOq9jd+0wOrzxSRUHrZbTwqTsdShoqNq3sP6WrBSbi1aDkM4rUnnRlV
ZqvWeCEvt7JMWlBIT3shxhWanzAppTsEELU58lfVHFMO/51QEKQH7mNJgddVCEUl
hDLwHglwA6WYQM+/iKi2U476Bsglx2KpR+BWlDSrljyrUnC/TDVnIBLnNbF/OYWI
TdUWT5X4AbnW19fgSwHsMqFTsn5CkYqQMSFBr10rNMxwyUgAcY6eYeORysnKpAKq
flohJDnMss4=
=qd6S
-----END PGP SIGNATURE-----

--Sig_/EwtDsLpWzKpVJ9g.qUmroOK--
