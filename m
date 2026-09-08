Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62190572688
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886267; cv=none; b=Zk5QSFbnLYmBNvcJAsu26sRm++haSmoJzSkd+qSEyXmP+TK13jbTpt8Ak8XCMy5UOLLufv1cC9eWVyMHQg9cBhZuznf1v0eAS9LWu/9Ft6kyJV48F7tQHs67otEFV1gYSAngmubAAWs9GzkKscMNpk9DRh7HNDdt087YrP71Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886267; c=relaxed/simple;
	bh=//Xd2E9Et0LpJ/htgFKkYKCvZz8Q8y6Fs3nOUuaKX1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njrk0fQRwmkSD8/fBBdvFx0wEkP6UjWfqQfDYVe0kxYssU1viDfnj5qptvCT78uwxi7K4+HwSyxXUM5Ce3psXwHrLo7QlaydDYJVxlXyaGcVxuYINW6TOi3j0jsN6EBYtnbPMNuVqTUnybO/NBzq5733bYiFwA4vWJRWrzpPBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDpwWrG0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDpwWrG0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso2607140a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886265; x=1789491065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8ZA0hxlEL612Yt3BdEYa97uIj05iqxTvv5XFoK7oW4=;
        b=JDpwWrG0dJ1WfudmT6ZYZBO+YXA3kN9D9ZBeVCdG0Yjbk8VRv369FJJf/3oCqnl14w
         olewqGgcFQZWfIeEECsTBBeAtH5kwfAxphFGOaM3o3/BeSACTcagmI0lun+HE8I3QndP
         XPWRSjztiGT3bXfVJfpZja4MT5UQwKy6bgHOVQvuBbUEoJFJ98jxH0tnkkWYpcGc8fLE
         4jqQwkk83Zt60oi5SP/uO/gE6gqHYQ+R4Gc9KXceVBZc2YkbraL9LGULF0w8qsvkk1r1
         HfebQ0ye65IFdwvl65bN22gzvkEzJSg8uSsSJe704tuFG5w1zSwNtSyg98EQobgxzSIA
         iIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886265; x=1789491065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8ZA0hxlEL612Yt3BdEYa97uIj05iqxTvv5XFoK7oW4=;
        b=asi6clvsUHT6i1gwPmRv8ONqVMv6aYfVs5+6Jg/FXiVIVNTF25cMMuIcKNss/w7ZtA
         khPt015q2Zw33x73Jjlf/ZKc/O1t/fVN1W+WleTyV+VFXb3SQBLu6m6JK6FNWOkTVWWr
         DIM4EMsdNGkh7rn3wSp3iu9VxEMQdGAj9qWE+qpUEarJkbPi34C7RzRq5bZnn1GubeEb
         xrd67CmnSWa4ZDSOWo8JPJhc7o0WlDvLIc5fnUbeqHE4jwydXk8ANrX8Ni5s7iHAvsXy
         6ukPiIwlQoStVOEoL6Lt+FfM1d67Q4t1nhgMzQh3Hs5PMGqKyom9NOypxpfOi0xlIDnh
         +dXw==
X-Gm-Message-State: AFuF++leOXNX9RpETDuASMp95mbx9rUT4KQCWP5MeKeeShVVVruaoJXT
	oucobsLfnns6QLtD7kSIav1ZWswYjZrrNHgQlpekxxaR2pHTIJUe9c1F
X-Gm-Gg: AYBFou0Vk7DAUc0FhLfoIO0fInKtS/6PHZNOYsRfvQvwA9YVwbjBwtrS6QnBXM4SPZf
	bdTJtDesuyWbVCqcNo+MJrEOx6NzMTLkAxAHx1t6l5FSdtREVVXlbYQ4LHPGfJYyzTgNmmpTin0
	qjSi2MtXXSkw52zSymsAVdAO8vSjlPPAZvqFTCUBY9bwBXQTdq7awl7hX8/0NdPNRCLSlofVKOz
	IeBmOgG2b4zHqDjtqMVOWjfrfvgX47iPbtkYe+sswvW0lstMag1badBB5m2f5KZI58Fn5cFxAj9
	eb/WElFwW8PF6YZMnRpIr/mAT3O5PS8NW7DDb57v5TOyFboVabAwz5xzxGRr8SYkrWWHCw5gmzi
	Z0ceWczcAbe0AmCmagOr4ofaMojT62xKQJc7MIW+FfxJluaut1UgQFWOrzl0wp+AnRdfc6pj4MD
	J7RVnGbyGOPL0P/Hu3jcHfcoX/jMttrqnAGaXRHl4YOqM4uvKEUJ1ALznpWWbPzl2xwBP1i4t6G
	K9Pi8is9AJy1Q==
