Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D63C108A
	for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076339; cv=none; b=jNcVtd+MxRCY/aIEPxNmpclkim688yw5MdiFsAFcjCoNwQvCZB5YBqXUZdGK6JJvT3r4GOjPsP/7aDW/DR6aWCb3rQ02IHGFOen/u0BwKk67heSmigryHSUF65M7zA0Oyw7Si55notwY4BR6bYu6sTIcdPX/xb6zgo2KwLa+K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076339; c=relaxed/simple;
	bh=gsY4ZKizChJHi8mdaJHpkNmx9Dc7Ngx4GDp2e7I28sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfiTJ8iqnm4muvIiD6vEEkNt3cmkL71fdYEOpTIn+8vz2LZxX1I4SDBrkrjlDoJPuJ3amub8fPELuveD/buq7o3WB2Z7YFMZWI4+paNefeEWstK7Sj3jAPeYFTZ2oAUMPpRQU8yGyY+2pGvWqb+SSzme1fqovgjegiFNUxTPs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+uEw4Jz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+uEw4Jz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso30772f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076334; x=1787681134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BpLRorZ+8g//Jx2rn+3VsusxAfSV2ctUsd6Mn928xaI=;
        b=W+uEw4Jz4lWqf3fc1nRaZGxrRjQQCxx1RxIz2QrK2EIgFj8D0y7nCLt+jdQEGybU68
         nmzIGFcb0nFZw0AX90SPwd0KhwHxtyAJTkZDxMw7S4d+rLlS2iIlEfZeXeHNl+98Hsz2
         wl1KFD11u3ayypvVQqTckdNgG28Gi0OYKA7a3r9fOZHaLXMhFZpLQKJV+py5Z8GVW+7c
         DUUMsDIUrWD7lTrLUVhYWbtjT0Qn+teiGZ0KjlR5elCU0x8guJRZTqw7yO7O6sRFpUn8
         5jR6pZx34+B5mxsralWtOEYaruq3pj0wPSDSkvy2KqtYyP7Fce1deFyx+h8zR/GZEclE
         WD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076334; x=1787681134;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BpLRorZ+8g//Jx2rn+3VsusxAfSV2ctUsd6Mn928xaI=;
        b=Ox2oDcbyNTM+4gWPmg3GsCqaRS2RGSbD2aVgH2Ifv48MTPJ0psJzROYCrxk5yu0qni
         h/r5IhsTU6D4gaQhQ0vbteysCpywxzhiqEHGHObFgXpsa/xpC5piOUFkcDa+lth1yq25
         rsZhSKUqNm855wPwLLnfYfeDY87V50c8Jd6sImHBziV3amj11XBK0aWANNzmuK1yvgt2
         oZPVeS+VqV128Xu0LI30NCnoqcwJ2tBj2QSsQBwTnOAYVRzU9WXiTa/Ebgf4MolYq12G
         Sb1nnimrrab2JHp+oHO/bFSoQOEgqzxNUrvQvYCeWuV6f+Og3gODJwD84KevAKGICCzi
         vJcg==
X-Gm-Message-State: AOJu0YzM4n5wnDT3dLrQldva5aqKlcCZ9GB5IgKng7dOy3NC8dfFdwlc
	tfjkY8hh/DMOvB4en+Ec3Va77RXdnpPQU3QA4iSQNSO0sOrGQxjlbq1QcuSQW2lQ69c=
X-Gm-Gg: AR+sD11qvE6FLDVBIr5+TL6GURHf1B0E9nA8QqE0Oqbr47iHLVQQlOflfCvbzhVvcMK
	V7aJWiyzllQuR2YInEgYQG1fMrhTKx6oltdcqgrJEQLZXogCNaoyXr0L+VwoYZJuE2/LqZWuDjy
	mvTLQ+ugZ/NZ177zznT6xmwR8fXTJVRGuKB9wpxTvrm12grZflHum7eIc34Xg8oM2jMIANDoPE3
	wYJf69ZWFZinFQhbyZ4b0YV/giPqOnjNlPCz6nFFfXL2b0OILUxvy4GfdVUhY1e2NAcVMdrvN0o
	r0yvATmm8D5eRSxyIYQF49FMHym73DmT/O3LheF0r27LJ5l6ly+qbPFSccOVSaIe9RVdDIOQfqv
	Uoc92X/KykZqHSIsGmX8mNquzLZLpbC64MbOWr4nbgCtNIJIUJPoHCBcjky1eTQoVxzz07ti/ZO
	GBrObZbjdJDl2/B6uhEnULMziSJV/Damr+AnN5TFQ5pyacaCIgE5H8+U4RhA==
X-Received: by 2002:adf:fd0a:0:b0:481:51b7:290b with SMTP id ffacd0b85a97d-481607630fdmr44512057f8f.14.1787076334045;
        Tue, 18 Aug 2026 11:05:34 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c5e7sm13272234f8f.24.2026.08.18.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:05:33 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	johan@kernel.org,
	ulfh@kernel.org,
	cjb@laptop.org,
	tony.olech@elandigitalsystems.com,
	linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: [PATCH v3] mmc: vub300: fix sleeping function called from invalid context
Date: Tue, 18 Aug 2026 21:04:36 +0300
Message-ID: <20260818180514.71765-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoR_1vXMIqIdBDaI@hovoldconsulting.com>
References: <aoR_1vXMIqIdBDaI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot reports:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
  ...
   <IRQ>
   __might_resched
   __cancel_work_sync
   mmc_free_host+0x19/0x30 [drivers/mmc/core/host.c:700]
   call_timer_fn+0x192/0x5e0 [kernel/time/timer.c:1748]
   run_timer_softirq
   ...

vub300_inactivity_timer_expired() runs in softirq (timer) context.
When the USB interface had already gone away (->interface == NULL,
cleared by vub300_disconnect() or the probe() error path), the timer
handler dropped the object's last kref via
kref_put(&vub300->kref, vub300_delete). If that was the last
reference, vub300_delete() ran from softirq context and called
mmc_free_host(), which calls cancel_delayed_work_sync() - a sleeping
function, illegal from softirq/timer context.

Root cause: inactivity_timer is armed in probe() and continuously
re-armed via mod_timer(), but - unlike sg_transfer_timer, which is
explicitly deleted after each use - it is never stopped when the
device is torn down, so it can still fire after ->interface has
been cleared.

Fix this by decoupling inactivity_timer from the object's kref
entirely: drop the kref_get() taken on its behalf in probe(); make
vub300_inactivity_timer_expired() a no-op when ->interface is NULL
instead of dropping a reference; and in both vub300_disconnect() and
the probe() err_stop_io path, call
timer_delete_sync(&vub300->inactivity_timer) right after clearing
->interface and before the final kref_put(). Since ->interface is
already NULL at that point, any concurrently running timer instance
takes the no-op branch, so timer_delete_sync() is guaranteed to
return with the timer stopped for good - removing any race with the
final kref_put()/vub300_delete()/mmc_free_host(). Before this
patch, a successful probe() left two references on the kref (one
from kref_init(), one from the timer's kref_get()); after it, only
the initial kref_init() reference remains, matching the single
kref_put() in vub300_disconnect() and err_stop_io.

While auditing the driver for the same class of bug, also switch
sg_transfer_timer's two timer_delete() call sites (in
__command_read_data() and __command_write_data()) to
timer_delete_sync(), since usb_sg_wait() returning does not
guarantee a concurrently running vub300_sg_timed_out() has finished.
__command_write_data() additionally only deleted the timer on the
success path, leaking an armed timer on the cmd->error path; the
(now synchronous) delete is moved before that check so it always
runs.

Reported-by: syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0e06aa1bdc6495bac24b
Fixes: 1036f69e2513 ("mmc: core: Cancel delayed work before releasing host")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v3: To clarify,

LLM usage clarity:
The fix logic itself (decoupling inactivity_timer from the kref, the
ordering of timer_delete_sync() before kref_put() in both teardown
paths, and the sg_transfer_timer leak fix) is produced by me, not
the LLM. LLM was used solely to clarify the English wording of the
commit message at first (English is not my native language). The
"see commit message" comment style was also a recommendation from
the LLM (argument that "in-code comments are unnecessary when
there's a detailed commit message") - I now see that this is bad
practice for the patch, so I reverted comments to the classic,
self-explanatory in-code format, first time I tried this and I
won't repeat this pattern going forward.

Proof that mmc_free_host() is not a core issue:
In response to Jakov, you said that the fix might lie in the MMC
core.
a) The doc-comment of mmc_free_host() does not specify any context
(process/softirq) requirements, as in:

/**
 *	mmc_free_host - free the host structure
 *	@host: mmc host
 *
 *	Free the host once all references to it have been dropped.
 */
void mmc_free_host(struct mmc_host *host)

b) grep -rn "mmc_free_host(" drivers/mmc/ result showed that all
callers to mmc_free_host() (including SDHI, dw_mmc, sdhci-style
drivers) call it in the process context, on the remove/probe-error
path - usually after mmc_remove_host() or on the probe's error
branches, both part of the system's normal non-atomic teardown
flow. vub300 is the only exception: it calls it from the softirq
context via inactivity_timer.