X-Received: by 2002:a17:90b:4c06:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-39b26116d9fmr39048348a91.8.1788886264478;
        Tue, 08 Sep 2026 09:51:04 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26155324sm26567910a91.17.2026.09.08.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:51:03 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Tony Olech <tony.olech@elandigitalsystems.com>,
	Chris Ball <cjb@laptop.org>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: [PATCH] mmc: vub300: never tear the host down from the inactivity timer
Date: Tue,  8 Sep 2026 22:20:50 +0530
Message-ID: <20260908165050.1930-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vub300_probe() takes a second kref reference on behalf of the inactivity
timer and arms it:

	kref_init(&vub300->kref);
	...
	kref_get(&vub300->kref);
	timer_setup(&vub300->inactivity_timer,
		    vub300_inactivity_timer_expired, 0);
	vub300->inactivity_timer.expires = jiffies + HZ;
	add_timer(&vub300->inactivity_timer);

and expects the timer to release that reference from its own expiry
function, once it observes that vub300->interface has been cleared:

	if (!vub300->interface) {
		kref_put(&vub300->kref, vub300_delete);
	} else if (vub300->cmd) {

That is wrong in both directions, because the expiry function runs in
softirq context.

If the timer happens to hold the last reference, the kref_put() runs
vub300_delete() -> mmc_free_host() -> cancel_delayed_work_sync(), which
sleeps. The ->probe() error path arranges exactly that: it clears
->interface and drops only its own reference, leaving the timer armed
and owning the last one.

	BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 191, name: kworker/0:2
	Call Trace:
	 <IRQ>
	 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
	 __cancel_work_sync kernel/workqueue.c:4487 [inline]
	 cancel_delayed_work_sync+0xb8/0xf0 kernel/workqueue.c:4568
	 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
	 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
	 kref_put include/linux/kref.h:65 [inline]
	 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747
	 call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
	 </IRQ>

If instead the timer drops its reference and stops rearming, one of the
mod_timer() calls in the command and dead work threads can arm it again
-- those do not take a reference of their own. The kref_put() in
vub300_disconnect() then drops what is now the last reference and
vub300_delete() frees the host together with the still armed timer
embedded in it.

	ODEBUG: free active (active state 0) object: ffff88803cd81420 object type: timer_list hint: vub300_inactivity_timer_expired+0x0/0x3f0
	WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230 lib/debugobjects.c:629
	Call Trace:
	 <TASK>
	 debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
	 kfree+0x13e/0x6d0 mm/slub.c:6792
	 kobject_put+0x222/0x550 lib/kobject.c:737
	 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
	 vub300_disconnect+0x280/0x2f0 drivers/mmc/host/vub300.c:2388
	 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:458
	 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2345
	 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5961
	 </TASK>

Take the timer out of the reference counting altogether. The expiry
function no longer inspects ->interface and no longer drops a reference;
it just queues the dead work and rearms as before. Both teardown paths
now call the new vub300_stop_inactivity_timer(), which runs
timer_shutdown_sync() from process context and then drops the reference
that ->probe() took for the timer. timer_shutdown_sync() additionally
turns any later mod_timer() into a no-op, so the work threads can no
longer resurrect the timer, and vub300_delete() only ever runs somewhere
it is allowed to sleep.

vub300_deadwork_thread() has the same "->interface is NULL, so put the
reference" shape, but it runs in process context and releases the
reference that vub300_queue_dead_work() took for it, so it is left as
is.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Reported-by: syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4a0159ce6802a0a4774
Reported-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1ee4f3b9228e35f14677
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 drivers/mmc/host/vub300.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..b8e72a054439 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -743,14 +743,22 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
 {				/* softirq */
 	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
 							    inactivity_timer);
-	if (!vub300->interface) {
-		kref_put(&vub300->kref, vub300_delete);
-	} else if (vub300->cmd) {
-		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
-	} else {
+	if (!vub300->cmd)
 		vub300_queue_dead_work(vub300);
-		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
-	}
+
+	mod_timer(&vub300->inactivity_timer, jiffies + HZ);
+}
+
+/*
+ * Stop the inactivity timer and drop the reference that ->probe() took on its
+ * behalf.  Must be called from process context: once timer_shutdown_sync() has
+ * returned the timer can neither run nor be rearmed by the mod_timer() calls
+ * made from the command and dead work threads.
+ */
+static void vub300_stop_inactivity_timer(struct vub300_mmc_host *vub300)
+{
+	timer_shutdown_sync(&vub300->inactivity_timer);
+	kref_put(&vub300->kref, vub300_delete);
 }
 
 static int vub300_response_error(u8 error_code)
@@ -2350,6 +2358,7 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_stop_io:
 	vub300->interface = NULL;
+	vub300_stop_inactivity_timer(vub300);
 	kref_put(&vub300->kref, vub300_delete);
 
 	return retval;
@@ -2384,6 +2393,7 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
+			vub300_stop_inactivity_timer(vub300);
 			mmc_remove_host(mmc);
 			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
-- 
2.55.0.windows.5