If it were the core's fault, we would expect:
- The API documentation to have made a promise that "I am safe in
  every context" (it doesn't)
- Multiple drivers to be using this pattern (calling from softirq)
  (it doesn't, only vub300)
- The line added by 1036f69e2513 to have broken a pre-existing
  guarantee (it doesn't - there was no guarantee before, it was
  just safe by chance)

Proof for the Fixes: tag is 1036f69e2513:
I noticed that the commit preceding 1036f69e2513 didn't have
cancel_delayed_work_sync(), only mmc_pwrseq_free() and
put_device(), and contained no sleeping calls. The git show
1036f69e2513 diff proves that the
cancel_delayed_work_sync(&host->detect) line was added in that
exact commit. Conclusion: VUB300's pattern, which has been safe for
13 years, has become insecure with 1036f69e2513 adding a sleeping
call to mmc_free_host() - this commit is the true origin of the
bug. My previous Fixes: tag, 88095e7b473a, was wrong.

 drivers/mmc/host/vub300.c | 46 +++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..474625ad29d8 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -744,7 +744,12 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
 	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
 							    inactivity_timer);
 	if (!vub300->interface) {
-		kref_put(&vub300->kref, vub300_delete);
+		/*
+		 * The interface is already gone; timer_delete_sync()
+		 * in vub300_disconnect() or the probe() error path is
+		 * guaranteed to run after this and stop the timer for
+		 * good, so no kref handling is needed here.
+		 */
 	} else if (vub300->cmd) {
 		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	} else {
@@ -1453,7 +1458,12 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 						  (linear_length / 16384));
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
-			timer_delete(&vub300->sg_transfer_timer);
+			/*
+			 * Use the sync variant: usb_sg_wait() returning
+			 * does not guarantee vub300_sg_timed_out() has
+			 * finished if it fired concurrently.
+			 */
+			timer_delete_sync(&vub300->sg_transfer_timer);
 			if (vub300->sg_request.status < 0) {
 				cmd->error = vub300->sg_request.status;
 				data->bytes_xfered = 0;
@@ -1570,10 +1580,17 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 							   linear_length / 16384);
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
+			/*
+			 * Always delete synchronously and before checking
+			 * cmd->error: usb_sg_wait() returning does not
+			 * guarantee vub300_sg_timed_out() has finished,
+			 * and the old success-only delete leaked an armed
+			 * timer on the error path.
+			 */
+			timer_delete_sync(&vub300->sg_transfer_timer);
 			if (cmd->error) {
 				data->bytes_xfered = 0;
 			} else {
-				timer_delete(&vub300->sg_transfer_timer);
 				if (vub300->sg_request.status < 0) {
 					cmd->error = vub300->sg_request.status;
 					data->bytes_xfered = 0;
@@ -2327,7 +2344,12 @@ static int vub300_probe(struct usb_interface *interface,
 	INIT_WORK(&vub300->deadwork, vub300_deadwork_thread);
 	kref_init(&vub300->kref);
 	timer_setup(&vub300->sg_transfer_timer, vub300_sg_timed_out, 0);
-	kref_get(&vub300->kref);
+	/*
+	 * inactivity_timer does not hold its own kref (see the
+	 * no-op branch in vub300_inactivity_timer_expired()); it
+	 * is stopped via timer_delete_sync() in the teardown
+	 * paths instead of dropping a reference.
+	 */
 	timer_setup(&vub300->inactivity_timer,
 		    vub300_inactivity_timer_expired, 0);
 	vub300->inactivity_timer.expires = jiffies + HZ;
@@ -2350,6 +2372,14 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_stop_io:
 	vub300->interface = NULL;
+	/*
+	 * Stop the timer before the final kref_put(): once
+	 * ->interface is NULL, any concurrently running timer
+	 * instance takes the no-op branch above, so this call
+	 * is guaranteed to return with the timer stopped for
+	 * good.
+	 */
+	timer_delete_sync(&vub300->inactivity_timer);
 	kref_put(&vub300->kref, vub300_delete);
 
 	return retval;
@@ -2384,6 +2414,14 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
+			/*
+			 * Stop the timer before the final kref_put(): once
+			 * ->interface is NULL, any concurrently running
+			 * timer instance takes the no-op branch above, so
+			 * this call is guaranteed to return with the timer
+			 * stopped for good.
+			 */
+			timer_delete_sync(&vub300->inactivity_timer);
 			mmc_remove_host(mmc);
 			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
-- 
2.55.0

